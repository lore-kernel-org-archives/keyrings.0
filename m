Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795498140;
	b=umG+XMeLXgh19f9CdopQTKSUTrV+lbcqdnhsMhJn+jytBDTpK7Q8PwPxmKIWP3Khqh4r
	 dLuVkFD70PIJ11w0WQqq2tU2DgKXwNbZlBSrtFNy/o2oLkLM8y72qhAi8zzZbRK1w1ytC
	 uby2AWfoN/ylXyVWeI5LGc79bz0my4VoLH8pCgiJYQuNxQDIm2zC8V+qOIT0nMFCd9Rlp
	 tGl9bMh8SwUk8oa3pVXilRef7xwGc7NcFL5RpGZfrCUUD8rcKVdpap3EEhoFN9RTsoU62
	 B4Eh+OlEa5MHNiCNXHNzjVMhBju6YtlL+ZbmD6j25xp9OQe/9Dxhv1T+DpOfO8wAaOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795498140;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ccod0uJAd0yXu81DJSEWudz3HU6ElIuIfF6lkt69LrY=;
	b=ldO3NZ/5Hbk8DWRUlTjRVnXuDxBw+6i+5ZXP1ScEv0rNDXw0nWA8GXSLD+bZ9pUKv/wP
	 p4JMMmNnx4lTsIC8CDaaF6oGQ0hFEu7T8nruU8i3qvE3VVecAw4YrOkvvRYZUamVP9ZkY
	 VD1ZUw3RhnASCNFma05WwX7c1SxS8TP66TGzutnz+Z6PyUfxNhLXEMctdtQ501b/XKnLv
	 /8Xxel3x+eifaN812/R1oUn+Vghf+DZJFM3W6PPArSlhgT7rHJHjls2MPa94GTHz+c6cj
	 nAmaZLdB677IACoHg1vegNr2s5ucI0V6yqFtnyutMQ+V16cnvI6y14Sqh7kaqAFq4xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28D606A31E;
	Tue, 24 Nov 2026 05:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD28D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eee8ada0e7c711f19a56ed5b684f684d-20261124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c8dfff5b-4efd-4687-be29-0173442e4e4c,IP:10,
	URL:25,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:55
X-CID-INFO: VERSION:1.3.19,REQID:c8dfff5b-4efd-4687-be29-0173442e4e4c,IP:10,UR
	L:25,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:55
X-CID-META: VersionHash:7db8b62,CLOUDID:be79c93fc9754e3551ebcf6f7c9e9bf6,BulkI
	D:261124132854IOOK88EY,BulkQuantity:0,SF:17|19|38|66|78|102|127|153|850|86
	5|898|915,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:11|94|82|1,File:nil,RT
	:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eee8ada0e7c711f19a56ed5b684f684d-20261124
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 520931854; Tue, 24 Nov 2026 13:28:51 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Guicai Ma <maguicai@kylinos.cn>
Subject: [PATCH] KEYS: Use kfree_sensitive() in keyctl_pkey_e_d_s()
Date: Tue, 24 Nov 2026 00:28:49 -0500
Message-ID: <20261124052849.940005-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
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

keyctl_pkey_e_d_s() frees the temporary 'in' and 'out' buffers with
kfree(). For encrypt, decrypt and sign operations these buffers hold
plaintext or other sensitive data.

Free them with kfree_sensitive() instead.

Closes: https://sashiko.dev/#/bug/linux-4199b169-0b8d-4055-9a71-6b5b79e38eb3
Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Cc: stable@vger.kernel.org
Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
 security/keys/keyctl_pkey.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index e7121523b9c9..8d2c2b65f50b 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -314,9 +314,9 @@ long keyctl_pkey_e_d_s(int op,
 		ret = -EFAULT;
 
 error_out:
-	kfree(out);
+	kfree_sensitive(out);
 error_in:
-	kfree(in);
+	kfree_sensitive(in);
 error_params:
 	keyctl_pkey_params_free(&params);
 	return ret;
-- 
2.47.3
