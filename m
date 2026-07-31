Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A93672AA;
	Fri, 31 Jul 2026 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515277; cv=none; b=JkRhHxxbLJt7fsKuWcpy0x7MlaOJPZaZFJdDGqrAeEa7/IMv1YqKbDCVTtRIyfx41FZo6HhocVdSw7VABYni2GxkE6Zg0J/8XvanY9c+GVRh+7BxHhK4Ev3xfThy/FgZOl7iSUFlpH/U+cOA+f4PJgXnhAzdFLVMBfHLZiPkFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515277; c=relaxed/simple;
	bh=I2k9tNY8KM9fClDrZSMYISjwoUpnSWKEICUB8QwP4cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQGGF5+rGfw8V3UdfDrj8dmSCcIbP78vZQKuYKKKd+2S9T84EeVY9Mtv0Kay9FQ2GH7FGqYTh2G6chi3j5AvehgkA5RiRy6DI8k8EexSv72dLKcfH1zE2UOE6vSlGnJo9SSsqfn/xqu651xeH6a4gO9sBEn/HeOD4FflKljhwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=Hclb6FV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wv7tZH1Q; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="Hclb6FV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wv7tZH1Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 41BD21D000DD;
	Fri, 31 Jul 2026 12:27:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jul 2026 12:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785515271;
	 x=1785601671; bh=WDJuTD8Vcay2+Rdlju8jd0+4JfwRzRzUz3/gOwvyzEk=; b=
	Hclb6FV2E4h7miUmIFatF7vgILbkq5iEkCMeqX58TuS1emswDoozRst6lCLKrT1r
	IwITO94liQrRfXoq/UR1Cp45KPNsviPwwaTbL5dl1J8NxCPQ13RczR1dczbxjxZP
	9yc1a8zrGTfnHzhDuEwa7y5ErpPHcdhwPrDPhXLxII/PT8FJzNMWEp4NwHhtdTXf
	h4j/3BmUkYfS/ar6hgh3ffuMnR6LX31WkKnzR/LgTwG20Zs/bgUe0u2jMR8u2zXW
	9R/T76b5+qNd+cj2Mbi7EhQyyRkH8+/nDEC5w5Lp3crhvIugjKbgkLBw0MzF4u84
	yWx3dHwY61PVrsiE8Ham3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785515271; x=
	1785601671; bh=WDJuTD8Vcay2+Rdlju8jd0+4JfwRzRzUz3/gOwvyzEk=; b=W
	v7tZH1Q/YHqS3HUVGTuTIPse3MKFqCZelV6q9mYHY4epWM2zC+aAKpHYzUeAySVC
	rDOKrgHWMN+O21uy3IjLf3ebGB2cUpbFc3LQ7G6aurdaEeA5N6MEJv2wJ/zSiWbP
	AzPKJ8WKMUGeylC2516STchvP0vG+fB7DTU5uv3wEV052H0Mrkg6lwAozynmpeTi
	YNJKnLkhgerLAIWp2Np26HbQP2WFTZGHiQTXKltDpnYyfV5XOCXl40+zj4O6UJTE
	TXsFg/Igq8SRvisRCMykDMbxchMDiktjSKPctY0bjnbFHdBJG4S74Lyu6QKijenN
	vK/oIJEMFzMqNN3Xz1HSw==
X-ME-Sender: <xms:Bs1saljrSp7mk7qc2Vw1p5p4ABiZpUtE60indWxE6MA5Q3FhEyBU3g>
    <xme:Bs1saqf6GAyquJwmY98GouY6oCpUCPdALmTT7XE8-BnueW-XHa7BuRsZrY-sZhLL0
    71t9bxQKpzUn9I3ByU6kqK0wgaPTPoLDFrC6U7kzqL28z-XRlA>
X-ME-Received: <xmr:Bs1saly_z0Ti2R2ioYZbzjjBljD6tu9JbMmznqN9gcb7hoNzzCACiHHQ7pbGe-iM2Mabw2lZcTJhboptqA>
X-ME-Proxy-Cause: dmFkZTELfHAaFlN+kIG6IssmIq8q0/JRtHYiEDamnKwtHAGTm/rIkphiM7dmck7n/tEVID
    Jll9XZRXegS5DA66U1m8pj9kUlkWW6jbmxkpZ2Vy+f9sbLWY4LPn/k9o06nVK28CzSnHlD
    lWYRxoJf+HWhSZ1zy9/rODG5OphaTJnkZfxiinHtBeukYGRaEV6rsOpAthbf9Rnwd5neaW
    b5ga7UTCgjqgAq9wYXuIHu4RL0lK64k1SgzKLwhWoz9uN8eIJVTlSs/QiafsKJeCqGBPP+
    mXVeoA/rZsAKFBE67k4yvTZ9NpiBwhCbzC9zQWp6wR2HnNM114K5oGLjvHnZO8zy7kGoVA
    hWs1HmKnirvo6badLfxFLC1ngv0vJGoRz2yU1pHhumbJcOkKOI1TtNPdhNaBkQabzrHwSs
    Y+7ylrnEBz1FMgf9G6IsR8hTGiv7XS1m50dEM7iVhvYlPUG0379fhge2f9V/z3oUvLoxr9
    ROaKaguFReJhiqZNhkD2XnlISmZ06TLF+XHEmpScoNRo1mg4BzI04MU+Oxq/K72xAlD1/c
    lRg7SLxd+kAXPrpQII8V7zbztgUBuWpkzKb8l+6UjlDsNcWEj2Tr5qCKIMZOXP0v6qIQIy
    +V+eXG639NjJ3RxuUWndaCx4R8t6V8NOngjS48abG8QAD/cuG5n/twKPLx9w
X-ME-Proxy: <xmx:Bs1sah0J_Zqx9Wm495aAHKKyq_zeBhRa8kYfGRkR0LXdWure1xaNMA>
    <xmx:Bs1sajwoT1TWg_kbaEU9yClxnpO-kipWVN0DCX0fgJ9aab9iuIojBA>
    <xmx:Bs1sauUKn1OLfclDrDHmd_7hCcA_KhPZF7HTuDRW2QMgnsxL2ZKuiA>
    <xmx:Bs1san85u3s4a8sam9gCd9BRSEWPxpnzprbbAhoOLGglgWyESU-nig>
    <xmx:B81salKYXEKXujICpl4UbPwDur3BiZlPUHWa6w3bSr8Ec7HpXLwZQlpO>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:27:49 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/4] kexec: add CRASH_ZEROIZE to wipe secrets before kdump
Date: Fri, 31 Jul 2026 18:27:37 +0200
Message-ID: <20260731162739.158320-3-linux@jaseg.de>
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

When kdump is used to capture system memory after a panic(), any secret
keys currently in RAM end up in the dump. Add an opt-in atomic notifier
chain, crash_zeroize_notifier_list, invoked late into __crash_kexec().
Subsystems holding secrets can register a callback to scrub them.

Callbacks are run after machine_crash_shutdown() has already stopped the
other CPUs and disabled preemption. Callbacks must not wait on locks,
which will never be released.

This is a best-effort, defence-in-depth measure, not a guarantee.
Secrets in flight on the stack, in registers, in DMA buffers, or in
other places in memory are out of scope.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
---
 include/linux/crash_core.h |  5 +++++
 kernel/Kconfig.kexec       |  8 ++++++++
 kernel/crash_core.c        | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index bc087124cd78..5c7207c0bba1 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#include <linux/notifier.h>
 
 struct kimage;
 
@@ -34,6 +35,10 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
+#ifdef CONFIG_CRASH_ZEROIZE
+extern struct atomic_notifier_head crash_zeroize_notifier_list;
+#endif
+
 #ifndef arch_crash_handle_hotplug_event
 static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
 #endif
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..92ab0a69c8ec 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -179,4 +179,12 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+config CRASH_ZEROIZE
+	bool "Zeroize secrets on panic"
+	depends on CRASH_DUMP
+	help
+	  Wipe secrets (e.g. kernel keyring and memfd_secret pages) on crash or panic.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..d3a7763e2759 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -23,6 +23,7 @@
 #include <linux/objtool.h>
 #include <linux/delay.h>
 #include <linux/panic.h>
+#include <linux/timekeeping.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -33,6 +34,22 @@
 /* Per cpu memory for storing cpu states in case of system crash. */
 note_buf_t __percpu *crash_notes;
 
+#ifdef CONFIG_CRASH_ZEROIZE
+ATOMIC_NOTIFIER_HEAD(crash_zeroize_notifier_list);
+EXPORT_SYMBOL_GPL(crash_zeroize_notifier_list);
+
+static void crash_zeroize(void)
+{
+	ktime_t zeroize_start = ktime_get();
+
+	pr_info("Wiping sensitive secrets...\n");
+	atomic_notifier_call_chain(&crash_zeroize_notifier_list, 0, NULL);
+	pr_info("Done in %lld us\n", ktime_us_delta(ktime_get(), zeroize_start));
+}
+#else
+static inline void crash_zeroize(void) { }
+#endif /* CONFIG_CRASH_ZEROIZE */
+
 /* time to wait for possible DMA to finish before starting the kdump kernel
  * when a CMA reservation is used
  */
@@ -142,6 +159,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
 			crash_cma_clear_pending_dma();
+			crash_zeroize();
 			machine_kexec(kexec_crash_image);
 		}
 		kexec_unlock();
-- 
2.53.0

