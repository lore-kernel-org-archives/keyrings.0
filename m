From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
Date: Sat, 06 Jul 2019 03:44:18 +0000
Subject: next-20190705 - problems generating certs/x509_certificate_list
Message-Id: <27671.1562384658@turing-police>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==_Exmh_1562384658_2389P"
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

--==_Exmh_1562384658_2389P
Content-Type: text/plain; charset=us-ascii

This worked fine in next-20190618, but in next-20190701 I'm seeing dmesg
entries at boot:

dmesg | grep -i x.509
[    8.345699] Loading compiled-in X.509 certificates
[    8.366137] Problem loading in-kernel X.509 certificate (-13)
[    8.507348] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.526556] cfg80211: Problem loading in-kernel X.509 certificate (-13)

I start debugging, and discover that certs/x509_certificate_list is a zero-length file.
I rm it, and 'make V=1 certs/system_certificates.o', which tells me:

(....)
make -f ./scripts/Makefile.headersinst obj=include/uapi
make -f ./scripts/Makefile.headersinst obj=arch/x86/include/uapi
make -f ./scripts/Makefile.build obj=certs certs/system_certificates.o
---- smoking gun alert
  scripts/extract-cert "" certs/x509_certificate_list
----
  gcc -Wp,-MD,certs/.system_certificates.o.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/9/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -D__KERNEL__ -D__ASSEMBLY__ -fno-PIE -m64 -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wa,-gdwarf-2 -DCC_USING_FENTRY -I.   -c -o certs/system_certificates.o certs/system_certificates.S

I go look at extract-cert.c, and sure enough, if the first parameter is a null string
it just goes and creates an empty file.

The Makefile says:

quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
      cmd_extract_certs  = scripts/extract-cert $(2) $@

and damned if I know why $(2) is "". Diffed the config files from -0618 and -0705,
not seeing anything relevant difference.

Any ideas?


--==_Exmh_1562384658_2389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXSAZEgdmEQWDXROgAQJdfBAAh0OK5AXK+UV3PLU7Zf5MEVbiRWdArkQl
/Mq2xWj7D7T/cNw5C6rkF+15mZr/Jrn7hQS2pdAXf2bBJ1yt+09dDr5+fCMkIzCv
+XKxE876Cd6CnrmyKHprKeitoRxs2Lgre1WPamzWwDKcq3HYgEl1mKrNEnk+bYhp
h/U7qQgpxxRKx+rZU0ZwejwpJw4wgtiYELHUP5ibaGjLwzqZhzQ6prfIW/ow9zRi
m08yxe1THhXs/3ZBAZsXx/LeoUZQhhb7H6WfKYMMU+mwnUSw0rw6fUI0VkOVHV6P
VRcaDpWOV8gAgO6rZffunApCZrRPlTMa+wZwh1vCXApEn1vCtgul6jLKBh9H0XSR
+TS5z90I2BBx9TpmjR2aP04DqATir2CBeXRm1KubQUKPeXJUnjxJF2y/uURUsK52
Uvb5lYRcdPWoYwDsi9eikPKPda8y7H+TQGuygzV9VQAbYyffHfXR3cQMnAVltxko
ZZqtxIBG+/7WtfmTUqN8hzKThHieF92yF1bGgJk8mIjppvUAsoReZgSKqGKePvHX
F3NZoKtMW4A78Yc6PYl9rVADMj0wtapdo8Y7hAjogaf27M/Qu7g94nITro2p8lVx
rJLj61K7Q644ChMjWodkFxNnI4UiiBR5ut+bwVb5IQE/8TSU/eRC1wuuEJk76gQD
MCKeD0Nx+bI=
=etAO
-----END PGP SIGNATURE-----

--==_Exmh_1562384658_2389P--
