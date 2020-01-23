From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 23 Jan 2020 15:46:30 +0000
Subject: Re: SELinux: How to split permissions for keys?
Message-Id: <de2c5cda-567b-d310-42f7-46a2c20969c4@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <8ee40192da117d9cdf4eab1e63ab5f77b359801c.camel@btinternet.com>
 <4057700.1579792320@warthog.procyon.org.uk>
In-Reply-To: <4057700.1579792320@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On 1/23/20 10:12 AM, David Howells wrote:
> Hi Stephen,
> 
> I have patches to split the permissions that are used for keys to make them a
> bit finer grained and easier to use - and also to move to ACLs rather than
> fixed masks.  See patch "keys: Replace uid/gid/perm permissions checking with
> an ACL" here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-acl
> 
> However, I may not have managed the permission mask transformation inside
> SELinux correctly.  Could you lend an eyeball?  The change to the permissions
> model is as follows:
> 
>      The SETATTR permission is split to create two new permissions:
>      
>       (1) SET_SECURITY - which allows the key's owner, group and ACL to be
>           changed and a restriction to be placed on a keyring.
>      
>       (2) REVOKE - which allows a key to be revoked.
>      
>      The SEARCH permission is split to create:
>      
>       (1) SEARCH - which allows a keyring to be search and a key to be found.
>      
>       (2) JOIN - which allows a keyring to be joined as a session keyring.
>      
>       (3) INVAL - which allows a key to be invalidated.
>      
>      The WRITE permission is also split to create:
>      
>       (1) WRITE - which allows a key's content to be altered and links to be
>           added, removed and replaced in a keyring.
>      
>       (2) CLEAR - which allows a keyring to be cleared completely.  This is
>           split out to make it possible to give just this to an administrator.
>      
>       (3) REVOKE - see above.
> 
> The change to SELinux is attached below.
> 
> Should the split be pushed down into the SELinux policy rather than trying to
> calculate it?

My understanding is that you must provide full backward compatibility 
with existing policies; hence, you must ensure that you always check the 
same SELinux permission(s) for the same operation when using an existing 
policy.

In order to support finer-grained distinctions in SELinux with future 
policies, you can define a new SELinux policy capability along with the 
new permissions, and if the policy capability is enabled in the policy, 
check the new permissions rather than the old ones. A recent example of 
adding a new policy capability and using it can be seen in:
https://lore.kernel.org/selinux/20200116194530.8696-1-jeffv@google.com/T/#u
although that patch was rejected for other reasons.

Another example was when we introduced fine-grained distinctions for all 
network address families, commit da69a5306ab92e07224da54aafee8b1dccf024f6.

The new policy capability also needs to be defined in libsepol for use 
by the policy compiler; an example can be seen in:
https://lore.kernel.org/selinux/20170714164801.6346-1-sds@tycho.nsa.gov/

Then future policies can declare the policy capability when they are 
ready to start using the new permissions instead of the old.

> 
> Thanks,
> David
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 116b4d644f68..c8db5235b01f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6556,6 +6556,7 @@ static int selinux_key_permission(key_ref_t key_ref,
>   {
>   	struct key *key;
>   	struct key_security_struct *ksec;
> +	unsigned oldstyle_perm;
>   	u32 sid;
>   
>   	/* if no specific permissions are requested, we skip the
> @@ -6564,13 +6565,26 @@ static int selinux_key_permission(key_ref_t key_ref,
>   	if (perm = 0)
>   		return 0;
>   
> +	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ | KEY_NEED_WRITE |
> +				KEY_NEED_SEARCH | KEY_NEED_LINK);
> +	if (perm & KEY_NEED_SETSEC)
> +		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
> +	if (perm & KEY_NEED_INVAL)
> +		oldstyle_perm |= KEY_NEED_SEARCH;
> +	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
> +		oldstyle_perm |= KEY_NEED_WRITE;
> +	if (perm & KEY_NEED_JOIN)
> +		oldstyle_perm |= KEY_NEED_SEARCH;
> +	if (perm & KEY_NEED_CLEAR)
> +		oldstyle_perm |= KEY_NEED_WRITE;
> +

I don't know offhand if this ensures that the same SELinux permission is 
always checked as it would have been previously for the same 
operation+arguments.  That's what you have to preserve for existing 
policies.

>   	sid = cred_sid(cred);
>   
>   	key = key_ref_to_ptr(key_ref);
>   	ksec = key->security;
>   
>   	return avc_has_perm(&selinux_state,
> -			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
> +			    sid, ksec->sid, SECCLASS_KEY, oldstyle_perm, NULL);
>   }
>   
>   static int selinux_key_getsecurity(struct key *key, char **_buffer)
> 
