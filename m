From: Dave Young <dyoung@redhat.com>
Date: Wed, 09 Jan 2019 01:33:56 +0000
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Message-Id: <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190108081247.2266-1-kasong@redhat.com>
 <20190108081247.2266-2-kasong@redhat.com>
 <1546960680.19931.114.camel@linux.ibm.com>
In-Reply-To: <1546960680.19931.114.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, linux-security-module <linux-security-module@vger.kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

CC kexec list
On 01/08/19 at 10:18am, Mimi Zohar wrote:
> [Cc'ing the LSM and integrity mailing lists]
>=20
> Repeating my comment on PATCH 0/1 here with the expanded set of
> mailing lists.
>=20
> The builtin and secondary keyrings have a signature change of trust
> rooted in the signed kernel image.=A0=A0Adding the pre-boot keys to the
> secondary keyring breaks that signature chain of trust.
>=20
> Please do NOT add the pre-boot "platform" keys to the secondary
> keyring.

If we regard kexec as a bootloader, it sounds natural to use the
platform key to verify the signature with kexec_file_load syscall.

It will be hard for user to manually sign a kernel and import the key
then to reuse kexec_file_load.

I think we do not care if platform key can be added to secondary or not,
any suggestions how can kexec_file to use the platform key?

>=20
> Mimi
>=20
>=20
> On Tue, 2019-01-08 at 16:12 +0800, Kairui Song wrote:
> > Currently kexec may need to verify the kerne image, and the kernel image
> > could be signed with third part keys which are provided by paltform or
> > firmware (eg. stored in MokListRT EFI variable). And the same time,
> > kexec_file_load will only verify the image agains .builtin_trusted_keys
> > or .secondary_trusted_keys according to configuration, but there is no
> > way for kexec_file_load to verify the image against any third part keys
> > mentioned above.
> >=20
> > In ea93102f3224 ('integrity: Define a trusted platform keyring') a
> > .platform keyring is introduced to store the keys provided by platform
> > or firmware. And with a few following commits including 15ea0e1e3e185
> > ('efi: Import certificates from UEFI Secure Boot'), now keys required to
> > verify the image is being imported to .paltform keyring, and later
> > IMA-appraisal could access the keyring and verify the image.
> >=20
> > This patch links the .platform keyring to .secondary_trusted_keys so
> > kexec_file_load could also leverage the .platform keyring to verify the
> > kernel image.
> >=20
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
> >  include/keys/platform_keyring.h | 12 ++++++++++++
> >  security/integrity/digsig.c     |  7 +++++++
> >  3 files changed, 49 insertions(+)
> >  create mode 100644 include/keys/platform_keyring.h
> >=20
> > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > index 81728717523d..dcef0259e149 100644
> > --- a/certs/system_keyring.c
> > +++ b/certs/system_keyring.c
> > @@ -18,12 +18,14 @@
> >  #include <linux/verification.h>
> >  #include <keys/asymmetric-type.h>
> >  #include <keys/system_keyring.h>
> > +#include <keys/platform_keyring.h>
> >  #include <crypto/pkcs7.h>
> > =20
> >  static struct key *builtin_trusted_keys;
> >  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> >  static struct key *secondary_trusted_keys;
> >  #endif
> > +static struct key *platform_keys =3D NULL;
> > =20
> >  extern __initconst const u8 system_certificate_list[];
> >  extern __initconst const unsigned long system_certificate_list_size;
> > @@ -67,6 +69,12 @@ int restrict_link_by_builtin_and_secondary_trusted(
> >  		/* Allow the builtin keyring to be added to the secondary */
> >  		return 0;
> > =20
> > +	if (type =3D &key_type_keyring &&
> > +	    dest_keyring =3D secondary_trusted_keys &&
> > +	    payload =3D &platform_keys->payload)
> > +		/* Allow the platform keyring to be added to the secondary */
> > +		return 0;
> > +
> >  	return restrict_link_by_signature(dest_keyring, type, payload,
> >  					  secondary_trusted_keys);
> >  }
> > @@ -188,6 +196,28 @@ static __init int load_system_certificate_list(voi=
d)
> >  }
> >  late_initcall(load_system_certificate_list);
> > =20
> > +#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && defined(CONFIG_SECON=
DARY_TRUSTED_KEYRING)
> > +
> > +/*
> > + * Link .platform keyring to .secondary_trusted_key keyring
> > + */
> > +static __init int load_platform_certificate_list(void)
> > +{
> > +	int ret =3D 0;
> > +	platform_keys =3D integrity_get_platform_keyring();
> > +	if (!platform_keys) {
> > +		return 0;
> > +	}
> > +	ret =3D key_link(secondary_trusted_keys, platform_keys);
> > +	if (ret < 0) {
> > +		pr_err("Failed to link platform keyring: %d", ret);
> > +	}
> > +	return 0;
> > +}
> > +late_initcall(load_platform_certificate_list);
> > +
> > +#endif
> > +
> >  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > =20
> >  /**
> > diff --git a/include/keys/platform_keyring.h b/include/keys/platform_ke=
yring.h
> > new file mode 100644
> > index 000000000000..4f92ed6c0b42
> > --- /dev/null
> > +++ b/include/keys/platform_keyring.h
> > @@ -0,0 +1,12 @@
> > +#ifndef _KEYS_PLATFORM_KEYRING_H
> > +#define _KEYS_PLATFORM_KEYRING_H
> > +
> > +#include <linux/key.h>
> > +
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +
> > +extern const struct key* __init integrity_get_platform_keyring(void);
> > +
> > +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
> > +
> > +#endif /* _KEYS_SYSTEM_KEYRING_H */
> > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > index f45d6edecf99..397758d4f12d 100644
> > --- a/security/integrity/digsig.c
> > +++ b/security/integrity/digsig.c
> > @@ -176,3 +176,10 @@ int __init integrity_load_cert(const unsigned int =
id, const char *source,
> >  	pr_info("Loading X.509 certificate: %s\n", source);
> >  	return integrity_add_key(id, data, len, perm);
> >  }
> > +
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +struct key* __init integrity_get_platform_keyring(void)
> > +{
> > +	return keyring[INTEGRITY_KEYRING_PLATFORM];
> > +}
> > +#endif
>=20

Thanks
Dave
