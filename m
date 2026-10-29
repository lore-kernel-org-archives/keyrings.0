Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264241;
	b=J+txdu8KzvtRrA7xC1dHR4l6jrW5fmPg6D2+sYvz1m6E3KxOikiK+XyinmO88rEXP93l
	 m4D4TVGY5gsPDV+Q4n/DIQ+6Qth+sfDk5pwiytE+3I246WvVgbgYAEXl8haVxN0r+JYIZ
	 sD1kn2pAHWNLNEcfmxCVLMb8Ip/evkOqIekyJfSTljY3Gk+QWqeapLxvzE9immtTVJVf1
	 nu/yvBhIy/1amqV8vgUPRwpz80hVzOXesXDi5ABqmHpw7IXoxhWOyB4F9J2egTNyb1JDb
	 DJDlJ3cpYzicp5SHFv8AxVsjwTBXzBo8Ppcn/P3pkqwiJxDgtv3d07MI6ZupGDTB8yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l2H0bFieZXxd5jJJlL+lwbMkDWOOduyv3s8IOA4GnsU=;
	b=w+XgFlYMLaVkpfzcqxYm+DNlS6pTDHAPJZFJsNBVWX9Lze3qbKaaE7rXHdJ5ykbfmmBn
	 6gY0ugSb6eFLB65jVzSzuP8nwroqX+tE+bvoiX725PaY5etjAcxvsGnbN6QmAHtHwv1QE
	 yxZrxwo/E09PmPam93jKMx5PRg5QZa74I604NMoNAau4RASCHGXGN+yLqxOZdZkGqQzdq
	 q8ZpF7WXA9p+LRyUhbJRPBjTc4eDGDA8HytkJCII5IMDyUoP20jsQxFW6dDEKjmYxMEjj
	 5XKqS7C/IcN0wpxAdZoDPEK5b0sDWHuMMb6NKu/du9jIeV5u8X31je/5xyglAMNbXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVOk1ChT;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FD606A32C
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 08:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77FD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVOk1ChT
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3550c917fd3so2693763eec.0
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 01:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264240; x=1793869040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2H0bFieZXxd5jJJlL+lwbMkDWOOduyv3s8IOA4GnsU=;
        b=hVOk1ChTsyDShJ56FOp8o/9+3MQFLB0HW1Ei0A0/oEO++7zL1B6B1eZnTpmrIYtipJ
         St7BvbStGgaYM8FI+pgxJwnqYzTBIDCI6RH48ISInnwbjSoJWTaKWHcj+dxy2IwnDz5z
         pPZy5M3Wrv3Zc6ZjmIe8kbynI/RK51T2vfk++Lawt8B9M6KGNcOdFk4Ym3l59f6IadYQ
         gjX1nIvb4LAzRV//gMrTJGuNZ3TLl989iUwDvOtrQQd87WYuuKl7nTHM2ggKsKxL1cY2
         ALXOzhV1gXysgRz6wxfNsk0WlxN8WBguWpiasJJmzs8wVmwCVrLFNHpWYNkpCkcJexd/
         FhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264240; x=1793869040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2H0bFieZXxd5jJJlL+lwbMkDWOOduyv3s8IOA4GnsU=;
        b=MS4kwENGWUWVMDb2QulZF1Zdzqfwe/bntNm8v2RgcYjGI8PfiANvBbohu88TEypSsE
         LyOB3WR8GVrkkyLxEO0TVoVttprdqJ1XZvuz2HbrFN0IXM3D8HIAt7MPAW/QnlucJt4F
         KLOhuYv+GvM05+KsZJfGRCAAfbYZpECcnPBBrt/4h8msgxgtEusir8rsl4wgYkGN+HD2
         WKbMnQmN74GcRply2ASvr/WNn2eLDnLBGJXtFDH/y0v54cV38ZfVVv/rQAJwKv9JoJYP
         jmmSIVV3YALrLGLLRDPo18wkqgWJUQolvFB+av6qP/rS/Ztf6OgF6h5tVwbyMDW1FoqD
         Dm9w==
X-Forwarded-Encrypted: i=1; AKwUvBw+kX9H5mboeozXsuDUchBEjKtbE0X2tD+02+18qnNYRVDcOUrY+TjUpo6wambAoAElRXvqO6YK4A==@vger.kernel.org
X-Gm-Message-State: AFq9FYInx7HZWRaB2L9O1tihrJwGkegWVo4igOoIMtn23ZiAX49+5hbh
	4Nce9r+LSu2WfMXd4cgnhMdMlryNdvTGjy+wKxYCukoJBew/mOjxebs=
X-Gm-Gg: AYBFou0sgjv5osj429QGmmu2SF6aengFjLppC1+umg3ZWIvR4kF3caWCtydeBGj30mn
	zZvfyGQKbwxk4LT3ouAilz0CQb5VZ2y/8+oT8ctLKGRFiRKBajC+BEyx8TFkOdAHdBFQfW+i6jF
	74/PvVuz/qLjqaNB6h7iXsNrfwqOPqq7CmLH/J+DQixiOq8irgcNQkLc/FVw1M304mqR94Iw2by
	h8/M/If6Q4AbwKaw+GxdSGulENUqUsHUMG2bnsu5ywj/n94dbYntitOFoQLsn8GSKwogjxnd2FZ
	Kjq4NYpuwDyI21ykg9BF49wQthX7age6I9ctONQHLLC16sMw9TXBeT/fCKl8N7BzjZzw4LDCrhI
	QaiqjJ1qSrNMpkLtZ6FmZVN+q4aYxa14LdwPqdMV6OuYIlf7NDCAHBAa/wz7HUqzEFxwZMkubn/
	6rASrNSrFG66KXr1EhvKFzrXniTJ67X0cT4Y7gIJbEgKnG1GaLGUztlCmRKolbYYwitAIkDK8CX
	W+a4c3MsjGMtVrGlp7hy38aRpbpBO7rMbH1XEb/2qYUlCiJMswrXYdYteWYsdAr8yTZA3ft+Utr
	MlvCA4IygzDDSbIaSCx0z2zJTOOQdKm7A/a2ff98/TQ3/pL4uKkkNM6AsrCY5A==
X-Received: by 2002:a05:7300:e9c4:20b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a20427d57mr7840856eec.36.1793264239420;
        Thu, 29 Oct 2026 01:57:19 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:57:19 -0700 (PDT)
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
Subject: [RFC PATCH 03/14] watchdog: add driver for apple smc
Date: Thu, 29 Oct 2026 04:52:00 -0400
Message-ID: <20261029085504.3547-4-atharvatiwarilinuxdev@gmail.com>
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

Add a watchdog driver for the SMC on Intel Macs. It can
reset the machine if the system stops responding. It works
on both newer and older SMC versions.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/mfd/macsmc-core.c     |  11 +++
 drivers/watchdog/Kconfig      |  11 +++
 drivers/watchdog/Makefile     |   2 +-
 drivers/watchdog/macsmc_wdt.c | 140 ++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/watchdog/macsmc_wdt.c

diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index b8905c834..1c1469828 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -33,6 +33,10 @@ static const struct mfd_cell apple_smc_acpi_rtc[] = {
 	MFD_CELL_NAME("macsmc-rtc"),
 };
 
+static const struct mfd_cell apple_smc_acpi_wdt[] = {
+	MFD_CELL_NAME("macsmc-wdt"),
+};
+
 int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size)
 {
 	guard(mutex)(&smc->mutex);
@@ -147,6 +151,13 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 				return ret;
 		}
 
+		if (apple_smc_key_exists(smc, SMC_KEY(NATJ))) {
+			ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_wdt,
+				ARRAY_SIZE(apple_smc_acpi_wdt), NULL, 0, NULL);
+			if (ret < 0)
+				return ret;
+		}
+
 	} else
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_rtkit_devs,
 			ARRAY_SIZE(apple_smc_rtkit_devs), NULL, 0, NULL);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c..854ab772f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1810,6 +1810,17 @@ config SIEMENS_SIMATIC_IPC_WDT
 	  To compile this driver as a module, choose M here: the module will be
 	  called simatic-ipc-wdt.
 
+config MACSMC_WDT
+	tristate "Apple SMC Watchdog"
+	depends on X86 && MACSMC_ACPI
+	select WATCHDOG_CORE
+	help
+	  This driver adds support for Watchdogs in Intel macs Using
+	  Apple SMC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called macsmc_wdt.
+
 # M68K Architecture
 
 config M54xx_WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9ac406677..f142a5d8d 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -158,7 +158,7 @@ obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
 obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
 obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
 obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
-
+obj-$(CONFIG_MACSMC_WDT) += macsmc_wdt.o
 # M68K Architecture
 obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
 
diff --git a/drivers/watchdog/macsmc_wdt.c b/drivers/watchdog/macsmc_wdt.c
new file mode 100644
index 000000000..38f68d0d8
--- /dev/null
+++ b/drivers/watchdog/macsmc_wdt.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple SMC Watchdog Driver
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ */
+
+#include <linux/mfd/macsmc.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int timeout = WATCHDOG_TIMEOUT; /* in secounds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+struct macsmc_wdt {
+	struct apple_smc *smc;
+	bool has_oswd; /* Newer version of watchdogs in macsmc */
+	struct watchdog_device wdd;
+};
+
+static int macsmc_wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
+{
+	struct macsmc_wdt *drv = watchdog_get_drvdata(wdd);
+	int ret;
+
+	if (timeout)
+		wdd->timeout = timeout;
+
+	if (drv->has_oswd) {
+		ret = apple_smc_write_u16(drv->smc, SMC_KEY(OSWD), (u16)(timeout << 8));
+		if (ret < 0)
+			return ret;
+	} else {
+		/*
+		 * NATJ = 2, makes the watchdog do force restart if NATi == 0
+		 * NATJ = 0, makes the watchdog do nothing if NATi == 0
+		 */
+		if (timeout == 0) {
+			ret = apple_smc_write_u16(drv->smc, SMC_KEY(NATJ), 0);
+			if (ret < 0)
+				return ret;
+		}
+		ret = apple_smc_write_u16(drv->smc, SMC_KEY(NATi), (u16)(timeout << 8));
+		if (ret < 0)
+			return ret;
+
+		if (timeout != 0) {
+			ret = apple_smc_write_u16(drv->smc, SMC_KEY(NATJ), 2);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+static int macsmc_wdt_start(struct watchdog_device *wdd)
+{
+	return macsmc_wdt_set_timeout(wdd, wdd->timeout);
+}
+static int macsmc_wdt_stop(struct watchdog_device *wdd)
+{
+	return macsmc_wdt_set_timeout(wdd, 0);
+}
+
+static int macsmc_wdt_ping(struct watchdog_device *wdd)
+{
+	struct macsmc_wdt *drv = watchdog_get_drvdata(wdd);
+	int ret;
+
+	if (drv->has_oswd)
+		ret = apple_smc_write_u16(drv->smc, SMC_KEY(OSWD), (u16)(wdd->timeout << 8));
+	else
+		ret = apple_smc_write_u16(drv->smc, SMC_KEY(NATi), (u16)(wdd->timeout << 8));
+
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct watchdog_ops macsmc_wdt_ops = {
+	.owner =	THIS_MODULE,
+	.start =	macsmc_wdt_start,
+	.stop  =	macsmc_wdt_stop,
+	.set_timeout =	macsmc_wdt_set_timeout,
+	.ping =	macsmc_wdt_ping,
+};
+
+static const struct watchdog_info macsmc_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "Macsmc Watchdog timer",
+};
+
+static int macsmc_wdt_probe(struct platform_device *pdev)
+{
+	struct macsmc_wdt *drv;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(struct macsmc_wdt), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->smc = dev_get_drvdata(pdev->dev.parent);
+	if (apple_smc_key_exists(drv->smc, SMC_KEY(OSWD)))
+		drv->has_oswd = true;
+	else
+		drv->has_oswd = false;
+
+	drv->wdd.ops = &macsmc_wdt_ops;
+	drv->wdd.info = &macsmc_wdt_info;
+	drv->wdd.min_timeout = 1;
+	drv->wdd.max_timeout = 255;
+	watchdog_init_timeout(&drv->wdd, timeout, &pdev->dev);
+	watchdog_set_nowayout(&drv->wdd, nowayout);
+	watchdog_set_drvdata(&drv->wdd, drv);
+
+	return devm_watchdog_register_device(&pdev->dev, &drv->wdd);
+}
+
+static struct platform_driver macsmc_wdt_driver = {
+	.probe = macsmc_wdt_probe,
+	.driver = {
+		.name = "macsmc-wdt"
+	},
+};
+module_platform_driver(macsmc_wdt_driver);
+
+MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("Apple SMC Watchdog Driver");
+MODULE_ALIAS("platform:macsmc-wdt");
-- 
2.55.0

