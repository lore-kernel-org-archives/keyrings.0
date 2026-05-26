Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F503C3C0E;
	Tue, 26 May 2026 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782015; cv=none; b=hwfxKiU5kcA8hnGB99ELGJWC42OEnAMoEmAEDX+RQXanDdrOsASeYnNhOp2ZGudTIfCc4QKHSU4Yt910owzwFtaIUNdTaXKJy7r/LHAtQ6hmoq3DlSs3EoH/F9mmo2pRTTDwTzGhZwxhsaZXTe3dLN0nKoRwVINB0224jxrjAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782015; c=relaxed/simple;
	bh=PcThI1BoyjVUtfmWqtNgKsUMru2GLviK0ovOx+c7bNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1Og1NbpJlLXBTpyC+lqKBt25+3zumQzwtqxLV6JyFZI5N3X1rzKVc1+K5Hocuq/f+I0K0EXwFJnfRej7zwEneMUM8MJiTWgh+QjkKT1uQvXobq1GBCRs5HDO/dLG0qjhiBCygv4Iaz8N6MLehvjhPqw/mmFsHbVcpi1lzCGzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8hUD8I5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8hUD8I5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8D7031F00A3A;
	Tue, 26 May 2026 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779782014;
	bh=nYxpBaGqUSxWUWyckAnbLtrN2g0awmSJ1qiK/g5z2Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8hUD8I5r5viE+3paIJo8PzERmcmQvNknhFsONOpsvQ3KdHgHZ3qfBIVhO0F4WFO5
	 SAINdg67zmIiO47kRkgbzqDio2cV3uOeBJiQtZRFRKz/BhN5v3khYnqdZS1H3nCRju
	 KMo1OvtO8N8l6Av/zokiTbCCcPtyG06vvuf7mB5mEK6JsVIjM6+O7maAaG34hkcRlM
	 Gp9EFQjDCGVnKb1WN0J6Z9bUuPsmfM1U8Qf4728t+AuiQoiU9oo0CQLUudnaPTkQEI
	 96dbk+/nPTVHipCbIM94oaGc7RfJpE+FjS0veSqKtkI6wGZiXXuVW7FiBPMRK92ewh
	 rSMligZ4wLmog==
Date: Tue, 26 May 2026 10:53:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Arun Menon <armenon@redhat.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Alec Brown <alec.r.brown@oracle.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm-buf: memory-safe allocations
Message-ID: <ahVRefyT4BTKOu0m@kernel.org>
References: <20260522013555.1063716-1-jarkko@kernel.org>
 <33b4a34ceea0934e238c08e0256b975511ef99c8.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33b4a34ceea0934e238c08e0256b975511ef99c8.camel@HansenPartnership.com>

On Mon, May 25, 2026 at 01:50:51PM -0400, James Bottomley wrote:
> On Fri, 2026-05-22 at 04:35 +0300, Jarkko Sakkinen wrote:
> > Decouple kzalloc from buffer creation, so that a managed allocation
> > can be
> > used:
> > 
> > 	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
> > 						GFP_KERNEL);
> > 	if (!buf)
> > 		return -ENOMEM;
> > 
> > 	tpm_buf_init(buf, TPM_BUFSIZE);
> > 
> > Alternatively, stack allocations are also possible:
> > 
> > 	u8 buf_data[512];
> > 	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
> > 	tpm_buf_init(buf, sizeof(buf_data));
> 
> This isn't really a good idea from a security point of view.  Remember
> the buffer has to be big enough for both the sent and the received
> data.  Today we simply set TPM_BUFSIZE to the maximum amount a TPM
> requires and all the send and receives just work.  If we let callers
> set this size, we're asking for them to get it wrong (or at least
> forget about the receive part) and for us to get a DMA overrun from the
> TPM ... which might be potentially exploitable depending on how it
> occurs (think of an unseal of user chosen data overrunning).

It's one patch so you're free to remark the call sites where this
happens. This is not a majorn concern at all.

> 
> I get the desire to support some of the newer chunked commands, but
> since none of them is yet present in the kernel, why not introduce an
> API that works only for them to avoid the risk of a security cockup in
> existing code?

Multiplying amount of maintenance work with a redundant implemntation
is not something I support.

> 
> Regards,
> 
> James


BR, Jarkko
