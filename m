Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05028347529
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484241; cv=none; b=VtrbZLRCqMNfvpFG9RMGCq+9drgoD/wYbayZIETQLhq2eA1xJNpvdA1g7AIL+gXQ5r4PFsL/viWYT3V9HrYkBD4JGPLzvC8hyUTI65oAtIbVeo25bDlZFhNimI8165Gme5Q4B/vlwZKJ8aq+964qWVvjAOOkQLX0viZMpH67Ptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484241; c=relaxed/simple;
	bh=v9HeOFbg7yqaPJFAebJkoHX6/z4ZNAksuMZiGZTzcV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3yw2UVW1OUF1tdRzUXpWSaTg0UHH+zCjifju5nUN3D3lFvhPC4tEPBrewJbWfjSbbiK87Mr6v8CyOt0tgXXWUQ5SfDiMnuF09oILCbfCrMCMgXm8j9ddejqJ079nnGOlmnB95C/iQ1vJLHALUQLULLe2u34Ucv3EymPLe2yY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg7MNV9C; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg7MNV9C"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so5947535a12.2
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484235; x=1785089035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdVZ4aGJrm1DuTj3OJVvOnHsBpK+4e3jVQB95QmtQUM=;
        b=gg7MNV9CA9igFeOzIJfAXVNKOwkbLs9PG4eMCYQjLezdWaZeh7jVGLj5Bj+Ifn4bGZ
         9k7C45ijMqgkKegBw2uAAYb2GPAqQ8ebq/LU9PHT/VfBPXsw4/R5BiIXxbb/h6EKYtGl
         jHGI7NRDvxstNnUchf2jW03fLgLCF4a97s4DP+uQ1hn2Kd3dmFBTLw9lNvT4mIC61tgW
         ZiI5dd/5sYZ1v3FyIwphdF9J1lp25UR/KdNFZItpiBWIJon9xb7I23APgu02mGWys9uZ
         VQWOEPF7tUF4JX95pBH7CI77gBwfNsugWDFHrFpz1euzx9cWfs26ekO/zsIKOxDppCUd
         uK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484235; x=1785089035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SdVZ4aGJrm1DuTj3OJVvOnHsBpK+4e3jVQB95QmtQUM=;
        b=EilX7/0V5Tiic8Pm00VVIBvIyEX6PcTlVgMVX1+ww87OHIHFj1b6vDKCyZlu+WyYVt
         r7cV4rCJtwYdXAbW73WbPo6lUMju/2oR5rM2/2GFmzAU+3V11u3QDVfgFiiVSXGDfAOQ
         N8Krh2nviygOaquivzvIGa6PY1hTKoc7tGxK5JBKvQ6T3nQAXzPdSXypZLWQU2gQsjSo
         mM5zc6GK1eoFkc/eG08BXpQ0YPXdocux9GHPvmA/rNwyrTMgI4wCh9iVF9B2cpS38kAH
         7t1osEKS6KQdeKvgn0Vw88SOmOuaBf04t59Ft+gf3KetOtlL6y5dKTZsMX4EJAjUIAEb
         Hr7A==
X-Forwarded-Encrypted: i=1; AHgh+Rq4s+HCefhh7RfdLdiF5ndIYjrVc9WDuNhWHSaPROsW4qkr8CG5oBjj0hQ8O9Jo1jGXDE8UprjBnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNj4UVieYy9+pHBNzcsLIsxM7e6wqPiA02apEAOF1xFQqsto+
	WIIALAfYj1FlQWTR7e9QYY7hwpwHtnBs2MUgHEbffvcL7PIdlhkBovM=
X-Gm-Gg: AfdE7ckS56bpp7laBr+u6rOuHzYl5ug2Qu0RYXH10t5T+LTzw0S0F448bs7Hq6NkST3
	cVK0ud3O8glNEBpVmfx+60BLBMgvXLeRkS/rDSTML/3/7R/i8MDcFscZgLMpYot/NZCFSjJn5OL
	3agKzdirIztle+Ov4mR8CepYt/+lgluJjbZ0nU7Y8Uul1W1Z9nkY9647jicooLM6PAFRMz9TwR7
	tNnwv4aOYDrTUZjWmr2kedSBUWJAMPZdQc2QQtvagcRVLJIYBMVWhRqcS4xK5Mqb0tOLZ5ICgY4
	O6xwfoSiD4fDhKQm0m9gGvRYsqAAKzAKW0mkFphY8nHOHh9QBn8Z9qOXDClQkSyiCPJuGG68z89
	cYv1obdoEPgjlLmHHvJwrIfDuPZFlHXvLLCXnJsMOrAPmLzjaz0Y4EPU5RGycEVQGLCZUPfA5Kh
	C5AZWDtMVPZIRZk48ZJ+IvzQ6qpJrgB4tIBsEQSrhA
X-Received: by 2002:a05:6a20:bca2:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c3bbe69a9amr6850926637.17.1784484235584;
        Sun, 19 Jul 2026 11:03:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:03:54 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
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
Subject: [PATCH 1/2] treewide: Add a flag to detect the Apple T2 chip
Date: Sun, 19 Jul 2026 14:03:03 -0400
Message-ID: <20260719180308.1398-2-atharvatiwarilinuxdev@gmail.com>
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

Add a flag to detect Apple T2 chips on Intel Macs.
Cache the result to avoid repeated checks. That will
be used in upcoming patches.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 arch/x86/pci/fixup.c                          | 10 +++++
 include/linux/platform_data/x86/apple.h       |  5 +++
 security/integrity/platform_certs/load_uefi.c | 38 ++++---------------
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b301c6c8df75..fbd204ca4c6d 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/suspend.h>
 #include <linux/vgaarb.h>
 #include <asm/amd/node.h>
@@ -995,6 +996,15 @@ static void asus_disable_nvme_d3cold(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d3cold);
 
+bool has_t2_chip;
+EXPORT_SYMBOL(has_t2_chip);
+
+static void apple_has_t2_chip(struct pci_dev *pdev)
+{
+	has_t2_chip = true;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, 0x1801, apple_has_t2_chip);
+
 #ifdef CONFIG_SUSPEND
 /*
  * Root Ports on some AMD SoCs advertise PME_Support for D3hot and D3cold, but
diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3c21..a2ab63bd1eac 100644
--- a/include/linux/platform_data/x86/apple.h
+++ b/include/linux/platform_data/x86/apple.h
@@ -6,8 +6,13 @@
  * x86_apple_machine - whether the machine is an x86 Apple Macintosh
  */
 extern bool x86_apple_machine;
+/**
+ * has_t2_chip - whether the machine has the Apple T2 chip
+ */
+extern bool has_t2_chip;
 #else
 #define x86_apple_machine false
+#define has_t2_chip false
 #endif
 
 #endif
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index c0d6948446c3..da57ac322e72 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -3,42 +3,16 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
-#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/efi.h>
 #include <linux/slab.h>
 #include <linux/ima.h>
+#include <linux/platform_data/x86/apple.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "../integrity.h"
 #include "keyring_handler.h"
 
-/*
- * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
- * certificates causes occurrence of a page fault in Apple's firmware and
- * a crash disabling EFI runtime services. The following quirk skips reading
- * these variables.
- */
-static const struct dmi_system_id uefi_skip_cert[] = {
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,3") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,4") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,3") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro16,4") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir8,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookAir9,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "Macmini8,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacPro7,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,1") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMac20,2") },
-	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "iMacPro1,1") },
-	{ }
-};
-
 /*
  * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
  * it does.
@@ -165,10 +139,14 @@ static int __init load_uefi_certs(void)
 	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
 	efi_status_t status;
 	int rc = 0;
-	const struct dmi_system_id *dmi_id;
 
-	dmi_id = dmi_first_match(uefi_skip_cert);
-	if (dmi_id) {
+	/*
+	 * On T2 Macs reading the db and dbx efi variables to load UEFI Secure Boot
+	 * certificates causes occurrence of a page fault in Apple's firmware and
+	 * a crash disabling EFI runtime services. The following quirk skips reading
+	 * these variables.
+	 */
+	if (has_t2_chip) {
 		pr_err("Reading UEFI Secure Boot Certs is not supported on T2 Macs.\n");
 		return false;
 	}
-- 
2.43.0

