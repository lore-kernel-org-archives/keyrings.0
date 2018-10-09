From: David Howells <dhowells@redhat.com>
Date: Tue, 09 Oct 2018 15:21:36 +0000
Subject: Re: [PATCH 05/22] KEYS: Provide software public key query function
Message-Id: <16730.1539098496@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LRH.2.21.1810040520570.16168@namei.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618449119.7946.11025480207548147086.stgit@warthog.procyon.org.uk>
In-Reply-To: <alpine.LRH.2.21.1810040520570.16168@namei.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +	if (strcmp(encoding, "raw") = 0) {
> > +		strcpy(alg_name, pkey->pkey_algo);
> > +		return 0;
> > +	}
> 
> Can encoding here also be NULL to indicate raw? per patch 01:

Okay, I'm making the attached changes to patch 01.  They're
documentary/commentary only.

David
---
diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 2cdccde6c585..c144978479d5 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1507,12 +1507,12 @@ The structure has a number of fields, some of which are mandatory:
 		enum kernel_pkey_operation op : 8;
 	};
 
-     This includes the key to be used; an optional string indicating the
-     encoding to use (for instance, "pkcs1" may be used with an RSA key to
-     indicate RSASSA-PKCS1-v1.5 or RSAES-PKCS1-v1.5 encoding); the name of the
-     hash algorithm used to generate the data for a signature (if appropriate);
-     the sizes of the input and output (or second input) buffers; and the ID of
-     the operation to be performed.
+     This includes the key to be used; a string indicating the encoding to use
+     (for instance, "pkcs1" may be used with an RSA key to indicate
+     RSASSA-PKCS1-v1.5 or RSAES-PKCS1-v1.5 encoding or "raw" if no encoding);
+     the name of the hash algorithm used to generate the data for a signature
+     (if appropriate); the sizes of the input and output (or second input)
+     buffers; and the ID of the operation to be performed.
 
      For a given operation ID, the input and output buffers are used as
      follows::
diff --git a/include/linux/keyctl.h b/include/linux/keyctl.h
index e89b4a4e43d0..c7c48c79ce0e 100644
--- a/include/linux/keyctl.h
+++ b/include/linux/keyctl.h
@@ -32,7 +32,7 @@ enum kernel_pkey_operation {
 
 struct kernel_pkey_params {
 	struct key	*key;
-	const char	*encoding;	/* Encoding (eg. "oaep" or NULL for raw) */
+	const char	*encoding;	/* Encoding (eg. "oaep" or "raw" for none) */
 	const char	*hash_algo;	/* Digest algorithm used (eg. "sha1") or NULL if N/A */
 	char		*info;		/* Modified info string to be released later */
 	__u32		in_len;		/* Input data size */
