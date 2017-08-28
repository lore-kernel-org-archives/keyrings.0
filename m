From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Mon, 28 Aug 2017 10:34:01 +0000
Subject: Re: [PATCH 7/8] crypto: ecdh - constify key
Message-Id: <cdf29df5-ff6f-3330-0ecb-1d854217c7bd@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <2715753.J0rCo2lbig@positron.chronox.de>
 <1694255.qHQGcMPfKl@positron.chronox.de>
In-Reply-To: <1694255.qHQGcMPfKl@positron.chronox.de>
To: =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Cc: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>



On 04/19/2017 02:07 AM, Stephan M=C3=BCller wrote:
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>   include/crypto/ecdh.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
> index 03a64f6..b5bb149 100644
> --- a/include/crypto/ecdh.h
> +++ b/include/crypto/ecdh.h
> @@ -40,7 +40,7 @@
>    */
>   struct ecdh {
>   	unsigned short curve_id;
> -	char *key;
> +	const char *key;
>   	unsigned short key_size;
>   };
>  =20
>=20

I just came across this and remembered that Stephan already
made a patch, so:

Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>
