Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4313AA4E3
	for <keyrings@vger.kernel.org>; Thu, 13 Aug 2026 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601430; cv=none; b=QzqToNI+o3uFc1u+Ku5YhWhJheI2w7K953AVMo1LIiVcNfYRbu6zG1IstWXOB/PQZw7NfLbwYZjE8ANnYO4JZLlxqdoALBFUgOmEwD3GQr1CPNnOxJObKwPDs55KAdt+iehFBC/fDHkHnptKGNsMN53n+0zzmfGUAdtt1AEW0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601430; c=relaxed/simple;
	bh=7WEh5O5bExfXu8mXQ1B7pKZcn7Iuz4j6v61TvONpq3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDQDdIWLmefik/FHyPa5mrc7MYMXfUJ6r2f6BxWy06PQzKVTTGtkR1OcXYh2pMkOCyKWVal21hhXZPI9SBoYumtoe6VStncp6QkVPPIbnP5dk3uKJ3l9CWjFCCYN4zMo9HJNjwyAKwV75oqEAxudELaGq2Iy8qqbzVl033YOxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6vxQUIE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYl9xba2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6vxQUIE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYl9xba2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786601427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9+13YGpGqP8LzpQBtciWgZWdxF7wOy5ADfzqZPo8FI=;
	b=M6vxQUIEFenao35nQ4f68TFjRmXEoWTlnWzjX8f9vS6vvgDYrU8ENn5DwLGj37HJY87INM
	rgYkeGgHj1MxxbHwNvD0fUa82XPduVG/oHo4xf8oVqWoPiKMH7DvyJi4m+INmVRJbMjCtt
	4hnGmGsTfOhN2upsIwUnOO4uwTU/wEE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-OwKVvapqM-Sza-9Fu8O9MA-1; Thu, 13 Aug 2026 02:10:26 -0400
X-MC-Unique: OwKVvapqM-Sza-9Fu8O9MA-1
X-Mimecast-MFC-AGG-ID: OwKVvapqM-Sza-9Fu8O9MA_1786601425
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f6db77430so948392f8f.0
        for <keyrings@vger.kernel.org>; Wed, 12 Aug 2026 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786601425; x=1787206225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9+13YGpGqP8LzpQBtciWgZWdxF7wOy5ADfzqZPo8FI=;
        b=eYl9xba2FMWSRMynmCw8vDtZwWiMQIn6B7ORMTJrX4poGybCRP4s+Ig4V/acFZYLEE
         CZqjTQqXnvUaWe7YR4lnUfRyvA3RLiAJtSw1eeRRnZQa4kBgnqozm00o8OHVe9noeGnA
         hXjDa+HwlENzVI0AlWNO6uCj9Wo/CF3tn9I2iUOpwMKK3wb0UhOrzYB4alBiC0TP+A3E
         dhbic4H8I4HUrTJrKUtWVu1Lw/zI1rsOhuo0bu1gSV0rqwY5GG1SudtQGGgu4jPo1nqA
         ElD8kV3NIGWbSDPixhye3YWetYo0UJAbyzhYh3hd7cZnn4ysKD2qOkxbhYCV2sxFiE/E
         4gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786601425; x=1787206225;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9+13YGpGqP8LzpQBtciWgZWdxF7wOy5ADfzqZPo8FI=;
        b=eqAlpP8x9bdnE3PZDGCDj8gbNuc+4J9sGtw+FzY9v8mVLXKnXuAko+m0yaf6k3xrs/
         0ehOcKszj36Fldwspw+lARE7QPbZLT6MQMUNavcXZkP4eeoyFAG+W8uuTP0+/S4schxx
         7vutDYJtghLP3hNnQimm3QObI0R5PUxt+hOqppQo+LWk+SHOz0QrVFKoaSOfmrC5bv9v
         TLemJldc8mgVpkmOTME+QhK73K+ucwE4ilsyvK0/EnvdVnabSqXvUxJR4+UjkRmv7Kkp
         S1X+jmXlfPdEIlFKUzrWrS73j0uGlYGhVLmhixbiWhEVi5oumEVi6i3NUrbrJOi1AgmE
         pNzA==
X-Forwarded-Encrypted: i=1; AHgh+RrCuIZVHfn5nC0GDygbdkRGvUvFE26u0GJvgtUHvhxBFBOhSZYaLJTW+4O07Y1kM9OYsK4sFsaA5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsN3fDdgbBEVgRRHE5sS0gGF0mD2cA1/Ou/Jptic2C8gIo3AF9
	EdM0qb655e1kJO5WhMEnjAa1WK0vU3S+i4R2IqOuh/+6wsdtrcskpOhhdZLWnDsA6uBLOblXiwX
	+C1hCscqFYBCan790QYA5KGxiRBdAO2FM8YuHDKws7niLp1NGdcKAGbAzOyu7
X-Gm-Gg: AR+sD10SCrReecSmfk+GAWa/dcqekapZABmyS5aVLqCMz2GxQxFe/wpdZXGObZXyn2O
	k3sKDZE8dhBh/H25oKAbwLCT9Ec7hCDFVkoQRc0NvI44+LJAncG+BRxEVB7Bkois/ht18MhhmSk
	yqSyRdqykml62g+MCxdKRdlbIy0PJSjsGso1Os0Ef9dfyAJG2wtZfBOYwdXgPuuMH2yYEEJeY0n
	9NKT/5xUjGuwqmKiTcAvui65ySMa2QmibdGg2R0ytqcA4v140PfvtIgW6uFOEv+eM3q0luBQGyz
	fzLhb4KRGuV5uQ1k9z79/+5CKzOMX4SABu/Sa90i0iXt9FUOG4nVMiqT6ll760qqNMfmG1os
X-Received: by 2002:a05:600c:46cf:b0:499:4d4a:4990 with SMTP id 5b1f17b1804b1-4998219d44cmr27409095e9.3.1786601424513;
        Wed, 12 Aug 2026 23:10:24 -0700 (PDT)
X-Received: by 2002:a05:600c:46cf:b0:499:4d4a:4990 with SMTP id 5b1f17b1804b1-4998219d44cmr27408475e9.3.1786601424085;
        Wed, 12 Aug 2026 23:10:24 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f6b1sm39407845e9.4.2026.08.12.23.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 23:10:22 -0700 (PDT)
Message-ID: <fdd88f0f-ec72-4640-919b-3e6d3a3c9434@redhat.com>
Date: Thu, 13 Aug 2026 08:10:21 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lib/crypto: Provide a function for zeroizing
 hmac_sha1_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260812163336.3103835-1-thuth@redhat.com>
 <20260813022757.GB28329@sol>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260813022757.GB28329@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2026 04.27, Eric Biggers wrote:
> On Wed, Aug 12, 2026 at 06:33:33PM +0200, Thomas Huth wrote:
>> It's maybe not worth the effort for hmac_sha1_ctx right now (since there
>> is only one spot that forgot to zeroize the structure in case of errors),
>> but offering a function for zeroizing the data via __cleanup might help to
>> get future code into the proper shape right from the start. Thus let's
>> introduce a hmac_sha1_zeroize_ctx() function now and use it in the
>> appropriate spots.
>>
>> Thomas Huth (3):
>>    crypto: Provide a wrapper for zeroizing hmac_sha1_ctx
> 
> Subject prefix should be "lib/crypto: sha1:"
> 
>>    security: keys: trusted: always clear the hmac_sha1_ctx before
>>      returning
>>    lib/crypto: sha1: Use hmac_sha1_zeroize_ctx() instead of
>>      memzero_explicit()
>>
>>   include/crypto/sha1.h                     | 17 +++++++++++++++++
>>   lib/crypto/sha1.c                         |  2 +-
>>   security/keys/trusted-keys/trusted_tpm1.c |  2 +-
>>   3 files changed, 19 insertions(+), 2 deletions(-)
> 
> As you probably know, SHA-1 is a bit outdated.  Will these be coming for
> SHA-2 as well?  It would be nice to introduce all the APIs at the same
> time so that we can make sure they're consistent.  I would actually
> prioritize that over introducing callers of them right now, as that can
> be done later and often requires acks from other maintainers (and they
> can go through other trees as well).
Yes, makes sense. I've got a patch for HMAC-SHA2 ready, too, but the patch 
that is using it on the calling site has a conflict with the smb patch that 
I already sent out, so I wanted to wait a little bit til that is merged:

  https://lore.kernel.org/lkml/20260812130152.2861834-2-thuth@redhat.com/

... but if you're fine with a series that introduces the zeroization 
functions first, without immediately introducing callers, I'm happy to 
assemble such a patch series first!

  Thomas

