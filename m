Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D866E469829;
	Fri, 31 Jul 2026 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515274; cv=none; b=MsjVKLp8k1VjPyOa+R6hZB7qfKzUjDwBcNxAfGrn7Hu7fOFW3ZWKAYsjQCjF/9yJYe/bLXu+RlS6N0SNIl+2qIoLqYElPzGEcBYR6tQqLrYrLtBglaZlfds6qMGfzKJu+rLCtJTpXfEmCDjAUU61YwMNvuKarz0K4UZKbYpK08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515274; c=relaxed/simple;
	bh=oQakT4tZTZ26yYuWUyxmknYxLRV5Ax8XxkRik07misk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU7ogxYRAQZfibPOwBwQw69+5zz4TaEGJIXhIsVF6WWCPg8LHCaXBBRW+PvT18CMTHivhlBFr8c2z0VQPiNupm12EfsrGptrz/4VdwfRTbFqHJzU2zmUHpGi98ZBok6TX4yjhVNJ6P8pAScUyeSK0E8D5H8ApnPXdPYAGxGXHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=b5nCQHhm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQa0aJKS; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="b5nCQHhm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQa0aJKS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D71A7A00C2;
	Fri, 31 Jul 2026 12:27:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 12:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785515269;
	 x=1785601669; bh=J5nIrNoSMiFUIl5DH8xWdANuglVgj8cbxwTsb9rwYoA=; b=
	b5nCQHhm0J+Bh4qWMlYQ+VsiYMqE3pkfp60xUmMoRloMX0iNUYrevWKmbbyiOWGv
	C8A4jONRfkjwdqa4UDoPf2/VFB+0CJDYxlfdIuwSFIxZ1y5yisj6t0jPZSM4VxsH
	pqOYwrh8rjbx+0D9GGSdTnnVK18qbw6BQAVphQpwLDfz4mV8GxmENU1812Qmh5Mh
	Ai8uEnYo6JS6yVNNqsya7j+iQ9tZbapAF0QAWYlNV4Tj9LskF3Mp8dVvKMe/e6jt
	bPcW0IZ8vzdsMlpLkaVB7E1912BAhzHsum9haIOY48eNaYCmPLEPkjirpl8oGvVO
	BCNwOK0df5Nv7Fh7gsl1uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785515269; x=
	1785601669; bh=J5nIrNoSMiFUIl5DH8xWdANuglVgj8cbxwTsb9rwYoA=; b=a
	Qa0aJKSLM9u3cdJFxgBm0tbxdbLzGB4URrat1wcWTbAgoDVihHaOx1FvOk5GIiQR
	/9p0LgUh2oyils3n7tYpJKvL79ebLZhQB0aghE1ZC1j4GhFSfbj859ouesVQHpTR
	21iCK7tU/bndrfcMO96y43oh9nCedWbYQwwgEDW3Ng2xKkth4bK/CclGpjKqfrNr
	6g3aqGKku+hEg9VOusp0tbXKRRX9+w2lHNgEwF9ea2ZOoWk1yP9DpQEtpDwF+IsT
	OVW5dLG/FN5Eg5QFY7GFd4Cg0P0hlhUvEJGbgcnZD7AL/LonmXWVSSdE+vPlk7K8
	GD2+mOHKnOpxl9PcfPyJA==
X-ME-Sender: <xms:Bc1sakFa6ckKoqrFLAzPC3TUrv5WJxH6ldYcow49AmwJFyn0bT91aw>
    <xme:Bc1satyJ_0I47EPzXiqmmi1_m9TXVwaQcCgTvfFud_seRcZqPon_9myIfXvEIVnvh
    xtv3nMfz-y1XKLyXPeBF10jKdZoRdIgT3vmq_Ar_VFPFuD_TdrOvvI>
X-ME-Received: <xmr:Bc1sau1WgMT4nRpp1Fsg_3S3JEfCzTecw1KWURrEtAPSWNnCnA_fvP2WfJtWoMcWgnExcfRUem-PM7qFwQ>
X-ME-Proxy-Cause: dmFkZTGGTelZmm0/EhQAYArVTdDhZzjnmAPb6bZI2uOfRhcPRz2TI2oV8V45PSh9LdLr+9
    dOlgXoBfEoyyFAhrcqXPD5Q9hVEjtJXoIhF2MoKd1yKDTw2ea5Nuq/+/AmFYSUo339o9zZ
    H/at4LG3KrzxwoyaKUbXnTAmsLw8u8bstL0n0Hm+zeS6dtuk4WBOYvxR1KeM91qs9pbTHn
    V5Yj6ph4RyA95kbMawVJDFVjaiGwugJQQV6H1QnRSnyH1rCnmQnAGiB4dMHKZak/Asn8tO
    F/0oy0n4YeNO9MT0ImsCVvnJvFB1zR3ciQwN/2JEWm+YOztTqwzq31OHYrU6wne+Cpi3K5
    TTD8qnOBAfOaIb/KCcnmwKr8TGm24y8rMJ8KNnshmEvBNvcrVA3lZ/fsqnabQ+bcEZvCxK
    jVF6kNhPnROpmUpXsT9cQQ9WQAmvp3ChKXD/51Kcb96H3pMPJzDNcq1KfaKpkTZ8t4KfO5
    AZsrHKXNbdf8Go9a0FfJSzKbdlEWCCQe6tUIEj8/1faJjDnVbgdenfwqKItxhfUu5xB2KJ
    wGozjEql6w4pzgqozJiilyeInEsR6qujBgBrWFTgx+kdN6tGchhD24yAmJ/Q5c67/RvrEs
    wT/Jm4IWcIvL3Yzv1SN3Sy2S1UiUxCs+GGRjhmkWjnngDVFojYXuBC16Bqmg
X-ME-Proxy: <xmx:Bc1satrXBRkLfy7bBimN3F5eqR7idEanWT0Vno0Sk7EwpK5or2MGVw>
    <xmx:Bc1sarX8CGRGgs6ptGjh4hnHVpC5Hyl-vlRHZqdDlvC7PuwwdIO5XA>
    <xmx:Bc1samo4L8h--wHiXNuzz4IIByBgWUAUm6bNzU9kzfDiV70sIy9muA>
    <xmx:Bc1saiAZoPLmVSYE-iqXwOXEVnDxMd99-Vrj7I2Y-e1HY64J7oPTWw>
    <xmx:Bc1sahVxvqUHa0FML2utnkaBiC0hBDSUqJQDNS2wNexZYmN7JiE2vwDI>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:27:47 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/4] of/kexec: fix typo in comment (usable-memory-range)
Date: Fri, 31 Jul 2026 18:27:36 +0200
Message-ID: <20260731162739.158320-2-linux@jaseg.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731162739.158320-1-linux@jaseg.de>
References: <20260731162739.158320-1-linux@jaseg.de>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 drivers/of/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 029903b986cb..36635f6cb900 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -24,7 +24,7 @@
 
 /*
  * Additional space needed for the FDT buffer so that we can add initrd,
- * bootargs, kaslr-seed, rng-seed, useable-memory-range and elfcorehdr.
+ * bootargs, kaslr-seed, rng-seed, usable-memory-range and elfcorehdr.
  */
 #define FDT_EXTRA_SPACE 0x1000
 
-- 
2.53.0

