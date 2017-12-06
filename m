From: Julia Lawall <julia.lawall@lip6.fr>
Date: Wed, 06 Dec 2017 14:53:03 +0000
Subject: Re: [PATCH] security: keys: remove redundant assignment to key_ref
Message-Id: <alpine.DEB.2.20.1712061551310.25998@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.20.1712051116130.21642@localhost>
	<20171204181424.15808-1-colin.king@canonical.com>
	<15713.1512571817@warthog.procyon.org.uk>
In-Reply-To: <15713.1512571817@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org



On Wed, 6 Dec 2017, David Howells wrote:

> James Morris <james.l.morris@oracle.com> wrote:
>
> > I think a general cleanup in that function to make all of these follow the
> > pattern:
> >
> > 	if (something) {
> > 		key_ref = ERR_PTR(-error);
> > 		goto error;
> > 	}
> >
> > rather than unconditionally setting the error first, would be better, but
> > this is a clear enough fix on its own.
>
> There's a preference in Linux to use:
>
> 	key_ref = ERR_PTR(-error);
>  	if (something)
>  		goto error;
>
> instead because it uses less vertical space.  It might originally have been
> promulgated by Linus, but I don't remember.  Though you do have a point - your
> way makes error handling less subject breakage from code rearrangement.

I have the impression that there are many examples of both approaches.

julia

>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
