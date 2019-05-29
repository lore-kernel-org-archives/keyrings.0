From: David Howells <dhowells@redhat.com>
Date: Wed, 29 May 2019 21:34:44 +0000
Subject: Re: [PATCH 6/7] keys: Add a keyctl to move a key between keyrings
Message-Id: <19364.1559165684@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LRH.2.21.1905290646010.31297@namei.org> <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856412507.10428.15987388402707639951.stgit@warthog.procyon.org.uk>
In-Reply-To: <alpine.LRH.2.21.1905290646010.31297@namei.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +
> > +	if (flags & ~KEYCTL_MOVE_EXCL)
> > +		return -EINVAL;
> > +
> > +	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE, KEY_NEED_LINK);
> > +	if (IS_ERR(key_ref)) {
> > +		ret = PTR_ERR(key_ref);
> > +		goto error;
> > +	}
> 
> This could probably be a simple return, as there is no cleanup.

Changed.

David
