Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702407;
	b=LWXPllJHb23Ljz1ijwoFezyKm5t8Mcy6iitd3AJe+y09XaBhKjV0GS6rK9sfqncaXMv+
	 EjmlRxnXC0jeAtAnOf+5YS1tYNXiGPYe7VDaPOTE7/7nLXQu3Im62pU/EndJW8qFBdVZy
	 WUlyP/wWDYd7OG6KTIVL4byW9k8DKLhQ6rHZ5utGtoOZqUlDPERROxdnNRH9aY/tqBtW/
	 8iIDUoW+A0AFwoBPuEEkYoHk04PTvgcTE61xCHj6zTr0jzEWkkd1IVMSW6jQH49sv/yeI
	 d6+coLdw3sF+/2al30DlmNz+ynrZLPovBqn0DUqvXKV8g5vgVD+Y1T7OYKja/daGlww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702407;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cIUjhD1eFCgzgsEhBfvcHxxzCk6Lpi063thVghEHEDI=;
	b=wpheGD92gj6nawKDrgjAI9z5QaYu2LLLowpOWzbKcjMAXxigWp3IaW62AOntFTkr/upb
	 O8ahFLx5ry146/EekT9dkKGYZE/YQUNga/BTZ2VajM6FhOKenj4OPwwwNfdIMi9oDdIbx
	 KGakTuI3xrKotvGjE4UMb8uuxSMoDbeY80Vnz5glT7KqN67HNK/B4g9GvT7R2hnVlMf+Y
	 HcgwQFKdMt4TZ//frbDTs1HZCbLWq6elnpRk2t+5KSRwLP9wMXv+3JRpTbI50VUoYucr3
	 81cDtKKB16pDgBrVYJXfDsu7z845rP42tHGCItyhde54ZAVvhwtavCIPB0S14HaYAdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhORENuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB313606A31E;
	Thu, 26 Nov 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhORENuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4EA1F000EB;
	Thu, 26 Nov 2026 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702407;
	bh=cIUjhD1eFCgzgsEhBfvcHxxzCk6Lpi063thVghEHEDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jhORENuGTY26Jl2+E6P6oTBa5xhcyGEg+k84PLbn4PT+3kvp0fZ+duM3hXXKKFSgU
	 qlujBQ/DN3KxwPCKH7xFUzAxQUYbNxjRAFUFXChtKxykjt+UJUeRNWSjFVtu54v2SX
	 OzBUQMoYFQm2n9YXGMPBCXigGr/baS+NLS9yY7ZCMqLFqZwCPG73Za0DyRzf6ThW7w
	 8FU3YFKa20yAifgPug+nnY0dv13FBilNuPaPmoygXigIzvICViWl8iLFvZiKtY8RDi
	 gALyb/fxl+bKueLx6E79ub/fhlugGq63NNwdojiPYrDWV5iCZO7fWhdE15bmOdkJ67
	 FDJQB2g99sz8A==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:28 +0100
Subject: [PATCH v7 10/14] nvme-auth: allow to specify the key by key serial
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
Message-Id: <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=1428;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=fB5oEb7osfNq9IRI4wJ7VJEoxYdedRK+3dGaIwOdzsU=;
 b=Z6gvuKDfgCPBt658z01bDg/2bg69fua4ulgehYSv0KWapIiwlipJNPwpbKMNUAuqJ1VwidmwK
 huzVCRe7L4+Dvxa3P8hmzBHnZS9ApIEd8jrQrZS6iLAPOdAzYbT9/fN
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Update nvme_auth_extract_key() to accept a key serial
number in addition to the existing input formats.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 15e72fe8868af5698809cd6634a1f1f1da11ca2d..e336c698437dcea4d7ce4c435efda0b9f26eb63d 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
  * @generated: indicate whether a key has been generated
  *
  * Extracts or generates a key from @input.
- * @input can either be a key description or raw key data; in
+ * @input can be a key serial, a key description or raw key data; in
  * the latter case a key is generated from @input and
  * @generated is set to 'true'.
  *
@@ -158,7 +158,18 @@ struct key *nvme_auth_extract_key(const char *input, size_t input_len,
 				  bool *generated)
 {
 	struct key *key;
-
+	unsigned long key_serial;
+	int err;
+
+	/* Check if @input is a key serial */
+	err = kstrtoul(input, 0, &key_serial);
+	if (!err) {
+		key = key_lookup(key_serial);
+		if (!IS_ERR(key)) {
+			*generated = false;
+			return key;
+		}
+	}
 	/* Check if @input is a key description */
 	key = nvme_dhchap_psk_lookup(input);
 	if (!IS_ERR(key)) {

-- 
2.51.0

