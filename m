From: Yann Droneaud <ydroneaud@opteya.com>
Date: Thu, 06 Sep 2018 07:12:58 +0000
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-Id: <48b8af08170fb896c12cc4e3eae7501b4fa4181d.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <20180905165552.GB25206@kroah.com>
 <a1efae8d26cc5b73b180e9521d6b62590c55aa86.camel@opteya.com>
In-Reply-To: <a1efae8d26cc5b73b180e9521d6b62590c55aa86.camel-RlY5vtjFyJ3QT0dZR+AlfA@public.gmane.org>
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: moderated for non-subscribers <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryusuke Konishi <konishi.ryusuke-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>, linux-nilfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, codalist-/uMB558Y47wP4a1z8dhFYw@public.gmane.org, coda-ETDLCGt7PQU3uPMLIKxrzw@public.gmane.org, coreteam-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org, Kent Overstreet <kent.overstreet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Coly Li <colyli-l3A5Bk7waGM@public.gmane.org>, linux-bcache-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Jan Harkes <jaharkes-ETDLCGt7PQU3uPMLIKxrzw@public.gmane.org>, Michal Marek <michal.lkml-yyZNWGI4GtDR7s880joybQ@public.gmane.org>, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>

Le mercredi 05 septembre 2018 à 19:33 +0200, Yann Droneaud a écrit :
> Le mercredi 05 septembre 2018 à 18:55 +0200, Greg KH a écrit :
> > On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > > 
> > > Here's a set of patches that inserts a step into the build
> > > process to make
> > > sure that the UAPI headers can all be built together with C++ (if
> > > the
> > > compiler being used supports C++).  All but the final patch
> > > perform fixups,
> > > including:
> > 
> > Wait, why do we care?  What has recently changed to start to
> > directly
> > import kernel uapi files into C++ code?
> > 
> > And if userspace wants to do this, can't they do the C namespace
> > trick
> > themselves when they do the import?  That must be how they are
> > doing it
> > today, right?
> > 
> 
> They can't.
> 
> 
> Adding extern "C" { } doesn't magically make "class" a non keyword.
> Even if it was the case, writing C++ code using whatever->class would
> probably broke because class is a keyword in C++.
> 

For the record, libX11 has to handle the kink pf issue with C++
keyword:


https://gitlab.freedesktop.org/xorg/lib/libx11/blob/733f64bfeb311c1d040b2f751bfdef9c9d0f89ef/include/X11/Xlib.h#L227

typedef struct {
	XExtData *ext_data;	/* hook for extension to hang data */
	VisualID visualid;	/* visual id of this visual */
#if defined(__cplusplus) || defined(c_plusplus)
	int c_class;		/* C++ class of screen (monochrome, etc.) */
#else
	int class;		/* class of screen (monochrome, etc.) */
#endif
	unsigned long red_mask, green_mask, blue_mask;	/* mask values */
	int bits_per_rgb;	/* log base 2 of distinct color values */
	int map_entries;	/* color map entries */
} Visual;


Regards.

-- 
Yann Droneaud
OPTEYA
