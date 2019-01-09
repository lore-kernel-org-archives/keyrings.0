From: Kairui Song <kasong@redhat.com>
Date: Wed, 09 Jan 2019 02:02:41 +0000
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Message-Id: <CACPcB9e_1aom8hb2Xqd6u-QUmh=y+cni3YxrM09Mro2q_A5-gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190108081247.2266-1-kasong@redhat.com> <20190108081247.2266-2-kasong@redhat.com>
 <1546960680.19931.114.camel@linux.ibm.com> <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-security-module <linux-security-module@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

Thanks for the explanation Dave, my second thought is to let kexec use
the platform keyring directly, that is let kexec verify the image with
secondary/builtin keyring first then try platform keyring. And better
to make platform keyring independent of integrity subsystem, so kexec
could verify the image and don't depend on integrity. Any thought?

On Wed, Jan 9, 2019 at 9:34 AM Dave Young <dyoung@redhat.com> wrote:
>
> CC kexec list
> On 01/08/19 at 10:18am, Mimi Zohar wrote:
> > [Cc'ing the LSM and integrity mailing lists]
> >
> > Repeating my comment on PATCH 0/1 here with the expanded set of
> > mailing lists.
> >
> > The builtin and secondary keyrings have a signature change of trust
> > rooted in the signed kernel image.  Adding the pre-boot keys to the
> > secondary keyring breaks that signature chain of trust.
> >
> > Please do NOT add the pre-boot "platform" keys to the secondary
> > keyring.
>
> If we regard kexec as a bootloader, it sounds natural to use the
> platform key to verify the signature with kexec_file_load syscall.
>
> It will be hard for user to manually sign a kernel and import the key
> then to reuse kexec_file_load.
>
> I think we do not care if platform key can be added to secondary or not,
> any suggestions how can kexec_file to use the platform key?
>
> >
> > Mimi
> >
> >
> > On Tue, 2019-01-08 at 16:12 +0800, Kairui Song wrote:
> > > Currently kexec may need to verify the kerne image, and the kernel image
> > > could be signed with third part keys which are provided by paltform or
> > > firmware (eg. stored in MokListRT EFI variable). And the same time,
> > > kexec_file_load will only verify the image agains .builtin_trusted_keys
> > > or .secondary_trusted_keys according to configuration, but there is no
> > > way for kexec_file_load to verify the image against any third part keys
> > > mentioned above.
> > >
> > > In ea93102f3224 ('integrity: Define a trusted platform keyring') a
> > > .platform keyring is introduced to store the keys provided by platform
> > > or firmware. And with a few following commits including 15ea0e1e3e185
> > > ('efi: Import certificates from UEFI Secure Boot'), now keys required to
> > > verify the image is being imported to .paltform keyring, and later
> > > IMA-appraisal could access the keyring and verify the image.
> > >
> > > This patch links the .platform keyring to .secondary_trusted_keys so
> > > kexec_file_load could also leverage the .platform keyring to verify the
> > > kernel image.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > ---
> > >  certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
> > >  include/keys/platform_keyring.h | 12 ++++++++++++
> > >  security/integrity/digsig.c     |  7 +++++++
> > >  3 files changed, 49 insertions(+)
> > >  create mode 100644 include/keys/platform_keyring.h
> > >
> > > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > > index 81728717523d..dcef0259e149 100644
> > > --- a/certs/system_keyring.c
> > > +++ b/certs/system_keyring.c
> > > @@ -18,12 +18,14 @@
> > >  #include <linux/verification.h>
> > >  #include <keys/asymmetric-type.h>
> > >  #include <keys/system_keyring.h>
> > > +#include <keys/platform_keyring.h>
> > >  #include <crypto/pkcs7.h>
> > >
> > >  static struct key *builtin_trusted_keys;
> > >  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> > >  static struct key *secondary_trusted_keys;
> > >  #endif
> > > +static struct key *platform_keys = NULL;
> > >
> > >  extern __initconst const u8 system_certificate_list[];
> > >  extern __initconst const unsigned long system_certificate_list_size;
> > > @@ -67,6 +69,12 @@ int restrict_link_by_builtin_and_secondary_trusted(
> > >             /* Allow the builtin keyring to be added to the secondary */
> > >             return 0;
> > >
> > > +   if (type = &key_type_keyring &&
> > > +       dest_keyring = secondary_trusted_keys &&
> > > +       payload = &platform_keys->payload)
> > > +           /* Allow the platform keyring to be added to the secondary */
> > > +           return 0;
> > > +
> > >     return restrict_link_by_signature(dest_keyring, type, payload,
> > >                                       secondary_trusted_keys);
> > >  }
> > > @@ -188,6 +196,28 @@ static __init int load_system_certificate_list(void)
> > >  }
> > >  late_initcall(load_system_certificate_list);
> > >
> > > +#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && defined(CONFIG_SECONDARY_TRUSTED_KEYRING)
> > > +
> > > +/*
> > > + * Link .platform keyring to .secondary_trusted_key keyring
> > > + */
> > > +static __init int load_platform_certificate_list(void)
> > > +{
> > > +   int ret = 0;
> > > +   platform_keys = integrity_get_platform_keyring();
> > > +   if (!platform_keys) {
> > > +           return 0;
> > > +   }
> > > +   ret = key_link(secondary_trusted_keys, platform_keys);
> > > +   if (ret < 0) {
> > > +           pr_err("Failed to link platform keyring: %d", ret);
> > > +   }
> > > +   return 0;
> > > +}
> > > +late_initcall(load_platform_certificate_list);
> > > +
> > > +#endif
> > > +
> > >  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > >
> > >  /**
> > > diff --git a/include/keys/platform_keyring.h b/include/keys/platform_keyring.h
> > > new file mode 100644
> > > index 000000000000..4f92ed6c0b42
> > > --- /dev/null
> > > +++ b/include/keys/platform_keyring.h
> > > @@ -0,0 +1,12 @@
> > > +#ifndef _KEYS_PLATFORM_KEYRING_H
> > > +#define _KEYS_PLATFORM_KEYRING_H
> > > +
> > > +#include <linux/key.h>
> > > +
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +
> > > +extern const struct key* __init integrity_get_platform_keyring(void);
> > > +
> > > +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
> > > +
> > > +#endif /* _KEYS_SYSTEM_KEYRING_H */
> > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > index f45d6edecf99..397758d4f12d 100644
> > > --- a/security/integrity/digsig.c
> > > +++ b/security/integrity/digsig.c
> > > @@ -176,3 +176,10 @@ int __init integrity_load_cert(const unsigned int id, const char *source,
> > >     pr_info("Loading X.509 certificate: %s\n", source);
> > >     return integrity_add_key(id, data, len, perm);
> > >  }
> > > +
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +struct key* __init integrity_get_platform_keyring(void)
> > > +{
> > > +   return keyring[INTEGRITY_KEYRING_PLATFORM];
> > > +}
> > > +#endif
> >
>
> Thanks
> Dave



-- 
Best Regards,
Kairui Song
