From: Denis Kenzior <denkenz@gmail.com>
Date: Mon, 14 May 2018 18:48:26 +0000
Subject: Re: [RFC PATCH 1/5] KEYS: Provide key type operations for kpp ops
Message-Id: <e1179cb9-c0c1-df4b-f894-fa363a8c4796@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228165230.18729-2-tudor.ambarus@microchip.com>
In-Reply-To: <20180228165230.18729-2-tudor.ambarus@microchip.com>
To: keyrings@vger.kernel.org

Hi Tudor,

On 02/28/2018 10:52 AM, Tudor Ambarus wrote:
> Provide three new operations in the key_type struct that can be used to
> provide access to kpp operations. These will be implemented for the
> asymmetric key type in a later patch and may refer to a key retained in
> RAM by the kernel or a key retained in crypto hardware.
> 
>      int (*asym_kpp_query)(const struct kernel_kpp_params *params,
>                            struct kernel_kpp_query *res);
>      int (*asym_kpp_gen_pubkey)(struct kernel_kpp_params *params,
> 			       void *out);
>      int (*asym_kpp_compute_ss)(struct kernel_kpp_params *params,
>                                 const void *in, void *out);
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   Documentation/security/keys/core.rst | 54 ++++++++++++++++++++++++++++++++++++
>   include/linux/key-type.h             |  7 +++++
>   include/linux/keyctl.h               | 11 ++++++++
>   include/uapi/linux/keyctl.h          |  3 ++
>   4 files changed, 75 insertions(+)
> 
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index d224fd0..9b69a1f 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -1688,6 +1688,60 @@ The structure has a number of fields, some of which are mandatory:
>        If successful, 0 will be returned.  If the key doesn't support this,
>        EOPNOTSUPP will be returned.
>   
> +  *  ``int (*asym_kpp_gen_pubkey)(struct kernel_kpp_params *params, void *out);``
> +  *  ``int (*asym_kpp_compute_ss)(struct kernel_kpp_params *params, const void *in, void *out);``
> +
> +     These methods are optional. If provided the first allows to generate the
> +     public key pair corresponding to the private key. The second method allows
> +     to generate a shared secret by  combining the private key and the other
> +     party's public key.
> +
> +     In all cases, the following information is provided in the params block::
> +
> +       struct kernel_kpp_query {
> +               struct key      *key;
> +               __u32           in_len;         /* Input data size */
> +               __u32           out_len;        /* Output buffer size */
> +       }
> +

Probably not a huge deal as most common key sizes are already supported, 
but... is there a way to query supported key sizes?  I think for 
DH_COMPUTE we didn't have this problem as everything was done in 
software.  However, if the intent is to use TPM / other hardware engines 
we might need a way to query supported key sizes.

> +     This includes the key to be used and the sizes in bytes of the input and
> +     output buffers.
> +
> +     For a given operation, the in and out buffers are used as follows::
> +
> +       Operation ID            in,in_len            out,out_len
> +       ============ ==========  ============
> +       KEYCTL_KPP_GEN_PUBKEY   -                    Corresponding public key
> +       KEYCTL_KPP_COMPUTE_SS   Pair's public key    Shared Secret
> +
> +     If successful, the public key generation and the shared secret computation
> +     will return the amount of data written into the output buffer.
> +
> +  *  ``int (*asym_kpp_query)(const struct kernel_kpp_params *params, struct kernel_kpp_query *res);``
> +
> +     This method is optional. If provided it allows information about the
> +     asymmetric KPP (Key Protocol Primitives) key held in the key to be
> +     determined.
> +
> +     The ``params`` block will contain the key to be queried. ``in_len`` and
> +     ``out_len`` are unused.
> +
> +     If successful, the following information is filled in::
> +
> +       struct kernel_kpp_query {
> +               __u32           supported_ops;  /* Which ops are supported */
> +               __u32           max_size;       /* Maximum size of the output buffer */
> +       };
> +
> +     The supported_ops field will contain a bitmask indicating what operations
> +     are supported by the key, including public key generation and shared
> +     secret computation. The following constants are defined for this::
> +
> +       KEYCTL_SUPPORTS_{GEN_PUBKEY, COMPUTE_SS};
> +
> +     If successful, 0 is returned.  If the key is not an asymmetric kpp key,
> +     EOPNOTSUPP is returned.
> +
>   
>   Request-Key Callback Service
>   ==============
> diff --git a/include/linux/key-type.h b/include/linux/key-type.h
> index bc9af55..d354b6b 100644
> --- a/include/linux/key-type.h
> +++ b/include/linux/key-type.h
> @@ -19,6 +19,8 @@
>   
>   struct kernel_pkey_query;
>   struct kernel_pkey_params;
> +struct kernel_kpp_query;
> +struct kernel_kpp_params;
>   
>   /*
>    * key under-construction record
> @@ -165,6 +167,11 @@ struct key_type {
>   			   const void *in, void *out);
>   	int (*asym_verify_signature)(struct kernel_pkey_params *params,
>   				     const void *in, const void *in2);
> +	int (*asym_kpp_query)(const struct kernel_kpp_params *params,
> +			      struct kernel_kpp_query *res);
> +	int (*asym_kpp_gen_pubkey)(struct kernel_kpp_params *params, void *out);
> +	int (*asym_kpp_compute_ss)(struct kernel_kpp_params *params,
> +				   const void *in, void *out);
>   
>   	/* internal fields */
>   	struct list_head	link;		/* link in types list */
> diff --git a/include/linux/keyctl.h b/include/linux/keyctl.h
> index e89b4a4..8f464ea 100644
> --- a/include/linux/keyctl.h
> +++ b/include/linux/keyctl.h
> @@ -43,4 +43,15 @@ struct kernel_pkey_params {
>   	enum kernel_pkey_operation op : 8;
>   };
>   
> +struct kernel_kpp_query {
> +	__u32		supported_ops;	/* Which ops are supported */
> +	__u32           max_size;	/* Maximum size of the output buffer */
> +};
> +
> +struct kernel_kpp_params {
> +	struct key	*key;
> +	__u32		in_len;         /* Input data size */
> +	__u32		out_len;	/* Output buffer size */
> +};
> +
>   #endif /* __LINUX_KEYCTL_H */
> diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
> index d75d208..98b79f8 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -107,4 +107,7 @@ struct keyctl_pkey_params {
>   	__u32		__spare[7];
>   };
>   
> +#define KEYCTL_SUPPORTS_GEN_PUBKEY	0x0f

This looks fishy, the other KEYCTL_SUPPORTS_ block ends at 0x08.  This 
would imply that KPP supports encryption, decryption, sign, verify.  Do 
you mean 0x10 here?

> +#define KEYCTL_SUPPORTS_COMPUTE_SS	0x10
> +

And 0x20 here?

>   #endif /*  _LINUX_KEYCTL_H */
> 

Otherwise this looks good to me.  Feel free to add:

Reviewed-by: Denis Kenzior <denkenz@gmail.com>

Regards,
-Denis
