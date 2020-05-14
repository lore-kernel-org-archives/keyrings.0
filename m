From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 14 May 2020 17:06:28 +0000
Subject: Re: [PATCH] keys: Move permissions checking decisions into the checking code
Message-Id: <bf760071-0b34-41e7-1bc0-7c4d85d9bc8a@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com>
 <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
 <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
 <3999877.1589475539@warthog.procyon.org.uk>
In-Reply-To: <3999877.1589475539@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>

On 5/14/2020 9:58 AM, David Howells wrote:
> How about this then?
>
> David
> ---
> commit fa37b6c7e2f86d16ede1e0e3cb73857152d51825
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu May 14 17:48:55 2020 +0100
>
>     keys: Move permissions checking decisions into the checking code
>     
>     Overhaul the permissions checking, moving the decisions of which permits to
>     request for what operation and what overrides to allow into the permissions
>     checking functions in keyrings, SELinux and Smack.
>     
>     To this end, the KEY_NEED_* constants are turned into an enum and expanded
>     in number to cover operation types individually.
>     
>     Note that some more tweaking is probably needed to separate kernel uses,
>     e.g. AFS using rxrpc keys, from direct userspace users.
>     
>     Some overrides are available and this needs to be handled specially:
>     
>      (1) KEY_FLAG_KEEP in key->flags - The key may not be deleted and/or things
>          may not be removed from the keyring.
>     
>      (2) KEY_FLAG_ROOT_CAN_CLEAR in key->flags - The keyring can be cleared by
>          CAP_SYS_ADMIN.
>     
>      (3) KEY_FLAG_ROOT_CAN_INVAL in key->flags - The key can be invalidated by
>          CAP_SYS_ADMIN.
>     
>      (4) An appropriate auth token being set in cred->request_key_auth that
>          gives a process transient permission to view and instantiate a key.
>          This is used by the kernel to delegate instantiation to userspace.
>     
>     Note that this requires some tweaks to the testsuite as some of the error
>     codes change.
>     
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>     cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>     cc: Paul Moore <paul@paul-moore.com>
>     cc: Stephen Smalley <stephen.smalley.work@gmail.com>
>     cc: Casey Schaufler <casey@schaufler-ca.com>
>     cc: keyrings@vger.kernel.org
>     cc: selinux@vger.kernel.org
>
<snip> ...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8c61d175e195..ac9c93c48097 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4230,13 +4230,15 @@ static void smack_key_free(struct key *key)
>   * smack_key_permission - Smack access on a key
>   * @key_ref: gets to the object
>   * @cred: the credentials to use
> - * @perm: requested key permissions
> + * @need_perm: requested key permission
>   *
>   * Return 0 if the task has read and write to the object,
>   * an error code otherwise
>   */
>  static int smack_key_permission(key_ref_t key_ref,
> -				const struct cred *cred, unsigned perm)
> +				const struct cred *cred,
> +				enum key_need_perm need_perm,
> +				unsigned int flags)
>  {
>  	struct key *keyp;
>  	struct smk_audit_info ad;
> @@ -4244,12 +4246,6 @@ static int smack_key_permission(key_ref_t key_ref,
>  	int request = 0;
>  	int rc;
>  
> -	/*
> -	 * Validate requested permissions
> -	 */
> -	if (perm & ~KEY_NEED_ALL)
> -		return -EINVAL;
> -
>  	keyp = key_ref_to_ptr(key_ref);
>  	if (keyp = NULL)
>  		return -EINVAL;
> @@ -4265,6 +4261,71 @@ static int smack_key_permission(key_ref_t key_ref,
>  	if (tkp = NULL)
>  		return -EACCES;
>  
> +	/*
> +	 * Validate requested permissions
> +	 */
> +	switch (need_perm) {
> +	case KEY_NEED_ASSUME_AUTHORITY:
> +		return 0;
> +
> +	case KEY_NEED_DESCRIBE:
> +	case KEY_NEED_GET_SECURITY:
> +		request |= MAY_READ;
> +		auth_can_override = true;
> +		break;
> +
> +	case KEY_NEED_CHOWN:
> +	case KEY_NEED_INVALIDATE:
> +	case KEY_NEED_JOIN:
> +	case KEY_NEED_LINK:
> +	case KEY_NEED_KEYRING_ADD:
> +	case KEY_NEED_KEYRING_CLEAR:
> +	case KEY_NEED_KEYRING_DELETE:
> +	case KEY_NEED_REVOKE:
> +	case KEY_NEED_SETPERM:
> +	case KEY_NEED_SET_RESTRICTION:
> +	case KEY_NEED_UPDATE:
> +		request |= MAY_WRITE;
> +		break;
> +
> +	case KEY_NEED_INSTANTIATE:
> +		auth_can_override = true;
> +		break;
> +
> +	case KEY_NEED_READ:
> +	case KEY_NEED_SEARCH:
> +	case KEY_NEED_USE:
> +	case KEY_NEED_WATCH:
> +		request |= MAY_READ;
> +		break;
> +
> +	case KEY_NEED_SET_TIMEOUT:
> +		request |= MAY_WRITE;
> +		auth_can_override = true;
> +		break;
> +
> +	case KEY_NEED_UNLINK:
> +		return 0; /* Mustn't prevent this; KEY_FLAG_KEEP is already
> +			   * dealt with. */
> +
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +	/* Just allow the operation if the process has an authorisation token.
> +	 * The presence of the token means that the kernel delegated
> +	 * instantiation of a key to the process - which is problematic if we
> +	 * then say that the process isn't allowed to get the description of
> +	 * the key or actually instantiate it.
> +	 */
> +	if (auth_can_override && cred->request_key_auth) {
> +		struct request_key_auth *rka > +			cred->request_key_auth->payload.data[0];
> +		if (rka->target_key = key)
> +			*_perm = 0;
> +	}
> +
>  	if (smack_privileged_cred(CAP_MAC_OVERRIDE, cred))
>  		return 0;
>  
> @@ -4273,10 +4334,6 @@ static int smack_key_permission(key_ref_t key_ref,
>  	ad.a.u.key_struct.key = keyp->serial;
>  	ad.a.u.key_struct.key_desc = keyp->description;
>  #endif
> -	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
> -		request |= MAY_READ;
> -	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
> -		request |= MAY_WRITE;
>  	rc = smk_access(tkp, keyp->security, request, &ad);
>  	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
>  	return rc;

Better. Thank you.
