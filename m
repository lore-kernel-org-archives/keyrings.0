From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Sun, 03 Sep 2017 00:29:55 +0000
Subject: Re: [PATCH v2 4/6] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <ed93c70e-ceb9-134c-0dbf-2dd2991a4ef8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170902044020.GA7600@asgard.redhat.com>
In-Reply-To: <20170902044020.GA7600-ZbobWygYI+YXGNroddHbYwC/G2K4zDHf@public.gmane.org>
To: Eugene Syromyatnikov <evgsyr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Eugene, Stephan

On 09/02/2017 06:40 AM, Eugene Syromyatnikov wrote:
> ---
>  man2/keyctl.2 | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 179 insertions(+), 3 deletions(-)

Thanks for the patch, Eugene, and thanks for the review, Stephan. Applied.

Cheers,

Michael


> diff --git a/man2/keyctl.2 b/man2/keyctl.2
> index e4b4bc9..28d15a3 100644
> --- a/man2/keyctl.2
> +++ b/man2/keyctl.2
> @@ -25,6 +25,7 @@
>  .\" the source, must acknowledge the copyright and authors of this work.
>  .\" %%%LICENSE_END
>  .\"
> +.mso www.tmac
>  .TH KEYCTL 2 2017-03-13 Linux "Linux Key Management Calls"
>  .SH NAME
>  keyctl \- manipulate the kernel's key management facility
> @@ -1413,7 +1414,8 @@ via the function
>  .TP
>  .BR KEYCTL_DH_COMPUTE " (since Linux 4.7)"
>  .\" commit ddbb41148724367394d0880c516bfaeed127b52e
> -Compute a Diffie-Hellman shared secret or public key.
> +Compute a Diffie-Hellman shared secret or public key,
> +optionally applying key derivation function (KDF) to the result.
>  .IP
>  The
>  .I arg2
> @@ -1476,10 +1478,65 @@ system call was considered a good fit due to the DH algorithm's use
>  for deriving shared keys;
>  it also allows the type of the key to determine
>  which DH implementation (software or hardware) is appropriate.
> +.\" commit f1c316a3ab9d24df6022682422fe897492f2c0c8
>  .IP
> -The
> +If the
>  .I arg5
> -argument is reserved and must be 0.
> +argument is
> +.BR NULL ,
> +then the DH result itself is returned.
> +Otherwise (since Linux 4.12), it is a pointer to a structure which specifies
> +parameters of the KDF operation to be applied:
> +.IP
> +.in +4n
> +.EX
> +struct keyctl_kdf_params {
> +    char *hashname;     /* Hash algorithm name */
> +    char *otherinfo;    /* SP800-56A OtherInfo */
> +    __u32 otherinfolen; /* Length of otherinfo data */
> +    __u32 __spare[8];   /* Reserved */
> +};
> +.EE
> +.in
> +.IP
> +The
> +.B hashname
> +field is a null-terminated string which specifies hash name
> +(available into the kernel's crypto API; the list of the hashes available
> +is rather tricky to observe; please refer to the
> +.URL https://www.kernel.org/doc/html/latest/crypto/architecture.html "Kernel Crypto API Architecture"
> +for the information regarding how hash names are constructed and
> +to your kernel's source and configuration regarding what ciphers
> +and templates with type
> +.B CRYPTO_ALG_TYPE_SHASH
> +are available)
> +to be applied to DH result in KDF operation.
> +.IP
> +The
> +.B otherinfo
> +field is an
> +.I OtherInfo
> +data as described in SP800-56A section 5.8.1.2 and is algorithm-specific.
> +This data is concatenated with the result of DH operation and is provided as
> +an input to the KDF operation.
> +Its size is provided in the
> +.B otherinfolen
> +field and is limited by
> +.B KEYCTL_KDF_MAX_OI_LEN
> +constant that defined in
> +.B security/keys/internal.h
> +to a value of 64.
> +.IP
> +The
> +.B __spare
> +field is currently unused.
> +.\" commit 4f9dabfaf8df971f8a3b6aa324f8f817be38d538
> +It was ignored until Linux 4.13 (but still should be
> +user-addressable since it is copied to the kernel),
> +and should contain zeroes since Linux 4.13.
> +.IP
> +The KDF implementation complies with SP800-56A as well
> +as with SP800-108 (the counter KDF).
>  .SH RETURN VALUE
>  For a successful call, the return value depends on the operation:
>  .TP
> @@ -1535,6 +1592,12 @@ is set appropriately to indicate the error.
>  .B EACCES
>  The requested operation wasn't permitted.
>  .TP
> +.B EAGAIN
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and there was an error during crypto module initialisation.
> +.TP
>  .B EDEADLK
>  .I operation
>  was
> @@ -1545,6 +1608,43 @@ and the requested link would result in a cycle.
>  The key quota for the caller's user would be exceeded by creating a key or
>  linking it to the keyring.
>  .TP
> +.B EFAULT
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and one of the following has failed:
> +.RS
> +.IP \(bu 3
> +copying of
> +.BR "struct keyctl_dh_params" ,
> +provided in
> +.I arg2
> +argument, from the user space;
> +.IP \(bu
> +copying of
> +.BR "struct keyctl_kdf_params" ,
> +provided in non-NULL
> +.I arg5
> +argument, from the user space
> +(in case kernel supports performing KDF operation on DH operation result);
> +.IP \(bu
> +copying of data pointed by
> +.B hashname
> +field of
> +.B "struct keyctl_kdf_params"
> +from the user space;
> +.IP \(bu
> +copying of data pointed by
> +.B otherinfo
> +field of
> +.B struct keyctl_kdf_params
> +from the user space if
> +.B otherinfolen
> +field was non-zero;
> +.IP \(bu
> +copying of the result to the user space.
> +.RE
> +.TP
>  .B EINVAL
>  .I operation
>  was
> @@ -1567,6 +1667,20 @@ or
>  (the key description)
>  exceeded the limit (32 bytes and 4096 bytes respectively).
>  .TP
> +.BR EINVAL " (Linux kernels before 4.12)"
> +.I operation
> +was
> +.BR KEYCTL_DH_COMPUTE ,
> +argument
> +.I arg5
> +was non-NULL.
> +.TP
> +.B EINVAL
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +And the digest size of the hashing algorithm supplied is zero.
> +.TP
>  .B EINVAL
>  .I operation
>  was
> @@ -1574,6 +1688,33 @@ was
>  and the buffer size provided is not enough to hold the result.
>  Provide 0 as a buffer size in order to obtain the minimum buffer size.
>  .TP
> +.B EINVAL
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and the hash name provided in the
> +.B hashname
> +field of the
> +.B struct keyctl_kdf_params
> +pointed by
> +.I arg5
> +argument is too big (the limit is implementation-specific and varies between
> +kernel versions, but it is deemed big enough for all valid algorithm names).
> +.TP
> +.B EINVAL
> +.\" commit 4f9dabfaf8df971f8a3b6aa324f8f817be38d538
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and the
> +.B __spare
> +field of the
> +.B struct keyctl_kdf_params
> +provided in
> +.I arg5
> +argument
> +contains non-zero values.
> +.TP
>  .B EKEYEXPIRED
>  An expired key was found or specified.
>  .TP
> @@ -1590,6 +1731,23 @@ was
>  and the requested link would cause the maximum nesting depth
>  for keyrings to be exceeded.
>  .TP
> +.B EMSGSIZE
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and the buffer length exceeds
> +.B KEYCTL_KDF_MAX_OUTPUT_LEN
> +(which is 1024 currently)
> +or the
> +.B otherinfolen
> +field of
> +.B struct keyctl_kdf_parms
> +passed in
> +.I arg5
> +exceeds
> +.B KEYCTL_KDF_MAX_OI_LEN
> +(which is 64 currently).
> +.TP
>  .BR ENFILE " (Linux kernels before 3.13)"
>  .IR operation
>  was
> @@ -1606,6 +1764,18 @@ was
>  .B KEYCTL_UNLINK
>  and the key to be unlinked isn't linked to the keyring.
>  .TP
> +.B ENOENT
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and the hashing algorithm specified in the
> +.B hashname
> +field of the
> +.B struct keyctl_kdf_params
> +pointed by
> +.I arg5
> +argument hasn't been found.
> +.TP
>  .B ENOKEY
>  No matching key was found or an invalid key was specified.
>  .TP
> @@ -1662,6 +1832,12 @@ the parent process is not single-thread;
>  or the parent process is
>  .BR init (1)
>  or a kernel thread.
> +.TP
> +.B ETIMEDOUT
> +.I operation
> +was
> +.B KEYCTL_DH_COMPUTE
> +and the initialisation of crypto modules has timed out.
>  .SH VERSIONS
>  This system call first appeared in Linux 2.6.10.
>  .SH CONFORMING TO
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
