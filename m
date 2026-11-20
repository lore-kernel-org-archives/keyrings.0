Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141500;
	b=Nr48sSSVTudrOGt7eVkwHnLUvUmudOAACOBqptQTuSGm3g3hJcvYLlLlTPYP7r18XYca
	 Pgw1Nvorwj7uOxQjOQt2V2vFjF53W2qHsB6Y+y7rJ1Q47h97aeDzJsrO85zfLpmIYTPw9
	 rpzMmUp6IU+obhETDx8PTfpGi3SZFR02hGO88uE95aehc/j+JVTaXVLyg3x2d4NsVPUw1
	 TKhiWAaSfGKzQxxYaHtMnKBxdXocVvLRpb/4VURY0ARb21F9MfsIncMxhwr58hNGgWIxZ
	 niNmESl5GoFfSibFJg/dGsBglpgGc4YvlnZQM6LZTFnJmP5M5TDHsP78VvhY4KVjFUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141500;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e/yRF5PAOgtNpPxRDH950aFB6HeAwc96TzFEifGB/JA=;
	b=IUOXgk5d/PKYzWNbvWBc3GSMFwn6C8aj4t/qINojtJAw8OnZ40iCdfTFr36FB1DonwJa
	 vGsunb6kOwwZHZDkqxLRBdJa1roHfbo2bbHsINyLV/9nUGLSeb/ovMGbvGRdWW/IgUCQc
	 FCtDlVQc9MR7heZhvRdMm5j8AAHYipu/YoKy5/1WZk/DsUCqS5tBtcn7Oc6NOzlyx3s2v
	 hIS3c7QwBf6aRBwL4zGHgjTOawBBmb0o3RJH/t2HdQGQEh1sQuZBRabcW+Hq+PrZzm4X1
	 EFd9fM+f4PhjFs/KLLfYwTYOsQSrJtq8YKoOe3i5Dr+eCgktPz05RHC1YhtEI+G24hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6432606A320;
	Fri, 20 Nov 2026 02:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6432606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8fca1660e48911f19a56ed5b684f684d-20261120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3db980a9-a9db-468d-bc2c-f068f33d65ae,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:3db980a9-a9db-468d-bc2c-f068f33d65ae,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:e09aad131f9c11229837b4cdb02c98fa,BulkI
	D:261120102453QO96VTTD,BulkQuantity:0,SF:17|19|38|66|78|102|127|153|850|86
	5|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8fca1660e48911f19a56ed5b684f684d-20261120
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 410842112; Fri, 20 Nov 2026 10:24:49 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Florian Bauckholt <florian.bauckholt@cispa.de>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guicai Ma <maguicai@kylinos.cn>
Subject: [PATCH] KEYS: fix userspace buffer overflow in keyctl_pkey_e_d_s()
Date: Thu, 19 Nov 2026 21:24:47 -0500
Message-ID: <20261120022447.789625-1-maguicai@kylinos.cn>
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

Commit cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
changed keyctl_pkey_params_get_2() to set params->out_len to the maximum
output size of the operation instead of uparams.out_len, so that the
kernel buffer allocated in keyctl_pkey_e_d_s() is large enough.

Because uparams.out_len is no longer kept, keyctl_pkey_e_d_s() copies
ret bytes to _out without checking whether the result fits in the
caller's buffer. If a smaller out_len was passed, copy_to_user() writes
past the end of _out instead of failing with -EOVERFLOW.

uparams.out_len cannot simply be required to be at least the maximum
output size in keyctl_pkey_params_get_2(), since KEYCTL_PKEY_DECRYPT
with enc=pkcs1 can return a plaintext shorter than max_dec_size into a
matching smaller buffer.

Pass uparams.out_len back to keyctl_pkey_e_d_s() and return -EOVERFLOW
before copy_to_user() if ret exceeds it.

Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
Cc: stable@vger.kernel.org
Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
---
 security/keys/keyctl_pkey.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index e7121523b9c9..31bd55c4ca70 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -113,7 +113,8 @@ static int keyctl_pkey_params_get(key_serial_t id,
 static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_params,
 				    const char __user *_info,
 				    int op,
-				    struct kernel_pkey_params *params)
+				    struct kernel_pkey_params *params,
+				    u32 *user_out_len)
 {
 	struct keyctl_pkey_params uparams;
 	struct kernel_pkey_query info;
@@ -183,6 +184,8 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 	}
 
 	params->in_len  = uparams.in_len;
+	if (user_out_len)
+		*user_out_len = uparams.out_len;
 
 	switch (op) {
 	case KEYCTL_PKEY_VERIFY:
@@ -264,10 +267,12 @@ long keyctl_pkey_e_d_s(int op,
 		       void __user *_out)
 {
 	struct kernel_pkey_params params;
+	u32 user_out_len;
 	void *in, *out;
 	long ret;
 
-	ret = keyctl_pkey_params_get_2(_params, _info, op, &params);
+	ret = keyctl_pkey_params_get_2(_params, _info, op, &params,
+				       &user_out_len);
 	if (ret < 0)
 		goto error_params;
 
@@ -310,6 +315,10 @@ long keyctl_pkey_e_d_s(int op,
 	if (ret < 0)
 		goto error_out;
 
+	if (ret > user_out_len) {
+		ret = -EOVERFLOW;
+		goto error_out;
+	}
 	if (copy_to_user(_out, out, ret) != 0)
 		ret = -EFAULT;
 
@@ -349,7 +358,7 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
 	long ret;
 
 	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
-				       &params);
+				       &params, NULL);
 	if (ret < 0)
 		goto out_free_params;
 
