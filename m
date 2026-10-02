Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974130EF92;
	Fri,  2 Oct 2026 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911480; cv=none; b=XaAzjS2cUUgN6cPmS552NDEAqmk8tBjlzr+Eq845zxNKyeHVB5dZx/GFjc1BESYZeQ6q7nbCkg4AvRsTlNPSiWDLO791wIirCfIgkclMow5KkYwTqj+3IGp2/rn0P6Vit7h1Hj9CKwqRtOl0rE6e8NyG2yltecrqvLB+VEWDF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911480; c=relaxed/simple;
	bh=Mz/7hmRuGkTMnp/sszA7JjvPebPRiu441fr7RLv4oZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyn7yAcRjldPlIm7q9BYAOV5ZDVCw4DUNRD2SCV+6Xo0sqk5Nj5rCIgr+R4r1y9srt7e7+snF9YLgI1BSoRyQhxuBJHNFtpMLnpREFbKvoAXc3hcqicWJyuKhCzL52MjXOEOVqanXRhhwIxzUBiuLwEiPrenqVQfD3bmG1nVrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb3OOlHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb3OOlHQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 52D271F000FF;
	Fri,  2 Oct 2026 03:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790911478;
	bh=Yn08TUEN1s/ygGIHH/wD9OfgWTwHGPJLZ8ad0KevbTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xb3OOlHQQMJI2/1Jy9gqfMhFaBlO4gXJvqQoI7JfVFfyOiBH6VTNRg0VXQeZhKHQe
	 /q92wndSjJ+9PzmSPYy1CRcUIw4NQ2t/z5hTm9GemCb7Elpp5YoJAvxUDSlzJxp/9q
	 DASVR4k13evkaybWK8AnBk6ZqgJGFHUsogAr9AzSqr7AtGjSAyoV0JblbGiR6iBUIi
	 im8/K4mGZ6PvJwMPmkRC+DFscr7d/+VkcozTkeFQqDxRh+aBfwZb7ScQq/lEkP+GaI
	 iSRX968R7GIjnjBHd9kS3fPgG9jIZn6ilLUtbuJI5U4mwoS4jAoZgYXh7UbzzxpEvH
	 74xOiJfIvqqxg==
Date: Fri, 2 Oct 2026 06:24:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v3] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
Message-ID: <ar8j89aTa5H2t18h@kernel.org>
References: <20260926184203.479203-1-ssrish@linux.ibm.com>
 <arwqiNal3ElcgfON@kernel.org>
 <d0079240-f97f-4cfe-b26d-2ad2b88ab3b7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0079240-f97f-4cfe-b26d-2ad2b88ab3b7@linux.ibm.com>

On Wed, Sep 30, 2026 at 11:22:02AM +0530, Srish Srinivasan wrote:
> 
> On 9/30/26 2:45 AM, Jarkko Sakkinen wrote:
> > On Sun, Sep 27, 2026 at 12:12:03AM +0530, Srish Srinivasan wrote:
> > > TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
> > > creationTicket in its response parameter area. However, only outPrivate and
> > > outPublic are included in the trusted key blob. The size of the blob is
> > > therefore not determined by the size of the complete response parameter
> > > area.
> > > 
> > > tpm2_seal_trusted() currently compares the size of the complete response
> > > parameter area against MAX_BLOB_SIZE. This can reject a valid response
> > > when the remaining response outputs cause the entire response parameter
> > > area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
> > > TPM2B structures consumed by tpm2_key_encode() remain small enough to be
> > > encoded in the key blob.
> > > 
> > > This is observed when creating larger trusted keys using the swtpm TPM 2.0
> > > emulator backed by libtpms.
> > > 
> > > For example, requesting a 113-byte key succeeds, 114 fails.
> > > 
> > > ~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
> > > 520504613
> > > ~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
> > > add_key: Argument list too long
> > > ~$
> > > 
> > > Remove the MAX_BLOB_SIZE check on the complete response parameter area.
> > > Instead, use the response length passed to tpm2_key_encode() to validate
> > > that the outPrivate and outPublic TPM2B structures are fully contained
> > > in the response before accessing them.
> > > 
> > > Previously, a response parameter area larger than MAX_BLOB_SIZE was
> > > rejected with -E2BIG before ASN.1 encoding. With this change, if the
> > > resulting encoded blob does not fit in payload->blob, the error returned by
> > > asn1_encode_sequence() is propagated instead.
> > > 
> > > Also, use scope-based cleanup to simplify resource management.
> > > 
> > > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > > ---
> > > Changelog:
> > > 
> > >   v3:
> > >    - Simplify the TPM2B_PRIVATE and TPM2B_PUBLIC bounds checks
> > >    - Use appropriate error codes for failure returns
> > >    - Use scope-based cleanup to simplify resource management
> > > 
> > >   v2:
> > >    - Exclude a comment pointed out by Jarkko
> > > 
> > >   security/keys/trusted-keys/trusted_tpm2.c | 42 +++++++++++++----------
> > >   1 file changed, 24 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > > index 906700c3d7f0..920f45c7864b 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > @@ -25,24 +25,36 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> > >   {
> > >   	struct trusted_key_tpm *private = options->private;
> > >   	const int SCRATCH_SIZE = PAGE_SIZE;
> > > -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> > > -	u8 *work = scratch, *work1;
> > > -	u8 *end_work = scratch + SCRATCH_SIZE;
> > > +	u8 *scratch __free(kfree) = NULL;
> > > +	u8 *work, *work1;
> > > +	u8 *end_work;
> > >   	u8 *priv, *pub;
> > > -	u16 priv_len, pub_len;
> > > +	u32 priv_len, pub_len;
> > >   	int ret;
> > > +	if (len < 4)
> > > +		return -EINVAL;
> > > +
> > >   	priv_len = get_unaligned_be16(src) + 2;
> > > -	priv = src;
> > > +	if (priv_len + 2 > len)
> > > +		return -EIO;
> > > +	priv = src;
> > >   	src += priv_len;
> > >   	pub_len = get_unaligned_be16(src) + 2;
> > > +	if (pub_len + priv_len > len)
> > > +		return -EIO;
> > > +
> > >   	pub = src;
> > > +	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> > >   	if (!scratch)
> > >   		return -ENOMEM;
> > > +	work = scratch;
> > > +	end_work = scratch + SCRATCH_SIZE;
> > > +
> > >   	work = asn1_encode_oid(work, end_work, tpm2key_oid,
> > >   			       asn1_oid_len(tpm2key_oid));
> > > @@ -50,10 +62,9 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> > >   		unsigned char bool[3], *w = bool;
> > >   		/* tag 0 is emptyAuth */
> > >   		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> > > -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> > > -			ret = PTR_ERR(w);
> > > -			goto err;
> > > -		}
> > > +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> > > +			return PTR_ERR(w);
> > > +
> > >   		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> > >   	}
> > > @@ -65,8 +76,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> > >   	 */
> > >   	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> > >   		 "BUG: scratch buffer is too small")) {
> > > -		ret = -EINVAL;
> > > -		goto err;
> > > +		return -EINVAL;
> > >   	}
> > >   	work = asn1_encode_integer(work, end_work, private->keyhandle);
> > > @@ -79,15 +89,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> > >   	if (IS_ERR(work1)) {
> > >   		ret = PTR_ERR(work1);
> > >   		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
> > > -		goto err;
> > > +		return ret;
> > >   	}
> > > -	kfree(scratch);
> > >   	return work1 - payload->blob;
> > > -
> > > -err:
> > > -	kfree(scratch);
> > > -	return ret;
> > >   }
> > >   struct tpm2_key_context {
> > > @@ -340,10 +345,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> > >   		goto out;
> > >   	blob_len = tpm_buf_read_u32(buf, &offset);
> > > -	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
> > > +	if (buf->flags & TPM_BUF_INVALID) {
> > >   		rc = -E2BIG;
> > >   		goto out;
> > >   	}
> > > +
> > >   	if (buf->length - offset < blob_len) {
> > >   		rc = -EFAULT;
> > >   		goto out;
> > > -- 
> > > 2.53.0
> > > 
> > Now we can say that it leaves the tree to cleaner state than it was
> > before applying this patch. The first version, despite doing the right
> > thing was simply too convoluted.
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> 
> Thanks for the review and for helping improve the patch, Jarkko.

sure, np :-)

Br, Jarkko
