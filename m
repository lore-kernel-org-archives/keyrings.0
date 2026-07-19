Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2033B19A5
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484253; cv=none; b=YJzi3mHwZWq+bBIfSlDZ6U2VV1jElJTi3wNsYNDb88ezakghyTTS1ZvUQBFAaGaiCAKA9uFMfQcSRlmPn7ad+4CUj0CuxRzmxlRPpkf6nv3zpKtfWXKcaemIYCUzZsk6m7rmUEr+QjOd2u6zklmgIpDouHgFhu9A+sVXWan/hdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484253; c=relaxed/simple;
	bh=V0Tae/rKozWhabyRfdu4QuNkEaB8DkFkgOcQe8o5wq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUMrAyKvFm9cWQ6/DMwg1p3JBfShCE2AFwYPdsmeMNdZHeG4BVEwsYTV9a6KmZonAeDVGSrSJdj9yztDdMF62vpwNc6nezkQzLe0r1bBYVQq+FM9ia8wplrz2slPTVvFMDR5FUimLgR0WlPELJAEhQZuNyxgk41URENSdjevd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfG43JtS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfG43JtS"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cb5a6aa8cf4so1131016a12.3
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484246; x=1785089046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWQkBHme3djyDjtoGqM4G+GNxyywodyr8gsYJac/hfw=;
        b=FfG43JtSl6k2dkdJv1ue1j48FkxIOoBrilaiKruWxYFM28947LGwWga39sjiHmMDIJ
         TgWB5f/dZ/YajU65sC5pzoJMBx/NjJsBsQ7QhEwLeT99YAPnm4FgfBcgXMMTwp76pBuk
         A19zIh+9Fxg05n1+gVcE9ygTvcwo57pK/ul5J/Ll+Xqk+bhLzG4czKkx3fTsCPH+Hbwg
         tLwsoFBEx6MOv4OVTM8uqVvKAjtIp0ZOuNeYLfXBwvPFGaZHCLXiHWlGObp2EmJj92gI
         FXUwej9BaUvPlm371En4fqgIjkZjUcnbWYof5ME9Ppkq1pSjL6G/pqWjaDKT/tTl8GVZ
         svgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484246; x=1785089046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWQkBHme3djyDjtoGqM4G+GNxyywodyr8gsYJac/hfw=;
        b=QJBezWQlDk0ztNeN+WdghXaUOK6VbZQ+1uHsYHIoCzDQsgVv8GRevh51SYKMjWUXP+
         XYecxbbFUsBwU9ZQ4znOuSGbOd8fBVxgO8e2c14LsjVB1ykOsa3CX6BClAD3cgF0USaT
         4maCoQ4IFFKHfEhZe4vZy8TE+fWZoNKNeH46mKvc1zaJLZil5HWMr11f5jjAcsWOILsB
         lnUo50m03/Mg/YeC1g5rAqsAidYc89pH/74636lEq5xwup1hHKWr4yxP6ROTiFN21xpq
         4T6QRTgVciAjYOG2rpSodrNF0/YcXIfrdGZCxPsaQ8J/bWRcmSNeURqgQo6x/fAD7FY9
         kKbw==
X-Forwarded-Encrypted: i=1; AHgh+RpCOUi2uL6TJWyXCG9/pZ/5e1GiSmUkUkmmejYgpIRJ+V0+ytxE3zXZCfxUlv8zqKaJ/s4Ii09F7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmjzw9WWEIgg2p4inI61Lm1Bt8Mfb9frsjTlkZLEMxOeXsjN98
	Zn6wGhDc5pBC8ijXxHMRZjG7WMdJGJq3aqcZwVPnUEjSQwnfyCm+qXE=
X-Gm-Gg: AfdE7ck+vNGQiuxqJV1+rWpU8PAko3w1JSRSBDgoTl9UoEu0pxHj1zBTBcNXWqlSJ49
	x/MdwBRJwBqs6Q1DLt+ib62cAhnEe9ZnUeztDHwB6UmYpaKakLJXqn5s1xLjoW+vCBEc6cl4muL
	M1f9apniO7/7EunDnaRGfFrT7xpMuThPX//EwHS11u1xvjo2qhSIksULNDW6hKEKYp0D53rkXHd
	/8MCuh4vvkSaGDr81i9JbzrMqL3sjkUlWggrHTRgII76QFcY5wune5lPkeqkP3hqWljx1nWNEKa
	YCn7A+TE9aLLQl64TwabK3PapZvKlj4wKRMmmVlyEzeknGEBf63q8z5RIkdjkklYUzQc8/fBEQw
	NltpZOff5IuB3qPyn8tBp5TDFeFS3+j2RDTgKXbkE+5iPHvCDuIR8ltbVy1+D8/BaezBKqISjnJ
	U8ZCwlP7xY0sQUCy3xkNKZh/wC+pCZCFi4D3XZEI+5
X-Received: by 2002:a05:6a20:1713:b0:3c3:8651:b302 with SMTP id adf61e73a8af0-3c3ad7ac447mr8585778637.28.1784484246013;
        Sun, 19 Jul 2026 11:04:06 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:04:05 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <andre@negmaster.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Sun, 19 Jul 2026 14:03:04 -0400
Message-ID: <20260719180308.1398-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
References: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <andre@negmaster.com>

Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
associated PCIe root ports all sit directly on the root complex
with no upstream port. Apple's ACPI tables name Thunderbolt root
ports as TRP0, TRP1, etc. Find them and create device links back
to the NHI so that PCIe tunnels can be re-established after sleep.

Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
---
 drivers/thunderbolt/tb.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..26529141573a 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -3310,6 +3311,54 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs. the root ports are stored in ACPI as TRP0,
+	 * TRP1, etc. Find them and create device links
+	 * so that PCIe tunnels can be re-established after
+	 * sleep.
+	 */
+	if (has_t2_chip) {
+		struct acpi_device *adev;
+		unsigned int slot, func;
+		const struct device_link *link;
+		const char *bid;
+
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				pdev = pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
+				if (!pdev)
+					continue;
+
+				if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) !=
+						PCI_EXP_TYPE_ROOT_PORT)
+					goto put_pdev;
+
+				adev = ACPI_COMPANION(&pdev->dev);
+				if (!adev)
+					goto put_pdev;
+
+				bid = acpi_device_bid(adev);
+				if (!bid || strncmp(bid, "TRP", 3) != 0)
+					goto put_pdev;
+
+				link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+						DL_FLAG_AUTOREMOVE_SUPPLIER |
+						DL_FLAG_PM_RUNTIME);
+				if (link) {
+					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+						dev_name(&pdev->dev));
+					ret = true;
+				} else
+					dev_warn(&nhi->pdev->dev,
+						"device link creation from %s failed\n",
+						dev_name(&pdev->dev));
+
+put_pdev:
+	pci_dev_put(pdev);
+			}
+		}
+		return ret;
+	}
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
-- 
2.43.0

