From: klondike <klondike@klondike.es>
Date: Sat, 05 Oct 2019 13:47:32 +0000
Subject: Re: [PATCH] crypto: asymmetric_keys: select SYSTEM_DATA_VERIFICATION
Message-Id: <34b0f01f-13e6-86e1-5e44-a9987b304b69@klondike.es>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gIES5pIvLBRf5p1bpuDtJbw7OjyQcj5BK"
List-Id: <keyrings.vger.kernel.org>
References: <34dc7ee8-74f5-744e-a411-e36b462c4889@klondike.es>
In-Reply-To: <34dc7ee8-74f5-744e-a411-e36b462c4889@klondike.es>
To: keyrings@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gIES5pIvLBRf5p1bpuDtJbw7OjyQcj5BK
Content-Type: multipart/mixed; boundary="ENq7tGuYopFBHD5QtTwk2k9P62gUTm29A";
 protected-headers="v1"
From: klondike <klondike@klondike.es>
To: David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: Vivek Goyal <vgoyal@redhat.com>, keyrings@vger.kernel.org
Message-ID: <34b0f01f-13e6-86e1-5e44-a9987b304b69@klondike.es>
Subject: Re: [PATCH] crypto: asymmetric_keys: select SYSTEM_DATA_VERIFICATION
References: <34dc7ee8-74f5-744e-a411-e36b462c4889@klondike.es>
In-Reply-To: <34dc7ee8-74f5-744e-a411-e36b462c4889@klondike.es>

--ENq7tGuYopFBHD5QtTwk2k9P62gUTm29A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: sv-FI

El 5/10/19 a las 15:37, klondike escribi=C3=B3:
> SYSTEM_DATA_VERIFICATION is a non-visible symbol which is selected by i=
ts
> other users. PKCS7_TEST_KEY and SIGNED_PE_FILE_VERIFICATION both depend=
 on
> the symbol instead of selecting it which makes it impossible to choose
> these symbols unless another symbol selecting SYSTEM_DATA_VERIFICATION =
is
> already chosen.
>
> Replace their depends on SYSTEM_DATA_VERIFICATION menu attribute by a
> selects SYSTEM_DATA_VERIFICATION attribute so that the options can be
> efectively chosen by users.
>
> Signed-off-by: Francisco Blas Izquierdo Riera (klondike) <klondike@klon=
dike.es>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
>
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kc=
onfig
> index 1f1f004dc757..5940f343ab53 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -75,7 +75,7 @@ config PKCS7_MESSAGE_PARSER
> config PKCS7_TEST_KEY
> tristate "PKCS#7 testing key type"
> - depends on SYSTEM_DATA_VERIFICATION
> + select SYSTEM_DATA_VERIFICATION
> help
> This option provides a type of key that can be loaded up from a
> PKCS#7 message - provided the message is signed by a trusted key. If
> @@ -88,7 +88,7 @@ config PKCS7_TEST_KEY
> config SIGNED_PE_FILE_VERIFICATION
> bool "Support for PE file signature verification"
> depends on PKCS7_MESSAGE_PARSER=3Dy
> - depends on SYSTEM_DATA_VERIFICATION
> + select SYSTEM_DATA_VERIFICATION
> select CRYPTO_HASH
> select ASN1
> select OID_REGISTRY
>
Disregard the patch for now, I didn't notice the dependency loop. I'll tr=
y to get that fixed too.



--ENq7tGuYopFBHD5QtTwk2k9P62gUTm29A--

--gIES5pIvLBRf5p1bpuDtJbw7OjyQcj5BK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEDaSLWSPwfVgqfnPQ9L3S7+j/ePkFAl2YnvQACgkQ9L3S7+j/
ePlAERAAhVxirv4+KhqsZLpWRzMzC2EsbpoTR8Maf+N2bAnp6nJl908s90DOMrun
NnNVhhtztFPnwo2zd3GqHb6y82vbm94cf8lPy7hREa2kOxQ6ET9//EUEpw6oSB2C
IOR/qqcF3neioyBQZj0N1aJI3bQ6pWdUBA4+/35poXjg4D+M0rWsvc9RGpf09nEc
cuwRmYjuDaAL75TJV3FBXobk1Cg06GxRLtP8MyVujPbsgTJHJxSOZDg8xWdUC6ww
Asmo+RQ1dRU3JBzLzZaP9QMqPtQV0MyUpXgY/Uk8HgOH/SvR1ec3KMFlz+ZKRXtP
FnKhOKS5BtvAQYoYMypVdxNSQ6T9RvSSgt7OpfRQRw9ASAGqUWrsexc/yF6Edbkd
rL5Ado59H3YIqRqsHY7vaRzMUvk1TAFupGpi3iRnzJkQ4egCmKsOjTORTunEAP+Z
KM4cRfeTNMwkX5g43MCHbEQXX9Qp9mOF8125ibpxDTlfIRP7q2m7qD+8l4ojHTEW
vZ7yEHgMTzhEFPfP5ALXc0iI3/975XM3CGI/iQNVpU2dxOsMjd7hmbP6hgFoQT44
+tpB5Oxtf/hiHEOngC19NLsNao4vyw4g2YpM0AFscMkZYBjg9mg1gRKWdzb9eCcf
4MuJfOtsMTBalrfWUPd3arV9QOYbwnqSui8VSdq1FJjNaxVXC+Y=
=4XSb
-----END PGP SIGNATURE-----

--gIES5pIvLBRf5p1bpuDtJbw7OjyQcj5BK--
