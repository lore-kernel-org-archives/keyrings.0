From: James Morris <jmorris@namei.org>
Date: Tue, 28 May 2019 20:51:57 +0000
Subject: Re: [PATCH 6/7] keys: Add a keyctl to move a key between keyrings
Message-Id: <alpine.LRH.2.21.1905290646010.31297@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856412507.10428.15987388402707639951.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856412507.10428.15987388402707639951.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> +
> +	if (flags & ~KEYCTL_MOVE_EXCL)
> +		return -EINVAL;
> +
> +	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE, KEY_NEED_LINK);
> +	if (IS_ERR(key_ref)) {
> +		ret = PTR_ERR(key_ref);
> +		goto error;
> +	}

This could probably be a simple return, as there is no cleanup.

> +
> +	from_ref = lookup_user_key(from_ringid, 0, KEY_NEED_WRITE);
> +	if (IS_ERR(from_ref)) {
> +		ret = PTR_ERR(from_ref);
> +		goto error2;
> +	}
> +
> +	to_ref = lookup_user_key(to_ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
> +	if (IS_ERR(to_ref)) {
> +		ret = PTR_ERR(to_ref);
> +		goto error3;
> +	}
> +
> +	ret = key_move(key_ref_to_ptr(key_ref), key_ref_to_ptr(from_ref),
> +		       key_ref_to_ptr(to_ref), flags);
> +
> +	key_ref_put(to_ref);
> +error3:
> +	key_ref_put(from_ref);
> +error2:
> +	key_ref_put(key_ref);
> +error:
> +	return ret;
> +}
> +


-- 
James Morris
<jmorris@namei.org>
