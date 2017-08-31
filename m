From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 31 Aug 2017 15:58:36 +0000
Subject: [RFC PATCH 4/5] keyctl.2: document the ability to provide KDF parameters in KEYCTL_DH_COMPUTE
Message-Id: <20170831155836.GA5257@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 man2/keyctl.2 | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 3 deletions(-)

diff --git a/man2/keyctl.2 b/man2/keyctl.2
index e4b4bc9..570edf5 100644
--- a/man2/keyctl.2
+++ b/man2/keyctl.2
@@ -25,6 +25,7 @@
 .\" the source, must acknowledge the copyright and authors of this work.
 .\" %%%LICENSE_END
 .\"
+.mso www.tmac
 .TH KEYCTL 2 2017-03-13 Linux "Linux Key Management Calls"
 .SH NAME
 keyctl \- manipulate the kernel's key management facility
@@ -1413,7 +1414,8 @@ via the function
 .TP
 .BR KEYCTL_DH_COMPUTE " (since Linux 4.7)"
 .\" commit ddbb41148724367394d0880c516bfaeed127b52e
-Compute a Diffie-Hellman shared secret or public key.
+Compute a Diffie-Hellman shared secret or public key,
+optionally applying key derivation function (KDF) to the result.
 .IP
 The
 .I arg2
@@ -1476,10 +1478,67 @@ system call was considered a good fit due to the DH algorithm's use
 for deriving shared keys;
 it also allows the type of the key to determine
 which DH implementation (software or hardware) is appropriate.
+.\" commit f1c316a3ab9d24df6022682422fe897492f2c0c8
 .IP
-The
+If the
 .I arg5
-argument is reserved and must be 0.
+argument is
+.BR NULL ,
+then the DH result itself is returned.
+Otherwise (since Linux 4.12), it is a pointer to a structure which specifies
+parameters of the KDF operation to be applied:
+.IP
+.in +4n
+.EX
++struct keyctl_kdf_params {
+    char *hashname;
+    char *otherinfo;
+    __u32 otherinfolen;
+    __u32 __spare[8];
+};
+.EE
+.in
+.IP
+The
+.B hashname
+field is a null-terminated string no longer than
+.B CRYPTO_MAX_ALG_NAME
+(128 bytes as of this writing) which specifies hash name
+(available into the kernel's crypto API; the list of the hashes available
+is rather tricky to observe; please refer to the
+.URL https://www.kernel.org/doc/html/latest/crypto/architecture.html "Kernel Crypto API Architecture"
+for the information regarding how hash names are constructed and
+to your kernel's source and configuration regarding what ciphers
+and templates with
+.B CRYPTO_ALG_TYPE_SHASH
+are available)
+to be applied to DH result in KDF operation.
+.IP
+The
+.B otherinfo
+field is an
+.I OtherInfo
+data as described in SP800-56A section 5.8.1.2 and is algorithm-specific.
+This data is concatenated with the result of DH operation and is provided as
+an input to the KDF operation.
+Its size is provided in the
+.B otherinfolen
+field and is limited by
+.B KEYCTL_KDF_MAX_OI_LEN
+constant that defined in
+.B security/keys/internal.h
+to a value of 64.
+.IP
+The
+.B __spare
+field is currently unused.
+.\" commit 4f9dabfaf8df971f8a3b6aa324f8f817be38d538
+It was ignored until Linux 4.13 (but still should be
+user-addressable since it is copied to the kernel),
+and should contain zeroes since Linux 4.13.
+.IP
+The KDF implementation complies with SP800-56A as well
+as with SP800-108 (the counter KDF).
 .SH RETURN VALUE
 For a successful call, the return value depends on the operation:
 .TP
@@ -1545,6 +1604,43 @@ and the requested link would result in a cycle.
 The key quota for the caller's user would be exceeded by creating a key or
 linking it to the keyring.
 .TP
+.B EFAULT
+.I operation
+was
+.B KEYCTL_DH_COMPUTE
+and one of the following has failed:
+.RS
+.IP \(bu 3
+copying of
+.BR "struct keyctl_dh_params" ,
+pointed by
+.IR arg2 ,
+from the user space;
+.IP \(bu
+copying of
+.BR "struct keyctl_kdf_params" ,
+pointed by non-NULL
+.IR arg5 ,
+from the user space
+(in case kernel supports performing KDF operation on DH operation result);
+.IP \(bu
+copying of data pointed by
+.B hashname
+field of
+.B "struct keyctl_kdf_params"
+from the user space;
+.IP \(bu
+copying of data pointed by
+.B otherinfo
+field of
+.B struct keyctl_kdf_params
+from the user space if
+.B otherinfolen
+field was non-zero;
+.IP \(bu
+copying of the result to the user space.
+.RE
+.TP
 .B EINVAL
 .I operation
 was
@@ -1570,10 +1666,38 @@ exceeded the limit (32 bytes and 4096 bytes respectively).
 .B EINVAL
 .I operation
 was
+.BR KEYCTL_DH_COMPUTE ,
+.I arg5
+was non-NULL and kernel does not support applying KDF operation to the DH
+operation result.
+.TP
+.B EINVAL
+.I operation
+was
+.B KEYCTL_DH_COMPUTE
+And the digest size of the hashing algorithm supplied is zero.
+.TP
+.B EINVAL
+.I operation
+was
 .B KEYCTL_DH_COMPUTE
 and the buffer size provided is not enough to hold the result.
 Provide 0 as a buffer size in order to obtain the minimum buffer size.
 .TP
+.B EINVAL
+.\" commit 4f9dabfaf8df971f8a3b6aa324f8f817be38d538
+.I operation
+was
+.B KEYCTL_DH_COMPUTE
+and the
+.B __spare
+field of the
+.B struct keyctl_kdf_params
+provided in
+.I arg5
+field
+contains non-zero values.
+.TP
 .B EKEYEXPIRED
 An expired key was found or specified.
 .TP
@@ -1590,6 +1714,23 @@ was
 and the requested link would cause the maximum nesting depth
 for keyrings to be exceeded.
 .TP
+.B EMSGSIZE
+.I operation
+was
+.B KEYCTL_DH_COMPUTE
+and the buffer length exceeds
+.B KEYCTL_KDF_MAX_OUTPUT_LEN
+(which is 1024 currently)
+or the
+.B otherinfolen
+field of
+.B struct keyctl_kdf_parms
+passed in
+.I arg5
+exceeds
+.B KEYCTL_KDF_MAX_OI_LEN
+(which is 64 currently).
+.TP
 .BR ENFILE " (Linux kernels before 3.13)"
 .IR operation
 was
-- 
2.1.4

