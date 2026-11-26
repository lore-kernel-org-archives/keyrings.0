Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702372;
	b=js7e5pjuYSVg7nae1DTQ9H7omlfBkd1xQm4OnoL4tNaOaJvdhKujKdTzrzj7K3i9G4E3
	 kfrMKIxVl7zYGQiP/mRg0XsBjSaBhMP5aItf1z8d53EaRWgfj+In1vM7j0ZQFOurj4nzJ
	 kKBvSyTcTdODrkrCTk8vs56BcnUFlwVhclh/g1aHhosgrxWel+k0irQ9Q6Kq6yt2J2Xi0
	 yKfBommGiiWgr46/cZMH1QgckuhKHsmOaMlsx6vWm7M19ndslPEDPf+fUNgTNllxrW2Bx
	 CwrCs5aJoEPQnmljj1nuC5Y5F0PUKM+ousXfrZ1Uz97lMQbFl3pPsfPiG9ozEFwpJlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702372;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8eaMNBlC7DEchGsEEioGv4L8G7ys62634OKtlN/XSzY=;
	b=cAehxz/Cca1HHWV3XmaATZFNQJcCm26xtzE0AGg7b3JJe0NmfYRgtkxuVLUvEsYs7/Iy
	 eoONeHkLAmaAzLtGvlPSVUjsMInh1uZGfkA4Jwm0deRHPQj6xJwiOCQrsOtOMKL2PWEVI
	 7cAToo39P82GtwU1I2wKVDeyHMne0pLtTTZgJrsX7ILhDNqIWZlfCkYIMSKl5EuvnxKBi
	 7T9JdK/G4WUr0ZHXKh6zh+ouk87qx9IKGnhfe2FmNgzoDH3G5gCDuzdJYyUiiGqh7vnqi
	 OiMSuJpooNhgSRsjcZ4EmyEljcfDS4hXpBgeivtiYOeBWMB0u1f+NUVJjrMuAVcDieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ONAgsYo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC7606A321;
	Thu, 26 Nov 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONAgsYo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C378F1F000C0;
	Thu, 26 Nov 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702371;
	bh=8eaMNBlC7DEchGsEEioGv4L8G7ys62634OKtlN/XSzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ONAgsYo/5Ad8ELFMX07CoYilvBPHM1KLXm3+gJQdqg6E3K6bgGcHIKTBv+/qDWE6X
	 TFHKVdcWIzctWPMDszA+dp/JZ4fRHYNuJw5iTc7WDMvgXJB8UtZ6Q7HiVIpJhbqmBo
	 aLxlPOMVacK8vXm2zQy5fdAIrCeVVloxUuSl9QldIAFMeBv2jTAUlbgfet5l2KA8+t
	 QrcdG8MqEyk9GWM84nnlDafS92EMwEEh18UXruHn47Zz5Q5sA4sjA2Cv/PaXC5brMq
	 OrOVkFkJMZMThs9xwUCKGp/mhge3TOvSGbKCI6Y+pFID+96fscq2vtzvIWtJOdIymR
	 OxS1a0+gij5yw==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:21 +0100
Subject: [PATCH v7 03/14] nvme-keyring: drop nvme_tls_psk_revoked()
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-3-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=1215;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=lpCSLBw0U7mNVqtzC3VcLESHuh3Qh1H5dFLs35Wdjl8=;
 b=77ik5YnX60CQBJQmLlJrlMxK83hP/pkhtA9N0yRyzUDwPeD9PV+CK+oedE3AQd1qv9Q9i2bmS
 a8U/DmRTn42AX2uG5bw/0pR1+aIAy8CGoDohq7//nKTkWJLsSW8FKAw
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Replace with build-in function key_validate().

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index de8dab10fa1059d8bfc2351edd7bb68ee52207a5..373f51e1032a4d29ef945a62fd9fb3720f8a9ea8 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -22,24 +22,20 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
-static bool nvme_tls_psk_revoked(struct key *psk)
-{
-	return test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
-		test_bit(KEY_FLAG_INVALIDATED, &psk->flags);
-}
-
 struct key *nvme_tls_key_lookup(key_serial_t key_id)
 {
 	struct key *key = key_lookup(key_id);
+	int ret;
 
 	if (IS_ERR(key)) {
 		pr_err("key id %08x not found\n", key_id);
 		return key;
 	}
-	if (nvme_tls_psk_revoked(key)) {
-		pr_err("key id %08x revoked\n", key_id);
+	ret = key_validate(key);
+	if (ret < 0) {
+		pr_err("key id %08x invalid\n", key_id);
 		key_put(key);
-		return ERR_PTR(-EKEYREVOKED);
+		return ERR_PTR(ret);
 	}
 	return key;
 }

-- 
2.51.0

