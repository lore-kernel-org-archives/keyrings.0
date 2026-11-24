Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519259;
	b=iyBV7C1kLgcrxSnAh6sY/7iImLXcQfmEm66rtwkplBnaS1r0lDxLc68bqW/cNlB/FDq+
	 VTysqQxcBjLC0eLWDiWL7Zwj5hdFaJYVgyk8c//npMIMMiMaucO51//w2kWDn+qVMOc8w
	 MrhTIKuV49ZvOjxH0RWkbqI0rhQj5Cl4cwo4qnCo/eGxq2w4rzM0kuCthMasQ688IiuWI
	 0e9abAxh93eLB+iUHcP7Plz9IuSd8hlDV+u2Sn1Isz4e+Sc2Cbog3GL5w8ozS5w9PMLkC
	 xxJaJd1kfymeDQHjYBYQMIp62q7I9HKtmgrLSNil/RjRHjD5qMX9fuAtXZ8JCx1wxtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519259;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=IVS6eL8QbCi0pXUvL6cuqVq9lxhuJRcorsy7TUfmbDc=;
	b=jW+zu2502VxV+O2tmrJq+0rC0iqL7yPexTVWxYkPsgv6irdluqEH0MCb9y19wm6EScm2
	 YCgKg8bA6K+YZtDI7gVzqRJP9YK91BgvceTBkI95ul0Gwi2dUtO4DqzC2vSpRpmL5bNkL
	 CocidyJX4rOiIFnraQ0TYz+epAlRxH8eSMJGUNzHaamr2/5U3R9nqnc2aOHUW3gFYWQFG
	 qonjmYMnP/8S2gIZ/0xbbYhqCmzLAehENVGe+XlBO3zeR9iWzx+CmKx3B90mxBrC5P/Qt
	 Zll0lwx3Nj37+LOE4pIGANUx1PD6qio+R6QZ/Utzayy88irCOvzZB7lWtO/x49fG2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8CE606A32A;
	Tue, 24 Nov 2026 11:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B8CE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 18ab7722e7f911f19a56ed5b684f684d-20261124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5e60e0a9-95b9-423f-8750-d27f3a71bc6f,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:5e60e0a9-95b9-423f-8750-d27f3a71bc6f,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:df191d0fa27302da380c1b7e7acd0a28,BulkI
	D:2611241920513HWIY6N7,BulkQuantity:0,SF:17|19|66|78|81|82|83|102|127|136|
	153|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2,URL:0,File:
	nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 18ab7722e7f911f19a56ed5b684f684d-20261124
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 907033931; Tue, 24 Nov 2026 19:20:47 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Guicai Ma <maguicai@kylinos.cn>
Subject: Re: [PATCH v2] keys: fix crash on big_key read or revoke after a failed update
Date: Tue, 24 Nov 2026 06:20:44 -0500
Message-ID: <20261124112044.1042041-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
References: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 10:57:59AM +0800, Henry Martin wrote:
> Instantiate the new payload first and destroy the old one only on success;
> a positive key's reservation is already 16 bytes, so it cannot fail.

Looks good. Saving the old big_key_payload on the stack before calling
generic_key_instantiate() also keeps negative keys untouched if the
quota reserve fails, and the caller still frees prep via
big_key_free_preparse().

I tested this on 7.4.0-rc3 arm64 in QEMU (KASAN, lockdep,
CONFIG_BIG_KEYS=y). After creating a 4096-byte big_key and setting
root_maxbytes=1, a 1-byte KEYCTL_UPDATE fails with -EDQUOT on the
unpatched kernel and the next KEYCTL_READ hits the BUG at
fs/open.c:1145 in dentry_open(). With this patch the 1-byte update and
read succeed, as do file/buff update transitions and KEYCTL_REVOKE.

Reviewed-by: Guicai Ma <maguicai@kylinos.cn>
Tested-by: Guicai Ma <maguicai@kylinos.cn>
