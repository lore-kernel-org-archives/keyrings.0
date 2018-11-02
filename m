From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 14:35:47 +0000
Subject: Re: [PATCH v2 2/7] keyctl_dh_compute.3: mention /proc/crypto for hashnames
Message-Id: <10469.1541169347@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

>  specifies the Linux kernel crypto API name for a hash that shall be used
> -for the key derivation function, such as sha256.
> +for the key derivation function, such as sha256. See
> +.I /proc/crypto
> +for available hashes on the system.
>  The
>  .I hashname
>  must be a NULL terminated string.

I've moved your addition to the end of the paragraph as it seems to read
better there.

David
