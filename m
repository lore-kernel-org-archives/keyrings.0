Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076244607C
	for <keyrings@vger.kernel.org>; Fri, 24 Jul 2026 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911647; cv=none; b=ZqGenaQ1aoowOguLbLpiqG6IrXRJ8YQjEIRdjJx5Dxd2vPUnw/oLhsySxhO7b9i8VDvZOcyAt8ocHwNqcB5FqVzZhR61V2g1I+XPkE6l0QMM369j53OkwkjMiN4eFCXZUG7903zPmWPDuGUrhnYq6Hk7OPSigvYRf3E8d0Wqm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911647; c=relaxed/simple;
	bh=FFFpGIB531o8c167/WQHpfJrFsCnpwaLHErYAnoCO+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFIvVcwetN75rUmcSW1s+rg37qVBaa8fuvhlBtTc1yEJDQ860YXnR2YNjvZbUmLdTokcrEkJ2TqXu7E5y6JzfwdmCUc11dMzbLt8Qc9eXjRRQr2Kpqjm4OlkOEhl9bd3AkpSsUYm0YPovZpPZH2zF3GPepPX7qEdA8qqZ9Tqb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnS2G3kU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnS2G3kU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso7620635ad.1
        for <keyrings@vger.kernel.org>; Fri, 24 Jul 2026 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911645; x=1785516445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5u91OXTJKFbcF00+Q/uuRlO/lNDvMJ8xKMudAoQ8DSI=;
        b=ZnS2G3kU8JXYzF7dwokX3zdAS7zVDQONicp0aDUtzst9uqgARTGf6Vxkye1NSibgbM
         fCnu+/Jzawcq4/utKzpXlzi0LCOWA24UK3OVqpPy71WruK1qV7Fssr3TzzJRaKZyi8uw
         bhV0e/+VbMWkh5MFqg23A0VLOvSyuDh3XldLIVJ0luGA6VMiFToXXpO2S3I+HZJziGb3
         bmVBRfcBjrUJysYpWNZJu3w0KwOmfDoS/rmwo4w9JpW8kN+CiJ+eWVDqqsEQqw9D5tCn
         /dQay/pw157P1yBrbZdUwUx/o/WK6OMRQ1ISkFi7figPThchF/0aBvThivejccYviuFM
         7/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911645; x=1785516445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5u91OXTJKFbcF00+Q/uuRlO/lNDvMJ8xKMudAoQ8DSI=;
        b=WKV2aiuxUKKUknJewCmBCRAd4x76jGAgf6Asxa36q0jq85jqmxC6tO+Zdl38G/GQOT
         QnqUxCuC8rl/b1FMR4ftVl/0kmkozLXYRs5iWBJ/kmA8Cyh5knqBb7WTxCCRlg5Du7t0
         vcrBolrEi/ESRH3qOtnUe8jg8UqzEacj/LylT7+r73z2kw6DvAduAWGIIqqiksi/P/hN
         Ry1ddzsDVAFNUCviqLMfYrKRmOhhLmNNmYT9PZskocokiyybK9w33sxpV7mlrr5+Um9y
         qeb2wXTONlGZBz5Z9ojF9sQSTKI9MhZRfJnDyC8mjjuINQK0Zh74lMdhGbq444xHxgBw
         CJcg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3r0hi59YR29Bx/o0sehoXgR5ZteGK2PqiFuIE97+fUTtCd84TmCOY0acFdso8vI9VcmJ3ZeHIzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoA9AuaXyCaAEzzVxEJYUxZ95+pwDgDewAgWyuCXSVY63khi/V
	axapRSZAGsVrXj/G8pcM30vj5v+rEtGzobW8ZVwVdrXAfePEcWoj1VM=
X-Gm-Gg: AR+sD12x+QCTUgehT9id09aon1YO4NsFtmMyRkRPjpSEFC0OBmdRaD+Bm81DEmmEA8W
	E5+5uyujDyIiWJKTYm+uV1kMGWWrQdRFXNgXehEKJ/P5Jx+Nnx6s8El+RIaWZ3wN79HOi0FqHyT
	e0FzAlAuT9P+KXAZtA7yhhGIrN0rTkjmWpv6R6uzRkVSiXfMzSr3ZJ5H2LZ13J5ulLXL4T1XLo4
	b4Hk2r1D0j+kbRfEetnwG2R4fTxMjumI+qAkuFBNouiP8uHIYUpWmhZEyM5jXOxYBXkunD4qrHC
	8/An1JiuY+o+mbJpIy+K4BnWfwC8RS6qvQe9cmsnhn0By7EYIvR18xJpG3GxWSErGQXmXms53UH
	zQ0mbirYMQfwg7tdpRy+RvLqT0j5Xk7MDXRoQ9gfBPrz+5iFOtsE6En9XmGJZiyVmU5MZuRRSQx
	NdhKSDgSsUJIsWF2EgXQadKdVvR5GrJ4DG56GQ2A==
X-Received: by 2002:a17:902:ecd0:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2cfa6c66734mr90588615ad.28.1784911645204;
        Fri, 24 Jul 2026 09:47:25 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.19.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e29sm918244eec.15.2026.07.24.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:47:24 -0700 (PDT)
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
Subject: [PATCH v4 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Fri, 24 Jul 2026 12:46:37 -0400
Message-ID: <20260724164641.2239-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
References: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <andre@negmaster.com>

Icelake Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
associated PCIe root ports all sit directly on the root complex
with no upstream port. Apple's ACPI tables name Thunderbolt root
ports as TRP0, TRP1, etc. Find them and create device links back
to the NHI so that PCIe tunnels can be re-established after sleep.

And on other Thunderbolt NHI's, like Titan Ridge, the default method
is used to add device links.

Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
---
 drivers/thunderbolt/tb.c | 58 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..625451ff3ea0 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -6,9 +6,11 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 
@@ -3305,21 +3307,73 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs with Icelake thunderbolt NHI's.
+	 * the root ports are stored in ACPI as TRP0,
+	 * TRP1, etc. Find them and create device links
+	 * so that PCIe tunnels can be re-established after
+	 * sleep.
+	 */
+#if IS_ENABLED(CONFIG_ACPI)
+	if (has_apple_t2_chip && (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
+				nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1)) {
+		struct acpi_device *adev;
+		unsigned int slot, func;
+		const struct device_link *link;
+		const char *bid;
+
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				struct pci_dev *current_pdev __free(pci_dev_put) =
+					pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
+				if (!current_pdev)
+					continue;
+
+				if (!pci_is_pcie(current_pdev) || pci_pcie_type(current_pdev) !=
+						PCI_EXP_TYPE_ROOT_PORT)
+					continue;
+
+				adev = ACPI_COMPANION(&current_pdev->dev);
+				if (!adev)
+					continue;
+
+				bid = acpi_device_bid(adev);
+				if (strncmp(bid, "TRP", 3) != 0)
+					continue;
+
+				link = device_link_add(&current_pdev->dev, &nhi->pdev->dev,
+						DL_FLAG_AUTOREMOVE_SUPPLIER |
+						DL_FLAG_PM_RUNTIME);
+				if (link) {
+					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+						dev_name(&current_pdev->dev));
+					ret = true;
+				} else {
+					dev_warn(&nhi->pdev->dev,
+						"device link creation from %s failed\n",
+						dev_name(&current_pdev->dev));
+				}
+			}
+		}
+		return ret;
+	}
+#endif
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return false;
 	}
-
 	upstream = pci_upstream_bridge(nhi->pdev);
 	while (upstream) {
 		if (!pci_is_pcie(upstream))
-- 
2.43.0

