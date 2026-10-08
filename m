Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30583AAF5E
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479238; cv=pass; b=MA6Nv1FL+tE5FFxD6K421p8/gXrpO30u4hGe4D6vkdY7f3/8lmsyuqSlIQEPPxF+6C9z9wNeTYQzZ6I6k/nf5rcm/DbbPXaQ2lv4oDEihX0BqpMcU9ekCUUmvrP58+zbcqivs/A3FhNYS+2aET0moefQ0RmvgHsq5sY/GhIdtvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479238; c=relaxed/simple;
	bh=QqDI6Bbid4Z5TSJM6uhAIwDVDE3XcRkTjQOjWmVeRn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayPJP0fupBGmfNbFdxzxG/o3ChI0cIWb7+yQH1mjWheUNaE0v1b/9JE0z86y/ttndUE7VqeAN6o31s8leDcQHumPALpJ4qe7MsFerq1O/A8Hr7+U31f2dFVQzCVknjt2zlEjEPGZx1Dr1O46ETUZjdXdFB7M6tXTo0wX4J8Huo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjskiTdX; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjskiTdX"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-87ab6e5f91eso31513307b3.2
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 10:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791479236; cv=none;
        d=google.com; s=arc-20260327;
        b=OSFsSNzeXjHtaPtlApoYOxX7CVj3ghvqw34DqixBIotq4fji7BQb9zHibzhIxzZTZI
         K2AlArm/cxg8k3zkhAxW7/sx9SUUsGBBjdutF+smRfvvps9H+26QGusPjCKTCBaZQxl8
         7EWojlvezruUqeWcJfoUpSlMjAKG9YIfDh7kf8OC2i1zXymAB7w6wFzs5EAzVZ8I65wA
         1jp6PwAn9HqB+qJQDvpk343ex/TgtGmiMgXvLtkbwtj0HB61QITqAc8UlO94xRSVg9hO
         MRD2z+XBgxnYBTuY/dBsHR0y1XTCiA1E21acTQQtvAVyFFtLcCBeTeYWKuaKvExI41x5
         1/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        fh=d0BGee87TXmKAPaFXsHk95k1y7WujOf8Rdz1Gg/8jvc=;
        b=SqoTYhPy3gkWFO6SDJIuyGI+KHrerZoE6G2d35M1snG4tBMNN6LMonsF0g2SA7YCD7
         jj80/y1IAHKgQgIDIBKMknTkMGvYkbg6cUnaUnlq31aOOXw++d0heI15axPweu4EB8MM
         UWcilGkSKMXXLRDJQsYjpy0WkKXN9lDDZJEH/Dl9P7ePmKdLSM3QfFY2GsgkiyUhEmNM
         /UVieWMPxrdgHatqFk5745WJ3hTv7TtZCxppjmz9W0wWK0MDhx6jns4NLBNbC7C/rFJL
         fm6KcCaos4kmqmmze2DiwwjnA6dvI1nHYt7Jihj6cKoNPJWnM6+M7KOFSNIPP0PW6dsd
         Jnzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791479236; x=1792084036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        b=CjskiTdXhMBCOIOnG/ji8z7M7K/m2VM8bxynqze80Ch/Mad0y202dkdou7i8ZDrmGh
         pLXt6tEMMlu6isPmJjYONw0zlbyXN57WCSfJK2IqcD5y9CXWdpou684S3S3UefBh8m08
         d2fyETfcYmd/aBr6Fff9lHWFaF9d3TIbPFf5hE2ZYufrgNTosPdvW3Vws0Zn2h/+2r80
         wssMtraSEYY4zJmFsPiAzFjNq+j3E1lRC5s4fLoNSHhoYsIgrzDHSyjl5h+YzswXRf5c
         hEHXMo0+NUFC5JKAFGzM2Ff/yA4yX77jDoyM66BbKKiZWRqsL4WIOtSXFu5Y8BZjmozm
         cU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479236; x=1792084036;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2vxAQYqUPu2IyOv6/hcaTpeROBNAxx/kWZ9+SB1EYqQ=;
        b=SpHPHFxGPjqYAUZ//jh2yzN/lXcSBCmooQaswM3t815aLPYYt6/Toj4a3UOP8Oa41l
         8OgC6JWfLU+DGv2ouxLrNJH3Fwu8idv9bySM/Z3WTxwbrYe6SLEptTuO8OF0zidY736p
         bBe57FSgnhlKFmKlBGegtMXf7iCcKObcs050x26pbGaHcdSjBl4HBb1UEdE6Dqmpm3Lo
         lyFe3+1sYedlDFn32RceIOh3hT5LBwyg6olrksrDnGMjwcCcns/VV/eB7wd2DWVQP53a
         YvTnfHjBkRtP/LfdplwEa0jOiXt7s2gjOSEn8QD1jFDZrgvc2tIxfADnyZ7BcibB5w0C
         yvOw==
X-Forwarded-Encrypted: i=1; AKwUvBxpkChXATj7OI6VLS7qoE02xKgO25zOUA1nzjcmdvDy4DZvHIdxKGBR3HmOBPJDaSuvs4ClFtRj7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIadO9aolryFGMwV3I8YFRPXC1x0BnVvpc+VUDfQck7bEShgDwH
	F4bbrO6ugt3mOMwc3+s2AXW9KI77n12AmW46sg/4AcmDVY5uoXfCIQCrrhx61AHPZ+OdoAbl//E
	elTMgry8GZPkSdYSg5vJajl9aSkTjMzrUzuLc4wg0Kw==
X-Gm-Gg: AYBFou1vB3L0Q/jBocfaKKLGWUDYWqSXzfCvbgF2oTG6Ma6sKmYb9049+svW4LooNTi
	VtEV/QX0T0NdgKYX0hCbTp/z/gheYVnZxTXlGkd8XPzdDMOPMOxPMSK9giQ0s2rhPG/YNZlOFps
	3y0tDFqYyIgW83wufvJJxSQgt6gjgyW8JkADV4WkvJur/ExTKdEbILRA2Mqesxp1K/eZjkGpyFc
	Anr7GzY2ZPNzcvohCvJQdLm9zCqs5rXsceCWSZKzWJWunZcL2oECUTLahDemK6OfakPjp2K40Dv
	4faewTZ2cX9QCLYu/IT5j64FWUxztR2o8YwCahVb5cKlWC3eysahvVo4OvD4UqoWpiyFjKYkBkB
	SYbJ7EXrMBwwJb2sbQp1kcEDXMI4Yy6pmfMZzjqUfF40p5+el2ZQL9EeXTGE9M35UYKIlSWX4yZ
	89gvTQJ/waxLyz/pc2vKIvEBelmyZnLC8RmXElpSP30dBFyQX7pMb1fkwKWmIF7vNhd0Wucn7jq
	i+fE+ZSOMASDS17ex01EZejRP+EY0R7KZ00Gb/uHoSL16n6vnBWXGGGChd6Z3OZPoyY2GFkPjCe
	xbIvoIeTO9iu1TzpeU9SVvCTRSkeXW6vOCDgkqXPfUuUh/Ym7r/9k+7kq5gfLIQrs2Gczh4PpN4
	+wBaOxH8CjjzTuZs81S8h+eqjTk0a8X6R7Hia0YzbW558yKrf80IT/ZBXbwCDGtuH
X-Received: by 2002:a05:690c:6d84:b0:8ae:b617:7113 with SMTP id
 00721157ae682-8b05ae92339mr32919307b3.6.1791479235462; Thu, 08 Oct 2026
 10:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008132532.1155166-1-matthewg@nvidia.com> <20261008132532.1155166-2-matthewg@nvidia.com>
In-Reply-To: <20261008132532.1155166-2-matthewg@nvidia.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 20:06:39 +0300
X-Gm-Features: AclHuK_axRHHNMJXbXP5qGzIg8glDqrcsSviR3SuESczjar1LzYO3sHRH5FmG7w
Message-ID: <CAC_iWjJJMgTCPwmVA+vhDq+qfh5U36TbBiqyzPaKeDxTaYjqsQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
To: Matthew Garrett <matthewg@nvidia.com>
Cc: mjg59@srcf.ucam.org, keyrings@vger.kernel.org, 
	James.Bottomley@hansenpartnership.com, linux-integrity@vger.kernel.org, 
	rafael@kernel.org, linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

On Thu, 8 Oct 2026 at 16:25, Matthew Garrett <matthewg@nvidia.com> wrote:
>
> TPM NV indexes can be used for various purposes, including using them as
> PCRs without depleting the limited number of hardware PCRs. It would be
> beneficial to have one that's under control of the kernel in order to be
> able to prove whether certain TPM operations occurred within the kernel
> or not.
>
> Reserve NV index 0x014c4853 for use by the kernel, and filter commands
> submitted through /dev/tpm* and /dev/tpmrm* so that userspace cannot
> undefine or modify it. Blocking definition is more awkward so let's
> allow that for now, not being able to modify it means there's nothing
> interesting they can do there. The filter simply validates which handle
> the relevant set of commands is referring to and returns -EPERM if it's
> the kernel one.
>
> NV indexes are from allocated ranges and this is a range allocated to
> Linux, so there should be no userland depending on the ability to access
> this - but let's gate it behind a default N config option anyway.

I think the idea is useful overall.

>
> Signed-off-by: Matthew Garrett <matthewg@nvidia.com>
> ---

[...]

> +static bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> +{
> +       const struct tpm_header *header = (const void *)buf;
> +       size_t len = min_t(size_t, be32_to_cpu(header->length), bufsiz);

I haven't read the entire code base but don't you have to check bufsiz
and make sure it's a valid header before dereferencing header->length?

> +       u32 cc;
> +       int i, index;
> +
> +       if (len < TPM_HEADER_SIZE)
> +               return false;
> +
> +       cc = be32_to_cpu(header->ordinal);
> +
> +       for (i = 0; i < ARRAY_SIZE(tpm2_nv_modify_cmds); i++) {
> +               size_t offset;
> +
> +               if (tpm2_nv_modify_cmds[i].cc != cc)
> +                       continue;
> +
> +               offset = TPM_HEADER_SIZE +
> +                        tpm2_nv_modify_cmds[i].handle * sizeof(u32);
> +               if (len < offset + sizeof(u32))
> +                       return false;
> +
> +               index = get_unaligned_be32(&buf[offset]);

nit, but get_unaligned_be32() returns a u32, might as well define the
index as such

> +
> +               if (index == TPM2_KERNEL_NV_INDEX)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +#else
> +static inline bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> +{
> +       return false;
> +}

[...]

Regards
/Ilias
