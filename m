Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894665;
	b=fbghBz/yVWQgvkjG+WmpZ1IMYontr0ZEfiQsvQmQbBUF0U1l8F1eSGU4nRueltgfvhEc
	 iK1XPoJfMfhv2VazeYn0Ub6P9MNsM54dStbD/V3RMCKgnytlxFQKXlR/k9hqfzIynMkeT
	 mcwrnUnCNIlhOCQsfaLNVQuLACq6f2Lhd3Z6nxInV3vCon6zmFgT5WVbrFE756yuDOKlE
	 YchitQGfR2peTG/Lqty0WpYewn07YDQ2O3VAIYEGz7UQiO2/1ssheNARyPgQcX6Y9mfLt
	 oeWVPNfCKtLMvJRZ3oAtg1Obvuirq+IVU/wl/wTmgbhKqxnf85cqV+KGzajTK1tF/Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PmU9LeRVfJIomttwTfI12hurbmJm5G5qfWSq52y0m8o=;
	b=e2bwvRm1XNT18kGENtxOZZUBwVtn9rhYihXyAHs3sdpRKeQPmzUFZsQD7rsXlsiUiZR/
	 lBFo2lXiNycRQlQwrIJp67CwFP9RUPSWwNSddFK7v07lbVcnwK0DX9EWb4mqBUQ+DMPPc
	 +BkIxlsJ4dJkb+orVv6NSPISWqOiEJlRitv0k4iyXektZxFPc27rxaq+uoDVQ3YjQ+itY
	 FyjZG8qxeNWW5CEbH0yMshplHxLK+bYmZVxOk7q3OIV5Itiv8FaZNuP9pvVdVuFPH/t7u
	 EAVUj7SH1PHlrXj714IQS3eOwtafWmlAUWmv+ahQBJrA85E4pekzxb2gZTUv+kYFWdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pu6AoDu3;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A37606A31A
	for <keyrings@vger.kernel.org>; Sun, 25 Oct 2026 02:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6A37606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pu6AoDu3
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b28d9537bcso1303227b6e.0
        for <keyrings@vger.kernel.org>; Sat, 24 Oct 2026 19:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894664; x=1793499464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmU9LeRVfJIomttwTfI12hurbmJm5G5qfWSq52y0m8o=;
        b=pu6AoDu3aCeUvw4nLmqGFPqbIm2HBjwQIXqoXBzY/7qK7aiKJshMUp6t4G1dpv9To4
         J7XTpNw1bEquOgVLoV0hG30OUBNjN2LrH3L8YZzk7wPfvcZ1JCcaHToB46NUK4acGvIr
         PBLviwvVhGKnsZVyHiNuL08WPjwCXCP7+PNhCeFVwqZUTd21Zyweniy9mOtrhEvFpliN
         yEx0usVMwkaNP3+tAsXA6xtOaUgfmA88F9l4TC2KF1F7To/hmIVzu/RVtKQTEofrOMXm
         JyAiCBaElEkrNGiq0iDou0wKC47yRZzjmuC6FJaydy3a3FwTl9Z+etxazyx4lxptORUI
         teKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894664; x=1793499464;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmU9LeRVfJIomttwTfI12hurbmJm5G5qfWSq52y0m8o=;
        b=NtC8AHn3oRDzkYGtC1tsF1IwPwVVuDH1m/GfHXZaOlwSSaChkdDQ90B5JZW65KkqZt
         boq+1UTMvwQ/TxdD7ZnVZVTt6+VVMj6S62dZh4DkJQzh2yzQZe36oLokLzjQN200k9Gi
         A3Wi75PRKLdnEVHMx7YVdVPDOevjLwLZLIm+wBc53WOfX5LQdCTVXT66QKUPwDXzrsGW
         LWn9Aq91nyMPgJWeHZQRT3POcslql0TdQeKSPtaR9F91AjEic2Zea6TjY1O8jTgHIrRx
         bTVAY54IE8kJZr7zuPQkuOhsuGOc7eyQV2D7piJvWiGsrxEvpZ0hRVdZkgTijAd1Tc2n
         DgmA==
X-Forwarded-Encrypted: i=1; AKwUvBx1FsPZlolYzIpBP0GlnMUJmsqgG51pDzb/W+PjIW8B0CK2yzWDWOlxOPo3e04KswOqpgkwlrZByw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6fyGNtlb5JqHDpby7kuRqsnidezRjtZ+ztMS8AQdXU+THX/Zt
	SVNbrpxiYWnhr2QZA8fbOlF6HVRsasPtJxyWxJKjZo2Xz7Nt2IhVFDTu
X-Gm-Gg: AYBFou0aZvV+hkJ9e1/LPkY7Lvcon384ciwxA4Z8DxtErwubI2Vhi+W3/L+v8q96bXM
	C5kOZXXIuspgt9GPqqP9sK8vLT8g70lM+fu9MGFiQ/abhvXPe3/913TSjMn6QiDJunBOnAYkyRc
	HoNfXwoUHAVtB3O4quoNMwL8FEIhnKVZYyTGtWT9SXOZyxlGMTEOg/mGck5WPY7s7P+yKtPP048
	YiIUhE1V+LERhcLIfY0j+e5hat039D75Xp1+1+8tbxfXnruWNW8E7C3cqGTamVHLqvx8RXpe3vt
	pSe1GtJhTkIW4sPeOzutMsdoLqYdmPI5+W7aamHVtZBpsWcDsG/1FJJ+4P7yENTkw2S7Skw5BKt
	YLIbg9GBH6ignT+62zHDcO5eIjlrGPe/WA+XElhnxyNJQ8/obeWQmt8lsJqBUzSGb9Jo1MNA3/x
	9I+svpVs8mpDjhdS66l0rEJOxF2QXfOS7y7G4Zu1/zYDHUmUqAPLDpcbk65wp6am86xUyr7fk8E
	xS2B5lAq7B/g4oZCzzw79mpPx61qOafGrdluTjDPFPd6nYs+rA5vWUIgAyybfJmfGG3cA==
X-Received: by 2002:a05:6808:3196:b0:4f0:2d60:f0f4 with SMTP id 5614622812f47-55c00280f59mr1461562b6e.17.1792894663783;
        Sat, 24 Oct 2026 19:17:43 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c040806a7sm2433986b6e.2.2026.10.24.19.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:17:42 -0700 (PDT)
From: Leizhen Zhang <lzsx618@gmail.com>
To: dhowells@redhat.com
Cc: Leizhen Zhang <lzsx618@gmail.com>,
	akpm@linux-foundation.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] asn1_compiler: fix heap overflows on small or token-dense grammars
Date: Sat, 24 Oct 2026 21:16:54 -0500
Message-Id: <20261025021654.519754-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008164004.3668307-1-lzsx618@gmail.com>
References: <20261008164004.3668307-1-lzsx618@gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

Please drop this one. I went back and ran an ASan build of
asn1_compiler over every .asn1 grammar in the tree, and none of the 15
gets anywhere near the token-count assumption; only hand-written inputs
like "{}" or a comment-only file do. Since the compiler only ever sees
in-tree grammars, this is not a bug a real build can hit, and I would
rather not add churn for it.

Sorry for the noise.

Thanks,
Leizhen
