From: Dave Young <dyoung@redhat.com>
Date: Wed, 29 Nov 2017 02:15:04 +0000
Subject: Re: [PATCH] certs: always use secondary keyring first if possible
Message-Id: <20171129021504.GA4080@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171118044711.GA7352@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20171118044711.GA7352@dhcp-128-65.nay.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org

On 11/18/17 at 12:47pm, Dave Young wrote:
> Commit d3bfe84129f6 introduced secondary_trusted_keys keyring, current
> users of verify_pkcs7_signature are below:
> net/wireless/reg.c : uses its own trusted_keys
> kernel/module_signing.c : pass NULL trusted_keys 
> crypto/asymmetric_keys/verify_pefile.c : pass NULL trusted_keys
> 
> For both module and pefile verification, there is no reason to use builtin
> keys only. Actually in Fedora kernel module signing code passes 1UL, but
> kexec code does not pass 1UL for pefile verification thus we have below bug
> https://bugzilla.redhat.com/show_bug.cgi?id70995
> 
> Drop the hard code 1UL checking so that pefile verification can use
> secondary keyring as well.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  certs/system_keyring.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- linux-x86.orig/certs/system_keyring.c
> +++ linux-x86/certs/system_keyring.c
> @@ -229,8 +229,6 @@ int verify_pkcs7_signature(const void *d
>  		goto error;
>  
>  	if (!trusted_keys) {
> -		trusted_keys = builtin_trusted_keys;
> -	} else if (trusted_keys = (void *)1UL) {
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  		trusted_keys = secondary_trusted_keys;
>  #else

Ping, can anyone review this?

Thanks
Dave
