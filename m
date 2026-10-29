Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264328;
	b=4mGdQ+kFKT2Dh9ZD8awyqpefH2EEfHK36Bblmb1bvNSvQhPeppCuRke1/99WETv2DDJG
	 ahqMiUSrzgXH/+TxFfakY8DUIUTkp1HdQQyvGFa9hDeTgFQsi2RGoRXYrzg9r92aF/rxJ
	 aLl2eJTZGgZYXtkfKYZJfMvNM1mRetd7jqbFOeyGH1Svykw1PXieMj/XmTgzrSKEKW/kZ
	 FmyiPo/rqHDUVC8D7A7zqEfDtWz77Y2defbroXzWWlY2jF+YbJbcQhUHXORY4eUAthrpi
	 uC5vw7vdy9afogIC3osAG9tAwBfexE5juRPeeUsfcyYFSO7oWyfU5eA0bWXLkXrxKrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MA1va5T9XE5xJNcHi+mBsnQRuzOaQ1MDpEcJoNwX+FE=;
	b=eMU3hm0zeTKJII2p09UZg/1KCL7RNTbmuf1b51Vekh9OC7FLAIpSR0k8P8ZawIb1UIT+
	 DMBuAGg1bVb1CS7NbuqThor3jgGFIA1LgG6eqm+6LTCQhbycj/sqC2OrHn1FTPyIDkRCq
	 27roS+/2OQh6vg4P1KMs9hm0pYr5oStBAJiM3GuQAehNn4kt284vT+eyZ5eLIfppvYv0U
	 pF3wfjJWm12eM8SzSpfUQhbSUqtl39H6fD5N2g4taaCA6+TyoJNW+xuyIKuODa5xOF8eX
	 qC424GhZzr0fPEY8dM0VqxuRZHySV7eTIT7S3WbG6KC3r0AsFqZR9i8AF9Cz65JgSDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M/LEHeJC";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44959606A327
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 08:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44959606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/LEHeJC
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33fb4680717so813256eec.1
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264327; x=1793869127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MA1va5T9XE5xJNcHi+mBsnQRuzOaQ1MDpEcJoNwX+FE=;
        b=M/LEHeJCdSEFtQyLjoBSDXWtw18IcjVwvBNuis3vlkJcH6Cd+zyA5KLf/jRrUBxUKE
         Ji5UHAaA8Jfep+eLkBH3fpJ0DrQw9JanSZ+mhw1TrgPZYCcY60NUjnI9KQg40L4eI2Sn
         TlcEl0BfOUW9HAnyzfguKduUwN3FD/8412FJgjpz821bK6YdraNpfH+0aidphFW+r6Fp
         fbHiMaA/YPpMGQaUpcMMEZPKK/PjwGb0HzhdnZw/3ZeTpcGu5RkXXS1bWFjN8/QV/qAc
         eoRSQlhQMjXnLRijz6hFMAxt+aQBFw7RjgkK+5KsNgIXZEy2xC7RjulVs7ew1XO5CrV2
         USTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264327; x=1793869127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MA1va5T9XE5xJNcHi+mBsnQRuzOaQ1MDpEcJoNwX+FE=;
        b=uGJooZvIIP/JqZ707pKALDJ9V2WGoBDo7jbnFl4R/TRBcyk1bZmsDU7VvwJlvoyqli
         Fc10oEUIDSDjJ/WwInzpQYpyDcSfot2lAruOeeXXjG9dRUU1fVnBQ191AsDQTo6Sjx6g
         qQ6xYStALIMrmd2dmQepjOGpmXyqAA2JvuFaZdjO6nxurxRuLRbXdKdEto7Bm6/Cvg/B
         m1RGr/A9vdZ4rrBJaeAAInPK16Rr/HI07oLugUjfpdVT7DwcwilHmVlC4y+Af0NnRwLl
         Ea8GKXCRobSFSMliNamV+Gm/ANt2XD+5ssF+W/9q1pQEC3x6bWyFRQ763K88b1bXFL8+
         KFSw==
X-Forwarded-Encrypted: i=1; AKwUvBwQ8dRiVD7F3qdrN486BXafxtKUZB8WrgFi6yYdeLyTgC7645JpQFnAYzFzi5Jg20k1mJJm2raUdQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL0LHZ/jxnrmBRSzNWmJXHlMntqv0Xkw+1M8BRRJgA92uREZ+Ju
	TGs2aivoSa6K5UNUnziz3wY9PWNQGcPx5FOZMnKn/Y/TyGC5E2NlDnA=
X-Gm-Gg: AYBFou20niUK+llFjZBBblwKhCVriUVaZrCecIv640TJo2LoXq/smc7qTmbnUVDxIwv
	J/ZsN+EnrKHtt9kAzX2Gt9+C/+5sxTdSlVhCXzAEc4gMlGALkjMms7pUfT7OJcl2zGC2pe/T5tT
	PNgl2h09VaScy7rMQFXAouZdwE5XgfdDlLpKge8lmYWEFWIZ8fkSnLxHuMFrFTdXG+soEMwfeFT
	2hOHjaHIOkkaAIj8EPB6WdIBoYst+5QoD7AH/N7HCGbXOSHas0i+gTfAuo5EdpYAOoAPArL3wd/
	umI8rSefe+HSGmEdCyd3P1pXWfK/hGRcLaCAAy1IUNGPy0f4/iH+yVsEdIICsLhWXRy4lJuu/yE
	Fywe8Ln0H7hj1wYe5epov0A76japlEtssc4FN2Z2o/QJ8prpr1TiJ5JimKROwYdziDX8j8nLdid
	YdSV5IC3FjXU8WyBnZqFZfviW8/cbYMmCRzSRCEvZUCPw8xqKVPX1hg6wCMjZ0D8V6fp0Yr0ZWX
	NDFlGp1jQ2tbmn6f9sJEPCSmI+cB5uYdWGousSqvZIFMBEV5Putou2fVhKbU2d3eI90btnSSTYp
	HeHaYPJxSBRrCYo1Wth3lMejo1xObUpVHeLmKxyw9wzHlZfMwHPi3q8a5irjtlkmVgLaNk5w3vc
	3FecKLvl+
X-Received: by 2002:a05:693c:2411:b0:359:9302:a526 with SMTP id 5a478bee46e88-36a203ad100mr6959524eec.7.1793264327087;
        Thu, 29 Oct 2026 01:58:47 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:58:46 -0700 (PDT)
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
Subject: [RFC PATCH 06/14] leds: add support for macsmc kbl
Date: Thu, 29 Oct 2026 04:52:03 -0400
Message-ID: <20261029085504.3547-7-atharvatiwarilinuxdev@gmail.com>
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

Add a LED class driver to control the keyboard backlight.

This replaces the keyboard backlight support in applesmc.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/leds/Kconfig       | 11 ++++++
 drivers/leds/Makefile      |  1 +
 drivers/leds/leds-macsmc.c | 69 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/macsmc-core.c  | 11 ++++++
 4 files changed, 92 insertions(+)
 create mode 100644 drivers/leds/leds-macsmc.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 7ec2c8d78..30cd64d41 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -729,6 +729,17 @@ config LEDS_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called leds-adp5520.
 
+config LEDS_MACSMC
+	tristate "Keyboard Backlight support for Intel-Macs"
+	depends on LEDS_CLASS
+	depends on MACSMC_ACPI
+	help
+	  This option enables support for the Keyboard backlight in
+	  Intel-Macs using macsmc.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-macsmc.
+
 config LEDS_MAX5970
 	tristate "LED Support for Maxim 5970"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4d4b08915..7c38dbef4 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_LEDS_KUNIT_TEST)		+= led-test.o
 obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o
 obj-$(CONFIG_LEDS_ACER_A500)		+= leds-acer-a500.o
 obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
+obj-$(CONFIG_LEDS_MACSMC)		+= leds-macsmc.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
diff --git a/drivers/leds/leds-macsmc.c b/drivers/leds/leds-macsmc.c
new file mode 100644
index 000000000..f38ef2113
--- /dev/null
+++ b/drivers/leds/leds-macsmc.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple SMC Keyboard backlight driver
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ *
+ * Based on drivers/hwmon/applesmc.c
+ * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
+ * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
+ *
+ */
+
+#include <linux/leds.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/platform_device.h>
+
+struct macsmc_led {
+	struct led_classdev cdev;
+	struct apple_smc *smc;
+	u8 brightness;
+};
+
+static enum led_brightness macsmc_led_get_brightness(struct led_classdev *cdev)
+{
+	struct macsmc_led *drv = container_of(cdev, struct macsmc_led, cdev);
+
+	return drv->brightness;
+}
+
+static void macsmc_led_set_brightness(struct led_classdev *cdev, enum led_brightness value)
+{
+	struct macsmc_led *drv = container_of(cdev, struct macsmc_led, cdev);
+
+	drv->brightness = (u8) value;
+
+	apple_smc_write_u16(drv->smc, SMC_KEY(LKSB), drv->brightness);
+}
+
+static int macsmc_led_probe(struct platform_device *pdev)
+{
+	struct macsmc_led *drv;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->smc = dev_get_drvdata(pdev->dev.parent);
+
+	drv->cdev.name = "macsmc-led";
+	drv->cdev.max_brightness = 255;
+	drv->cdev.brightness_get = macsmc_led_get_brightness;
+	drv->cdev.brightness_set = macsmc_led_set_brightness;
+	drv->cdev.dev = &pdev->dev;
+
+	return devm_led_classdev_register(&pdev->dev, &drv->cdev);
+}
+
+static struct platform_driver macsmc_led_driver = {
+	.probe = macsmc_led_probe,
+	.driver = {
+		.name = "macsmc-led",
+	},
+};
+module_platform_driver(macsmc_led_driver);
+
+MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
+MODULE_DESCRIPTION("LED keyboard backlight driver for Intel-macs using macsmc");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_ALIAS("platform:macsmc-led");
diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index 6567d2f1f..bc4200f57 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -33,6 +33,10 @@ static const struct mfd_cell apple_smc_acpi_common[] = {
 	MFD_CELL_NAME("macsmc-power"),
 };
 
+static const struct mfd_cell apple_smc_acpi_led[] = {
+	MFD_CELL_NAME("macsmc-led"),
+};
+
 static const struct mfd_cell apple_smc_acpi_light[] = {
 	MFD_CELL_NAME("macsmc-light"),
 };
@@ -179,6 +183,13 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 			if (ret < 0)
 				return ret;
 		}
+
+		if (apple_smc_key_exists(smc, SMC_KEY(LKSB))) {
+			ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_led,
+				ARRAY_SIZE(apple_smc_acpi_led), NULL, 0, NULL);
+			if (ret < 0)
+				return ret;
+		}
 	} else
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_rtkit_devs,
 			ARRAY_SIZE(apple_smc_rtkit_devs), NULL, 0, NULL);
-- 
2.55.0

