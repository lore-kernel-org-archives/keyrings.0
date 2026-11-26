Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702427;
	b=nnNrAg0djH8NKbzgx6dRfAlWVSz50V88lz5CwJ5JJ3U4t0hlkNV/eINy6Ag7QkZWih6n
	 Nji22TvIi8gUtaftLD2qGTWp5/BGfnV1PfrG5FmEacg/HhzqRw0XPK0O8JN37OaBFiWOo
	 wzQX2yFwcEc0kbbijxTYMXJwp1FJzZOhR9/ujOjUdYBc4/wyVCTEx0iNh6iMintuDSxAE
	 LXwq1QBV4QrPSeEm60wnURxwZFalDsmXS01bPhC8pwp4vC5K9Qyj9qzdKpMvu2TPn8jYJ
	 1JTeUfmU2drJ1Je3ZSTvaU9Ukp4WMmqQY2ziVLa97s12xV+0gs8yiIhD2DmLnu175vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702427;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=33K4Azq2ZZpNyKPsW49RA8yazeVp7W2aUTHzcJ9NLrU=;
	b=m9s0aBaWOY1GyyI87M83/Hbs1oRpiSI3plAvAmL+2tS2XQ3DUh+9KZnDXZl47I7uL08b
	 Wp6ffWcQ4fPp863uZzpZkehx/ZGdgIRiyvKSAHruLAMFpSrdKgg0258lhvGVoZ2EXFPew
	 gf12SGCiEc/RCl0hhOmsQTRC+rTbPzg71THh6RoN1wcg5o+U8MWVgsw44HpIbktlyISBm
	 /G4RkemR3kZiIW1LpIY/D/1rx5ngaaz3PXCttL5ugQerj7+atsa0dJCclMFmpfwDoFKfk
	 QxSZ6MdsNOvl2R8SFujJql1IK3bLcMqGvN865eQcRRTkQxGobG1oaWBJpOEFOMI1uoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXSQurCt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B185606A321;
	Thu, 26 Nov 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXSQurCt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DF81F000EE;
	Thu, 26 Nov 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702426;
	bh=33K4Azq2ZZpNyKPsW49RA8yazeVp7W2aUTHzcJ9NLrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RXSQurCt7Cka8FbhvXtiUIsmJluA+YfkEFAwMkBpnf0B1ulN/l/sD1FvMETni+YfK
	 /jQTeivSoqKUtxs9McYB6QILxiy5m9b3FaiD1nKuvwsWuOndh3F5cgOadmjA08QqWO
	 BIWdcdlKZzHBOUfeswc/kNoBW+1kESuw85xnSB0eaQ++V2bFXM2kNKDuBG+43Vs3F9
	 GlBX4iRDSSraGowp1XVcbe7ZwmrzolwJahaKp8WQuZvSqz6pAcS1u09aQD7Dt2/VRA
	 9Zit8yo2GB0FqoFiYJ+hmfVTi5IZS0omI0BenCyu866LQw/pCuHPKZkobjAaWYQNfI
	 snPDCL3mTAGKw==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:32 +0100
Subject: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned keys
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
Message-Id: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
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
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
 Martin Belanger <martin.nvme.dev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=2896;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=k8uZimUreD/fN2EnDSCf2QftPYT3UGOnGwunPz2gxwA=;
 b=57WB6XkU9H/tsf23qL6xDpwjvcyOHVLGCasikjEoyeagQ9Vn5VLRBdPjPlJbDGZhSMge4RTa4
 ZFaFQFddnzGDmoXKy1VtFskil5Wb/mGeSrVRJCxRZ+ejJ6GRQN93Xoa
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

As we're passing key serial ids between fabrics options and the
actual nvme controller structure we can implement key rotation by
allowing the key contents to be updated (ie calling 'keyctl update').
This results in the key serial to remain stable, and we just need
to do a re-authentication with the new key contents.
In order for this to work we need to disallow changing of
pre-provisioned keys from sysfs, and implement an .update callback
to the dhchap key type.

Suggested-by: Martin Belanger <martin.nvme.dev@gmail.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c |  1 +
 drivers/nvme/host/sysfs.c     | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index bee64c592752a7179e1e6575f96749a7ae26a6d6..ffabd37cd090d8fe3e461a02cdee0dc4cd4135c5 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -100,6 +100,7 @@ static struct key_type nvme_tls_psk_key_type = {
 	.free_preparse  = user_free_preparse,
 	.match_preparse = nvme_tls_psk_match_preparse,
 	.instantiate    = generic_key_instantiate,
+	.update         = user_update,
 	.revoke         = user_revoke,
 	.destroy        = user_destroy,
 	.describe       = nvme_tls_psk_describe,
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 0ffea12fcfb6b5e79100fca4f125a655042695ca..0eb68b3973a1e7d6fbd6b84fba2a6880a1da4dcd 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -887,9 +887,17 @@ static ssize_t dhchap_secret_store(struct device *dev,
 		kfree_sensitive(dhchap_secret);
 		return ret;
 	}
+	if (!generated &&
+	    key_serial(old_key) != key_serial(key)) {
+		dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
+			 key_serial(old_key));
+		key_put(key);
+		kfree_sensitive(dhchap_secret);
+		return -EPERM;
+	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->host_key;
-	if (old_key && key_serial(old_key) == key_serial(key)) {
+	if (old_key && old_key == key) {
 		dev_warn(ctrl->device, "using existing key %08x\n",
 			 key_serial(old_key));
 		old_key = key;
@@ -984,9 +992,17 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		kfree_sensitive(dhchap_secret);
 		return ret;
 	}
+	if (!generated &&
+	    key_serial(old_key) != key_serial(key)) {
+		dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
+			 key_serial(old_key));
+		key_put(key);
+		kfree_sensitive(dhchap_secret);
+		return -EPERM;
+	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->ctrl_key;
-	if (old_key && key_serial(old_key) == key_serial(key)) {
+	if (old_key && old_key == key) {
 		dev_warn(ctrl->device, "using existing ctrl key %08x\n",
 			 key_serial(old_key));
 		old_key = key;

-- 
2.51.0

