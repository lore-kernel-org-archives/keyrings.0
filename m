Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011031.outbound.protection.outlook.com [52.103.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F93438A8;
	Sun, 31 May 2026 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780260714; cv=fail; b=mP0o22LcGnafIf35rvidASgXtdxvf7ECGUptpVyBrjrMEAHjbt+6YL5P6tB4oEU6ErO+JPx3goMxJvkvIxgcxCW0DovVOI6lUUAiKRGYRwxwFQxHGMlwV0CH7zljXYQynHH6p63865GPMMAwQRbgRJGTfRhR3Gy0GtmhLA0MmmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780260714; c=relaxed/simple;
	bh=woHBLWWaUtQAntiuDiGR+ZJ+68QJuqQHdQVHyoP1yAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fNh8xWYHnPygUjgwCf5glLAFbdIttxFjABMdyPt8U1wkFjVeVLZfB35Dld9EA9AsyOua85UlvzRG8KS6/OzFI0JOOWssKcktCV0JxLs/vb472ZLSvG+ln5kDIMg8uPyE0wbcrEjnOOdOhg9XMNjFpOaaMT0Bvpam0SiIIyujZr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HqByfeRo; arc=fail smtp.client-ip=52.103.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HqByfeRo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a76vnoFFa9fE8cvkmDx1lGogad7+A8c32XTQ7K+WNToIebxarQBk/xSNJ4KakhX5muHbkeR3ODEiHn1YmjfKOxkc5L9Ej5AuaGubxDlnjWVKE2+Rso4a62gHNNP6cuERO4Aywo6M+t/KYp9eCvLmEiDjfMSOxVkpscUQtqWTzdDjufUfoiUNkMRxGfrBvqyCWHDHtKhjGqQXQ0Q0n8ZL0V8SBybBsm5cZ+ePH5V/8k52jsDzv4LEXCZyTkUpE1YV2LReFz0Sa0oYe0oRgnjgb29kWhHtoR7hhJw4FypQCwWl8rhiBs79qQ8VhTNWRYi9iOBCDhheCG3JXqllEZc7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woHBLWWaUtQAntiuDiGR+ZJ+68QJuqQHdQVHyoP1yAA=;
 b=IWI/ex+sYkFsF1Eg1D3exqMTQyAvRl2irwyMrX1sUB6Lq3RnqN/sG1XAR/PqHeF7aEAuevkUXI9dJQdaBlP1C5loXioeVoSwXx7ebEsM3/yM0ulTBvCPfT/2DTmW5kLRhNFbzmYkykE8rh+uOzt+TJE47EFlNY53lN6w7b08txIhP88VitQ58MKmYUAkkxZ2OYIhkpa2GF6RD5vuNG+Wjaj7LX8dpdbVnYkVX0X+rhst69a0ZfZivg6Qdr98FSsnD+FlEWtSNYZvMXE/OdpjPm2yI1WROi71cB9kfmZTLqxpgNLjH395EWWf+7QtEa30Y79CSdrXJDUtnpOZK0NJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woHBLWWaUtQAntiuDiGR+ZJ+68QJuqQHdQVHyoP1yAA=;
 b=HqByfeRofCWfFJ2Zrc3g6QqEGX/hIgf4aOYs6YWQ+8HcHcFmIPP0+ZDeh+m2Fmrjx5kKC/notORxSZhPwasA/er7DAcvNIXncAweWsHhQP8DxhF0z6JMtQwk41ecqLu7yABDdlwOcxsjmkVuDXdrC/UtMyeRGOnuqjBqy1EwL8FHsZ+OgHrTZYyds9ExRcs+Ao7JDfhwBRyW2/+1oWmhmDHww46nQpqCkW76mxoGCAr1b3Jh9LEHq2nt0CM1X07vVZ4xj8n8RAiyUDd+tV0yK8+be/NlP0Z3h5e/jTFIopun8LLcdRJGd39qj0TjhOa6DVns9iGJlw3wJU4WC5kyCg==
Received: from ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::12)
 by SY8P300MB0252.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:265::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Sun, 31 May
 2026 20:51:49 +0000
Received: from ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
 ([fe80::40c:1bbb:6484:38c]) by ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
 ([fe80::40c:1bbb:6484:38c%6]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 20:51:49 +0000
From: Liu Mingyu <Edwardliu0214@outlook.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
CC: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biggers
	<ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, Mimi Zohar
	<zohar@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/2] keys: Enforce keep guard when moving keys
Thread-Topic: [PATCH v2 1/2] keys: Enforce keep guard when moving keys
Thread-Index: AQHc8T9Nz7kg76WGQUaSkw/c42Z5Qw==
Date: Sun, 31 May 2026 20:51:49 +0000
Message-ID: <20260531205059.mliu-keyrings-v2-1@outlook.com>
References: <20260531205059.mliu-keyrings-v2-0@outlook.com>
In-Reply-To: <20260531205059.mliu-keyrings-v2-0@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0618:EE_|SY8P300MB0252:EE_
x-ms-office365-filtering-correlation-id: 7009ae8b-994d-4168-4acc-08debf566fb6
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|24021099003|12121999013|38102599003|41001999006|8060799015|15080799012|8062599012|19110799012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUJGSENoY1RQTWhoaWV4eDl2RlBRc05KcjJOaXZzUnBRZnIwc3NvMEhwdXk5?=
 =?utf-8?B?TmxPY0ZudkxzMDFQR3g3Vm9hcjE3N1Z3VFk1RGFqeHpPRjdyaWxjVWRIRklw?=
 =?utf-8?B?bUd6WHAxSWV4ZFRrdzZxeGdra0RGRVk5ZnIrUWxaVkxkZjgwSXpmY2ZyNlRu?=
 =?utf-8?B?RUVJUmhQcFNkT3hyWU1lcW1ScllpQXJtVWRjUmdyYmFrN3h6V2JMak0zb1pv?=
 =?utf-8?B?ZStlQzNDNm9XN2lmSFljNTcrT1pZQWl1TlJzdXRsK0pORDFmTUtmcjRQRnJk?=
 =?utf-8?B?S0RyMXlhUUpKRGd1bWlYNFJobW9lN3R0WWNqUDR5cEEwKzN5L3FhS2Yyd3dt?=
 =?utf-8?B?WUQvaDhPZmxhVjIzVTNySTk5U3piTTRzYTNHYmdpSVg3M3dVMUs5SjFRYTV2?=
 =?utf-8?B?SzljdTVFZTNsemoyV0hTOVlCK2toamRMSkxYdHh2aGkrQytpVG5WYVZLenFW?=
 =?utf-8?B?T0VMVzRyd01taWZkbnpyNy80eXB5YkhLQ2ZLMUgxMldBc0pad3JmenlYbEtY?=
 =?utf-8?B?TlRQeWg0QWxFMkg4bTRHSGpqUElIRHFuNDRNOFFvMmVPSzNXbzJLZEZuUUZh?=
 =?utf-8?B?WVNaMlpBemtYWVlwWE9uUklaemlPbUxFV3R4RGtKODEwR1RYUmZqWHZqTFg0?=
 =?utf-8?B?RStsWHphSUhPMFhhdkFRV3U0V3FFeU14UlpYWVR6OEpGQkZkT1JSZTVmRlNo?=
 =?utf-8?B?azIyMWFGNHcvdlVBS3pxbkpNK1BQWTA1M1hvNkZ3VzlBMjMzOENjUWJpcHND?=
 =?utf-8?B?L0tZM1ArZnZMYzR0Rjh2L3FROU9CNDhRK2phcFNiMlBHUXhibmF6ZVBiNEJG?=
 =?utf-8?B?NkNiRFhFbzJ5YkFNcXpycDVhRklxRFQwTkFQN1MzWXRWVEgraUpKY0lEMVdE?=
 =?utf-8?B?MjNGMWh2dFZQd1ArTDRpY2VSeGpQZkwwT0w1T1lxUUlzR0Z0R1pMTlZNUElr?=
 =?utf-8?B?SGI2Sm5VMnc3M2p1dGRMMFNjVzZwakd2OHRJcHl3RnFoMW9nSHpVZWtIdlBy?=
 =?utf-8?B?TjBxM0NXVkdnQndRTzNNazBEVCs1RU5KZHRJQTA4cEwwSVZWdk4yc1FyMG84?=
 =?utf-8?B?bjJXeEtyQlJEL0JMbzdINEtjZzRPelJXRElXQXZCQjhxZU1jZTU1SUxXbmxv?=
 =?utf-8?B?OTVob0ZXTE96M1BxMFE0QXpUN1ViT0I3SlRhYkpTelpTYU9nWTNBOEhQRVJD?=
 =?utf-8?B?NWhjZEdONkdXWm5nQVZHbEl2cEJCRXBOWUZQZW1zM1RBN091d0J1WE91ZXhY?=
 =?utf-8?B?aWNPdndBbDBudVc1U1NWZytwRDJNSGx6WktPc0VzcDM5TlllY2FMZVhuenNy?=
 =?utf-8?B?Q2d1TzFWQWIrOGEzb2VxcWczMkE1TkJtY1JPOFRLMU85SDE3dGg1bldHbUpD?=
 =?utf-8?Q?0xtIGbUwG7Udj5/W+Awi0aIq6OGC7XzA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WS90VUh2RUZsOEszb0Noc1NvSzJldy9qcGZieUY3TFRIUElDdk1tWVM0czRB?=
 =?utf-8?B?NGMvRXZwMXhRbDRMR3E1a2FGNUtZbWQ5bm5zY0tkenp5eVExRm9kQmpVR0JY?=
 =?utf-8?B?K1lDN1VYQWFkNDJxUXl3dThKL1llZm5BZG5PclZMcEMrZGowbTJxSmtpekY5?=
 =?utf-8?B?Qll1am53Z1VQV0lka1hJeTB0YVN0TFdyUy9IR1VMSE9RYlJ1S2hZL3FTcXkz?=
 =?utf-8?B?cHJOMXJ0bDY5VW9zaUd6dVFFZ0RiN0NSUmdmRGd5WlJkYmZmTUUxbHVlMEZE?=
 =?utf-8?B?Q3oybUZjUUtVTlNhUENYbklkU1c0bFhra2JhMm8rR3RJYWhyVW9lVUFkeCtN?=
 =?utf-8?B?TEdoTWx3ZmN6Sm1aVHVnbmtxazBGQUtZamoxWVJDSzVvdkNZNCt0aXpEQlpZ?=
 =?utf-8?B?UWtPZWcvMVVlYlZEbGJJTWlxYmFQL2gyVzJ3SC9sNkJEcjJReWhyRk5yOExy?=
 =?utf-8?B?dndXM1psU2NSaFNPd0FuNktLRUg1Nld1ck45dXpPK0RJZVhYcWszaDFmNnBF?=
 =?utf-8?B?VEx6Sy92ZWdVK3hyT0lLbEdWUHo4WUNvd1NyL0RwY1lXRXh3N0E2a1pjbjlW?=
 =?utf-8?B?WDQ1NkloUjFyejZDV1JxUU9tbHdLTWs1dGRoSDRNK3l3Z3VZRjdhNTQ2QzRz?=
 =?utf-8?B?cHdLcE8wL3FrT0R4b1VEdVYzQnV4NEZ4UzdIeEYydnVvN1NyMGd1NnRWdVlP?=
 =?utf-8?B?VE5LSFI4TXRSNlZ4bGN4ZlQ1ODNNTVIwN0lLL1dWQnRCT3owdldXbUhsd2Vz?=
 =?utf-8?B?VTRSbXJWeVVOSDQyU3lzSVpleGtlelB6a3lWRXM4OU5CZEVDWmk5QXN1NEt3?=
 =?utf-8?B?R1hJOU02aElTUzd1THBtUHlUNHMvUzgwZVJQSEpJNW9wQ0wweTRMaFNWaXVD?=
 =?utf-8?B?WStqalcvU2tjVktrdTlqOTJDcGxLTkM0b29lZVpKdDZ5cEFSdlU1WFcwQ2pr?=
 =?utf-8?B?YW9RcUJUbytuWDU4RzMwaXFqS0VKVEovY2hkSW9BNXM4K3pJZkJnVTRtM0xs?=
 =?utf-8?B?THpjK25CdkJrb1hNUWxSUHZPK205aEdMbVZpRGl4ZVRqdzk5SWRGM24yVnlI?=
 =?utf-8?B?cnpIYk9hSkJvdXk3R01vQlg5WWdsQm5yZldmVVlrN2kzY3RkNjNhN1JNaDhF?=
 =?utf-8?B?ZExtZzhYcm9hRGtabWxjQUoydHQ0cXdXRXBtUFRKL09CeDJ3ZTBnTTZ2Q0NJ?=
 =?utf-8?B?UUw1KzVGeW8rbGQ2Q3AxdFBuekppNXlsMUROcHFCb3Y0enZPOUNvZUNUUFh2?=
 =?utf-8?B?WFVFNmFkZW1HRmpmSk9kbnVkQTBIVCtnM0tBdnNvTTFTVGlxazlMRTZwRGxC?=
 =?utf-8?B?WSsvdlBPZEJJb2pUc21ac3REbmdVVys3MGF0ZDZHT0VZZzlVa3RwYlVRYjZm?=
 =?utf-8?B?UUZqRkhTYjB2ODJPOFlHWWRROXFKWGRQVDRNKzRvcG1vNjJMZktQSzRzUVhE?=
 =?utf-8?B?OXV6L29yeXJxSGM0MTFtVm5PaXRiTEc5SXpzZ25pVnEwaUZ0d1R4RXVjL1lV?=
 =?utf-8?B?VDFtUTBhUS9veTNpNlhMc3ZPenhHZ1c4TW5oVldDOVNQVXZEcUpBYW9BUWNt?=
 =?utf-8?B?dFViUStXRjlSc25HdFgvWFFlN256UFQ2SGVLUW9mUW5QKzVSR0tJTmp2VXZI?=
 =?utf-8?B?Zk1HYm9YUjlqUW1LamQ2eTVrV3Z4ZzF5ZHVna0VZaC9YRCs3amhIcmx4REhx?=
 =?utf-8?B?OTcwMUZJUmNLWnhFbnVTNGE0azhhQllvSldITzdwcEV5YVYrMDhCM08ydzFz?=
 =?utf-8?B?a1R6ZWZSVHExS1ZidDVoQVBjRDdvNVk1bkZEa1haY2huWnJzUGJaQjRuUklF?=
 =?utf-8?B?RWo3VHBTSmdjbUJLRHhXbXY3d0xjTUROd1hOS1ovN2tveWhUYXM4LzEvMEtj?=
 =?utf-8?Q?Qe4yjzQllwUKM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15852B0736284C46AF7DA17CB277DD7A@AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7009ae8b-994d-4168-4acc-08debf566fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 20:51:49.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0252

S0VZQ1RMX01PVkUgcmVtb3ZlcyB0aGUgc291cmNlIGxpbmsgYXMgcGFydCBvZiBtb3ZpbmcgYSBr
ZXkNCmJldHdlZW4ga2V5cmluZ3MuIGtleV91bmxpbmsoKSByZWplY3RzIHJlbW92YWwgb2YgYQ0K
S0VZX0ZMQUdfS0VFUC1wcm90ZWN0ZWQga2V5IGZyb20gYSBLRVlfRkxBR19LRUVQLXByb3RlY3Rl
ZCBrZXlyaW5nLA0KYnV0IGtleV9tb3ZlKCkgZGlkIG5vdCBlbmZvcmNlIHRoZSBzYW1lIHJ1bGUu
DQoNClJlamVjdCBzdWNoIG1vdmVzIHdpdGggLUVQRVJNIHdoZW4gYm90aCB0aGUgc291cmNlIGtl
eXJpbmcgYW5kIGtleQ0KYXJlIHByb3RlY3RlZC4gTGVhdmUgc2FtZS1rZXlyaW5nIG1vdmVzIGFz
IGEgbm8tb3Agc28gY2FsbGVycyBjYW4NCmNvbnRpbnVlIHRvIHVzZSBLRVlDVExfTU9WRSBpZGVt
cG90ZW50bHkuIERvY3VtZW50IHRoZSBlcnJubyBzbw0KY2FsbGVycyBjYW4gZGlzdGluZ3Vpc2gg
dGhlIHByb3RlY3RlZCByZW1vdmFsIGNhc2UuDQoNCkZpeGVzOiBlZDBhYzVjN2VjMzcgKCJrZXlz
OiBBZGQgYSBrZXljdGwgdG8gbW92ZSBhIGtleSBiZXR3ZWVuIGtleXJpbmdzIikNCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBNaW5neXUgTGl1IDxlZHdhcmRsaXUw
MjE0QG91dGxvb2suY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL2NvcmUu
cnN0IHwgMSArDQogc2VjdXJpdHkva2V5cy9rZXljdGwuYyAgICAgICAgICAgICAgIHwgMiArKw0K
IHNlY3VyaXR5L2tleXMva2V5cmluZy5jICAgICAgICAgICAgICB8IDcgKysrKysrLQ0KIDMgZmls
ZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL3NlY3VyaXR5L2tleXMvY29yZS5yc3QgYi9Eb2N1bWVudGF0aW9uL3Nl
Y3VyaXR5L2tleXMvY29yZS5yc3QNCmluZGV4IDMyNmI4YTk3MzgyOC4uNjA5NmNlNmM2M2RhIDEw
MDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL2NvcmUucnN0DQorKysgYi9E
b2N1bWVudGF0aW9uL3NlY3VyaXR5L2tleXMvY29yZS5yc3QNCkBAIC02MDAsNiArNjAwLDcgQEAg
VGhlIGtleWN0bCBzeXNjYWxsIGZ1bmN0aW9ucyBhcmU6DQogICAgICBBIHByb2Nlc3MgbXVzdCBo
YXZlIGxpbmsgcGVybWlzc2lvbiBvbiB0aGUga2V5IGZvciB0aGlzIGZ1bmN0aW9uIHRvIGJlDQog
ICAgICBzdWNjZXNzZnVsIGFuZCB3cml0ZSBwZXJtaXNzaW9uIG9uIGJvdGgga2V5cmluZ3MuICBB
bnkgZXJyb3JzIHRoYXQgY2FuDQogICAgICBvY2N1ciBmcm9tIEtFWUNUTF9MSU5LIGFsc28gYXBw
bHkgb24gdGhlIGRlc3RpbmF0aW9uIGtleXJpbmcgaGVyZS4NCisgICAgIElmIHRoZSBrZXkgYW5k
IHNvdXJjZSBrZXlyaW5nIGFyZSBwcm90ZWN0ZWQsIEVQRVJNIHdpbGwgYmUgcmV0dXJuZWQuDQog
DQogDQogICAqICBVbmxpbmsgYSBrZXkgb3Iga2V5cmluZyBmcm9tIGFub3RoZXIga2V5cmluZzo6
DQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva2V5cy9rZXljdGwuYyBiL3NlY3VyaXR5L2tleXMva2V5
Y3RsLmMNCmluZGV4IGVmODU1ZDY5Yzk3YS4uYjM3YmYxNTA1ZWM1IDEwMDY0NA0KLS0tIGEvc2Vj
dXJpdHkva2V5cy9rZXljdGwuYw0KKysrIGIvc2VjdXJpdHkva2V5cy9rZXljdGwuYw0KQEAgLTU5
MCw2ICs1OTAsOCBAQCBsb25nIGtleWN0bF9rZXlyaW5nX3VubGluayhrZXlfc2VyaWFsX3QgaWQs
IGtleV9zZXJpYWxfdCByaW5naWQpDQogICogdGhlIGNhbGxlciBXcml0ZSBwZXJtaXNzaW9uLiAg
VGhlcmUgbXVzdCBhbHNvIGJlIGEgbGluayBpbiB0aGUgZnJvbSBrZXlyaW5nDQogICogdG8gdGhl
IGtleS4gIElmIGJvdGgga2V5cmluZ3MgYXJlIHRoZSBzYW1lLCBub3RoaW5nIGlzIGRvbmUuDQog
ICoNCisgKiBJZiB0aGUga2V5IGFuZCBzb3VyY2Uga2V5cmluZyBhcmUgcHJvdGVjdGVkLCAtRVBF
Uk0gd2lsbCBiZSByZXR1cm5lZC4NCisgKg0KICAqIElmIHN1Y2Nlc3NmdWwsIDAgd2lsbCBiZSBy
ZXR1cm5lZC4NCiAgKi8NCiBsb25nIGtleWN0bF9rZXlyaW5nX21vdmUoa2V5X3NlcmlhbF90IGlk
LCBrZXlfc2VyaWFsX3QgZnJvbV9yaW5naWQsDQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva2V5cy9r
ZXlyaW5nLmMgYi9zZWN1cml0eS9rZXlzL2tleXJpbmcuYw0KaW5kZXggNWE5ODg3ZDZiN2JlLi42
MGMxODRiZDlhOGQgMTAwNjQ0DQotLS0gYS9zZWN1cml0eS9rZXlzL2tleXJpbmcuYw0KKysrIGIv
c2VjdXJpdHkva2V5cy9rZXlyaW5nLmMNCkBAIC0xNTgyLDcgKzE1ODIsOCBAQCBFWFBPUlRfU1lN
Qk9MKGtleV91bmxpbmspOw0KICAqDQogICogUmV0dXJucyAwIGlmIHN1Y2Nlc3NmdWwsIC1FTk9U
RElSIGlmIGVpdGhlciBrZXlyaW5nIGlzbid0IGEga2V5cmluZywNCiAgKiAtRUtFWVJFVk9LRUQg
aWYgZWl0aGVyIGtleXJpbmcgaGFzIGJlZW4gcmV2b2tlZCwgLUVORklMRSBpZiB0aGUgc2Vjb25k
DQotICoga2V5cmluZyBpcyBmdWxsLCAtRURRVU9UIGlmIHRoZXJlIGlzIGluc3VmZmljaWVudCBr
ZXkgZGF0YSBxdW90YSByZW1haW5pbmcNCisgKiBrZXlyaW5nIGlzIGZ1bGwsIC1FUEVSTSBpZiB0
aGlzIHdvdWxkIHJlbW92ZSBhIHByb3RlY3RlZCBrZXkgZnJvbSBhDQorICogcHJvdGVjdGVkIGtl
eXJpbmcsIC1FRFFVT1QgaWYgdGhlcmUgaXMgaW5zdWZmaWNpZW50IGtleSBkYXRhIHF1b3RhIHJl
bWFpbmluZw0KICAqIHRvIGFkZCBhbm90aGVyIGxpbmsgb3IgLUVOT01FTSBpZiB0aGVyZSdzIGlu
c3VmZmljaWVudCBtZW1vcnkuICBJZg0KICAqIEtFWUNUTF9NT1ZFX0VYQ0wgaXMgc2V0LCB0aGVu
IC1FRVhJU1Qgd2lsbCBiZSByZXR1cm5lZCBpZiB0aGVyZSdzIGFscmVhZHkgYQ0KICAqIG1hdGNo
aW5nIGtleSBpbiBAdG9fa2V5cmluZy4NCkBAIC0xNjA4LDYgKzE2MDksMTAgQEAgaW50IGtleV9t
b3ZlKHN0cnVjdCBrZXkgKmtleSwNCiAJa2V5X2NoZWNrKGZyb21fa2V5cmluZyk7DQogCWtleV9j
aGVjayh0b19rZXlyaW5nKTsNCiANCisJaWYgKHRlc3RfYml0KEtFWV9GTEFHX0tFRVAsICZmcm9t
X2tleXJpbmctPmZsYWdzKSAmJg0KKwkgICAgdGVzdF9iaXQoS0VZX0ZMQUdfS0VFUCwgJmtleS0+
ZmxhZ3MpKQ0KKwkJcmV0dXJuIC1FUEVSTTsNCisNCiAJcmV0ID0gX19rZXlfbW92ZV9sb2NrKGZy
b21fa2V5cmluZywgdG9fa2V5cmluZywgJmtleS0+aW5kZXhfa2V5KTsNCiAJaWYgKHJldCA8IDAp
DQogCQlnb3RvIG91dDsNCi0tIA0KMi41MS4yLndpbmRvd3MuMQ0KDQo=
