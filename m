From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 30 May 2019 11:35:06 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <CAFqZXNt0NP090oKtF3Zsq4bvvZ7peH8YNBa-9hiqk_AAXgc0kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com> <20190530071400.jpadh2fjjaqzyw6m@gondor.apana.org.au>
In-Reply-To: <20190530071400.jpadh2fjjaqzyw6m@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

On Thu, May 30, 2019 at 10:12 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, May 21, 2019 at 12:00:34PM +0200, Ondrej Mosnacek wrote:
> >
> > @@ -256,6 +362,48 @@ static int alg_setsockopt(struct socket *sock, int level, int optname,
> >                       goto unlock;
> >
> >               err = alg_setkey(sk, optval, optlen);
> > +#ifdef CONFIG_KEYS
> > +             break;
> > +     case ALG_SET_KEY_KEYRING_LOGON:
> > +             if (sock->state = SS_CONNECTED)
> > +                     goto unlock;
> > +             if (!type->setkey)
> > +                     goto unlock;
> > +
> > +             err = alg_setkey_keyring(sk, &alg_keyring_type_logon,
> > +                                      optval, optlen);
> > +             break;
> > +     case ALG_SET_KEY_KEYRING_USER:
> > +             if (sock->state = SS_CONNECTED)
> > +                     goto unlock;
> > +             if (!type->setkey)
> > +                     goto unlock;
> > +
> > +             err = alg_setkey_keyring(sk, &alg_keyring_type_user,
> > +                                      optval, optlen);
> > +#if IS_REACHABLE(CONFIG_TRUSTED_KEYS)
> > +             break;
> > +     case ALG_SET_KEY_KEYRING_TRUSTED:
> > +             if (sock->state = SS_CONNECTED)
> > +                     goto unlock;
> > +             if (!type->setkey)
> > +                     goto unlock;
> > +
> > +             err = alg_setkey_keyring(sk, &alg_keyring_type_trusted,
> > +                                      optval, optlen);
> > +#endif
> > +#if IS_REACHABLE(CONFIG_ENCRYPTED_KEYS)
> > +             break;
> > +     case ALG_SET_KEY_KEYRING_ENCRYPTED:
> > +             if (sock->state = SS_CONNECTED)
> > +                     goto unlock;
> > +             if (!type->setkey)
> > +                     goto unlock;
> > +
> > +             err = alg_setkey_keyring(sk, &alg_keyring_type_encrypted,
> > +                                      optval, optlen);
> > +#endif
> > +#endif /* CONFIG_KEYS */
> >               break;
>
> What's with the funky placement of "break" outside of the ifdefs?

I swear that checkpatch.pl was complaining when I did it the normal
way, but now I tried it again and it isn't complaining anymore...
Perhaps in the meantime I rebased onto a more recent tree where this
checkpatch.pl quirk has been fixed... I'll remove the funk in future
revisions.

>
> > diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
> > index bc2bcdec377b..f2d777901f00 100644
> > --- a/include/uapi/linux/if_alg.h
> > +++ b/include/uapi/linux/if_alg.h
> > @@ -35,6 +35,13 @@ struct af_alg_iv {
> >  #define ALG_SET_OP                   3
> >  #define ALG_SET_AEAD_ASSOCLEN                4
> >  #define ALG_SET_AEAD_AUTHSIZE                5
> > +#define ALG_SET_PUBKEY                       6 /* reserved for future use */
> > +#define ALG_SET_DH_PARAMETERS                7 /* reserved for future use */
> > +#define ALG_SET_ECDH_CURVE           8 /* reserved for future use */
>
> Why do you need to reserve these values?

Because libkcapi already assumes these values [1] and has code that
uses them. Reserving will allow existing builds of libkcapi to work
correctly once the functionality actually lands in the kernel (if that
ever happens). Of course, it is libkcapi's fault to assume values for
these symbols (in released code) before they are commited in the
kernel, but it seemed easier to just add them along with this patch
rather than creating a confusing situation.

[1] https://github.com/smuellerDD/libkcapi/blob/master/lib/internal.h#L54

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
