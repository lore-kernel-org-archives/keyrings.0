Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264493;
	b=3zw2I4gZaPFEwoTRPmfK3LnhyFeYgsvLKpdkEtaeammOiIF6gK1IUafXRU1HoU56EKOp
	 Ew+qEi6T0HbhxS+/8l2fFCEKnfHzoLOi93A5YAEOzgdAUm7d4FVpFuB0Dp3pfuj/8o2H6
	 wzQTnzAkScKxLXJ+qBYI//Gvqm+s+AAIeXOqU6fKH/HYggacKSsPG8ESIaYJK7GOZzeNp
	 mWJJJl7OPSuVaOQPKVqTSyljzc8UjFKBJ70rzi3ndWmtCxxLyqll2e57lWuXtQ0ShIWfX
	 6gh0UbEPC6nk01Y3xytV5I3e6SyXGyhjsi/kxk2qhy7Sw71CyiYwTDJCEjJieXxXD6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
	b=b8vleXCxwBvWQagSYJG9BRMN4WsBr95CFJakt57Ta0k3nqM38wwHv5mVSBWVeRmmuuqz
	 eaDSa+GPUC9hDIE06m3fWx2EWkO05o/o+I6wiP/EjhJEiDBSjYnvCM9x3/yBndbnbdbaW
	 1lNqW+33L3haP3ZgHfSQ3BACCLdjMoysf+msSMuWRhbvE/Yl6p683znMwdiZKZXJs2iw9
	 rJTkRBK0Ze7zQ7ZwLKVIgzKmqXKXN+83aUNjtvI8VrYowsr80c35b+Zlqv482TWgKGZQg
	 0iAdMGEqDcl1HYcEvrBzkarzR3GgolBLae7keG2lPg1oHab0gZU3IDIY388ppf+b3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA3LCyJ7;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810C606A33C
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1810C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA3LCyJ7
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3465630eec.0
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264492; x=1793869292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
        b=CA3LCyJ7nJ/xoJVBGK7euuvFzDooHoTkancn1/gOxLVhjkV9W0IXBNdBCqW/OiX92H
         9gXvxbQ5ViuabsM2dJqowCO25Nhn0OnwZtEr0DGEq1trREc/LmtGBEDHIE1+uJOjFOzK
         xc3mXgwxk1dwMn3lfUNHTlk1yX9y2ij0QeRu6KKP3rTNCIj2saYmL0zm0nbzBivHhcUk
         +MUT5NcNWQ+IQenZp4oOj7GXdjUVtpF16UUjZ9VbmIyylrrQjEGl+1U/aQKidV+fsDBe
         +5j+PrkMZuRgJ7aKoCIDWEYqX4gv0aePmwTjEVe1F0VQVTuVNSwHPI5oGlTatJ1SLARt
         DX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264492; x=1793869292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
        b=wujypH+BgoO657LrVJ0RiRl4hfzyDEVKYl0LbqiL8WmlgyNzo18oRrjZ20sUlCa+9Z
         1XV2fWzIV1Dp90x6VBxCO2uQgZQ7cYXLXEiGnzEfPElqqSVgLC1qiiz2YegoEcHwUpTO
         ZGMZGzYEe2+2IudtVAOOQuhE1xNzABcDDiexFHTqHZ0TFKuGSkD9hqQiWjcFAn4hZDwa
         gE78LZ+u8yQR49j1ZyVx6CYVQtR896iP2Jw5hNQ07HSMYN2V1tHOIfL5ioobXiMzuP7b
         4fKMGhoLsM6UigHe5bNE6i43/n0eQTykKiJHdLYDIJbBuegbikga1Xuk8Dv9irr4doho
         gbMA==
X-Forwarded-Encrypted: i=1; AKwUvBzj9uaNWg7zTArjFyU1NQDLurHtqui4SuLbrUXPCnWEfY/6aBimScBmOyAVx0zrZJ7NCi+X+8xuJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJl/alHe1iy2sZEY9b0cB+x6sZ5hMC/8K7A4O7PCqWn7+wJXhZN
	v2UJeOO9wOhExPlvtgXu4ESQ1WmgYDh+m/PeooMmgG1BEHuHGnheXMY=
X-Gm-Gg: AYBFou1ezblyHOAwGDOt4i+RQBLsPMRCju/TPHseNxh+HYbqTWc6pmuNaREDLP/473u
	rz0IrtV052dvoWlwOvvQ2a4nZPzV2FFFyZtvJm8BYoanVWLLuq7Dajm6XfajRG537FAJ3ZMqGKQ
	u6JSBYopCBmq16hRazKRB6tQIK2H6pfvDi6ZtqKSclfVfqLmdxF2N17e+L0DJuJB++SNwICrxT2
	hMv9H8bH6zPL5WoMGYBF6lN/YhU0BqFpioHZLeNtQrsDZixtcJVmvoN1934MF6MIxESeh+CSLrZ
	fHHyoMgjcO/8/uiR4k18GnCVZHJ66QGr+YXKoq8gO08HybKr8YEyUFbJSubItCvPWuHHx1332MC
	Jzz22dc6Hb44KkOBOR28UZ6NGM1XmGUql1EkJEnQWmVzlzHCWTp53yODubxwT77QHlEkwtoPSRd
	jMUeA6cgpRriNmTrI7/0U+PJWr51WrI27cyydavP+rEvudnxJn0LoaIyxxFUw3hlpGL7TsTXm38
	wwQjxg3pYFU1JnZgocEchKA1CGm+ypriJ5kbS6yg4Rbc23l5uYazbPAG9pkkyADxJt03RBWsQ6g
	QoHYZ0epBMhsQZVdv6c66vRK8Fbv+ErzPffV26vz/ND08UewnudGHhKQ0x5/Vg==
X-Received: by 2002:a05:7300:f587:b0:369:fc38:6821 with SMTP id 5a478bee46e88-36a20113296mr6116491eec.12.1793264491785;
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
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
Subject: [RFC PATCH 12/14] hwmon/macsmc: add more types
Date: Thu, 29 Oct 2026 04:52:09 -0400
Message-ID: <20261029085504.3547-13-atharvatiwarilinuxdev@gmail.com>
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

SMC keys come in many data types, and Intel Macs use a lot
that macsmc-hwmon couldn't read, such as the signed fixed
point types like sp1e.

Add support for the common integer and fixed point types,
and allow writing fan speeds.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/hwmon/macsmc-hwmon.c | 310 +++++++++++++++++++++++++++++++++++
 1 file changed, 310 insertions(+)

diff --git a/drivers/hwmon/macsmc-hwmon.c b/drivers/hwmon/macsmc-hwmon.c
index 1500ec2cc..2e74dcd66 100644
--- a/drivers/hwmon/macsmc-hwmon.c
+++ b/drivers/hwmon/macsmc-hwmon.c
@@ -221,6 +221,313 @@ static int macsmc_hwmon_read_key(struct apple_smc *smc,
 			*val = (long)ioft;
 		break;
 	}
+	/* unsigned 8-bit integer */
+	case __SMC_KEY('u', 'i', '8', ' '): {
+		u8 ui8 = 0;
+
+		ret = apple_smc_read_u8(smc, sensor->macsmc_key, &ui8);
+		if (ret)
+			return ret;
+
+		*val = ui8 * scale;
+		break;
+	}
+	/* signed 8-bit integer */
+	case __SMC_KEY('s', 'i', '8', ' '): {
+		s8 si8 = 0;
+
+		ret = apple_smc_read_s8(smc, sensor->macsmc_key, &si8);
+		if (ret)
+			return ret;
+
+		*val = si8 * scale;
+		break;
+	}
+	/* unsigned 16-bit integer */
+	case __SMC_KEY('u', 'i', '1', '6'): {
+		u16 ui16 = 0;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &ui16);
+		if (ret)
+			return ret;
+
+		*val = ui16 * scale;
+		break;
+	}
+	/* signed 16-bit integer */
+	case __SMC_KEY('s', 'i', '1', '6'): {
+		s16 si16 = 0;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &si16);
+		if (ret)
+			return ret;
+
+		*val = si16 * scale;
+		break;
+	}
+	/* unsigned 32-bit integer */
+	case __SMC_KEY('u', 'i', '3', '2'): {
+		u32 ui32 = 0;
+
+		ret = apple_smc_read_u32(smc, sensor->macsmc_key, &ui32);
+		if (ret)
+			return ret;
+
+		*val = ui32 * scale;
+		break;
+	}
+	/* signed 32-bit integer */
+	case __SMC_KEY('s', 'i', '3', '2'): {
+		s32 si32;
+
+		ret = apple_smc_read_s32(smc, sensor->macsmc_key, &si32);
+		if (ret)
+			return ret;
+
+		*val = si32 * scale;
+		break;
+	}
+	/* 2.14 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '2', 'e'): {
+		u16 fp2e;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp2e);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp2e), scale, BIT(14));
+		break;
+	}
+
+	/* 3.13 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '3', 'd'): {
+		u16 fp3d;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp3d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp3d), scale, BIT(13));
+		break;
+	}
+
+	/* 4.12 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '4', 'c'): {
+		u16 fp4c;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp4c);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp4c), scale, BIT(12));
+		break;
+	}
+
+	/* 5.11 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '5', 'b'): {
+		u16 fp5b;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp5b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp5b), scale, BIT(11));
+		break;
+	}
+
+	/* 6.10 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '6', 'a'): {
+		u16 fp6a;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp6a);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp6a), scale, BIT(10));
+		break;
+	}
+
+	/* 8.8 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '8', '8'): {
+		u16 fp88;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp88);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp88), scale, BIT(8));
+		break;
+	}
+	/* 14.2 fixed point decimal */
+	case __SMC_KEY('f', 'p', 'e', '2'): {
+		/*
+		 * fpe2 is only used for fan stats and fan control
+		 * so precision is not needed
+		 */
+		u16 fpe2;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fpe2);
+		if (ret)
+			return ret;
+
+		*val = (be16_to_cpu(fpe2) >> 2);
+		break;
+	}
+	/* 1.14 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '1', 'e'): {
+		s16 sp1e;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp1e);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp1e), scale, BIT(14));
+		break;
+	}
+
+	/* 2.13 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '2', 'd'): {
+		s16 sp2d;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp2d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp2d), scale, BIT(13));
+		break;
+	}
+
+	/* 3.12 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '3', 'c'): {
+		s16 sp3c;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp3c);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp3c), scale, BIT(12));
+		break;
+	}
+
+	/* 4.11 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '4', 'b'): {
+		s16 sp4b;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp4b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp4b), scale, BIT(11));
+		break;
+	}
+
+	/* 5.10 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '5', 'a'): {
+		s16 sp5a;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp5a);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp5a), scale, BIT(10));
+		break;
+	}
+
+	/* 6.9 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '6', '9'): {
+		s16 sp69;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp69);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp69), scale, BIT(9));
+		break;
+	}
+
+	/* 7.8 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '7', '8'): {
+		s16 sp78;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp78);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp78), scale, BIT(8));
+		break;
+	}
+
+	/* 8.7 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '8', '7'): {
+		s16 sp87;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp87);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp87), scale, BIT(7));
+		break;
+	}
+
+	/* 9.6 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '9', '6'): {
+		s16 sp96;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp96);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp96), scale, BIT(6));
+		break;
+	}
+
+	/* 10.5 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'a', '5'): {
+		s16 spa5;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spa5);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spa5), scale, BIT(5));
+		break;
+	}
+
+	/* 12.3 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'c', '3'): {
+		s16 spc3;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spc3);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spc3), scale, BIT(3));
+		break;
+	}
+
+	/* 13.2 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'd', '2'): {
+		s16 spd2;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spd2);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spd2), scale, BIT(2));
+		break;
+	}
+
+	/* 15.0 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'f', '0'): {
+		s16 spf0;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spf0);
+		if (ret)
+			return ret;
+
+		*val = (s16)be16_to_cpu(spf0) * scale;
+		break;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -263,6 +570,9 @@ static int macsmc_hwmon_write_key(struct apple_smc *smc,
 	/* unsigned 8-bit integer */
 	case __SMC_KEY('u', 'i', '8', ' '):
 		return apple_smc_write_u8(smc, sensor->macsmc_key, val);
+	/* 14.2 fixed point decimal */
+	case __SMC_KEY('f', 'p', 'e', '2'):
+		return apple_smc_write_u16(smc, sensor->macsmc_key, cpu_to_be16(val << 2));
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.55.0

