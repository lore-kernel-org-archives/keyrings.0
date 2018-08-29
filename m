From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 29 Aug 2018 22:56:48 +0000
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
Message-Id: <20180829155648.e4ec141bf7c66b3f13433ffa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
	<20180829024224.GA6083@kroah.com>
In-Reply-To: <20180829024224.GA6083@kroah.com>
To: linux-security-module@vger.kernel.org

On Tue, 28 Aug 2018 19:42:24 -0700 Greg KH <gregkh@linuxfoundation.org> wrote:

> > --- lnx-416.orig/include/uapi/linux/keyctl.h
> > +++ lnx-416/include/uapi/linux/keyctl.h
> > @@ -65,7 +65,7 @@
> >  
> >  /* keyctl structures */
> >  struct keyctl_dh_params {
> > -	__s32 private;
> > +	__s32 dh_private;
> 
> Ick ick ick, why not just put the C "namespace" on all uapi files if you
> are including them from c++ code?  I'm sure this isn't the only problem
> that has this problem, right?
> 
> This is valid C, no need to start worrying about C++ reserved names.

We've done this before and it's a simple enough change in order to be
friendly toward others.

That being said, it's been like this for two years so presumably anyone
who is using this header from C++ is already `extern "C" { ...}' around
their #include.

I'm OK with the patch as-is, but if we run into this issue more often,
we might want to look at doing something kernel-wide.

I'm not sure what though. Adding

#ifdef __cplusplus
extern "C" {
#endif

...

#ifdef __cplusplus
}
#endif

into every uapi file might work.  Unpleasing.
