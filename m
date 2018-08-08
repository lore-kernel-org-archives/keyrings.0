From: David Howells <dhowells@redhat.com>
Date: Wed, 08 Aug 2018 14:44:01 +0000
Subject: Re: [dhowells-fs:keys-asym-keyctl 21/21] crypto/asymmetric_keys/asym_tpm.c:657:8-14: ERROR: referenc
Message-Id: <15340.1533739441@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <f5ca9cd5-5582-4f1b-e165-80f8aec45d11@gmail.com>
In-Reply-To: <f5ca9cd5-5582-4f1b-e165-80f8aec45d11@gmail.com>
To: keyrings@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> I can fix this in the next version, or if David wants to silently amend that
> is fine as well.

Is the attached change right?

David
---
diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index a8cc8fc7e3fb..3753c2f1c4e9 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -647,10 +647,12 @@ static uint8_t *get_digest(const void *in, size_t in_len,
 				   crypto_req_done, &cwait);
 
 	r = crypto_wait_req(crypto_ahash_digest(req), &cwait);
-
-	if (r)
+	if (r) {
 		kfree(digest);
-	else if (out_digest_len)
+		goto error_free_req;
+	}
+
+	if (out_digest_len)
 		*out_digest_len = digest_len;
 
 	/* Copy the ASN.1 template before the digest */
