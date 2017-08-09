From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 09 Aug 2017 15:12:58 +0000
Subject: Re: [PATCH 3/3] net: rxrpc: Replace time_t type with time64_t type
Message-Id: <CAK8P3a2STbhgFB5kbVTZqAgY70K_GCaWgj6Kqs4RJOOt2oSd-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1502246501.git.baolin.wang@linaro.org>
	<8ac57c96bf5a0695ecc67fd230440b0b9d15740f.1502246502.git.baolin.wang@linaro.org>
	<CAK8P3a2WU5uYddGrkWhyfNB4qTEDYne_pyCVG6n5b1w+vb1-OQ@mail.gmail.com>
	<6767.1502271233@warthog.procyon.org.uk>
	<CAK8P3a3L11rXAV8-hE1fNtAZyMBNnQneRm5g7F8VDmk7HjQV4A@mail.gmail.com>
	<11686.1502285205@warthog.procyon.org.uk>
In-Reply-To: <11686.1502285205@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Wed, Aug 9, 2017 at 3:26 PM, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Do you know which format is used in practice? Are both kad and k5 common
>> among rxrpc users?
>
> The aklog program I'm using uses the non-XDR interface to push a Kerberos 5
> ticket to the kernel, so it doesn't actually invoke rxrpc_preparse_xdr() from
> rxrpc_preparse().

Ah, I'm slowly starting to understand how this fits together. So you can add
a key either through key_add() from local user space, or through an rxrpc
socket.

From what I can tell, the program you have at
http://people.redhat.com/~dhowells/rxrpc/klog.c will keep working beyond
2038 but not beyond 2106 on all 64-bit architectures and on those
32-bit systems that have a libc with 64-bit time_t. It could be modified
to use the xdr_rxk5 key format, which would make it use 64-bit time
values (and require the kernel fix mentioned above).

In contrast, the rxrpc socket interface would need a major rework to
support 64-bit expiration times. It receives a kerberos ticket with a
32-bit issue time
that gets used to calculate the expiry time in rxkad_decrypt_ticket, and from
there we pass it through a  rxrpc_key_data_v1 into key_instantiate_and_link(),
which calls rxrpc_preparse() and that just takes the expiry out again and sticks
it into another 32-bit field in struct rxkad_key, from where it
finally gets copied
into the (now 64-bit) key_preparsed_payload->expiry field.

Does my understanding match what you intended for the interfaces? Is there
a need to extend the rxrpc socket interface to support xdr_rxk5 keys as well?

         Arnd
