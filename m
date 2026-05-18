Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCC48BD41
	for <keyrings@vger.kernel.org>; Mon, 18 May 2026 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122693; cv=none; b=Yn1VErfuAGEx5Of3qlGml9TfDDIBESoiUfDCiTd/P+aT1MRmlpJ/xa9Rw70dTbk28pV0Q5qpD/KejWfk4EpTP1SmQZvQGAL/2e6UHmkpPZYj5vaECmNYCfHgmppFgvY5JWwmfTHt5Vxu7XCH85vk/YWEoVnMToXyuoM5NvV68lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122693; c=relaxed/simple;
	bh=cq2a7uQ8jpApJSDrbP3reomZGBn5KZ1p0V/+4eYXqWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSKhe4AG0MV0Rfs65Uz4v9PpWI+5uDRcEfAqqTzHExBowMzUL5giGCJ7+eA3iPuIY1/rP1NaeSxXM2GTbuY7LsJojl8SS8UFZyDmTTPMBP8Yh3j+FA3mD8t+BJtYXGMFbFkKmawcNWodTwvPfAdYW0fZp++qe8PTDwlJhfb0FWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZGNEhYz; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZGNEhYz"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2595448eec.0
        for <keyrings@vger.kernel.org>; Mon, 18 May 2026 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122691; x=1779727491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFll4KsJtYpY+ISlE5pnvUV/L033WJ6tSQssCbb7nlE=;
        b=PZGNEhYzlKD0oKB7huLCcVmzcVhmrRiEoqhLIJH0E0JWm9J19kB52OZM990S/yAhZl
         TZunz/evWxacWy0bGU3Emk5EqrdJ6t0m2iGrEJX+Viovs0WFnjnSpwnMoVI2+xI1T4I+
         Zr8EHs5n3vIjfm6XMWrwWbfsOkQDATs78NyLga8wHTEXyXmTH4qKR2YjmT8w2LwpOsxj
         53NhVIYZlKytXIeNRvsPPTs74xM20M+ZiJXkuI6suGhRReL6eTJynZzACXQWmWZwGl/G
         LuUy4cvEp/SvZg8ume4FUY0IiuyjErxiul0FKv3Fd8QJIDv/biOIzEp7MlBmbadBYKHb
         L2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122691; x=1779727491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFll4KsJtYpY+ISlE5pnvUV/L033WJ6tSQssCbb7nlE=;
        b=ZCcj/SbRxALk7T3rJkWG+DxgcgfJ7CQSKrmcxiZj9j2rR/1Uu0OIpxdWI9LPiz0x3a
         XPiaf8qZDjoUQeWjJdjonFdadOfBqI6R/m3FsZA+P6lua+Fd+ekfpo7w32nOoFnr6AcC
         Ub1hhCfX1vYeuEWzW59goZPXLY2V4ad42sgTWJ42HRKyDPm5U9hYI6Hua+ac7d0fB1U5
         LOTlgNz/jpvn/quZHKloSMi3QvkGhyHs4rzNdi8fYZAqJ/f1x1tqQ9L5aGGmENwmHJwX
         uktpGXaTETJRSINdkdNRgMherZkY1UIzzO4yiYn5nh6ZE/j2RT+ckwYr5Gkci643pTod
         +QEA==
X-Gm-Message-State: AOJu0YzRRWT2eUyeQXo57dES2qR5q8M8H0qioUBAsYd3VmepzIpXQiCu
	trStwraWyTIqbVF4CM7hFQC3E3UVgoMhCnf37Ol12dIo6UE3A0JN9qFsyhkMeh6bmK8=
X-Gm-Gg: Acq92OGkfL0qnTnUPRI/PigpxiQx5ZYgswSca09lBNW0EUwOA9gAHNwGc5wu7K61hQt
	mdAGUonwMC7/BuvXdak2rviFl70dsRnKiI8r6nNh8c1BwhiUQ9upi4v9RX6sh25yua4SE2j/MGv
	Eoqf8fOsfwnWmoc24GNo+EsEL/i9pSVEZ9asY0R2CxR6xZbyEbDQtcdp5EisfvslG+CC/cx8p6t
	Vbap9ZTlAJGPODutlcGloAPEQ1AdV6E3/Pq8t0uIoI1zaeaBJ9djJmmZdNOfHF6NVr8BC8GqsQr
	7y+WiCFM84Q0Bp0seh5M6h8lidHDiLrsm0rROFJSZcpojhkvpA0Ia9cuyqE8JYy5LLeWgNsqXf8
	AHwY7TduS3iFJYJ/J1HJg4qXs8Lpn99Ap7ehABDRpeqspnp+0BV6MQWVKtlzoDwosRJlYjyc5uK
	KgTbrVYGT7yT5HSmJB/tpwChr2KQvn96OdICAl98/wb2MhhjYZ
X-Received: by 2002:a05:7301:6884:b0:2ea:5057:a2f9 with SMTP id 5a478bee46e88-3039867f58bmr6060520eec.16.1779122690693;
        Mon, 18 May 2026 09:44:50 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffdf0sm14812937eec.8.2026.05.18.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:44:50 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Shaomin Chen <eeesssooo020@gmail.com>
Subject: [PATCH keyutils] dns: Limit AFSDB/SRV records to MAX_VLS
Date: Tue, 19 May 2026 00:44:35 +0800
Message-ID: <20260518164435.3875488-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

afsdb_hosts_to_addrs() and srv_hosts_to_addrs() store server names in
vllist[MAX_VLS], but iterate over all DNS answers without checking whether
vlsnum has reached MAX_VLS. A response with more than MAX_VLS usable records
can therefore write past the end of the array.

Ignore additional records once MAX_VLS entries have been collected.

Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
---
 dns.afsdb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dns.afsdb.c b/dns.afsdb.c
index 986c0f3..983e7cd 100644
--- a/dns.afsdb.c
+++ b/dns.afsdb.c
@@ -61,6 +61,11 @@ static void afsdb_hosts_to_addrs(ns_msg handle, ns_sect section)
 
 		/* We're only interested in AFSDB records */
 		if (ns_rr_type(rr) == ns_t_afsdb) {
+			if (vlsnum >= MAX_VLS) {
+				debug("Too many AFSDB records, ignoring extra record");
+				continue;
+			}
+
 			vllist[vlsnum] = malloc(MAXDNAME);
 			if (!vllist[vlsnum])
 				error("Out of memory");
@@ -141,6 +146,11 @@ static void srv_hosts_to_addrs(ns_msg handle, ns_sect section)
 		}
 
 		if (ns_rr_type(rr) == ns_t_srv) {
+			if (vlsnum >= MAX_VLS) {
+				debug("Too many SRV records, ignoring extra record");
+				continue;
+			}
+
 			vllist[vlsnum] = malloc(MAXDNAME);
 			if (!vllist[vlsnum])
 				error("Out of memory");
-- 
2.47.3

