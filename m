From: David Howells <dhowells@redhat.com>
Date: Wed, 09 Aug 2017 15:45:47 +0000
Subject: Re: [PATCH 3/3] net: rxrpc: Replace time_t type with time64_t type
Message-Id: <29920.1502293547@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAK8P3a2STbhgFB5kbVTZqAgY70K_GCaWgj6Kqs4RJOOt2oSd-g@mail.gmail.com>
	<cover.1502246501.git.baolin.wang@linaro.org>
	<8ac57c96bf5a0695ecc67fd230440b0b9d15740f.1502246502.git.baolin.wang@linaro.org>
	<CAK8P3a2WU5uYddGrkWhyfNB4qTEDYne_pyCVG6n5b1w+vb1-OQ@mail.gmail.com>
	<6767.1502271233@warthog.procyon.org.uk>
	<CAK8P3a3L11rXAV8-hE1fNtAZyMBNnQneRm5g7F8VDmk7HjQV4A@mail.gmail.com>
	<11686.1502285205@warthog.procyon.org.uk>
In-Reply-To: <CAK8P3a2STbhgFB5kbVTZqAgY70K_GCaWgj6Kqs4RJOOt2oSd-g@mail.gmail.com>
To: linux-security-module@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> Ah, I'm slowly starting to understand how this fits together. So you can add
> a key either through key_add() from local user space, or through an rxrpc
> socket.

No, you can't add keys through an rxrpc socket.

There are three 'classes' of key:

 (1) Client keys (type rxrpc).  These must be added by add_key() by userspace
     (but could also be acquired by upcalling to /sbin/request-key) and then
     the kernel calls request_key() to locate them on entry through either a
     kafs inode/file operation or through sendmsg() to an AF_RXRPC socket.

 (2) Server keys (type rxrpc_s).  These are created by userspace and are
     presented to an AF_RXRPC server socket by calling setsockopt().  The
     server uses these to validate/decrypt the token passed by a RESPONSE
     packet.

 (3) Service connection keys (type rxrpc).  These are created internally by
     AF_RXRPC after a successful challenge/response negotiation to hold the
     security details so that we have a struct key to pass around that
     corresponds to the key in (1).

David
