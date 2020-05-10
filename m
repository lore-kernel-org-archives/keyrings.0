From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Date: Sun, 10 May 2020 15:51:15 +0000
Subject: Re: sign-file: full functionality with modern LibreSSL
Message-Id: <375f18b9-c23a-7f59-4432-374816725a79@rosalinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <f13b4174-bcfa-6569-0601-65a9bfc9bb92@rosalinux.ru>
In-Reply-To: <f13b4174-bcfa-6569-0601-65a9bfc9bb92@rosalinux.ru>
To: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org

19.03.2020 00:31, Mikhail Novosyolov пишет:
> Current pre-release version of LibreSSL has enabled CMS support,
> and now sign-file is fully functional with it.
>
> See https://github.com/libressl-portable/openbsd/commits/master
>
> To test buildability with current LibreSSL:
> ~$ git clone https://github.com/libressl-portable/portable.git
> ~$ cd portable && ./autogen.sh
> ~$ ./configure --prefix=/opt/libressl
> ~$ make
> ~# make install
> Go to the kernel source tree and:
> ~$ gcc -I/opt/libressl/include -L /opt/libressl/lib -lcrypto -Wl,-rpath,/opt/libressl/lib scripts/sign-file.c -o scripts/sign-file
>
> Fixes: f8688017 ("sign-file: fix build error in sign-file.c with libressl")
>
> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>

I would like to remember about this.

LibreSSL 3.1.1 has been released, and this patch (https://patchwork.kernel.org/patch/11446123/) is required to sign kernel modules using libressl.

Libressl 3.1.1 can sign them with functional parity with OpenSSL.

> ---
>  scripts/sign-file.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index fbd34b8e8f57..fd4d7c31d1bf 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -41,9 +41,10 @@
>   * signing with anything other than SHA1 - so we're stuck with that if such is
>   * the case.
>   */
> -#if defined(LIBRESSL_VERSION_NUMBER) || \
> -    OPENSSL_VERSION_NUMBER < 0x10000000L || \
> -    defined(OPENSSL_NO_CMS)
> +#if defined(OPENSSL_NO_CMS) || \
> +    ( defined(LIBRESSL_VERSION_NUMBER) \
> +    && (LIBRESSL_VERSION_NUMBER < 0x3010000fL) ) || \
> +    OPENSSL_VERSION_NUMBER < 0x10000000L
>  #define USE_PKCS7
>  #endif
>  #ifndef USE_PKCS7
