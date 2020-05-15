From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 15 May 2020 15:06:19 +0000
Subject: Re: [PATCH] keys: Move permissions checking decisions into the checking code
Message-Id: <CAEjxPJ5wW2qHYDsqKr5rjnRJ++4f2LXobCQkKZvWCSb_j0WN6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
 <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
 <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com> <3999877.1589475539@warthog.procyon.org.uk>
In-Reply-To: <3999877.1589475539@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, May 14, 2020 at 12:59 PM David Howells <dhowells@redhat.com> wrote:
>
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

Why can't they be deleted / removed?  They can't ever be deleted or
removed or for some period of time?

>      (2) KEY_FLAG_ROOT_CAN_CLEAR in key->flags - The keyring can be cleared by
>          CAP_SYS_ADMIN.

Why do some keyrings get this flag and others do not?  Under what
conditions?  Why is CAP_SYS_ADMIN the right capability for this?

>      (3) KEY_FLAG_ROOT_CAN_INVAL in key->flags - The key can be invalidated by
>          CAP_SYS_ADMIN.

Ditto.

>      (4) An appropriate auth token being set in cred->request_key_auth that
>          gives a process transient permission to view and instantiate a key.
>          This is used by the kernel to delegate instantiation to userspace.

Is this ever allowed across different credentials?  When?  Why?  Is
there a check between the different credentials before the auth token
is created?

>     Note that this requires some tweaks to the testsuite as some of the error
>     codes change.

Which testsuite?  keyring or selinux or both?  What error codes change
(from what to what)?  Does this constitute an ABI change?

I like moving more of the permission checking logic into the security
modules and giving them greater visibility and control.  That said, I
am somewhat concerned by the scale of this change, by the extent to
which you are exposing keyring internals inside the security modules,
and by the extent to which logic is getting duplicated in each
security module.  I'd suggest a more incremental approach, e.g. start
with just the enum patch, then migrate the easy cases, then consider
the more complicated cases.  And possibly we need multiple different
security hooks for the keyring subsystem that are more specialized for
the complicated cases.  If we authorize the delegation up front, we
don't need to check it later.
