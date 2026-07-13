Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36735CB95
	for <keyrings@vger.kernel.org>; Mon, 13 Jul 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977819; cv=none; b=HuVs2F66TZQTlMXZM3H9NDH7A4upl1q850PdSmmrIpAssp303vixTJeP6DppF6/SNyMDk/kG3ncOGn2q/zEWB7QAGkADGFwgA1DnnTow3iGtKFOUMccomy5fVPy+YoZ9ntF50vJRWuH8ehicoIJNK2WGJtkDQYgWROptZllH01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977819; c=relaxed/simple;
	bh=Mk2t8nzgYJzLwlkNud85cE38NzovhsoQrscNbszw33o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyv0AeGyQZ0pQto4LZ0/AxaiIAMaXCGjK+AuvcJrqAxBTcxQcoBW4fvE9nWoXipnv7U1pSJ3ETIxT2yPlBLWncHoUNA+xplMzFtZPEfn1Z2ASwKZwAp49FJ/CsqhGAHqIB5wyjeRK0iUByFDE8nsc53lp37yU5iMCAnvfDioVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nU5AVbYd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nU5AVbYd"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15e0c3f395so43964366b.3
        for <keyrings@vger.kernel.org>; Mon, 13 Jul 2026 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783977816; x=1784582616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=otBwmNaHaQM26sxlH4S7rvsrxllaQCtHmYJAwTDxIaM=;
        b=nU5AVbYdOk14ul97B2TpMQT9P63laTWKwu3Hj+jxnFVLxxsDqAWex0fZg+38F58Tip
         9US0CLactf0EmTXF1Xg+EC0JNNFhFvQYCcfpA8ac40NTafUUIrJOnBdLQJCIR0A18pUL
         PNNif1KiHpS/AENraiEXM0FcSlpWORWwLGtUlA/wyxJrBwE9yWu0LeqsUS5vyyE/kxt0
         6d6nLRGsNvTQWOx2Kmm7wkF5bp6fSyMuGNeFm3703n44UjZcaYZbIqe5Dby/Y0mLE6ln
         YJPmsCb/rm7mz7l+q5QdexVjMVuAM1jl0qGtH6lmPPohdq2G9POwqjFxMPonNoIaPfIg
         sWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977816; x=1784582616;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otBwmNaHaQM26sxlH4S7rvsrxllaQCtHmYJAwTDxIaM=;
        b=R2KpEr78cMlW4K+LoEsr3KrAMhj+X7F/0pAfTVBRjv+Usimv2OJPFHQBrZWDviTLQf
         I9YxJmyBYiV154BYP9aMFKM94Yqf9wdkO8lAIGdEsyrbc4f3oeB6DlXqdZWCqQQIM5Up
         VlFpsIDNR4QK6ObvA0YqtarX9lGVfJOeaVmusOYjx8SNUCAn9J+336wwBtuVKxPuOD9B
         NsT9q/y0caJLutG+K/CyvasLnSvqrwb9t9YgDZUF6x0CIHA1HRhGYwVFVNGiH011CZdh
         6Ch5AG3bzqqzIVqmiiN7ToTvx0Gbntmwtnf4SCI19dEgDR4DvVspE9IGMB2AQZy0Enfc
         geVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1u7eELR4U8zZ06ChpVTY38zt0CjUUQ0J9szC/yKe4caoiRchqg87fkS1oJt71nNVqqWARQibJUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71ekSU1cPk+Z8zL+HxrIP32Law5rJ83QKOyFJkwXIjAiADGBD
	6DogoKOeR9lrNaoqbt7QnWCGm7GDNxWI/vuTzQ7Hg8tJ+joH97H/ODoE
X-Gm-Gg: AfdE7cndmoRhy4apiV4o9EOSKub8aKbMpCyuyaBTe5vMnBmKS/P9LSLd0oLlZ8J1I+x
	/8vNF4/CRaMOnJJKADcRVL6YZ36rNVOd9cx1qCWWn5TtX9ikrILiUubx6lWpccEH509L/76HEVp
	Mcsv45jc3FhkAnx8cs4PsiP0Lrl6IizmxFPcMCnRGy8LZxWJ4zONhnfUkEEqKfk2pdpff9B7Gb2
	64zK+YcdP5FZDneVsjjycnIiCCmJT0jDHFfve47Fbak4aui8OBcKkklHb0uqG7ZbSTr0gu2XHGp
	6fpA9W65+heYjEqM9zaon5y6aRcJP/UZ1ya8M2zulYYaH6q2DP4FZrwayUwHyiqt1euuYxRc7sx
	v5ngxfUDRDmDY1x/07llg2D0hM6xOKu5ZxJgrd95Sw/xJb614X63akjF3T01469T97AEMEfV2bG
	0u2ghA85q+L95IXA0hSEHtPrtPcqc+8QyZ2eofW2ovfepjwSUtqno=
X-Received: by 2002:a17:907:268c:b0:c15:f029:63a5 with SMTP id a640c23a62f3a-c161f393b9emr486403266b.50.1783977816462;
        Mon, 13 Jul 2026 14:23:36 -0700 (PDT)
Received: from fudgebox (k10193.upc-k.chello.nl. [62.108.10.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c1470325sm910975566b.14.2026.07.13.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:23:35 -0700 (PDT)
Date: Mon, 13 Jul 2026 23:23:04 +0200
From: David Gall <david.ccm.gall@googlemail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH] crypto: pkcs7_verify: use constant-time comparison for
 digest and signature verification
Message-ID: <alVXOFaHEzjWMSnR@fudgebox>
References: <alEsSl8i1_FpoU0f@fudgebox>
 <8607c6f25d3bad7601665bc4c4ce528e9f4cabef.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8607c6f25d3bad7601665bc4c4ce528e9f4cabef.camel@HansenPartnership.com>

On Fri, Jul 10, 2026 at 01:56:51PM -0400, James Bottomley wrote:
> On Fri, 2026-07-10 at 19:30 +0200, David C.C.M. Gall wrote:
> > Replace memcmp() with crypto_memneq() for cryptographic digest and
> > signature comparisons to prevent timing side-channel attacks.
> > 
> > crypto/asymmetric_keys/pkcs7_verify.c: PKCS#7 message digest
> > comparison during signature verification passes argument pkcs7 and
> > attached signatures to pkcs7_digest via pkcs7_verify_one.
> > pkcs7_digest utilized memcmp which could leak valid prefix length for
> > attached signatures via timing side-channel.
> 
> Please explain how this information is usable by an attacker?  The
> assumption is the attacker sees the module (or whatever is signed) so
> the pkcs7 digest is inside the signature in plain text and the digest
> of the entity being compared should be computable by any attacker.
> 
> Regards,
> 
> James
> 
Looking into the usage of these methods a bit deeper, I agree with you
that an attacker does not gain any useful information. I double checked
and the method in question is also used as part of IMA modsig
collection during the measurement collection process, but there too the
method is not used to verify a signature, just to generate a hash, so
the comparison itself is never reached in that path.
                                                                                                                                                                                              
In that case, I'd actually drop this patch. The only affected paths
don't disclose anything useful to an attacker that can't already be
computed by just examining the content.

David
