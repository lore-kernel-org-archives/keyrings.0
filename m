From: Thomas Deutschmann <whissi@gentoo.org>
Date: Tue, 07 Jul 2020 15:55:30 +0000
Subject: keyutils-1.6.2 is failing tests/keyctl/watch/bad-args
Message-Id: <b8a08c75-f71a-3617-c14a-4eba4ac910bb@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LxlakjZLcuq3HjyyVxwzm2J5WN1I0BiHD"
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxlakjZLcuq3HjyyVxwzm2J5WN1I0BiHD
Content-Type: multipart/mixed; boundary="a7OLi36eIbCJozkdyi71wQuTWZgs9IuKi"

--a7OLi36eIbCJozkdyi71wQuTWZgs9IuKi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

we are seeing tests/keyctl/watch/bad-args failing in v1.6.2 while v1.6.1
is passing on same system:

> ### RUNNING TEST keyctl/watch/bad-args
> Running with session keyring RHTS/keyctl/869
> Joined session keyring: 187752783
> keyutils version: keyctl from keyutils-1.6.2 (Built 2020-07-07)
> =3D=3D=3D /var/tmp/portage/sys-apps/keyutils-1.6.2/work/keyutils-1.6.2-=
abi_x86_32.x86/tests/keyctl/watch/bad-args/test.out =3D=3D=3D
> +++ CHECK WATCH INVALID KEY                                            =
                                                 FAILED
> +++ ADD USER KEY
> +++ UNLINK KEY
> +++ UPDATE UNLINKED KEY
> FAILED
> +++ CHECK DODGY FILTERS
> make[1]: *** [Makefile:41: run] Error 1
> make[1]: Leaving directory '/var/tmp/portage/sys-apps/keyutils-1.6.2/wo=
rk/keyutils-1.6.2-abi_x86_32.x86/tests'
> make: *** [Makefile:250: test] Error 2


> cat keyutils-1.6.2-abi_x86_32.x86/tests/keyctl/watch/bad-args/test.out
> ++++ BEGINNING TEST
> +++ CHECK WATCH INVALID KEY
> keyctl watch 0
> nice: cannot set niceness: Permission denied
> /dev/watch_queue: No such file or directory
> =3D=3D=3D FAILED =3D=3D=3D
> Session Keyring
>  187752783 --alswrv    250   250  keyring: RHTS/keyctl/869
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +++ ADD USER KEY
> keyctl add user wibble stuff @s
> 499501700
> +++ UNLINK KEY
> keyctl unlink 499501700 @s
> +++ WAITING FOR KEY TO BE UNLINKED
> keyctl unlink 499501700 @s
> keyctl_unlink: No such file or directory
> keyctl unlink 499501700 @s
> keyctl_unlink: Required key not available
> +++ UPDATE UNLINKED KEY
> keyctl watch 499501700
> nice: cannot set niceness: Permission denied
> /dev/watch_queue: No such file or directory
> =3D=3D=3D FAILED =3D=3D=3D
> Session Keyring
>  187752783 --alswrv    250   250  keyring: RHTS/keyctl/869
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +++ CHECK DODGY FILTERS
> keyctl watch -fZ @s
> nice: cannot set niceness: Permission denied
> Unknown filter character 'Z'
> keyctl watch -fZ -fQ @s
> nice: cannot set niceness: Permission denied
> Unknown filter character 'Z'
> keyctl watch -f: @s
> nice: cannot set niceness: Permission denied
> Unknown filter character ':'
> ++++ FINISHED TEST: FAIL


--=20
Regards,
Thomas Deutschmann / Gentoo Linux Developer
fpr: C4DD 695F A713 8F24 2AA1 5638 5849 7EE5 1D5D 74A5


--a7OLi36eIbCJozkdyi71wQuTWZgs9IuKi--

--LxlakjZLcuq3HjyyVxwzm2J5WN1I0BiHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEExKRzo+LDXJgXHuURObr3Jv2BVkFAl8EmvVfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDEz
MTI5MUNFOEY4QjBENzI2MDVDN0I5NDQ0RTZFQkRDOUJGNjA1NTkACgkQRObr3Jv2
BVnNkwf+JO/AfODyrEoFcJqXCkBGSGf1QIMSvbKJfbxZA5PVKaypATh96lowEV+C
bDO+YRdKgvrhWsv3v999u3RY/WfkE7NUSxyFAKiHgHPsSQJdddClR6Ry1xiTgKhP
Ljvpj/Sc2/VXGYjDj1C9D63qzpbWQlpT/KJKqf6O6RDkfiXlgu0w6GhwCloF12ZV
7DCpOMvrGW5nnKGSPEdANRA/Pt++3xkkX/2SJJoY/CNnmK8x49TxBFqyHn/wSUuK
6dZG3bApPCZWJ2+8U8wC8jsBvIJfDJTaGlmF99l1s6Nywk5cDUDWlsyTYwhJOPWt
xAN6dRCO3UnH1H6s4Tz8iqV2Ua6WkQ==
=eov+
-----END PGP SIGNATURE-----

--LxlakjZLcuq3HjyyVxwzm2J5WN1I0BiHD--
