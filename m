From: Kairui Song <kasong@redhat.com>
Date: Tue, 15 Jan 2019 16:48:46 +0000
Subject: Re: [RFC PATCH v2 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Message-Id: <CACPcB9e+TWK7s5ud_yNd4EiuFyM5hctAMqBSnOZzL3g03ryr_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190115094542.17129-1-kasong@redhat.com> <20190115094542.17129-3-kasong@redhat.com>
 <1547567218.4156.289.camel@linux.ibm.com>
In-Reply-To: <1547567218.4156.289.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com, Dave Young <dyoung@redhat.com>, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

On Tue, Jan 15, 2019 at 11:47 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
>
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 7d97e432cbbc..a06b04065bb1 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -534,9 +534,18 @@ static int bzImage64_cleanup(void *loader_data)
> >  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> >  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
> >  {
> > -     return verify_pefile_signature(kernel, kernel_len,
> > -                                    VERIFY_USE_SECONDARY_KEYRING,
> > -                                    VERIFYING_KEXEC_PE_SIGNATURE);
> > +     int ret;
> > +     ret = verify_pefile_signature(kernel, kernel_len,
> > +                     VERIFY_USE_SECONDARY_KEYRING,
> > +                     VERIFYING_KEXEC_PE_SIGNATURE);
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>
> Consider using IS_ENABLED() or IS_BUILTIN().
>
> Mimi

Thanks for the suggestion, will update the patch later if there are no
other comments.

>
> > +     if (ret = -ENOKEY) {
> > +             ret = verify_pefile_signature(kernel, kernel_len,
> > +                             VERIFY_USE_PLATFORM_KEYRING,
> > +                             VERIFYING_KEXEC_PE_SIGNATURE);
> > +     }
> > +#endif
> > +     return ret;
> >  }
> >  #endif
>



--
Best Regards,
Kairui Song
