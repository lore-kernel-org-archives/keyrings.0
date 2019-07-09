From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 09 Jul 2019 20:17:12 +0000
Subject: Re: next-20190705 - problems generating certs/x509_certificate_list
Message-Id: <20190709201712.GI641@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <27671.1562384658@turing-police>
In-Reply-To: <27671.1562384658@turing-police>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:44:18PM -0400, Valdis Kl=C4=93tnieks wrote:
> This worked fine in next-20190618, but in next-20190701 I'm seeing dmesg
> entries at boot:
>=20
> dmesg | grep -i x.509
> [    8.345699] Loading compiled-in X.509 certificates
> [    8.366137] Problem loading in-kernel X.509 certificate (-13)
> [    8.507348] cfg80211: Loading compiled-in X.509 certificates for regul=
atory database
> [    8.526556] cfg80211: Problem loading in-kernel X.509 certificate (-13)
>=20
> I start debugging, and discover that certs/x509_certificate_list is a zer=
o-length file.
> I rm it, and 'make V=3D1 certs/system_certificates.o', which tells me:
>=20
> (....)
> make -f ./scripts/Makefile.headersinst obj=3Dinclude/uapi
> make -f ./scripts/Makefile.headersinst obj=3Darch/x86/include/uapi
> make -f ./scripts/Makefile.build obj=CErts certs/system_certificates.o
> ---- smoking gun alert
>   scripts/extract-cert "" certs/x509_certificate_list
> ----
>   gcc -Wp,-MD,certs/.system_certificates.o.d  -nostdinc -isystem /usr/lib=
/gcc/x86_64-redhat-linux/9/include -I./arch/x86/include -I./arch/x86/includ=
e/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/gen=
erated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/=
linux/kconfig.h -D__KERNEL__ -D__ASSEMBLY__ -fno-PIE -m64 -DCONFIG_AS_CFI=
=3D1 -DCONFIG_AS_CFI_SIGNAL_FRAME=3D1 -DCONFIG_AS_CFI_SECTIONS=3D1 -DCONFIG=
_AS_SSSE3=3D1 -DCONFIG_AS_AVX=3D1 -DCONFIG_AS_AVX2=3D1 -DCONFIG_AS_AVX512=
=3D1 -DCONFIG_AS_SHA1_NI=3D1 -DCONFIG_AS_SHA256_NI=3D1 -Wa,-gdwarf-2 -DCC_U=
SING_FENTRY -I.   -c -o certs/system_certificates.o certs/system_certificat=
es.S
>=20
> I go look at extract-cert.c, and sure enough, if the first parameter is a=
 null string
> it just goes and creates an empty file.
>=20
> The Makefile says:
>=20
> quiet_cmd_extract_certs  =3D EXTRACT_CERTS   $(patsubst "%",%,$(2))
>       cmd_extract_certs  =3D scripts/extract-cert $(2) $@
>=20
> and damned if I know why $(2) is "". Diffed the config files from -0618 a=
nd -0705,
> not seeing anything relevant difference.
>=20
> Any ideas?
>=20

I'm seeing on mainline now:

[   10.915386] Problem loading in-kernel X.509 certificate (-13)

- Eric
