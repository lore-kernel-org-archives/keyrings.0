From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 15 Jan 2019 15:54:49 +0000
Subject: Re: [RFC PATCH v2 1/2] integrity, KEYS: add a reference to platform keyring
Message-Id: <1547567689.4156.291.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190115094542.17129-1-kasong@redhat.com>
         <20190115094542.17129-2-kasong@redhat.com>
         <1547566455.4156.283.camel@linux.ibm.com>
         <CACPcB9fQUNiD8UEVDa+bU67PZSOkckwhwD00Qvu4m3G0JmqqHQ@mail.gmail.com>
In-Reply-To: <CACPcB9fQUNiD8UEVDa+bU67PZSOkckwhwD00Qvu4m3G0JmqqHQ@mail.gmail.com>
To: Kairui Song <kasong@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com, Dave Young <dyoung@redhat.com>, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

On Tue, 2019-01-15 at 23:47 +0800, Kairui Song wrote:
> On Tue, Jan 15, 2019 at 11:34 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
> > [snip]
> >
> > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > index f45d6edecf99..bfabc2a8111d 100644
> > > --- a/security/integrity/digsig.c
> > > +++ b/security/integrity/digsig.c
> > > @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
> > >               keyring[id] = NULL;
> > >       }
> > >
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +     if (id = INTEGRITY_KEYRING_PLATFORM) {
> > > +             set_platform_trusted_keys(keyring[id]);
> > > +     }
> > > +#endif
> > > +
> > >       return err;
> > >  }
> > >
> >
> > Any reason for setting it here as opposed to in the caller
> > platform_keyring_init()?
> >
> > Mimi
> >
> 
> Yes, "keyring" is static so unless I expose it to other files, it is
> only accessible here. And I think there should be no problem to put
> the set_platform_trusted_keys here.

Right, that's a really good reason.

Mimi
