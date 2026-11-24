Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500193;
	b=2x0/kI2zgYxYSaJCfml5URcIy+G6qRo0/7MYv68K64u2xpkNDcSLKNUPBlZRI3yiQPW4
	 rpkmRBN1FmYB37JdYSU/7na8bTLFC55JrKyllQB0fAs3jU5kbTy/FihtH1yrAjAtr8CRB
	 j0aZ6DqevwHEgFopp8lCir/zCQCcB+yZtReg8GH+/SyEyeCBzbVdH3BIkjGhcnHQxC8xa
	 +z9pcK9VppV95sz/bUcoGI9ZXznqt6DNL4H1SCMTFsGoRg+8AtEV2nNbXwS5sux3ivRMl
	 0L1qXu9EuYchSV3ih6xPR8jM5NMdgxDTb3Mmq7d0hn9dt5ARqdalQn47FRc0IVLZjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lnAdljoJQmmxnLAeZNWJc88qLWk+7V1U8lO1+PHZZJ0=;
	b=TZSJztKnBL5J1VB8V0O0oyn8LvGl7eK47XlesLyJnNLPukybrCeX1RoS9LpoOa1vbrg1
	 AzKXfu4u19pT3a+fGn81dnofJ18B70qm6bbqXh3ddp8zxSO9XVHc/NjcGGU/q8WhFor9z
	 W817d/22cEumd7BgCVUdIwFgj2oZ6qK0sk/E4UN2WJPaJXvfj42Jgd00xQGSdc3fbCsRi
	 5RI6Q3+wBUmCOzs+1z23Nf/YxiVM4nzA/nPorVPFsdmPE0x0+iv9q7azApVF4w4qc2PeN
	 6gy+kPG8vefeh+v+wkidyE4spgspaGsB0tiF+LC6eQavGSaJ5/pI65V4o/4G0sYGQZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=diGA5g7o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A45606A31E;
	Tue, 24 Nov 2026 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=diGA5g7o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E8C1F000C4;
	Tue, 24 Nov 2026 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795500192;
	bh=lnAdljoJQmmxnLAeZNWJc88qLWk+7V1U8lO1+PHZZJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=diGA5g7obnCp4XYJ/q81DP5x1TrZF2wyfL8C82KteNt7avJpXAqSXgjbBeWAjrDDn
	 48DciiAK1fMVxmNWdZsIoyMqnCVG1FZrHcq1BOvLXotjNGP7BaBXXmy+TzoPgbdJXk
	 Gfip7lCyJq7h88tJgFmHY7otUsb4kuqbfv6IW4yU=
Date: Mon, 23 Nov 2026 22:03:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: zzz <abc0eichs@qq.com>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>,
 keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] lib/asn1_encoder: fix encoding of zero OID components
Message-Id: <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
In-Reply-To: <tencent_AFE15D698FFD4F18E16A6EF7CDA002D69806@qq.com>
References: <tencent_AFE15D698FFD4F18E16A6EF7CDA002D69806@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 21:00:55 +0800 zzz <abc0eichs@qq.com> wrote:
>

Sorry, "zzz" isn't usable.  See
Documentation/process/submitting-patches.rst under "Sign your
work":"using a known identity (sorry, no anonymous contributions.)".

So for now I'll rewrite this as From:me and Reported-by:zzz.  Please
send a 

	Signed-off-by: Your Real Name <email@address>

as a reply-to-all to this message and I shall alter the attributions
appropriately.

> asn1_encode_oid_digit() encodes a zero component as 0x80, setting the
> continuation bit on its only octet. A trailing zero therefore produces
> an unterminated subidentifier, while an interior zero produces an
> overlong encoding of the following component.
> 
> For example, 1.2.0 is encoded as 06 02 2a 80 instead of 06 02 2a 00.
> Emit zero without the continuation bit, as required for the final
> octet of a base-128 subidentifier.

Super-slim bug and it appears that nothing in the current tree uses
this code path.  But a bug is a bug.

> Validation:
> - A local UML KUnit suite called the actual encoder with six OID
>   vectors and short buffers. The original failed the zero-component
>   vectors; the fixed kernel passed both subtests.

Feel free to send along a patch which adds a KUint test for the
asn1_decoder code.

> The sole current in-tree caller uses a fixed, nonzero TPM OID whose
> encoding is unchanged. This fixes the exported encoder's handling of
> valid zero components; it does not claim an observed TPM failure.

yup.

> --- a/lib/asn1_encoder.c
> +++ b/lib/asn1_encoder.c
> @@ -97,7 +97,7 @@ static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
>  
>  	/* quick case */
>  	if (oid == 0) {
> -		*data++ = 0x80;
> +		*data++ = 0;
>  		(*data_len)--;
>  		goto out;
>  	}

Thanks,  Added to the pile!
