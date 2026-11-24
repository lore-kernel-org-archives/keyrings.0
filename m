Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535626;
	b=kriEMkAqb4k4dQq/SJUWpsyplL7n+OtpurpxwK/pnGL1LObVmN19LQaZM5Ur59Yh9IJr
	 ULLIGTLr+RSaAiJ4lJbZkzZiSRScwh0w82Ey+te9SMS7XBVMFt9gn0EouyiIA5GGP6SqC
	 sQWtJkWVYzh/NdYf/dazqq2wWlj4fI0cycGGMNyl/mfbsKrrsL/Qv7OtRl0RJEfmI7/Kc
	 kL67+YFgeZskx/JI1f6cWvqgZREzE1M6Y+0WySXVKj3NgT1XUeciw32lwW/W+93tAhS05
	 cRbyvc7ImEP0Rr/N9xIlF9ozS0t3rzcXn6RYGwVU+4/Hbd7QxZakfN1zqJJB6hx1lqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535626;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GZujQcb1vIGlqn+UNi02fGM1tAPwUlH77khPImIX75E=;
	b=hEY7BgVpHvw5+bREw8inFSf7J/kB4vrY77e293MSfH3wX+CqdE9qiSR71hAK7fixAs1q
	 cldqU0OiRwQvM50Gm+n4ShJyxmKVIR3Gibk0iz5TtgNegpCDZtfz7WxE5kEnX5FJN4s65
	 97Ajy7FiNFRGoBenEb/vsXowj3y9pNTYdYru4t89XNtRuBn4p2rQBtK1ZI8xA8aeiHbWT
	 FX0KtX5vH9oQ1oAGSN0nZAmAdKEVaYyQR39wsdzd6rWKtRaYZgouIqjZOBWAUIs5s+XmZ
	 9bj1pvrEaEUdzo78eBcr7aULWIBuq5XFh1K/qrEws78UHhaWzAh5EV+6hc1Nj8bbJMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.jp;
	spf=pass smtp.mailfrom=outlook.jp;
	dkim=pass header.d=OUTLOOK.JP header.i=@OUTLOOK.JP header.a=rsa-sha256 header.s=selector1 header.b=pimBKHcb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.26
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011026.outbound.protection.outlook.com [52.103.43.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2910606A31E;
	Tue, 24 Nov 2026 15:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2910606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.JP header.i=@OUTLOOK.JP header.a=rsa-sha256 header.s=selector1 header.b=pimBKHcb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGs+loAMDHL6HUmWFiqGgIXs9MaabJfxflDXh80NfYn4sXgt7BZ+OAjT+4kGx36kaQgd0tTeWKdJMbBcyGflJU6UadkYOm+VXnxmKVSlLD6b+qyhg8euTdgWX6JmkRD2eZi/mlSUSTzQR85Hj+UE7ZYhCGz3ZPJbuo71DkLtjKV/+01VPG3fNx0kXvfHYtbAeTecJ87NAAainbAv0ncLAPfTWoGoICiiiWRe3say3myGFy30kU1KfBOW/9+tkjU20/wNtwrJKKzMgAm0ntq9LA9ryb+w0ftyruLPGKupRwQ0dyCE1+/8D8PyrhfxFvVjZ2Y4jGlPNHYOlsuc83yQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZujQcb1vIGlqn+UNi02fGM1tAPwUlH77khPImIX75E=;
 b=uDyecwCCS0YuALQ7uxvMedzy/JJNVNnXnVgO0mfAxlQq2AW7GoTo2bY2Ru1/uMveoIRTgo+tjGZnGlENJiUogh4wBgevgY47/Lyd/bi7Fyl/h7tn/G2wEn5WKBWd7weJ/V3h8W2tViHvLrpgDgUAiIkKg/Mj2aj+R4rjqpaHJn9i41uijdCZGvfKN40BMzNajYrKNNsiHeYSsr28XA7wIfKUe0GGTqQFBUCgADvyF3sOxOVVbxYGZJMG/IXE4UQYAI6I9G/d8zSZm4zLy01sQlifAI5amc9o/F4uqmpx1hJoyBBgaclJvYCn7jHsntpR5y/vNmGtjRms34MWP7QpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZujQcb1vIGlqn+UNi02fGM1tAPwUlH77khPImIX75E=;
 b=pimBKHcb+aDi4101VuPh8cMEWgfuKJWtgmz1zZfO77RLBSdwmlmq20TTXBVW+owO0sfTmpIYqhzvxA0Q2ZfD5+r58/jP0gCWsValOKHdLVUKhxj0cyXNWeG+36ySD3ynQqXcPcvJLgdCF2Z73L12r7SZd13kMQw7xTc4CJn8RWNhUNcyHTz7pcX+jCOiBBlXVAXRrUkV0ROhWQu7pBSRBw9mv2epqNbVOTRIDUwSm4QzB0NVuoVCxS94McBh32b+m/exTxey9ZMyD/s422hURYp2lQt32fxcgNZm3nBdupSKIwmLl8ICq92PKJ7mvBk+oh2ZZ1EIX4m+GDGO8D9Hvg==
Received: from OS7PR01MB14363.jpnprd01.prod.outlook.com
 (2603:1096:604:388::11) by OS9PR01MB14000.jpnprd01.prod.outlook.com
 (2603:1096:604:35f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 15:53:40 +0000
Received: from OS7PR01MB14363.jpnprd01.prod.outlook.com
 ([fe80::eeff:dfdb:bd3b:591b]) by OS7PR01MB14363.jpnprd01.prod.outlook.com
 ([fe80::eeff:dfdb:bd3b:591b%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:53:39 +0000
From: Keisuke Tsukuda <tkdkei@outlook.jp>
To: "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "paul@paul-moore.com"
	<paul@paul-moore.com>, "jmorris@namei.org" <jmorris@namei.org>,
	"serge@hallyn.com" <serge@hallyn.com>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Keisuke Tsukuda <tkdkei@outlook.jp>
Subject: [PATCH] KEYS: trusted: caam: propagate protected key option parsing
 errors
Thread-Topic: [PATCH] KEYS: trusted: caam: propagate protected key option
 parsing errors
Thread-Index: AQHdfCv5bjdYMvpuBEqVKq2niinaTw==
Date: Tue, 24 Nov 2026 15:53:39 +0000
Message-ID: <20261124155310.32044-1-tkdkei@outlook.jp>
Accept-Language: en-US, ja-JP
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14363:EE_|OS9PR01MB14000:EE_
x-ms-office365-filtering-correlation-id: 03b8ff89-92f9-41fa-33cc-08df4a431bb4
x-microsoft-antispam:
 BCL:0;ARA:14566002|25031999004|15080799012|8062599012|22141099003|38102599003|4140399003|25010399006|8060799015|24021099003|31061999003|19110799012|41001999006|39105399006|41105399003|40105399003|102099032|26104999009|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xp4lSqN/MVVGYi31fDDbiOwdGyLOXZyNMplFNmh+CAV7DDr+D/CtA1PbTv?=
 =?iso-8859-1?Q?BJC+mbre/fM1/0F8TPnx1PY/Q4itYSJYNHGxe+jnWOGl/P35sfLReoC0yF?=
 =?iso-8859-1?Q?J+dTpR80PkzHo+SOfTWAPQ24b79vybZVvE+rKwa5cQj1st8uinRK3CLdiy?=
 =?iso-8859-1?Q?J42F0OFEALhZKUjrrCAtTWrMYeWhhvdGtnwm9n/AIOq5/4OMD8GR1UPRgz?=
 =?iso-8859-1?Q?TXxe1XMMRAQnuFrDm0ddmv0YE71Eauw1U5qTAUdbbNri/Wjy/UScukOSOK?=
 =?iso-8859-1?Q?Ni28LUXGyc6a5M2P4qIYjuioO1jhaK0ccO2FNisQILkP7OgLkARazHkzAM?=
 =?iso-8859-1?Q?OnoJ1CycErGz5dOaxccc3nBjdXrsEhOMnfNBlmjgIg4dCtIgUQa53q3OmJ?=
 =?iso-8859-1?Q?2jFxKFZpw/cidH5XYmXW84oIC5CR/Kc2QycnBJH1FyPfYG0FcTJJ3LhMMV?=
 =?iso-8859-1?Q?SJgZUb5NDI7bDHz4++CUaamxGQqSk573nxB2P36H7Tyz197emFtBZwHyEH?=
 =?iso-8859-1?Q?2uwz7SkGCR3HwUgp1Nvylfem5O4a6ViFqtBbtsvCl2iOhwA6UzuYBkPX9f?=
 =?iso-8859-1?Q?PIxPSCvQQo6Z4jOZAlHYmjIj8UiXy1oPTwlajVq2ciismc2o2pQXx4s5l5?=
 =?iso-8859-1?Q?MKR/U4z858n9SNPjXVRfhLXAqI4/zZGT4q+PJygw5ZLXgxtdfBqe5MGKPb?=
 =?iso-8859-1?Q?cR1HJjzccyY1YOfLOC1JAsfsEzvaHyW+8eDsdUUFawB4YqTtThLWmXFNzX?=
 =?iso-8859-1?Q?wXgcZUHRUcRP0rYVTy2YPz1B7s+e5/RM1Zq/OqBri9OdC2PZSlMZgdy7NG?=
 =?iso-8859-1?Q?1MXsx/KmwZaKazWPSCGr7tQ0WCS8+jJ5UfBGMKupKYbWRfdbN7OvkjxRZ+?=
 =?iso-8859-1?Q?gZjfUkiTsoV4WZ+3d7kiJ0KoCNSrn0dqDohg0fHJOZX7puDrhIpB2icEWa?=
 =?iso-8859-1?Q?N1mUtAOHBGr5APnp8nl1t4N8Q1y2LDmib4+Ms2PwJLiCT1wL+A58LJurV6?=
 =?iso-8859-1?Q?JZ3fhv3ea2XdEgaafvT4GvRA3WubINgDc9MvXj8i74hlfrZQ7ilPsv1Onq?=
 =?iso-8859-1?Q?2BQmhwVU9l1n7TV9Imehi1y0r5TpZDAdYbQraljNizbs52IzkQ9tM9J1V4?=
 =?iso-8859-1?Q?ACwYsyglWnv0Fy06/w75AwbozXAaU0p8iE7qGqPHEFZ61xHNlQ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?s2TthIOGV1m/IYjVs9qCIcbAKH3lg+hS014T7HMTnz4P87JcPslUHfdNxw?=
 =?iso-8859-1?Q?YxxFnEeaqPq3P8uxaNHqgEMIoHc3J5l8GElzDYqApCXqRlHAg71lGb9sGM?=
 =?iso-8859-1?Q?BOOCVRFvpT3w6Kvllcs/nKXMQlv8tOZqWpjsDfP3XbXqoDxNhYH7sx2HQr?=
 =?iso-8859-1?Q?I+mnIN+YXlDPZhodpOU1N2lsJIE10lh6jMtkz7BVuiApfPnIuUYdICvv4d?=
 =?iso-8859-1?Q?pRbyc6JPuahhrWO/rik/fDHPQ5N4eKn7Slm/2kKSv1PRqxEdbHs0OjteOS?=
 =?iso-8859-1?Q?DgsGQzyNCDobKMhcvVcsr0op8FWAXj/OOHVSb6NG7ddl+M16FIPPJ9Y0Od?=
 =?iso-8859-1?Q?tqOIjTpbVvfLz8OqvYFjsnRVQwrojq8jzl4Gu74Mey9cFJoI4o5f96cCT5?=
 =?iso-8859-1?Q?0M68HSzZB18rjNsDr4hKjTiahTBDwWJUNd/7rc7pKM/tPh7xwgpzd9oxp7?=
 =?iso-8859-1?Q?35LHWIKPEbrwsUgG4V6BcA/xUjaSVuDpi3tbT7Bw+avQtDlU/184ho5xu+?=
 =?iso-8859-1?Q?iUqPvKFXsfKSMlsogE+q+H34/65by4oeGk1jq4ctS80xozNDNalxz9OP0r?=
 =?iso-8859-1?Q?/PXXdhKGxJdg563eEGsqUXhuabeZDz7y+f+bcJPX1jZGM2ofcYNpHFEXJF?=
 =?iso-8859-1?Q?C24Y6v1V2ucEhdVn73EWq98aglkLgqhY0FQiS1G1c3Bgt/6zR0IYwyAwI9?=
 =?iso-8859-1?Q?MFA48rqyZmBeeHeKHfsJ3AmsoUbVgvFDGUdK20kiJOpXwvPtXTb9b8C8wY?=
 =?iso-8859-1?Q?4hQjcfklaiG6QoVjF7FqSK2OJ5RMWqiabig/YY/oyC0rnlx0IHxatbaJGn?=
 =?iso-8859-1?Q?AUXTZWiX0f+NEByp662KGOIqm4eRohTE1ZYw/9ssSdd140ewQ7oBJ/Vs2n?=
 =?iso-8859-1?Q?Ftc0Aypz6h+Zcw23BBJLoGTzJY5I9e1ANoGMSwbiPDjL/2uu8WQfB6f2gO?=
 =?iso-8859-1?Q?TeIJnsyjCo3qH6IdUH6S3QsRTT5fPcKoBSVxaot1sSY7CEgL5avVjr/elQ?=
 =?iso-8859-1?Q?K3MzVRrleY1PEc6nHdG77JB7rFC6F9UAEA6WT6OAx4QGxvWcLqiaLlcQ+1?=
 =?iso-8859-1?Q?/1895LGCFQRKFsNZW4KONaNUsKEC9/5FpN73e3RIOh8wgnREGBVbY4Evmz?=
 =?iso-8859-1?Q?EZgHCvgbuMnCAtRWpCd6nqgIhlXmoKPERd4+Ym/AkpC1lzRcGM6hSri+Z3?=
 =?iso-8859-1?Q?4vH+CX4KzHTzmo92t/l1zJ0eUcGnUcB3Ng+FAmcOF1QRVonZVOVRFJywJ2?=
 =?iso-8859-1?Q?5XDqOIIyLFcGH6uciFzTuJB5VXcQh/kRBuXdFlkjqsZaBZU3V2MLPYxagc?=
 =?iso-8859-1?Q?QSuwLUUrpm33a1IarK/wyNwvRBhvO09VwIpWr8jYEsXe9j0afLelRPw4HH?=
 =?iso-8859-1?Q?QKoD+WD7Y295j8tact/kk0tL3zUJbK7nhnM4WVCN7IM0Trmtz232g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14363.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b8ff89-92f9-41fa-33cc-08df4a431bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 15:53:39.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14000

From: Keisuke Tsukuda <tkdkei@outlook.jp>=0A=
=0A=
get_pkey_options() returns -EINVAL for invalid protected key options,=0A=
such as "key_enc_algo=3DGG". trusted_caam_seal() and trusted_caam_unseal()=
=0A=
ignore this error and return 0. The trusted key core then instantiates=0A=
a key without a blob for "new", or with a zero-length key for "load".=0A=
=0A=
On an i.MX6Q running a 7.4.0-rc2-based kernel, adding a key with=0A=
"new 32 pk key_enc_algo=3DGG" succeeds, but KEYCTL_READ returns zero=0A=
bytes because no blob was created. The key cannot be saved and=0A=
reloaded.=0A=
=0A=
Return the parsing error from both paths. On the patched kernel,=0A=
"new" and "load" with "key_enc_algo=3DGG" both fail with -EINVAL, while=0A=
valid requests succeed.=0A=
=0A=
Fixes: a703a4c2a328 ("KEYS: trusted: caam based protected key")=0A=
Signed-off-by: Keisuke Tsukuda <tkdkei@outlook.jp>=0A=
---=0A=
 security/keys/trusted-keys/trusted_caam.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trus=
ted-keys/trusted_caam.c=0A=
index 6a33dbf2a..33000d7bb 100644=0A=
--- a/security/keys/trusted-keys/trusted_caam.c=0A=
+++ b/security/keys/trusted-keys/trusted_caam.c=0A=
@@ -110,7 +110,7 @@ static int trusted_caam_seal(struct trusted_key_payload=
 *p, char *datablob)=0A=
 		info.pkey_info.is_pkey =3D 1;=0A=
 		ret =3D get_pkey_options(datablob, &info.pkey_info);=0A=
 		if (ret < 0)=0A=
-			return 0;=0A=
+			return ret;=0A=
 		dump_options(&info.pkey_info);=0A=
 	}=0A=
 =0A=
@@ -142,7 +142,7 @@ static int trusted_caam_unseal(struct trusted_key_paylo=
ad *p, char *datablob)=0A=
 		info.pkey_info.is_pkey =3D 1;=0A=
 		ret =3D get_pkey_options(datablob, &info.pkey_info);=0A=
 		if (ret < 0)=0A=
-			return 0;=0A=
+			return ret;=0A=
 		dump_options(&info.pkey_info);=0A=
 =0A=
 		p->key_len =3D p->blob_len + sizeof(struct caam_pkey_info);=0A=
-- =0A=
2.50.1 (Apple Git-155)=0A=
=0A=
