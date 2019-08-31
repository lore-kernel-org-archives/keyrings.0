From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Sat, 31 Aug 2019 14:27:49 +0000
Subject: Re: [PATCH 1/2] sign-file: introduce check_module_sig
Message-Id: <d02fabb7-057f-430e-4fc1-0f1cf0343334@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <92f6ccea-f36e-61b9-9013-2c037ef24b14@linux.alibaba.com>
In-Reply-To: <92f6ccea-f36e-61b9-9013-2c037ef24b14@linux.alibaba.com>
To: keyrings@vger.kernel.org



On 2019/8/31 下午4:22, Yihao Wu wrote:
> This method checks if there's any existing signature. And it returns the
> actual module size, which excludes the signature.
> 
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
>  scripts/sign-file.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)

I'm assuming your patch is based on the latest upstream.

> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index fbd34b8e8f57..8647a78368d3 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -62,9 +62,11 @@ struct module_signature {
>  	uint32_t	sig_len;	/* Length of signature data */
>  };
>  
> +#define SIGSIZ (sizeof(struct module_signature))
>  #define PKEY_ID_PKCS7 2
>  
>  static char magic_number[] = "~Module signature appended~\n";
> +#define MAGIC_SIZE (sizeof(magic_number) - 1)
>  
>  static __attribute__((noreturn))
>  void format(void)
> @@ -132,6 +134,74 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
>  	return pwlen;
>  }
>  
> +/*
> + * Check if there is at least one valid PKCS#7 signature
> + */
> +static bool check_module_sig(char *module_name, unsigned long *module_size)
> +{
> +	int sig_offset, magic_offset;
> +	unsigned long file_size, offset;
> +	uint32_t sig_len;
> +	char buf[4096];
> +	uint16_t type;
> +	BIO *bm;
> +
> +	bm = BIO_new_file(module_name, "rb");
> +	ERR(!bm, "%s", module_name);
> +
> +	while (BIO_read(bm, buf, 4096) > 0)

> +		;
> +	file_size = *module_size = offset = BIO_number_read(bm);

Use the combination of BIO_seek() and BIO_tell() to get file size instead.

> +
> +	for (;;) {
> +		magic_offset = offset - MAGIC_SIZE;
> +		if (magic_offset < 0)
> +			break;
> +
> +		if (BIO_seek(bm, magic_offset))
> +			break;
> +
> +		if (BIO_read(bm, buf, MAGIC_SIZE) != MAGIC_SIZE)
> +			break;
> +
> +		if (memcmp(buf, magic_number, MAGIC_SIZE))
> +			break;
> +
> +		if (magic_offset <= SIGSIZ)
> +			break;
> +
> +		sig_offset = magic_offset - 4;
> +		if (BIO_seek(bm, sig_offset))
> +			break;
> +
> +		if (BIO_read(bm, &sig_len, 4) != 4)

Change all hardcoding "4" to sizeof(sig_len).

> +			break;
> +
> +		sig_len = ntohl(sig_len);
> +
> +		offset -= MAGIC_SIZE + SIGSIZ + sig_len;
> +		if (offset <= 0)
> +			break;
> +
> +		if (BIO_seek(bm, offset))
> +			break;
> +
> +		if (BIO_read(bm, &type, 2) != 2)


Change all hardcoding "2" to sizeof(type).

Jia

> +			break;
> +
> +		/* The structured type must be a sequence. And the length of the
> +		 * content info must be at the next 2 bytes (0x82 - 0x80 = 0x2)
> +		 */
> +		if (type != 0x8230)
> +			break;
> +
> +		*module_size = offset;
> +	}
> +
> +	ERR(BIO_free(bm) < 0, "%s", module_name);
> +	return *module_size < file_size;
> +}
> +
>  static EVP_PKEY *read_private_key(const char *private_key_name)
>  {
>  	EVP_PKEY *private_key;
> 
