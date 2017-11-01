From: David Howells <dhowells@redhat.com>
Date: Wed, 01 Nov 2017 13:57:18 +0000
Subject: Re: [PATCH] KEYS: fix in-kernel documentation for keyctl_read()
Message-Id: <7859.1509544638@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026205458.105299-1-ebiggers3@gmail.com>
In-Reply-To: <20171026205458.105299-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> -     As much of the data as can be fitted into the buffer will be copied to
> -     userspace if the buffer pointer is not NULL.
> -
> -     On a successful return, the function will always return the amount of data
> -     available rather than the amount copied.
> +     On success, the function will return the amount of data placed into the
> +     buffer.
>  
> +     If the specified buffer is too small, then the size of the buffer required
> +     will be returned, and it is unspecified whether any data will be copied
> +     into the buffer.

How about:

     If the specified buffer is too small, then the size of the buffer
     required will be returned.  Note that, in this case, the contents of the
     buffer may be have been overwritten in some undefined way.

     Otherwise, on success, the function will return the amount of data copied
     into the buffer.

David
