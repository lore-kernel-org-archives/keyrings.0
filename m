From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 01 Nov 2017 23:22:23 +0000
Subject: Re: [PATCH] KEYS: fix in-kernel documentation for keyctl_read()
Message-Id: <20171101232223.GA30281@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026205458.105299-1-ebiggers3@gmail.com>
In-Reply-To: <20171026205458.105299-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

On Wed, Nov 01, 2017 at 01:57:18PM +0000, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > -     As much of the data as can be fitted into the buffer will be copied to
> > -     userspace if the buffer pointer is not NULL.
> > -
> > -     On a successful return, the function will always return the amount of data
> > -     available rather than the amount copied.
> > +     On success, the function will return the amount of data placed into the
> > +     buffer.
> >  
> > +     If the specified buffer is too small, then the size of the buffer required
> > +     will be returned, and it is unspecified whether any data will be copied
> > +     into the buffer.
> 
> How about:
> 
>      If the specified buffer is too small, then the size of the buffer
>      required will be returned.  Note that, in this case, the contents of the
>      buffer may be have been overwritten in some undefined way.
> 
>      Otherwise, on success, the function will return the amount of data copied
>      into the buffer.
> 
> David

I guess that's fine --- either way users can't rely on the contents of the
buffer.  The man page should use the same wording, though.  Should I send a v2
of both patches?

Eric
