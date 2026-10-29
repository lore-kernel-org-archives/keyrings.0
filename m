Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264466;
	b=Qmrr6xOaJpE/oX1KUXSt+DoODWFCu38eFovjUqyO5kTBaXwWuzT2VKdsCnjcd0H2kzhu
	 2jLgc5QfDCyLcrs6HHBO7ir6ZglqW0wh5CiEw7aPF6LiNmS2AtEvlPk4oDPDBBcEDNQER
	 ZgwnGC4i7NOBI11lBNhBhFfr302k4ZadB+AicnV8fH6e8elAGU0U7VFFWPhjtN5nPMOI6
	 0jyXlLhWvJ1iK6PXbOz2PVm+dVEViAQM+GEtm4iITcWqR0t3xa40QsR46taUD6AXjqnjX
	 GtQJRoCO/bdlv5PYFjUg9BW2KuDS2uPJVcG7xuKUowryh8G3Fgvncq+Kse/n7O4C8Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z3mbcZY+neJw3cJUW+gndo2WA1VaXIZUfre4RITk+7k=;
	b=UoO9pJSHnDcDxtBwPV6FQoiSLX/VfGfbnVApxlM4fsn8I6Jk+ZCud59NWGxQTGHLsb4+
	 3aBCRZ1bxtBN7HDQtDGRTlarnXfzXnFn0D2n4dJBvoAqXkq3mWQKdRanVWYMQjJGvuuOD
	 R0kSIM08+E60QSRAAoZjct7QYQuudkVW5iPLOnp3KFcdZAm95yfe9/HPkNsBy/zYYDdJZ
	 ZH5CxdOiI4liHKZlTRqJAsuAJM/bjG7JrX+fUNFo78h08WzhJeNNiFX8kGy5EsjhA/V74
	 y/swRbeuTN4ksWkmFAz+yUrr7QigOmLFJXubW4QSndRb3nEVEnzxpBJ87K43o3mrZBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCcGnNUJ;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD0606A32C
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 09:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86BD0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCcGnNUJ
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a1947498bso1261397eec.1
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264465; x=1793869265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3mbcZY+neJw3cJUW+gndo2WA1VaXIZUfre4RITk+7k=;
        b=TCcGnNUJc9rE3+MU2dfBg1/buLqpvuGZpYCZpTH5anu5u+ZMXaHl9K3FX4AOJa36iE
         SHLYuQ8VH7B/b7kK8397LfdltoUH5e6q2jo++wZvHhNr1Kqx2KiiJVNWv++16GSYeXQH
         t6Ww3ttl7Q+94LDcf7q0QvjHrUAXJfa/V7tBTLTrruB4gSw/g97V32iMOOU0Sm9ERl9S
         4MGRGzLa94oKF7jIl1QFcE66oOfgguRO0RAazo4KhivQuQbL7hiPIbc7D/5wupmrnu67
         NZ2ljq3nvkvPLFUrnS/YtgabfHFLNHyNR8ZRtyhzh7sH9L0c+OWsajyMQ2UolEIrFD08
         PAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264465; x=1793869265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3mbcZY+neJw3cJUW+gndo2WA1VaXIZUfre4RITk+7k=;
        b=LYyqawpSKUIyj4hj/8Iyz/5z9YKiENVXRHDyHpd6JtEA2WeHNT/5/a68HRn23SSAp+
         qrdPqVt6gFwclXYpe2HnscPq/gEoqCQZJ2frVK+BSn/lp3wp35RxcNqYbmQLh0jq2wcF
         Iu6aCioPz1EdJgBxBkulmAsvga5jGdqsVJiOX8iskgo77SfLxG5O13r9k8E/QJ4vb0F1
         hIq9fRASL/hXqiZHe/49X3/JzloC1TNvf/EpFu4hl20PTs7mg9QqA/BlZxJlnUvydAYd
         O4/59LZBdxcNypnKX8klhbxaKQE59umIJCAot6F+xWSX0mF3sapi3vYlkjRBgSWhW9TR
         rP8A==
X-Forwarded-Encrypted: i=1; AKwUvBwO0ux7EWCoWeV918owTL2dtCs78k0GXRZoeX1ShQTp0jIGFGLrA3AZXLUnDx6qCFKzEAa78YP+Ww==@vger.kernel.org
X-Gm-Message-State: AFq9FYLah6fRHDYOaZKi3Ru1SIIm98IzrC1t73kbGBAnsMY3vQpIQNm3
	mA7pSpupiNdo8YgPq6dClUH+cH192k6+HTGJ3xL5C9cOfC5Zb1pmWQo=
X-Gm-Gg: AYBFou2+ftFT0aH6eQVn0bO+4N9GqJAbu0Cp8mo9QLQHmYFR4ms581IqA2HGW2Rrfu+
	QtVwqS85C0ICWV3CRcZiOA62wxYLexO/jJL79zhpnI0iSCoKwdoLk8lJePtE/6yLz7IsodC6zF6
	/wG8acNGz2Jyn1160MszgYOO/CKXuJZbvPunhUhReifnw7Lfbk8p/8Wzho6TxwOJ4NYYRlsbpKu
	2mw6BYFZTJ6hszb6mZeiodoXuvg0IhIVFqF/VNXXqskPtM+R9rtHqOMGXY+tPWSufQpTtbvGcTx
	Jh4HnmrSJa635+DRPQKAc0rGECuPPxyqo+dphhDmsTxGX3WwwYtdkbUWrRHD+hsanWPg2JLz6WK
	r1riBbAAEzlFBGNFyOyi8JUVmsnc0IRE+G/U5m+RA36uFtaj0tAieWT/G8E7nz/pTcY15MxOghJ
	YqPPlsuHnLNHlZEtnt6+QBA5L5yr/BnTL15ugd0tL4/xliEOKvdv7SFWRLJiJdu1aRLUQUs4umf
	ZjwO3qTDeA5in1S+nCPLceYXjnS9y/tR1Qh2xSOM93FwuZg89nM/Qe80to5RZor1r8FFVX2e9Jh
	UHzNPVsr0Ly9jba68a+zbnzryWVTVjyllIDhHCgpsD+EE+ubsogqdClv5y7Wqw==
X-Received: by 2002:a05:7300:f894:b0:351:207d:bff4 with SMTP id 5a478bee46e88-36a202bc360mr7083860eec.4.1793264464275;
        Thu, 29 Oct 2026 02:01:04 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:03 -0700 (PDT)
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 11/14] acpi: disable battery and adapter for x86 apple machines
Date: Thu, 29 Oct 2026 04:52:08 -0400
Message-ID: <20261029085504.3547-12-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
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

When macsmc-power is enabled on an Intel Mac, skip acpi-sbs
and the ACPI battery and adapter drivers, since macsmc-power
now provides them. This avoids duplicate devices.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/acpi/sbs.c       | 17 +++++++++--------
 drivers/acpi/x86/utils.c |  4 ++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f10bbf13c..b12f2acc0 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -634,6 +634,9 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 	int result = 0;
 	int id;
 
+	if (IS_ENABLED(CONFIG_MACSMC_POWER) && x86_apple_machine)
+		return -ENODEV;
+
 	device = ACPI_COMPANION(&pdev->dev);
 	if (!device)
 		return -ENODEV;
@@ -655,14 +658,12 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 
 	result = 0;
 
-	if (!x86_apple_machine) {
-		result = acpi_manager_get_info(sbs);
-		if (!result) {
-			sbs->manager_present = 1;
-			for (id = 0; id < MAX_SBS_BAT; ++id)
-				if ((sbs->batteries_supported & (1 << id)))
-					acpi_battery_add(sbs, id);
-		}
+	result = acpi_manager_get_info(sbs);
+	if (!result) {
+		sbs->manager_present = 1;
+		for (id = 0; id < MAX_SBS_BAT; ++id)
+			if ((sbs->batteries_supported & (1 << id)))
+				acpi_battery_add(sbs, id);
 	}
 
 	if (!sbs->manager_present)
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 418951639..9f3b9b7d9 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/x86/apple.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../internal.h"
@@ -608,6 +609,9 @@ bool acpi_quirk_skip_acpi_ac_and_battery(void)
 	long quirks = 0;
 	int i;
 
+	if (IS_ENABLED(CONFIG_MACSMC_POWER) && x86_apple_machine)
+		return true;
+
 	dmi_id = dmi_first_match(acpi_quirk_skip_dmi_ids);
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
-- 
2.55.0

