Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786748;
	b=g7KGSQ+qk+ey3yI0sQ1et55FWaHXOfpo2IjkJyIEPH1S8scKNMC45dnKiM26jxzh1b/l
	 tO20mMv+qleBtqBBHCgVadQzRdBZEfIH0Nw0AodagKPzBNjWUb6spC7/UfhZEKPck3eAC
	 pObhCZ0KSBuOTkfnkLV6fJmlYXkkObYtbWGGS/Z4vlE/nRKTasVxUbkm5c3XVAmqCxi/p
	 H9T+7XgT5gqipNOqKo2Xg4zTA+Y5MhI8g8GMll69rBDrGpN0k/cYEzdoOxjMRMku2PQ+4
	 VvY8nPuvsY9v4omNfjxY1gQZ4RD+X7WvNRIJjPebtnA6//8TCHzAq1FpAX82V2XBc0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786748;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i/p2wvRKT+lQbre46Qn/U695FyNFxcoHdBV/+pShc7w=;
	b=MSllWgoBwXho6Y9dNqF/KPTYqXg+2L/RV0x8FrlJtXt0fo3sIKE5GZFCcPTCfEnDfB9j
	 Nn27kQLqD/84nv3TH4P6wyvLY902yqf4hdZNW5c1JXai79K3ZcTpmiAIBGLab7mOHWfP5
	 tRU/fS/QbXe8Gj4d/ri7HC4IAaKNvixvO+CbMsUNtV9JkVbTFzlMs8c929JxwcmFsbqkT
	 1Vk4Ddi5c2GCFJDdU6/+3zKyKSzEMdzjWaoi7jO0aMx9R98Lett1EzVu03G1ptOk1sLUK
	 NQZnfpOHTyElZMtZWtG7iV+eWD/8Cti+JgrOnLTQwDDFPGy7hJrvYZE1fDePmAYySWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O5W/VuYz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3CF37606A31F;
	Sun, 15 Nov 2026 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5W/VuYz
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4DEB01F000C4;
	Sun, 15 Nov 2026 23:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786747;
	bh=i/p2wvRKT+lQbre46Qn/U695FyNFxcoHdBV/+pShc7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O5W/VuYziGvMigtVcXN5ZOJsviXX/STpwLvpfHtQUQC1iZnE105Cg9fmMICjos7jm
	 UiYEI6kYsEQ4sJucLHYhVAvQUhF1owL7WEmrLbU0oX+NTKSquBIhT+utzgkGCC6YeN
	 9qfsF6guDzFs/khlyzVIOSyxkIcDWiWF7zrFl+T+mwi7W9FWeL7ZqmC7CtS8P1rka8
	 kZLSrwayPH1b0gcGCugLWCyGbvTQfvKGckQqXADaBrrZIDwxQ8KaTgvJBmevETVF50
	 kXRaRo/PiReYE9H3JtMaTQeKWbJmivjj/NFWApm8lKl0RZj4R029CLr6LaXiRJmixv
	 7kd/GoWL9Ui1g==
Date: Mon, 16 Nov 2026 01:52:23 +0200
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
Message-ID: <avpFt2HzpKXN_uY5@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
 <avpDrQF4QAcCMnsr@kernel.org>
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
In-Reply-To: <avpDrQF4QAcCMnsr@kernel.org>

On Mon, Nov 16, 2026 at 01:43:45AM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 16, 2026 at 01:31:52AM +0200, Jarkko Sakkinen wrote:
> > v2:
> > 
> > - Based on Sashiko feedback I changed "offset += tpm_buf_read_u16()" into
> >   "rc = tpm_buf_read_u16(...)" and "offset += rc". I'm convinced that this
> >   was necessary but since it does not have a cost, at least this should
> >   mute Sashiko.
> 
> No further Sashiko complains.

tpm_buf_read*() really should update the offset on success, and be
fallible calls. Overflow-flag, and eventual failure makes more
sense when building commands.

Br, Jarkko
