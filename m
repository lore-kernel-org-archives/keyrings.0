Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A53CB8E9;
	Fri, 25 Sep 2026 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376291; cv=none; b=rEe116S/3dIoZsxPvblP3ot//33zepkL4IxL8uZgjAa1rBAIpj2sTGWPvqWOs37PCbrhHULYbw5H96JE2+JcFjmpFAwc67ABP/1kDDQ0nrgYkdGaOvGhHxitejTvhqtSBUSfArzNQrlZiAg3itF9jT6UXq27XxBetP2hRgMLAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376291; c=relaxed/simple;
	bh=gRsMG9vyNVnm0P7DbLD9VqbtkEJT6gPcPKPRHrjFOcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj1Nt+WSuKjlm03HrWfpoafoP2FLOen6HHRQE1evPgHosw5SHCoHHQMi7MuH0X3VE+UzOp0zn7SC8OQZx451d71tD41FGKxw9lJjnAVctPlRM718DMCpaR2RwhYPPAkbosVOMlRGaz1/tN9kzQncOgRoUhOjwuKnKrFQ1IkTIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RatJQX/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RatJQX/A"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C32BB1F000FF;
	Fri, 25 Sep 2026 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790376290;
	bh=S57bUIN+2Jz25Fw2JoescnMVb5QndsgsNFhP4OhluBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RatJQX/AgdTrXwFLW93vi4xsWnSSvnM3ItINfTX8ELN38gaQBGjcH6nnM4UY/9vqf
	 cC0VZ4XrX4H7g8pTQREUCBPQdEZPtBxARhe9DO8e1UPVcuM7l1LG4X3vyPxB2qydGs
	 15eMFYltnYP60Oe9zdkbCotUi9FwPD1Q9U22lkSRi6P1I+VKUvLbG7SXirdkKWOIDv
	 xRjGN0zx4XT83NBmwJrgHeii/JLGWZCO2mHCz8/HAoBvpbRNPRhrb7Ktw3tJH3EpUW
	 A7capIN7H711uywvtbEzIxcTmRwzsuMppW20B+d787qcvSaO5Yq2qU2d7EDPo0eGRG
	 uf8+Os2DsAFnQ==
Date: Sat, 26 Sep 2026 01:44:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v2] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
Message-ID: <arb5XnpAHe3SZEfv@kernel.org>
References: <20260910100222.247529-1-ssrish@linux.ibm.com>
 <aqydqxpVmp67kTQO@kernel.org>
 <e05d8ca7-ac48-47ef-bc47-bef5b22cb723@linux.ibm.com>
 <arZZTGtmo1ZLit0j@kernel.org>
 <bec84181-565a-478e-a485-7f63819024cc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bec84181-565a-478e-a485-7f63819024cc@linux.ibm.com>

On Fri, Sep 25, 2026 at 08:42:09PM +0530, Srish Srinivasan wrote:
> Hi Jarkko,
> Thanks for taking a look.
> 
> On 9/25/26 4:51 PM, Jarkko Sakkinen wrote:
> > On Fri, Sep 18, 2026 at 12:18:25PM +0530, Srish Srinivasan wrote:
> > > On 9/18/26 7:40 AM, Jarkko Sakkinen wrote:
> > > > On Thu, Sep 10, 2026 at 03:32:22PM +0530, Srish Srinivasan wrote:
> > > > > TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
> > > > > creationTicket in its response parameter area. However, only outPrivate and
> > > > > outPublic are included in the trusted key blob. The size of the blob is
> > > > > therefore not determined by the size of the complete response parameter
> > > > > area.
> > > > > 
> > > > > tpm2_seal_trusted() currently compares the size of the complete response
> > > > > parameter area against MAX_BLOB_SIZE. This can reject a valid response
> > > > > when the remaining response outputs cause the entire response parameter
> > > > > area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
> > > > > TPM2B structures consumed by tpm2_key_encode() remain small enough to be
> > > > > encoded in the key blob.
> > > > > 
> > > > > This is observed when creating larger trusted keys using an swtpm TPM 2.0
> > > > > emulator backed by libtpms.
> > > > > 
> > > > > For example, requesting a 113-byte key succeeds, 114 fails.
> > > > > 
> > > > > ~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
> > > > > 520504613
> > > > > ~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
> > > > > add_key: Argument list too long
> > > > > ~$
> > > > > 
> > > > > Remove the MAX_BLOB_SIZE check on the complete response parameter area.
> > > > > Instead, use the response length passed to tpm2_key_encode() to validate
> > > > > that the outPrivate and outPublic TPM2B structures are fully contained
> > > > > in the response before accessing them.
> > > > > 
> > > > > Previously, a response parameter area larger than MAX_BLOB_SIZE was
> > > > > rejected with -E2BIG before ASN.1 encoding. With this change, if the
> > > > > resulting encoded blob does not fit in payload->blob, the error returned by
> > > > > asn1_encode_sequence() is propagated instead.
> > > > > 
> > > > > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > > > > ---
> > > > > Changelog:
> > > > > 
> > > > >    v2:
> > > > >     - Exclude a comment pointed out by Jarkko
> > > > > 
> > > > >    security/keys/trusted-keys/trusted_tpm2.c | 35 +++++++++++++++++------
> > > > >    1 file changed, 27 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > > > > index 01f18bb37047..cbec4f591952 100644
> > > > > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > > > > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > > > > @@ -24,24 +24,42 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> > > > >    			   u8 *src, u32 len)
> > > > >    {
> > > > >    	const int SCRATCH_SIZE = PAGE_SIZE;
> > > > > -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> > > > > -	u8 *work = scratch, *work1;
> > > > > -	u8 *end_work = scratch + SCRATCH_SIZE;
> > > > > +	u8 *scratch;
> > > > > +	u8 *work, *work1;
> > > > > +	u8 *end_work;
> > > > >    	u8 *priv, *pub;
> > > > > -	u16 priv_len, pub_len;
> > > > > +	u32 priv_len, pub_len;
> > > > >    	int ret;
> > > > > -	priv_len = get_unaligned_be16(src) + 2;
> > > > > +	if (len < sizeof(__be16))
> > > > > +		return -EFAULT;
> > > > > +
> > > > > +	priv_len = get_unaligned_be16(src);
> > > > > +	if (priv_len > len - sizeof(__be16))
> > > > > +		return -EFAULT;
> > > > > +
> > > > > +	priv_len += sizeof(__be16);
> > > > >    	priv = src;
> > > > > +	if (len - priv_len < sizeof(__be16))
> > > > > +		return -EFAULT;
> > > > This caused for me some head scrathing tbh.
> > > > 
> > > > See:
> > > > 
> > > > 1. len >= 2
> > > > 2. priv_len <= len - 2
> > > > 3. 2 - priv_len + priv_len <= 2 - priv_len + len - 2
> > > > 4. 2 <= len - priv_len
> > > > 
> > > > Is this check required?
> > > 
> > > Hi Jarkko,
> > > Thanks for taking a look.
> > > 
> > > The preceding check,
> > > 
> > > 
> > >      if (priv_len > len - sizeof(__be16))
> > >          return -EFAULT;
> > > 
> > > 
> > > ensures that the complete TPM2B_PRIVATE, including its size field,
> > > fits within len. After this check, priv_len is incremented by 2 and
> > > therefore represents the complete TPM2B_PRIVATE length.
> > > 
> > > 
> > > The check you pointed out,
> > > 
> > > 
> > >      if (len - priv_len < sizeof(__be16))
> > >          return -EFAULT;
> > > 
> > > 
> > > then ensures that at least 2 bytes remain for reading the following
> > > TPM2B_PUBLIC size field.
> > OK, maybe I got something wrong in my deduction but I'm not
> > still entirely sure whether this is leanest way to do these
> > checks.
> 
> 
> Sure, I will simplify this. Would the following be better?
> 
> 
>     if (len < 4)
>       return -EINVAL;
> 
>     priv_len = get_unaligned_be16(src) + 2;
>     if (priv_len + 2 > len)
>       return -EIO;
> 
>     priv = src;
>     src += priv_len;
> 
>     pub_len = get_unaligned_be16(src) + 2;
>     if (priv_len + pub_len > len)
>       return -EIO;
> 
>     pub = src;
> 
> 
> The first check ensures that len can contain both TPM2B size fields.
> The second verifies that the complete TPM2B_PRIVATE leaves room for the
> TPM2B_PUBLIC size field. The final check ensures that both the complete
> TPM2B_PRIVATE and TPM2B_PUBLIC structures fit within len.
> 
> > 
> > I'll iterate some other remarks so that this can move forward.
> > 
> > I was not either entirely sure why this was done:
> > 
> > -	u16 priv_len, pub_len;
> > +	u32 priv_len, pub_len;
> 
> 
> Yes, so the change from u16 to u32 was because the values stored in priv_len
> and
> pub_len include both the 16-bit value read from the response and the
> two-byte TPM2B
> size field.
> 
> 
> > 
> > Why wrong len causes -EFAULT and not -EINVAL? EFAULT is for
> > memory failures. Probably two that follow should return -EIO.
> 
> 
> Agreed, I will fix this.
> 
> 
> > 
> > One more that came to mind:
> > 
> > -	priv_len = get_unaligned_be16(src) + 2;
> > +	if (len < sizeof(__be16))
> > +		return -EFAULT;
> > +
> > +	priv_len = get_unaligned_be16(src);
> > +	if (priv_len > len - sizeof(__be16))
> > +		return -EFAULT;
> > +
> > +	priv_len += sizeof(__be16);
> > 
> > Removing the line above is not necessary and neither is the last
> > the last statement if you just change your check accordingly.
> 
> 
> Yes, that's right. And I have made this change in the diff
> that I have pasted above.
> 
> Please let me know if this looks better now.
> 
> And, thanks for the feedback.

Yeah, so this is a patch that needs a few iterations I'm not against
the change itself per se :-)

I think it would make sense to declare "u8 *scratch __free(kfree)"
while at it so that rollback does not complicate this function 
further.

> 
> > 
> > 
> > BR, Jarkko
> 
> 
> Thanks,
> Srish.
> 

Br, Jarkko
