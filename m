Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010011.outbound.protection.outlook.com [52.103.73.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8A38CFEF;
	Fri, 29 May 2026 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030503; cv=fail; b=dccIuPa644zOUkWlCZdRSlMeHco5uPsHHTj+yR4uq6zmAvBWmW8Mjd6esdWyneTAApxPO46unY+ZJV232CHmfkc5tjWI7/euyqpItRJP0wLpL1X8nDmG8sLJlDw67nUUCULmQdvZyDND/4RaNsIgrfZwAV5minawsn8IaCRST2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030503; c=relaxed/simple;
	bh=haQ3ik24LElYaQkUqCumt4PnaP5BenGcdVfnNA0OVtg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=akRJ5z+gleAPo4euzTWrmb0s/VjF/bWG29nakRc5OnHNazc3veM82aZHbicvcLe1ZLB0JiuPJ3LV2Zhtk3rP/6EV1SW7TM6R0WIl36Vf0nK22ZTjM0ZivDMfBCPypWVGaKobG7ctP2DOM6Zp/JdHsFdftKBb6RNpjR8fH/4eEEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c6QSs8OD; arc=fail smtp.client-ip=52.103.73.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c6QSs8OD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsnUTrWMZlPK7OF+AGgkXznTr0wQCfZeciiT5HSGyJ/BzHouKtyQ0ZqKb2Bma+InL2E12xJVmZXI/8BPAszkaVS9N5SJl321eMvHPTrXNirYsEe0AQZ5f3dFOXbwKqIy8+msTOaIHPNJHUmyTHGXmdQ5XAqivGt6tY6BL+LHO5YXcfHctE2Kdv6ZHOUYQcSoRxCc3yCPRgiJkAWLV3ov58+pwsFTITHT/BWOTnvyuUk+/E6WesipEt4aFFcPTBf1hnb3PqFSEnS10OvQ0ufRX2gD8uLZjAOskSlURv0rjfIZ+zMUnP8MAlFuUaI6QJa1VAHEedyp03tvlcSeeyDpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGsYKgtOm6MW89nmTbhp4mXiXM+H9baCJJJJjaGYKQk=;
 b=X5j3P1frhSRhcDLpWDOeWtT5xVZf12EzOv5nLMAp9RxvpCy2tAlvtaanPudRpug5scr+CyJQOIXdTQwzKgf4bTLwPGO6SM3H0RpUEnQVRbZRT4YfzCfLecQKEgR9txl1lGx52Sj6lqxPXnmtsQIJ6uuiXUC/rtloiE5o26uA7uaCNgsJWg5vNWEsE5Xwv31N0xt4w5/qeLhYLQ+NQ9gmORUS/TaDom7XyyRDku0VgiSYXLVTF+g4KLWWpzGMbUz5HCY+CNuNKT+gfzciPZc+QC87WrBbGehN2VUlmlnrGxOQJQO5cQBI8SgATNj4+DxLNXYd3JNOwuAUFHTWFI4oIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGsYKgtOm6MW89nmTbhp4mXiXM+H9baCJJJJjaGYKQk=;
 b=c6QSs8ODd+E21Lcf+xuppAXYoDberoUNjeSkmH+X2ZqCvhurFhi1bq3JPvb552mrzyBxaOrMegPSDp4xCVtprhrB8MPIMpG6vohZ/dMSX0S+5y0hbrW3JrfdA8mtzaiyl3GkyDbx651Tdw+16ckFIcpK7HPJcXWrJQ1FlGbOsh43NgCRktNWoB6z/teOztKymFeJSJy6zNAvj9LGQbdFqg9LzTsR/IVnLjy35kJnXpM/ILVA0mAh2A0cO96U+Em/pb6ccfOJr6O8hcHDgQuA8Y4bgCw8nMok2wwrgfzhJlS2ctPxy60z8grpAmAlYRYGTp7FbFcE/NpmoXnqeg1B6w==
Received: from ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::12)
 by SY7P300MB0588.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 04:54:53 +0000
Received: from ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
 ([fe80::40c:1bbb:6484:38c]) by ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
 ([fe80::40c:1bbb:6484:38c%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 04:54:53 +0000
From: Liu Mingyu <Edwardliu0214@outlook.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
CC: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biggers
	<ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, Mimi Zohar
	<zohar@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] keys: Enforce keep guard when moving keys
Thread-Topic: [PATCH] keys: Enforce keep guard when moving keys
Thread-Index: AQHc7ydJVu7ZEHqX90Gw0GA2lfel6w==
Date: Fri, 29 May 2026 04:54:52 +0000
Message-ID:
 <ME0P300MB0618CDE63E5F370D2790CDE9AA162@ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0618:EE_|SY7P300MB0588:EE_
x-ms-office365-filtering-correlation-id: ac0f815b-21d6-4e1f-ba77-08debd3e6bf6
x-ms-exchange-slblob-mailprops:
 gMiuAN0LASJuslsDKkdgU55RNSDSFMYZJ6kIic94OnO/KcWt+I0zLokbaTmcjaJsw5d8Mzp8sT9gDdiZMC68M4N6ZWnblgsPy1BgJs02keAmJIA4Z4pr0jMoISnzRbWpbZeMVuQBkRNBJ1avLs/Jh5RTWobxc60juYewxW8Abco6Nsdt2VKJ8W/SFtfHrlBv/b8DrqWukbI+yDobYH0AgOoCElWY5J+SoEZTuh13Q1dbpzDrdXXkFP5ady3dvJ92+Hc6OTFJ3YwNgdioKRzUbALWqYtJf5I6xnS/zq6VMZohr5g46ieaVovkHSEHllaw5UrXh2k+eIaZ28LCoxfCcjgy5UWTRv6ozVqyM57jcNV2Ux92aUgvZ8058/NiArIUCVq95nekNDuheVS60gjvU1FLw7A3CZFniAJx9V5atn5nJKieLnKmxU2CBGaFqUZ0ZULJ41dxGZ+QF48upXsOJaiF4ii82eFNAstpCYE1HSAN4FbPcIXrPOA8rjtgGYDcKCP2J1n3T/v25Tr1ZMi+5rhyk6i3JQUaOz0IVEUh2UsAN1JzYnbcKDzqrCQS9QLe55E2FMDhOSL38xawtfBWUEAvBKjXPEIexctf4/7gn555qfdx8VsIgqHujOZ5/BitewJTWsevbI/4DIaRiWXwNaHwFSH/v6Lw4UYjUyDr/PZmXhLvpe//spAFGRbGLrmjEpmPxJ/e3DAqEqQlgwc1rQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|24021099003|20031999006|39105399006|38102599003|12121999013|15080799012|31061999003|19110799012|8062599012|8060799015|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?o47FQASGdJZqfxPcYWPpBR0Do6pzSHMClaCa7JCLr9wRwui1NdwoABYemL?=
 =?iso-8859-1?Q?1E3Izh7cMEXSpR3H5KezofdiuRG658swFg5y8C5fXL0mQ22CJEpN9QY1jt?=
 =?iso-8859-1?Q?voJlbilzp2e02Zbyp5pvbFnIXkaEf5r+gz3dv9fZ+TcDk7UrS7hFwlalR8?=
 =?iso-8859-1?Q?duMYM49g4QQs/hWAtIB3sWcV0zHMf2vsgn3G9N93OozWDoSP4qm+de74dS?=
 =?iso-8859-1?Q?+Oy2JMLwrW8gzbwE102snw0tVkUKzh1ZXeffzWY5sFMB4vuo+ELzgMIEXO?=
 =?iso-8859-1?Q?FQrAVVpJN+hYpl44BvFlBTQL2N1uSWKi3I6tDiRtK14L9y5Q87JBab6NFb?=
 =?iso-8859-1?Q?O1sz9mNGJE3oiFdu4ZT7hk+ZAho1wUjNdcs4+Vz6bYB2LXGMp202NWreMF?=
 =?iso-8859-1?Q?Lw73cfy1yt9vUXWMSFhdLHCTGLaexlUqSwyHNbG0Smsxab5EDRd29JYpyB?=
 =?iso-8859-1?Q?yBu8BMFnexuyXmJ/osHexLFS06zvP5Y8Apgoz7q9czi13woSLBZKtpGhUF?=
 =?iso-8859-1?Q?VGCDbKc+ySCQDtmUYLHPqWjXAuWl0nnGSqdYQiCfuvMw7q/3tW45tWmPLo?=
 =?iso-8859-1?Q?44UJIpR1foM4/pZ+N6L95G8AXkqZ9mo4RBFL512oOoxejhu5ly2v0AddHq?=
 =?iso-8859-1?Q?MDvim9VTsoYx/n9mA1fwEVj6beBXiSpQjY3/flVS0+bGggUpXT3N1W0h9l?=
 =?iso-8859-1?Q?8vbippqgufbiI8YuRky94p7LrV6Gjxgi6ZkSWBqShEDe8I+KYv4hZ88FmF?=
 =?iso-8859-1?Q?/pwbBf1ymTXlTQqyB/zZOvZ5U3z1Hps7ixCwpczMdu24obEW5CA8Q6yA4n?=
 =?iso-8859-1?Q?iVBHnzwQerm1xzWIC7yVDavyiCR31OZv7sXQZ0++t8Ub6NUc9SzZrybGtn?=
 =?iso-8859-1?Q?ap7QZjYPhH1+BifRbyhrTFVZhEyrnIw3MgVoqVNcR2QQcyqhwRQPBplF3c?=
 =?iso-8859-1?Q?a6WK0d8KfnkDaFeaOtQa/ObiRxCJe08ecqBjpZIm7cUU0PaHvqquSrGPSu?=
 =?iso-8859-1?Q?mLWwrGETpfYLKMsfUUpueEXBHJ+FfEooZ+nLBZjQ7PyX24Wd2vV8j/ruP+?=
 =?iso-8859-1?Q?z3qz71ymDwHROW3C4IFd5HDESUdffd3+cgXToaDP1S/2?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gqI4etbSzeZSBY15/8aDYeTFBriJQ+wcegLBlzd5i38AInIIOG8Q/vAHvj?=
 =?iso-8859-1?Q?NgWpYNf2qeqX9SCw8uzdVj3haVohWVdgSNp6SpP9KSxVHkhIdCeLMawvVs?=
 =?iso-8859-1?Q?z0/xnT1V+oGCUZ5Zyjwmmw+YBCciqJ68WIExYADI8JErjMTzbQcdl6w9AT?=
 =?iso-8859-1?Q?8NIucHHmO6OXls+NWF+p4cKeDxIBb5EikftxE15ms+iuuWzAToFV+OhlWI?=
 =?iso-8859-1?Q?VJy3zjxqKAG8zrOfL5gyNd5ZRegNqhWxqNe8rEcptcYxEwtIiHOmd6oX+O?=
 =?iso-8859-1?Q?Oi2EzWvxOe1n2Lq7C2ItynMSHw+J5a33JUtRebo+PZJoEAk/7JU/C3H38o?=
 =?iso-8859-1?Q?vCb4Bh1vzL0kQzKPMFbn6xee58ew74RPoraJPxPy6xHgHlCIsYyRAFyZLf?=
 =?iso-8859-1?Q?K58VMPg8IJ+qZW3OCe/EJPOSStC5xNIEbQ453MvK5KxAvXit1204aMdIQ2?=
 =?iso-8859-1?Q?hAFxz9IsVlI7R0wTGp3m9m/yL7xltYOS7klIBUCxoscGDfByoL4q81N2yp?=
 =?iso-8859-1?Q?vpZRnA+2ZNHDsas37WFJCJpKAIRJ1oh4dd257/kGBYnS3M4tmi+sw/KCjM?=
 =?iso-8859-1?Q?ccpg/z1EicMSxwdnGkn0l0AF+Pj/mCO341OxwQh9S3+PYadcz/fZ/M1M4f?=
 =?iso-8859-1?Q?LDcJTMx7Q1GXjI75NrUDVGma3KU0ymcaFH/ke8wRBDR+xZA4hAZ7zklUnF?=
 =?iso-8859-1?Q?W+452rq4l/KfxGJA4FHiWx7+nSxC2yd/4Dq5y42Dxt09VHDz7XgWm+xk6j?=
 =?iso-8859-1?Q?eca6q0SLU1hoLiZ+hV2dxh/FjCeRH1w9uCKb4qeZ13cxGfUXX63H33Q2CV?=
 =?iso-8859-1?Q?feJPH+5qUYBzIGQcAr1Zhk6cVFifmilux+oCjlf+g8Te9ioJG+rEWsSucH?=
 =?iso-8859-1?Q?DbGOjwJgdjqXa4iZWimNV2bpDMhqqZ6y31E+KIMpPOktlAVbLawUzDd/ok?=
 =?iso-8859-1?Q?lj4cOSqv9VbMataeBK5ks7yDw11GJPUKV8XmO9JZx2bgsIzBIZOkVwrzVN?=
 =?iso-8859-1?Q?ngwk20MdV+XQgWzsnyOEogcpeGHvL3vYpROEmKJ5Iwxn+1iMP2l9fuJrqc?=
 =?iso-8859-1?Q?kXzfv9AnYqwEe7ecFI3SnNNa9KaeESOr5j+mA/HGL4Zj64eSQDMyQGwlTe?=
 =?iso-8859-1?Q?o4QZNdkSKksP/OLpPFzcRwKzsRgjF3o928dK7uP+ItrKq0EeyMh300xMnw?=
 =?iso-8859-1?Q?pYLAXoY42OmIq7u41xEzHnn/Zol7EhgroKzAPmPm1gnQg80MiA344WhfzP?=
 =?iso-8859-1?Q?vH2zwvy3BcbedSuRxulqu9ghGbHrjKjYuOVr6L8cMH/Qp9dZRCoXFBSJqr?=
 =?iso-8859-1?Q?s4LjAXsRvdifdBMFjH5pTQDH6GlbEOacUg1eY68j71C+f9n5WfpxAjoxWu?=
 =?iso-8859-1?Q?nJl4LwBjA6PAaWsHFRX+CkGnAgf5FIrSl0gmdSswL0BX7PulnlnbNSyzxx?=
 =?iso-8859-1?Q?yz4fzCk2vN3JsBkw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0f815b-21d6-4e1f-ba77-08debd3e6bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 04:54:52.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0588

KEYCTL_MOVE removes the source link as part of moving a key
between keyrings. key_unlink() rejects removal of a
KEY_FLAG_KEEP-protected key from a KEY_FLAG_KEEP-protected keyring,
but key_move() did not enforce the same rule.

Reject such moves with -EPERM when both the source keyring and key
are protected. Leave same-keyring moves as a no-op so callers can
continue to use KEYCTL_MOVE idempotently. Document the errno and add
KUnit coverage for the normal move, protected rejection and no-op paths.

Fixes: ed0ac5c7ec37 ("keys: Add a keyctl to move a key between keyrings")
Signed-off-by: Mingyu Liu <edwardliu0214@outlook.com>
---
 Documentation/security/keys/core.rst |   1 +
 security/keys/Kconfig                |  13 +++
 security/keys/Makefile               |   1 +
 security/keys/keyctl.c               |   2 +
 security/keys/keyring.c              |   7 +-
 security/keys/keyring_test.c         | 121 +++++++++++++++++++++++++++
 6 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 security/keys/keyring_test.c

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/=
keys/core.rst
index 326b8a973828..6096ce6c63da 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -600,6 +600,7 @@ The keyctl syscall functions are:
      A process must have link permission on the key for this function to b=
e
      successful and write permission on both keyrings.  Any errors that ca=
n
      occur from KEYCTL_LINK also apply on the destination keyring here.
+     If the key and source keyring are protected, EPERM will be returned.
=20
=20
   *  Unlink a key or keyring from another keyring::
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 84f39e50ca36..acffb5f7385c 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -129,4 +129,17 @@ config KEY_NOTIFICATIONS
 	  This makes use of pipes to handle the notification buffer and
 	  provides KEYCTL_WATCH_KEY to enable/disable watches.
=20
+config KEYS_KUNIT_TEST
+	tristate "KUnit tests for keyrings" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for keyring operations.
+	  These tests exercise keyring link and move behavior, including
+	  protection of KEY_FLAG_KEEP entries.
+	  They are intended for KUnit runs on developer kernels and are not
+	  needed for normal systems.
+
+	  If you are unsure how to answer this question, answer N.
+
 endif # KEYS
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 5f40807f05b3..fa583a4ea945 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SYSCTL) +=3D sysctl.o
 obj-$(CONFIG_PERSISTENT_KEYRINGS) +=3D persistent.o
 obj-$(CONFIG_KEY_DH_OPERATIONS) +=3D dh.o
 obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) +=3D keyctl_pkey.o
+obj-$(CONFIG_KEYS_KUNIT_TEST) +=3D keyring_test.o
=20
 #
 # Key types
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ef855d69c97a..b37bf1505ec5 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -590,6 +590,8 @@ long keyctl_keyring_unlink(key_serial_t id, key_serial_=
t ringid)
  * the caller Write permission.  There must also be a link in the from key=
ring
  * to the key.  If both keyrings are the same, nothing is done.
  *
+ * If the key and source keyring are protected, -EPERM will be returned.
+ *
  * If successful, 0 will be returned.
  */
 long keyctl_keyring_move(key_serial_t id, key_serial_t from_ringid,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5a9887d6b7be..60c184bd9a8d 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1582,7 +1582,8 @@ EXPORT_SYMBOL(key_unlink);
  *
  * Returns 0 if successful, -ENOTDIR if either keyring isn't a keyring,
  * -EKEYREVOKED if either keyring has been revoked, -ENFILE if the second
- * keyring is full, -EDQUOT if there is insufficient key data quota remain=
ing
+ * keyring is full, -EPERM if this would remove a protected key from a
+ * protected keyring, -EDQUOT if there is insufficient key data quota rema=
ining
  * to add another link or -ENOMEM if there's insufficient memory.  If
  * KEYCTL_MOVE_EXCL is set, then -EEXIST will be returned if there's alrea=
dy a
  * matching key in @to_keyring.
@@ -1608,6 +1609,10 @@ int key_move(struct key *key,
 	key_check(from_keyring);
 	key_check(to_keyring);
=20
+	if (test_bit(KEY_FLAG_KEEP, &from_keyring->flags) &&
+	    test_bit(KEY_FLAG_KEEP, &key->flags))
+		return -EPERM;
+
 	ret =3D __key_move_lock(from_keyring, to_keyring, &key->index_key);
 	if (ret < 0)
 		goto out;
diff --git a/security/keys/keyring_test.c b/security/keys/keyring_test.c
new file mode 100644
index 000000000000..0055b50224e9
--- /dev/null
+++ b/security/keys/keyring_test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * KUnit tests for keyring operations.
+ */
+
+#include <keys/user-type.h>
+#include <kunit/test.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/key.h>
+#include <linux/key-type.h>
+#include <linux/keyctl.h>
+#include <linux/module.h>
+#include <linux/uidgid.h>
+
+static void keyring_test_key_put(void *data)
+{
+	key_put(data);
+}
+
+static struct key *test_keyring_alloc(struct kunit *test, const char *desc=
,
+				      unsigned long flags)
+{
+	struct key *keyring;
+
+	keyring =3D keyring_alloc(desc, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				current_cred(), KEY_POS_ALL | KEY_USR_ALL,
+				KEY_ALLOC_NOT_IN_QUOTA | flags, NULL, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, keyring);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							keyring_test_key_put,
+							keyring), 0);
+
+	return keyring;
+}
+
+static struct key *test_user_key_alloc(struct kunit *test, const char *des=
c,
+				       struct key *keyring,
+				       unsigned long flags)
+{
+	static const char payload[] =3D "payload";
+	struct key *key;
+	int ret;
+
+	key =3D key_alloc(&key_type_user, desc, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			current_cred(), KEY_POS_ALL | KEY_USR_ALL,
+			KEY_ALLOC_NOT_IN_QUOTA | flags, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, key);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+							keyring_test_key_put,
+							key), 0);
+
+	ret =3D key_instantiate_and_link(key, payload, sizeof(payload),
+				       keyring, NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return key;
+}
+
+static void keyring_move_user_key(struct kunit *test)
+{
+	struct key *from, *to, *key;
+	int ret;
+
+	from =3D test_keyring_alloc(test, "move-from", 0);
+	to =3D test_keyring_alloc(test, "move-to", 0);
+	key =3D test_user_key_alloc(test, "move-key", from, 0);
+
+	ret =3D key_move(key, from, to, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret =3D key_move(key, to, from, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static void keyring_move_keep_key_fails(struct kunit *test)
+{
+	struct key *from, *to, *key;
+	int ret;
+
+	from =3D test_keyring_alloc(test, "keep-from", KEY_ALLOC_SET_KEEP);
+	to =3D test_keyring_alloc(test, "keep-to", 0);
+	key =3D test_user_key_alloc(test, "keep-key", from, 0);
+
+	KUNIT_ASSERT_TRUE(test, test_bit(KEY_FLAG_KEEP, &from->flags));
+	KUNIT_ASSERT_TRUE(test, test_bit(KEY_FLAG_KEEP, &key->flags));
+
+	ret =3D key_move(key, from, to, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EPERM);
+
+	ret =3D key_move(key, to, from, 0);
+	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
+}
+
+static void keyring_move_keep_same_keyring(struct kunit *test)
+{
+	struct key *keyring, *key;
+	int ret;
+
+	keyring =3D test_keyring_alloc(test, "keep-same", KEY_ALLOC_SET_KEEP);
+	key =3D test_user_key_alloc(test, "keep-same-key", keyring, 0);
+
+	ret =3D key_move(key, keyring, keyring, 0);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+}
+
+static struct kunit_case keyring_test_cases[] =3D {
+	KUNIT_CASE(keyring_move_user_key),
+	KUNIT_CASE(keyring_move_keep_key_fails),
+	KUNIT_CASE(keyring_move_keep_same_keyring),
+	{}
+};
+
+static struct kunit_suite keyring_test_suite =3D {
+	.name =3D "keyring",
+	.test_cases =3D keyring_test_cases,
+};
+
+kunit_test_suite(keyring_test_suite);
+
+MODULE_LICENSE("GPL");

base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
--=20
2.51.2.windows.1

