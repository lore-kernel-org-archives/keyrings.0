Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264273;
	b=bpmAs61DnBO12qi5fV/9iXaamtutirdPBJaydCZ8bL39bM1qN9In7ZTLfKPoMlMJK7cX
	 HhQpjoUtS+O4JRwB5+Rdk4N70lJa5ciH57GCAkJkN7pObZcQU0KsOT4dsElmfqi7L0Ozu
	 sJhBRKvuVEjZ1VPFR+KpOx/ZQdm0p5n0Tc0NzIhszwHMvKjHuWFTCbNV0hhcdRTW44DuR
	 25+yfMS2gsEJfN3VJpoEzNhtZo2PP+CVWYQE1FxCsMqQygVi7GODKY0suqE+Vz+QTjn+l
	 rae14vB0f9OZFUtnBtNn/lZDSkY0u/6Gg4HJG2eMXeJxb1pDXLNIIor76IYWV2T+Jog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cs7lasADMMl4bjEjGvbybzUuKYrhEora6V1skLnp0co=;
	b=0lp3d8YNlJnt8ugqIwbFVF3M67eYNJPbNGbURPIrwL0ZErIHylmXbn4C4TdlpZudBYSf
	 E50QEunn7bAC4v9RcH73u22aEveWNUQzFw/gLnZ1OPRCkzUAcNm5u7ZcWVSWXxqFFiWe6
	 mcWfb4eVfQAMvNdq+LkjwdAeK5qVHMnK/p4xZu+TaGDRqFN045SbWky0WN4SRLp/RV1D1
	 gllroKNJwsLnePxRs1ukiS7FPVVIitCXrDtO3efdOozAc1sdV3gb31zIb1UDmDsH5Qt5z
	 vhPDD2e+yLsmvgkx/lkI/y56klPMAGt56UgM5nLVinrT6aDXrRKAj1LJdGZAUgm/ROw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRtT2iUT;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344F606A31E
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 08:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1344F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRtT2iUT
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a1947498bso1254520eec.1
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264271; x=1793869071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cs7lasADMMl4bjEjGvbybzUuKYrhEora6V1skLnp0co=;
        b=HRtT2iUTIP8tQw0W2BF26I1s3RT7ZhcG3VnZDhwJ0/tWXcgCT1stZLKnUS9jKYY/pe
         Qw8TAVw2OvDsE60gmnd+EW02UWEmkaqK9UP+jxxvNRtkxL/qYmdNkLloF7ZVUeUI/lcg
         hL2EgfJIc4uL4D/gFtXsvzUtZGcJiWiTVbonWyG2YL6Ya57C1P96E/CGd5gKuQCWIa9X
         94/0tUFVsZGEpt1X574eJA3ZBDxVk2zTZxqvXyddtci5lM2nRezNMD8TjE1ErEoWxHnr
         cCAb1f1omnp9csacXav36aPoiaX+swdxYOmk9bluvJP5ylS8bEuIhwcEV8GjTh+CoFPJ
         FVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264271; x=1793869071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cs7lasADMMl4bjEjGvbybzUuKYrhEora6V1skLnp0co=;
        b=0hR2Q200m+b5UoVPh6PspwwxFKBnsk5g1RK99S4Nd9dMCA7GbfHZpRNfPbiZAXHlji
         IJAG7/IHg9nfsSMBlQ+xJXrJo5hrOnQtR/kb5laTLGQyk5DL56t1KPYnB140yMeNptCw
         +Amt6Ch3UY4cnoTXJa+V2DuZ/u47AkrYoUqE/pBLhCnEI6ypnmk8FFbBhtFr8FJdDt2Q
         hE2y82ehRO5zhd3A3TySop7JDwIiIzstGTlVa2k2MMad61+/CCu/i5zHkLx7Wx14HcJM
         xcBk25Wye7dD+gNlDUSEu316NOe/KKQwEO7ZbZJhso+dztzsTsLpUXDn5CIfCYpdUI6W
         YQjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMN+8QVnbkLEX3iFD3hqEJB2lyY6WIreNIfub3yYVUsarcZyxURxKFE83zFuePBRhlRqOrbCPZag==@vger.kernel.org
X-Gm-Message-State: AFq9FYLRGrxgeWe5UZMnJvc4X9m9uNKefrz96tK124QWyiF/ucSAtnDr
	HCTAhbDHms0/BzmBBSNO3fE563ssPkuPZk4cevQ57EqBugkMcd4JH6M=
X-Gm-Gg: AYBFou0KRjkgnVtxh9jXVWPAkUqNp8p9DqgnlNYAF7+EWrDZyR4KSEDjf0qcDvBLgTg
	vxD1hmf6TI5/2HbJ7Xv+YA77Gwpl8FeUf4rTpJY+nxgFwOJAwsZOwGHYld51yZUuTRq5GWE1R+l
	lHaBd/9DFK7zOl0MJfa5KivQwixcTj5GxhRzBGCZNcPLK288lf74gKntWGD470XggZh4j4Y/Mq3
	vGN+bLuqE2H6YtSUaYDBqs/N1VZ2tsQSuf4Z2aIjpJv4YRB9hmDhnUovBYjRfrVWuQtoJ6EeYVW
	NNSQCooQZyOycOdAxF01ePEUJSCcF/2LI8ubcAaeaZynot2+ch3BaYQAWLC9TI2PuJA4te892qb
	ius5QuX4ZYvcCMEvPZ7C0IQWiKaZXsOJMtzety/Ed5vX9uygTriS0vycmXIMxSdFI48IXXm+6F0
	9sslgN1UB5seUNPUTJN4JcjEILIFCs9xrB/ugr2DJLc5qGedy2+ZV2WodRjbe8bXdnMlbgEo79R
	e2MFvp07wZzbavJU/WVIFvZergkV1dm7A7qsecjP4cSWGNIldkQ8v/L1jK54AbB8ARfkYVy1dhT
	+u4L9fDFTWtjYMzHiWw+7n/40K2NdHKZRcpFwjYkH97ie+lSQEOfYbv1xEYNTw==
X-Received: by 2002:a05:693c:4010:b0:36a:eee:bb41 with SMTP id 5a478bee46e88-36a202bc3ccmr7412692eec.1.1793264270972;
        Thu, 29 Oct 2026 01:57:50 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:57:49 -0700 (PDT)
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
Subject: [RFC PATCH 04/14] iio/light: add new driver for macsmc
Date: Thu, 29 Oct 2026 04:52:01 -0400
Message-ID: <20261029085504.3547-5-atharvatiwarilinuxdev@gmail.com>
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

Add a driver for the ambient light sensors, exposed through
the standard IIO interface with left and right channels.

This replaces the light sensor support in applesmc.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/iio/light/Kconfig        |  11 ++
 drivers/iio/light/Makefile       |   1 +
 drivers/iio/light/macsmc-light.c | 189 +++++++++++++++++++++++++++++++
 drivers/mfd/macsmc-core.c        |  11 ++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/iio/light/macsmc-light.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1dd..f84707edc 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -457,6 +457,17 @@ config LV0104CS
 	  To compile this driver as a module, choose M here:
 	  the module will be called lv0104cs.
 
+config MACSMC_LIGHT
+	tristate "Apple SMC Light Sensor"
+	depends on MACSMC_ACPI
+	help
+	  Say Y here if you have a Intel-based Mac. and you
+	  want support for light sensors.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called macsmc_light
+
+
 config MAX44000
 	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6672ed01a..2ef4c054d 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_LTR390)		+= ltr390.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
 obj-$(CONFIG_LV0104CS)		+= lv0104cs.o
+obj-$(CONFIG_MACSMC_LIGHT)	+= macsmc-light.o
 obj-$(CONFIG_MAX44000)		+= max44000.o
 obj-$(CONFIG_MAX44009)		+= max44009.o
 obj-$(CONFIG_NOA1305)		+= noa1305.o
diff --git a/drivers/iio/light/macsmc-light.c b/drivers/iio/light/macsmc-light.c
new file mode 100644
index 000000000..9d4532b34
--- /dev/null
+++ b/drivers/iio/light/macsmc-light.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Apple SMC Light Sensor Driver
+ *
+ * Copyright (C) 2026 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
+ *
+ * Based on drivers/hwmom/applesmc.c:
+ * Copyright (C) 2007 Nicolas Boichat <nicolas@boichat.ch>
+ * Copyright (C) 2010 Henrik Rydberg <rydberg@euromail.se>
+ */
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/byteorder/generic.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/platform_device.h>
+#include <linux/unaligned.h>
+
+enum {
+	LEFT_LIGHT = 0,
+	RIGHT_LIGHT
+};
+
+struct macsmc_light {
+	struct apple_smc *smc;
+	struct notifier_block nb;
+	struct iio_dev *indio_dev;
+	u8 size;
+};
+
+static int macsmc_light_read_raw(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan,
+		int *val, int *val2, long mask)
+
+{
+	struct macsmc_light *drv = iio_priv(indio_dev);
+	u8 buffer[10];
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	switch (chan->channel) {
+	case LEFT_LIGHT:
+		ret = apple_smc_read(drv->smc, SMC_KEY(ALV0), buffer, drv->size);
+		if (ret < 0)
+			return ret;
+
+		if (drv->size == 10)
+			*val = be16_to_cpu(get_unaligned_be16(buffer + 6)) >> 10;
+		else
+			*val = buffer[2];
+
+		break;
+	case RIGHT_LIGHT:
+		if (drv->size == 10) {
+			*val = 0;
+			break;
+		}
+		ret = apple_smc_read(drv->smc, SMC_KEY(ALV1), buffer, drv->size);
+		if (ret < 0)
+			return ret;
+
+		*val = buffer[2];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int macsmc_light_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct macsmc_light *drv = container_of(nb, struct macsmc_light, nb);
+	s64 timestamp = iio_get_time_ns(drv->indio_dev);
+
+	/* check if event is for us */
+	if (event != 0x2A)
+		return NOTIFY_DONE;
+
+	iio_push_event(drv->indio_dev,
+		IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+				LEFT_LIGHT,
+				IIO_EV_TYPE_CHANGE,
+				IIO_EV_DIR_EITHER),
+		timestamp);
+
+	if (drv->size != 10) {
+		iio_push_event(drv->indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+					RIGHT_LIGHT,
+					IIO_EV_TYPE_CHANGE,
+					IIO_EV_DIR_EITHER),
+				timestamp);
+	}
+
+	return NOTIFY_OK;
+}
+
+static void macsmc_light_unregister_notifier(void *data)
+{
+	struct macsmc_light *drv = data;
+
+	blocking_notifier_chain_unregister(drv->smc->event_handlers,
+					   &drv->nb);
+}
+
+static const struct iio_event_spec macsmc_light_events[] = {
+	{
+		.type = IIO_EV_TYPE_CHANGE,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec macsmc_light_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel = LEFT_LIGHT,
+		.extend_name = "left",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = macsmc_light_events,
+		.num_event_specs = ARRAY_SIZE(macsmc_light_events),
+	},
+	{
+		.type = IIO_LIGHT,
+		.channel = RIGHT_LIGHT,
+		.extend_name = "right",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = macsmc_light_events,
+		.num_event_specs = ARRAY_SIZE(macsmc_light_events),
+	},
+};
+
+static const struct iio_info macsmc_light_info = {
+	.read_raw = macsmc_light_read_raw,
+};
+
+static int macsmc_light_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct macsmc_light *drv;
+	struct apple_smc_key_info info;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*drv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	drv = iio_priv(indio_dev);
+	drv->smc = dev_get_drvdata(pdev->dev.parent);
+
+	ret = apple_smc_get_key_info(drv->smc, SMC_KEY(ALV0), &info);
+	if (ret < 0)
+		return -ENODEV;
+
+	drv->size = info.size;
+	drv->indio_dev = indio_dev;
+	drv->nb.notifier_call = macsmc_light_event;
+	ret = blocking_notifier_chain_register(drv->smc->event_handlers, &drv->nb);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, macsmc_light_unregister_notifier, drv);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "macsmc-light";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &macsmc_light_info;
+	indio_dev->channels = macsmc_light_channels;
+	indio_dev->num_channels = ARRAY_SIZE(macsmc_light_channels);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver macsmc_light_driver = {
+	.probe = macsmc_light_probe,
+	.driver = {
+		.name = "macsmc-light",
+	},
+};
+module_platform_driver(macsmc_light_driver);
+
+MODULE_AUTHOR("Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("Apple SMC Light Sensor Driver");
+MODULE_ALIAS("platform:macsmc-light");
diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index 1c1469828..6014df4fe 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -29,6 +29,10 @@ static const struct mfd_cell apple_smc_acpi_common[] = {
 	MFD_CELL_NAME("macsmc-power"),
 };
 
+static const struct mfd_cell apple_smc_acpi_light[] = {
+	MFD_CELL_NAME("macsmc-light"),
+};
+
 static const struct mfd_cell apple_smc_acpi_rtc[] = {
 	MFD_CELL_NAME("macsmc-rtc"),
 };
@@ -158,6 +162,13 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 				return ret;
 		}
 
+		if (apple_smc_key_exists(smc, SMC_KEY(ALV0))) {
+			ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_light,
+				ARRAY_SIZE(apple_smc_acpi_light), NULL, 0, NULL);
+			if (ret < 0)
+				return ret;
+		}
+
 	} else
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_rtkit_devs,
 			ARRAY_SIZE(apple_smc_rtkit_devs), NULL, 0, NULL);
-- 
2.55.0

