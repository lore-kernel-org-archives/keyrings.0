From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 14 May 2020 11:00:14 +0000
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
Message-Id: <3efc41d3ba70d253e30187485459a724a36bb5a9.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
         <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, stephen.smalley.work@gmail.com
Cc: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2020-05-12 at 23:33 +0100, David Howells wrote:
> Since the meaning of combining the KEY_NEED_* constants is undefined, make
> it so that you can't do that by turning them into an enum.
> 
> The enum is also given some extra values to represent special
> circumstances, such as:
> 
>  (1) The '0' value is reserved and causes a warning to trap the parameter
>      being unset.
> 
>  (2) The key is to be unlinked and we require no permissions on it, only
>      the keyring, (this replaces the KEY_LOOKUP_FOR_UNLINK flag).
> 
>  (3) An override due to CAP_SYS_ADMIN.
> 
>  (4) An override due to an instantiation token being present.
> 
>  (5) The permissions check is being deferred to later key_permission()
>      calls.
> 
> The extra values give the opportunity for LSMs to audit these situations.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: keyrings@vger.kernel.org
> cc: selinux@vger.kernel.org

So extensive comments already from Stephen and Paul that I'll just
wait for the next version (agree with the idea though).

/Jarkko
