Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AD46985D;
	Fri, 31 Jul 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515282; cv=none; b=fWnCYJ422EQqrk/z/1aGhReSZ6+6xIjeB7GH96eTXIzexunxQtrs3b3o49L563bQQz87KnBmNWW9bR6HY107OPswPgmrLJ5ze7KdcVfJyD1fdGESrhKNlwOkOF/wQ/LYesor7XE8vK//he9bA9cZ+lHkbHWw6D8AsOJxLE8+iRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515282; c=relaxed/simple;
	bh=vS5BfHBU3Cnn2TXuBo2HKYKqPnGyz48W7eVptxeLUZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbhovJDsY1Q7Kp6n2NVrZjNOZ94+oO5bedy5iFa7ct5Lq+IQgz9mhxSasiplXPK2HGJbd9Jwbtuh4VvQIJ7Xv03rdIPXg7gZD9ic4BXvO6ertqkywR2K2+DggJLRRBHSiBWzwLXh7uGMPRijSktfvo5FZkSWqJhIXJ1jCEZ9vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=k0Fn2v0h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dsZHhPgu; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="k0Fn2v0h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsZHhPgu"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A9757A011A;
	Fri, 31 Jul 2026 12:27:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 31 Jul 2026 12:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785515273;
	 x=1785601673; bh=vuhD3aoT0AyBzEwnNlnOqTcbkLD3kV+I1Y8Pd5N2o2I=; b=
	k0Fn2v0hBAvs16EZ/yLw7TLmuFAcOyD/YVjC8Ouq96comN5aDewzZCfL0asIk2DM
	c7VaqQfnLFOz3ABgiGWXaGftTmHIkQV30TQUqsMkko6p8fVn/eX1C7HZKlwCwSZ/
	2q5TdpN7JGDxH/IaZPK8mBG2PdPABArXvqZxVV0f1jdA44KVF1NtJaTuAFfaSGbL
	1WbTOlIVJrCpI1KDUJ3L5Cp6TI8dLucgg5JT/pkj3NQxdJHUdAdjESSRuZ6G6LkT
	7zRhJxK8optUcn1MCi5sFsYsVZA/q/8vf9K0Fr4Yg6lynEgKjmq4NGh58slVn9tg
	v5mBwTY08HlUzvXNCUe6rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785515273; x=
	1785601673; bh=vuhD3aoT0AyBzEwnNlnOqTcbkLD3kV+I1Y8Pd5N2o2I=; b=d
	sZHhPgulOxyRAtF1Xbe6k93rj3Mywvhma1m4kxcnHqoNqiBzekcoalPjzyO1gyy+
	Y4jC5rQKNvHv9ZYWpvZ+aDztsnCABebXs2Izww02hHxEj5V1Rp4vh6Xd7wyVDujc
	8xB5SdcKqwRsoFyI2w/FVwJBzuiln+aLCY4ODovodqBgvz+bou6uK56JmAAQfn4T
	wVX7XWb7r/BoMEjViUVmIqxm2mE1gRlklds09mmeDQMN78mjMinH0wJjCMz+ih4M
	06Aeu0npEkJowZhGqcRJLLl2c+ATj2EFJClO+H2uctY06MJF15RsbvGuFqtoRkDR
	VCNNIPnCa5cPuhlsXu4XA==
X-ME-Sender: <xms:CM1sarSPK8tl8pnWv2uH6g4wZr--5nqlC45vsxulbQzNbHOofZVLHw>
    <xme:CM1sauXjnv8yAG4obCa4UHqnYqll6lL21IBldfRSSJjGlhd1M-PeWtOdoG3mDdHkC
    KPCkk7kYosfPWaqnf-ltu-4kOsTShdKFa01UhdEy33jIt2BUlWiKw>
X-ME-Received: <xmr:CM1sanKtTrwfzroiDfSPnoQJTvuMplv57G2bzQv57sfayU2k8PSiyCTH6_QAI_f5FRJnBK2e35r6RP8iaQ>
X-ME-Proxy-Cause: dmFkZTELfHAaFlN+kIG6IssmIq8q0/JRtHYiEDamnKwtHAGTm/rIkphiM7dmck7n/tEVID
    Jll9XZRXegS5DA66U1m8pj9kUlkWW6jbmxkpZ2Vy+f9sbLWY4LPn/k9o06nVK28CzSnHlD
    lWYRxoJf+HWhSZ1zy9/rODG5OphaTJnkZfxiinHtBeukYGRaEV6rsOpAthbf9Rnwd5neaW
    b5ga7UTCgjqgAq9wYXuIHu4RL0lK64k1SgzKLwhWoz9uN8eIJVTlSs/QiafsKJeCqGBPP+
    mXVeoA/rZsAKFBE67k4yvTZ9NpiBwhCbzC9zQWp6wR2HnNM114K5oGLjvHnZO8zy7kGoM+
    43ztEq9yvmk5FIo339uS7eTYuFuzoPGBEBAV56zSFneeUyT1x+W8YuJDcNHflL5vlg94Nc
    tRE/z0/TBF6FknKyzSzFwXEGXce61rnIpBKiwhKAJPH1q9EgnFkJH/sYGfFrxEcKBzyjWF
    wJSyyb0894hIenNcHuohbTXDuBYnFqA9f9SKfwB/j1Fia7HM5hm118pFRPbsHhewSXfAqg
    1BMqPWBdv1JpB+6v6hYDG3BaNrKft+MpEMXFdE7J5adB6kIQFZDjk4ycPJK4tw3VG5E28x
    OVWMXqMrDck/XjQJJw4OWKtP4nkq1iPW22fpkHdEnpj5tXx568GTn10k6v1Q
X-ME-Proxy: <xmx:CM1sam1-EhJe4KMpBnYfP287RagS5IVRGdDFw-FSVRSSkYnuRsT8SQ>
    <xmx:CM1sasLDZpJ9gTmtx-jggzOhLZLPe6cIwPwFATB9WHkHTylD2ogjxA>
    <xmx:CM1saph9l7hk7_tiaqg8q_GRfrIvBxTU89PD8u2yo_CSHvCDkGLl4g>
    <xmx:CM1sakCBeSTaUWwDhnPN8X2QadLMaCSI-aNkkXTbqmwo5fpFcNsS2g>
    <xmx:Cc1sai_2vETs0lM7UmIQEF6NbdBMahVqO-7pdz6By6aE8MWAFYpavdUk>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:27:51 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 3/4] mm/secretmem: zeroize secret pages before kdump
Date: Fri, 31 Jul 2026 18:27:38 +0200
Message-ID: <20260731162739.158320-4-linux@jaseg.de>
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

Register a CRASH_ZEROIZE notifier that wipes secretmem folios. As a
result, when CONFIG_CRASH_ZEROIZE is set, secretmem areas will be
cleared before the kdump kernel is kexec'ed.

Zeroization runs after the other CPUs have been stopped, so the page
cache cannot be mutated concurrently and the xarray may be walked
without taking the i_pages lock. This is a best effort, defense in depth
measure. s_inode_list_lock is taken with trylock only. If a CPU was
stopped mid-modification the list may be inconsistent, and this late
into the panic path, there's nothing we can do about it.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 mm/secretmem.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index d29865075b6e..53f629d6633c 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -13,9 +13,11 @@
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/pagemap.h>
+#include <linux/notifier.h>
 #include <linux/syscalls.h>
 #include <linux/pseudo_fs.h>
 #include <linux/secretmem.h>
+#include <linux/crash_core.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
 
@@ -187,6 +189,50 @@ static const struct inode_operations secretmem_iops = {
 
 static struct vfsmount *secretmem_mnt;
 
+#ifdef CONFIG_CRASH_ZEROIZE
+/* Called far into vpanic from crash_core.c with other CPUs stopped and
+ * preemption disabled
+ */
+static int secretmem_crash_zeroize(struct notifier_block *nb, unsigned long
+		action, void *data)
+{
+	struct super_block *sb;
+	struct inode *inode;
+
+	if (!secretmem_mnt)
+		return NOTIFY_DONE;
+	sb = secretmem_mnt->mnt_sb;
+
+	/* If the list was modified in the exact moment we panic'ed, it might be
+	 * in an inconsistent state that would be unsafe to iterate. If we can't
+	 * get the lock, too bad, that's all we can do here.
+	 */
+	if (!spin_trylock(&sb->s_inode_list_lock)) {
+		pr_crit("crash_zeroize: can't acquire secretmem superblock lock.\n"
+			 "crash_zeroize: skipping zeroizing secretmem.\n");
+		return NOTIFY_DONE;
+	}
+
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		XA_STATE(xas, &inode->i_mapping->i_pages, 0);
+		struct folio *folio;
+
+		/* no need for locks if we're burning down the house :) */
+		xas_for_each(&xas, folio, ULONG_MAX) {
+			if (xas_retry(&xas, folio) || xa_is_value(folio))
+				continue;
+			inode->i_mapping->a_ops->free_folio(folio);
+		}
+	}
+	/* off to kexec()! */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block secretmem_zeroize_nb = {
+	.notifier_call = secretmem_crash_zeroize
+};
+#endif /* CONFIG_CRASH_ZEROIZE */
+
 static struct file *secretmem_file_create(unsigned long flags)
 {
 	struct file *file;
@@ -263,6 +309,10 @@ static int __init secretmem_init(void)
 	if (IS_ERR(secretmem_mnt))
 		return PTR_ERR(secretmem_mnt);
 
+#ifdef CONFIG_CRASH_ZEROIZE
+	atomic_notifier_chain_register(&crash_zeroize_notifier_list, &secretmem_zeroize_nb);
+#endif
+
 	return 0;
 }
 fs_initcall(secretmem_init);
-- 
2.53.0

