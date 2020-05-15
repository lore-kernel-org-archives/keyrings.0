From: David Howells <dhowells@redhat.com>
Date: Fri, 15 May 2020 16:45:09 +0000
Subject: Re: [PATCH] keys: Move permissions checking decisions into the checking code
Message-Id: <196730.1589561109@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ5wW2qHYDsqKr5rjnRJ++4f2LXobCQkKZvWCSb_j0WN6w@mail.gmail.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk> <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com> <3999877.1589475539@warthog.procyon.org.uk>
In-Reply-To: <CAEjxPJ5wW2qHYDsqKr5rjnRJ++4f2LXobCQkKZvWCSb_j0WN6w@mail.gmail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> >      (1) KEY_FLAG_KEEP in key->flags - The key may not be deleted and/or things
> >          may not be removed from the keyring.
> 
> Why can't they be deleted / removed?  They can't ever be deleted or
> removed or for some period of time?

This is only settable internally to keep special keys, such as the blacklist
loaded from the EFI BIOS, from being removed.

> >      (2) KEY_FLAG_ROOT_CAN_CLEAR in key->flags - The keyring can be cleared by
> >          CAP_SYS_ADMIN.
> 
> Why do some keyrings get this flag and others do not?  Under what
> conditions?  Why is CAP_SYS_ADMIN the right capability for this?
> 
> >      (3) KEY_FLAG_ROOT_CAN_INVAL in key->flags - The key can be invalidated by
> >          CAP_SYS_ADMIN.
> 
> Ditto.

So that the sysadmin can clear, say, the NFS idmapper keyring or invalidate
DNS lookup keys.

> >      (4) An appropriate auth token being set in cred->request_key_auth that
> >          gives a process transient permission to view and instantiate a key.
> >          This is used by the kernel to delegate instantiation to userspace.
> 
> Is this ever allowed across different credentials?

The kernel upcalls by spawning a daemon.  I want to change this as it's not
compatible with containers since namespaces make this problematic.

> When?

The request_key() system call will do this.  The normal use case is something
like the AFS filesystem asking for a key so that it can do an operation.  The
possibility exists for the kernel to upcall, say, to something that does aklog
on behalf of the user - but aklog in turn needs to get the TGT out of the
keyrings.

> Why?  Is there a check between the different credentials before the
> auth token is created?

No.  I don't even know what the target creds will necessarily be at this
point.

> >     Note that this requires some tweaks to the testsuite as some of the
> >     error codes change.
> 
> Which testsuite?  keyring or selinux or both?

The keyring testsuite.  No idea about the SELinux one.

> What error codes change (from what to what)?  Does this constitute an ABI
> change?

The following:

 (1) Passing the wrong type of key to KEYCTL_DH_COMPUTE now gets you
     EOPNOTSUPP rather than ENOKEY.  This is now as documented in the manual
     page.

 (2) Passing key ID 0 or an invalid negative key ID to KEYCTL_DH_COMPUTE now
     gets you EINVAL rather than ENOKEY.

 (3) Passing key ID 0 or an invalid negative key ID to KEYCTL_READ now gets
     you EINVAL rather than ENOKEY.

Technically, it consistutes an ABI change, I suppose, but I think it is
probably sufficiently minor.

Or maybe on (2) and (3) I should go the other way.  You get ENOKEY for invalid
key IDs (such as 0 or unsupported negative ones) across all callers of
lookup_user_key().  This would at least by consistent with the manual pages.

> I like moving more of the permission checking logic into the security
> modules and giving them greater visibility and control.  That said, I
> am somewhat concerned by the scale of this change, by the extent to
> which you are exposing keyring internals inside the security modules,
> and by the extent to which logic is getting duplicated in each
> security module.

It's what you asked for.

Now, I don't know if the LSM needs to know that the main keyutils permissions
checker invoked an override.  At least one of the overrides will have gone
through the LSM anyway when capable() was called.

> I'd suggest a more incremental approach, e.g. start with just the enum
> patch, then migrate the easy cases, then consider the more complicated
> cases.  And possibly we need multiple different security hooks for the
> keyring subsystem that are more specialized for the complicated cases.  If
> we authorize the delegation up front, we don't need to check it later.

I'll consider it.  But I really need to get what I'm going to include in the
middle of the notifications patchset sorted now - or risk the notifications
and fsinfo patchsets getting bumped again.

Maybe what's needed is a pair of hooks whereby the call to capable() is
replaced with LSM hook specifically to ask about the overrides:

	security_key_use_sysadmin_override(key, cred);
	security_key_use_construction_override(key, cred);

And/or a hook to ask whether the process is allowed to do the request_key()
call that they want:

	security_request_key(struct key_type *type,
			     const char *description,
			     struct key_tag *domain_tag,
			     const void *callout_info,
			     size_t callout_len,
			     void *aux);

I don't really want to do a "can the kernel delegate to process X?" hook just
at the moment, since I want to change/extend that code and I don't want to
commit to any particular security information being present yet.

I can go back to the enum patch for the moment if you and Casey can put up
with that for the moment?

David
