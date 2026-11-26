Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702412;
	b=Ohv8QnYZzsSyhHhDbowpGzt9HDRHCVP3C1Em5HfLQ2HSvy0shnvtLqj6dlkDfRpWNHuk
	 Ye7l2Z7qS49JZHuP7hpXOdMW/nsb+/tTKM+a/pkl3nZ5vQFwHud2c5dp7kzPglVoDJ74b
	 tgPBmykRQo6oG19tjCmmwds6rtZdsv50f4FfJxs4wzMJxnRc6ItL4fZuZOiL6Gkoj/8fo
	 BZ7PockZE1SGwz4p68iQyERbN/QirU+ExQmNwJwB5VV024542Kn5Ln8TroxFqkqQP97m7
	 BFbXUuYYumXGyc5kDhucvFJebDEC7OyXFwaO5Fn7Kh5nxCfTXr0sirqcJd6M8tBXzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702412;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BvUKm1Kc6TxTvWGhVgwmGhFF4aascmDSTk67ZMS1+no=;
	b=vYingBQEmOeU/OUVmUJFzxtha7avlMuH4LKfQdIND6mjj9td4IzXgQk8yv7fhSDa21SU
	 K6X3BuzdAH1MY0EvLqDBhvbgsQ0AhJjVrO3p4OVvioMeSjUsNrDUojfqqQ6+pLLM0Slfm
	 5gYGDbf12ODXxlJV8FTPuhhveCcFVLB/ERZV4eApI2sOvJBKr47r+scFjoWoLdgRxBR/f
	 1EvdTp+LXefCXO0vZBonyVcLNxn67I2sT1NNRtzbTJ5C+9404hBn8sZtLktUxqSNEPBXs
	 RZ54Dcitp5+Z3nlLH6+YUjIyc3ICsQ5njTMbg0m/kVp0TPYp7cJRWu5brZF4e6e3Z0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gYzGAwN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307B606A31C;
	Thu, 26 Nov 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYzGAwN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39791F008B2;
	Thu, 26 Nov 2026 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702411;
	bh=BvUKm1Kc6TxTvWGhVgwmGhFF4aascmDSTk67ZMS1+no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gYzGAwN/1GxhLQ/AFboZpDP4nb+5s5RvRz/Yb516Q526XWwAcqCjdXxov9kcfWmBq
	 wPL/GSf2DsD11w9GtlRz5OFRmL+YcuIkayeJlJ/ESg4kYKF/yIbzvzKEoza8RtUqZ1
	 QGtff/sQIkd5E/CTAfHRoFCz+crdsWrUwTkRcLdALF4yaXcH9H54IZ58VK5Aq2NiaW
	 fWvcHfQgR63VLZYatal2XM2ZyMRm9EuJz57XVG3dP10CUEp+iT68N5wsmLOfDSsbIB
	 0q/+Bl3Pe+RyY4mffX54xQS93PY6xrvYb2aXmgeX1MNQT051FhtxCkCKj4uDQXmKJR
	 r1i9cDdBvjfbQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:29 +0100
Subject: [PATCH v7 11/14] nvme-auth: wait for authentication to finish when
 changing keys
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
Message-Id: <20261126-dhchap-keyring-v4-v7-11-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=1265;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=NxkaI8mY5H5XZmcu73pyXibvOuqB8Vcv/J50v8rLZvc=;
 b=ywEpeYUqVl8+Hrn4lfPchjdwtHLhh8mv9UHyAiolv+onNInM40YQ9ez/LMb2ceFBElhPikEjH
 CCD7jp3MrRgBSv30JEh1cPXev1SvLr/QPlIeHQPg+0ziGIP0VtaGYnK
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

When changing DH-HMAC-CHAP keys in sysfs we need to wait for authentication
to complete on all queues. Otherwise the user might change the keys while
authentication is in progress, causing the authentication to fail and
I/O to be interrupted.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index ab912a4b281c717ca569062c19850d305f20500d..4ebc03a8ddcaede1344988dfe816bbaf3746bb55 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -908,7 +908,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 
@@ -1005,7 +1005,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-
+	flush_work(&ctrl->dhchap_auth_work);
 	return count;
 }
 

-- 
2.51.0

