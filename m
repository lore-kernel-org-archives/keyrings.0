From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 21 Aug 2019 14:20:44 +0000
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
Message-Id: <1566397244.5162.11.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1562814435.4014.11.camel@linux.ibm.com>
         <28477.1562362239@warthog.procyon.org.uk>
         <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
         <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com>
         <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
         <23498.1565962602@warthog.procyon.org.uk>
In-Reply-To: <23498.1565962602@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, James Morris <jmorris@namei.org>, keyrings@vger.kernel.org, Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-integrity@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On Fri, 2019-08-16 at 14:36 +0100, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > Sorry for the delay.  An exception is needed for loading builtin keys
> > "KEY_ALLOC_BUILT_IN" onto a keyring that is not writable by userspace.
> >  The following works, but probably is not how David would handle the
> > exception.
> 
> I think the attached is the right way to fix it.
> 
> load_system_certificate_list(), for example, when it creates keys does this:
> 
> 	key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
> 
> marking the keyring as "possessed" in make_key_ref().  This allows the
> possessor permits to be used - and that's the *only* way to use them for
> internal keyrings like this because you can't link to them and you can't join
> them.

In addition, as long as additional keys still can't be added or
existing keys updated by userspace on the .builtin_trusted_keys, then
this is fine.

> 
> David
> ---
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 57be78b5fdfc..1f8f26f7bb05 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -99,7 +99,7 @@ static __init int system_trusted_keyring_init(void)
>  	builtin_trusted_keys >  		keyring_alloc(".builtin_trusted_keys",
>  			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
> -			      &internal_key_acl, KEY_ALLOC_NOT_IN_QUOTA,
> +			      &internal_keyring_acl, KEY_ALLOC_NOT_IN_QUOTA,
>  			      NULL, NULL);
>  	if (IS_ERR(builtin_trusted_keys))
>  		panic("Can't allocate builtin trusted keyring\n");
> diff --git a/security/keys/permission.c b/security/keys/permission.c
> index fc84d9ef6239..86efd3eaf083 100644
> --- a/security/keys/permission.c
> +++ b/security/keys/permission.c
> @@ -47,7 +47,7 @@ struct key_acl internal_keyring_acl = {
>  	.usage	= REFCOUNT_INIT(1),
>  	.nr_ace	= 2,
>  	.aces = {
> -		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH),
> +		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
>  		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH),
>  	}
>  };

Thanks, David.  The builtin keys are now being loaded.

Mimi
