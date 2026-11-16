Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787444;
	b=2cZXd6n2SHQ8/f74g1iI2XoyZTAAx5m7xZdjRZHa3Xr5MrCNuPkZ+sRuCSpm5yCa1X2f
	 Q1BAwigypvz0DG2etJWQnFulfuuxcS/eE08t3RKwjZCmg7pC1ZyTKFYMIARm+6JsR5tBI
	 z6sidNh3F6rxosl56d7cWAtS/CVdmYuTAWyb62ZRgjJ9kdU7+p0N1jHjyMZHvzDe7lhE5
	 5FHOSJ6R5lqpBj3HQ0o0gidf9FUrJy6sRemKMHH18I28vBfweQWBCcQ8HLDPJ26pHFYNR
	 8QPcCrT0VL0u4J2YKeu5Iicm5KkyAJDG/3ohnEBLvzgTAfKsr6Jj89IbH7OfNOdAuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787444;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZM38k2toVyR7ppkuiIRLOdyiu7F++Mngluv/6M3nt5s=;
	b=vfVGxLjRTUzuG2gvHRtgAvE2u4C242AZo8iMSLQyoeaxU6Sc57iooPOgXq09qQSsSHad
	 7SPxaBzKOsEAEjnoMzKx2pGawGY+Yekybt4TTvPS+ZX2Bz1zSj0oXu/wPG+TvLABQ7zQk
	 5UvXka1kjgZ/qhaXHimWj8sQD/a8AP38PpnOFz6Iovy/P9y0kkRrhga+D8QZRwjGt1GN8
	 hvZv2gVaU8FTUFS0jFwQo2qAn04XzNrTbXJvUtG0j+tnxKzTcd/aMeNaOV9ngg9utI+Uh
	 MURGIO4i3M4ZhJRs6HrT1C9RlR+u+744tklpKwKdx1fyWCCb59SfPWKy6tQW9MyZZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvkpClqG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 78046606A329;
	Mon, 16 Nov 2026 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvkpClqG
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 940191F000C4;
	Mon, 16 Nov 2026 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794787444;
	bh=ZM38k2toVyR7ppkuiIRLOdyiu7F++Mngluv/6M3nt5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TvkpClqGpUKKahd4zD5YT7okMXYpofXGNKb0HMXGc6Mk2yoFBroE2RTL/1kMDG/fj
	 lVfR5Bz9fKrLQsSYYzqrUnhgpkMiH4a+l/XwIR2hmlVgeURBmuSyDIJKsJA8xpvPWa
	 nZQKUtVzt7OOF+YQUhCcl73VW7yYCEtTf79j9+YyH6PoBWvHl/XlyXAEGxHsK60uAo
	 3s7Pd9ua+66LLKG4UEqUP1Y2AeDtXstPVH3tY7uqhDyZWLAlhXtEdSr3Xf/iMm6+2d
	 IYsRqPASBWn2MSwhnikN0Hk2f7LuH2I44Rf+3OFP3b5RnYispsz4xNcFMl7LjD4d/L
	 Oe/Ac8ykUovbA==
Date: Mon, 16 Nov 2026 02:04:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	James Morris <jmorris@namei.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 0/4] Unsorted tpm2-sessions improvements
Message-ID: <avpIcBVKGFikTkAN@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
 <avpDrQF4QAcCMnsr@kernel.org>
 <avpFt2HzpKXN_uY5@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avpFt2HzpKXN_uY5@kernel.org>

On Mon, Nov 16, 2026 at 01:52:28AM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 16, 2026 at 01:43:45AM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 16, 2026 at 01:31:52AM +0200, Jarkko Sakkinen wrote:
> > > v2:
> > > 
> > > - Based on Sashiko feedback I changed "offset += tpm_buf_read_u16()" into
> > >   "rc = tpm_buf_read_u16(...)" and "offset += rc". I'm convinced that this
> > >   was necessary but since it does not have a cost, at least this should
> > >   mute Sashiko.
> > 
> > No further Sashiko complains.
> 
> tpm_buf_read*() really should update the offset on success, and be
> fallible calls. Overflow-flag, and eventual failure makes more
> sense when building commands.

I.e.

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 233e81d3f149..1ea2f2121f37 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -204,39 +204,37 @@ void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
  * @offset:	offset within the buffer
  * @count:	the number of bytes to read
  * @output:	the output buffer
+ *
+ * Return:
+ * * 0		- on success, and @offset is advanced by @count bytes
+ * * -EIO	- if the read would cross the end of the buffer
  */
-static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void *output)
+static int tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void *output)
 {
 	off_t next_offset;

-	if (buf->flags & TPM_BUF_INVALID)
-		return;
-
 	next_offset = *offset + count;
-	if (next_offset > buf->length) {
-		WARN(1, "tpm_buf: read out of boundary\n");
-		buf->flags |= TPM_BUF_INVALID;
-		return;
-	}
+	if (next_offset > buf->length)
+		return -EIO;

 	memcpy(output, &buf->data[*offset], count);
 	*offset = next_offset;
+	return 0;
 }

 /**
  * tpm_buf_read_u8() - Read 8-bit word from a TPM buffer
  * @buf:	&tpm_buf instance
  * @offset:	offset within the buffer
+ * @value:	returns the 8-bit word
  *
- * Return: next 8-bit word
+ * Return:
+ * * 0		- on success, and @offset is advanced
+ * * -EIO	- if the read would cross the end of the buffer
  */
-u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset)
+int tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset, u8 *value)
 {
-	u8 value = 0;
-
-	tpm_buf_read(buf, offset, sizeof(value), &value);
-
-	return value;
+	return tpm_buf_read(buf, offset, sizeof(*value), value);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_read_u8);

@@ -244,16 +242,23 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u8);
  * tpm_buf_read_u16() - Read 16-bit word from a TPM buffer
  * @buf:	&tpm_buf instance
  * @offset:	offset within the buffer
+ * @value:	returns the 16-bit word
  *
- * Return: next 16-bit word
+ * Return:
+ * * 0		- on success, and @offset is advanced
+ * * -EIO	- if the read would cross the end of the buffer
  */
-u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset)
+int tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset, u16 *value)
 {
-	u16 value = 0;
+	__be16 value_be;
+	int rc;

-	tpm_buf_read(buf, offset, sizeof(value), &value);
+	rc = tpm_buf_read(buf, offset, sizeof(value_be), &value_be);
+	if (rc)
+		return rc;

-	return be16_to_cpu(value);
+	*value = be16_to_cpu(value_be);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_read_u16);

@@ -261,16 +266,23 @@ EXPORT_SYMBOL_GPL(tpm_buf_read_u16);
  * tpm_buf_read_u32() - Read 32-bit word from a TPM buffer
  * @buf:	&tpm_buf instance
  * @offset:	offset within the buffer
+ * @value:	returns the 32-bit word
  *
- * Return: next 32-bit word
+ * Return:
+ * * 0		- on success, and @offset is advanced
+ * * -EIO	- if the read would cross the end of the buffer
  */
-u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
+int tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset, u32 *value)
 {
-	u32 value = 0;
+	__be32 value_be;
+	int rc;

-	tpm_buf_read(buf, offset, sizeof(value), &value);
+	rc = tpm_buf_read(buf, offset, sizeof(value_be), &value_be);
+	if (rc)
+		return rc;

-	return be32_to_cpu(value);
+	*value = be32_to_cpu(value_be);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_buf_read_u32);

diff --git a/include/linux/tpm_buf.h b/include/linux/tpm_buf.h
index f8c105d8b8bf..e86193fc6374 100644
--- a/include/linux/tpm_buf.h
+++ b/include/linux/tpm_buf.h
@@ -52,9 +52,9 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
 void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
 void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
 void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
-u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
-u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
-u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
+int tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset, u8 *value);
+int tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset, u16 *value);
+int tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset, u32 *value);
 void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);

 #endif

Br, Jarkko
