Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011031.outbound.protection.outlook.com [52.103.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF33321AA;
	Sun, 31 May 2026 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780260713; cv=fail; b=u6jrXur6eHPi33il7UfNitJGMx6dJHhH09hbt9w6JR9goWmzVlONj5UgIZrqbL3W8MEy14n8JSSeY8bG2uVegvroQvL9Mf4ZMDa2qrYXsonHKR015G+/P06BnVjNeuBLU2sbdLGUOZcGtqAGGVzIW1HapD51kXTR2kxncP+DmTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780260713; c=relaxed/simple;
	bh=qoT6Svs0tBn9tFRS/prKEWju4JslPcexf0h47sO2JIg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JfFJVw6OB99qNgFoHleYFfIhEdeQ5aJcmaoOPWA+KvCSAasQ0r3W3eFf1wt1cMhgdkPmVNXGNfodlrJ7Vi5HlpvKBgMb7KOvkZAeU5j4N7hl8m/Gba46Uilbx65F93kea715zz6q4Mm/IHfN0U+1E/oVJW9vc1ON9J9XQeMy4j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hVMfffAc; arc=fail smtp.client-ip=52.103.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hVMfffAc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eludDq3o570bq8AGtpv2MhkQs2sEIoln+RCd8G+NHqlz0YSGnwN9S6a9qNNZ3SQyBgy0vmzh6WBhumpEAlcOrtYGIc0YT/fK73lHcsKcOc4kyRctKV2rouwoIsLhslEl8hZ0YwtDXmCbxi45SqCac70R9FwW2kSUJgUckK3V2ZdAKG2RTrWegGN3A8N5IjjzQ0ePg5k69NGUK+sTHe7BLH6QSbuvcsmGoL4kgwAO7GDbvFiJJ0M0a8uWamllMw26SbjJqCTAGhbONlz6EaW8F7RoXfPCfc0FSyecQL6ZeahADhkMsLnkDemhRTDwrvh7+a7NVpCEK6fajoooyUSdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoT6Svs0tBn9tFRS/prKEWju4JslPcexf0h47sO2JIg=;
 b=UWWg3DpGn8JH+pFHNCQ3J2vRiBO0obZoW4b/7phUdANjdHMfZFqKN1ey2YU+jdWzeVzelOLXhi20vl57UPZZGZ2N/BKGHW4od3LmsgntHHRTSJwGMZeCT7LxBn0to5Kj9ekq6m8yTKjqPw3nOOLhm6UpvVQ4iqIoycw1NfonP3MSjuAXZ7exusBGEtoSylfxLLdroYiMsAVdEWKNPGkgyenLOCtMfo62rfIa4twq+6ZsiCoT+i6AYChymKfZaTLp4cfOdwyGco8kTfwHhUjfkbNX0XEW7M6qhVGTAbTdW/4xdUASORNTIWFvSjyqYxkOvZic1gbiG7VkQzOxntLOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoT6Svs0tBn9tFRS/prKEWju4JslPcexf0h47sO2JIg=;
 b=hVMfffAcOPuKB0seBBxTgsjT8599crtGIdu48Mrm6Bpg9kEMvdFelnVRPk4HNsiLPZ3l2ihEUr3+vZKe6Wn7Xh72AMlkQI64iOvYpavr/tVz5QBLNgWrB70DhQ8X8tAi+eDU4YnVGmTyozLXrzySHMaO8CIZLfJpK9KDKKx1ucgXNBRvGLF7tE5IGnRtjy3y2TBcxA+CRqMJY12rgzoZIAQkwkfV1gIuJKfRwW+N34qvxW1Znjao0At0EYWYO56NFTPzr2p+Anm20rkN9oAK3s5jMcccTAXyZjYGEVhO6uc0J2Z8OS/yI4AKNgFJgoGknghM7pNIjYbewssgrqPrUA==
Received: from ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::12)
 by SY8P300MB0252.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:265::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Sun, 31 May
 2026 20:51:47 +0000
Received: from ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
 ([fe80::40c:1bbb:6484:38c]) by ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM
 ([fe80::40c:1bbb:6484:38c%6]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 20:51:47 +0000
From: Liu Mingyu <Edwardliu0214@outlook.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
CC: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biggers
	<ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, Mimi Zohar
	<zohar@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/2] keys: Enforce keep guard when moving keys
Thread-Topic: [PATCH v2 0/2] keys: Enforce keep guard when moving keys
Thread-Index: AQHc8T9LJ0AlEuBDZEiXPxb/KKaYDQ==
Date: Sun, 31 May 2026 20:51:46 +0000
Message-ID: <20260531205059.mliu-keyrings-v2-0@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0618:EE_|SY8P300MB0252:EE_
x-ms-office365-filtering-correlation-id: fe0cf82f-dd66-4a3a-40f8-08debf566e35
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|24021099003|38102599003|41001999006|8060799015|15080799012|8062599012|19110799012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bE83U3VURGJRaTNuMExKZ1lPdng4WmtpaGw5K3RGbUNPU08zRFpQbkJNdXZT?=
 =?utf-8?B?djl0ZEVQd1d2L0V2anZmQU1ZSzRiNW9YdUxORllpMU8wY0RJMkM2Y0dRMXNo?=
 =?utf-8?B?ZUtlOTBTVXo3azM3cGxXZW9MMjdsQXg5ZUs3ODhRQytVT3Q2Z3V2MWpFSG1i?=
 =?utf-8?B?M0hPWVZwcFdFdStVd3haUlJWUWlJUlJ0ajNTbjYvazhQa3ZBMVNwUE9GL0tw?=
 =?utf-8?B?RmloZjlQNWZBY2puM1NPTWNyOC93M1dvbkNscG13UkErMXdSNVU5OTZvcUJk?=
 =?utf-8?B?ditoNzZRUU52V1ZDNTRNNjVQZXpyZlNZT290M1FoRlFHQ29LUDlvMnM5RVJ3?=
 =?utf-8?B?UHhkWVZWVDVVNUJoWDAxSHpxMFVmbkEvZkFEMnh3NldwdWdTQ0VYMlFrRUhC?=
 =?utf-8?B?eGZ6d0NXZ0ljOHNGRzNZZ3hrSTRGNkIvaEpTcGJXMkptM1dRSi91UzBtTzk5?=
 =?utf-8?B?WVlsOXFaMGd1d0RmU1pHNnNpb2lxaEhqeThTNDRqYUhCZ1p3SU92VitIclhY?=
 =?utf-8?B?bUdKSHdiZzFPLzZjWmhpTzNnTXU3WEc3c0pvWHBUYnZPM1VOTHJnaFRTSjBQ?=
 =?utf-8?B?SWYrdjBraWJNdEhFZE5XUStOcDRQbEhqejZYOUE2b3k3R2RSbjV6U3pUUmNP?=
 =?utf-8?B?UkRXVlh6c3JXbUZVWUpDNHpnQ1NrRTYrRWpicG1xTTNDTXRRdG1KZ0dNZGY5?=
 =?utf-8?B?eFJldzd0WmFENjRBclQ5U0hHOVU2SVpIQmVtdE9aczA2WjFtNnJRZ2t2ZkZu?=
 =?utf-8?B?YndPd24vNUJxVExDOHZ1NGxraVZza2pCZzJKSWVoZ2ZqUjlUU1lIdVp3QXI5?=
 =?utf-8?B?Ym9qWG95NzRpWEtKa2tBL2dmallFWXlkR1VScys3SHUzVzFBSGtTaXZtK3B2?=
 =?utf-8?B?MzNZZGlPdlpPV2dMa2FIMkVacmI1QlZyRHEvT21zQmxLN1FTRURkUFFzbHlB?=
 =?utf-8?B?TEQrenR3SlpUbkMwUjJvSzdJb0NvTWxSNnd0Y013OHkzcm9vcThQQjJwcVRC?=
 =?utf-8?B?cmNGR2xkQWFmajJiU3Z4YXVGYnhjUkVYdTNXQ2MxUjI0ZlB5OENRaW1qRC9R?=
 =?utf-8?B?emltT2laMDRRMU9OVWZMcllHLzdNdHhjSWU1WE52TWtCKzdONEJUVmExK0x2?=
 =?utf-8?B?N09Wb3QyYjh0NktXVExYaVp4WEVOY0g1UWVPSHkrbjJpUVdiVEpMYWFMZy90?=
 =?utf-8?B?ZC9mY0lYY1pvOGJxZEJUQU5aRTBvVkdscTR6aFhmOGROQWZOb1pqN2VRL0t5?=
 =?utf-8?B?cExaNWNMellGUS9rMzhiZFc2ZWtFbUVwSW1lZmNvTHpOYXJreldpRWJmRklt?=
 =?utf-8?Q?3xYD4r4pXrgcVVYmBedVAFOzgYtfZx3mbS?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGxmc1hBUVpPZDZHSGR1eG9SQ1hrREMxOU5MVFIvN20xSUoydWwrV2RMMjY5?=
 =?utf-8?B?c1p3RWREWHEwVGkrWmttVnRCMEVhb0tHUmNZWHM4S1NDMWFsY0Y0amZVWlNr?=
 =?utf-8?B?RUp4YmZwYlJJOWlvQkxJMzBsWFhyK3lZNnpyUUllUnlzM1Q4ZFdZbG8reTUx?=
 =?utf-8?B?UXh4TWYrZk1uVnIvdHoyYi9WL2s3RTVMejVvNzRpU0tvMG1PRzNDc1NHSStl?=
 =?utf-8?B?RGJmbldxc1NMZFVKS05RYjY2bUVGczMyUFJBNEFxRWpvMnVEVVhQdHVtdHBI?=
 =?utf-8?B?RjRYZEVhVG8vTU5UK2ZtNjZWaVRmamJicU1VZ3pJMWtOcU1SNHhOOUdONEYz?=
 =?utf-8?B?UUI4RFBUcGVMMU05bFBGMUtraFI2cGoyeExyWG85VXNoYTcrWVJXdHFaY3VS?=
 =?utf-8?B?MFZORVg0eUNWTVhNNVN4M3NaQlpjcDRrRUhmOHpiemwwblhVVEtnNHBJL3Vu?=
 =?utf-8?B?ZDBtZzhsTHM3MWJMRnE1Nng2ekJRa0VtbDNPRU5NMnZCQnV0a2xMbVBKODVt?=
 =?utf-8?B?dXMrTHlJbVo5bGduQnlrTU5aR3pzSVM5ekdERGV5SEpBL0tndHp0QmZqRkNu?=
 =?utf-8?B?T1Z6Q1JleTJ2dGkxRS9jR202b2RNQlpzVTBjOFdtaXhYMWpLYkw1d1BzT1hC?=
 =?utf-8?B?M3dyckRqODRsYUVMUkU5SitpOXJlUDBNSGF1amkwOVpDeUhRV0R4d3lpeTVV?=
 =?utf-8?B?L1BYcHl4V3A4RWxlczh4djlCVXZxZkhrR1BxNUl6cFViVzhyWm5JTWREYUFD?=
 =?utf-8?B?L0VnZUM4S0ozSVdqNUhnZjMrbStwNHhRZldSKzlqaUNkUEx3dUd3bEV6RkFE?=
 =?utf-8?B?bGVPSWdDYkhMbjNzajNqbzV6V2J5TjFKU0d4RzdSNm5hUmNmL25YTlQ4Q3NZ?=
 =?utf-8?B?TXdRNlN3SGZJb0ZkdHdlTUZJRHdFdStITE9YSjZYTk5BWWo5Q0xEbW02YTV4?=
 =?utf-8?B?NmIxMUQwL0NoeXp2amZWTS9BQllER3M2V1JnYVZjWGpvemRGa1RyRDNOcGhP?=
 =?utf-8?B?a21YMjVmblZoU3NDdnR6bUpQT1VseTFQemhtTXBMcGg1RVh1TUNaV0Y0OThZ?=
 =?utf-8?B?dFZ0WnF1OWtsYjhrNDd4LzF1dXdpOC8yNU9BNEtpeUxFWGVYUlBqc2xXNmVL?=
 =?utf-8?B?QVMxVExvM1RFNGtIcG5FSHJ2T1NjUll2d0ZkRUxmZ0JEeVd1SXRDL2VoQTlI?=
 =?utf-8?B?LzJIUmg1M3RURTJNQVJXV0dCNWUzZ0hTYmU1cTE1SnMrWkV6WlA1OFFMUENS?=
 =?utf-8?B?N1p2dXQwRzVYL1VFSGxvVHJVUDlXbWVGMVZ1MmNaeEhGRDNkUVNCb0oxaVo1?=
 =?utf-8?B?bHJCUThqVmFONmxITDZNdzlvVml5M0daUU5KUnBjMi8wTzk3emMrNWUvNlkr?=
 =?utf-8?B?R3M5NHVWNlhMTzcyb0FkU05kQWUyc2VVR09idDRSUVJyR2hEVmhUWmNVRUpy?=
 =?utf-8?B?WEgwa0JLeWw0Q2p6aXNMZ3pJclE1MXRhRFQ3bEdMbXB6QWlHTGRDdGRUQitL?=
 =?utf-8?B?ZXA3b1drWTdJU0RsUW1BN254Q2Vaek92Z0ZtYWtYWFNMV0hZbCs3RU5xelo3?=
 =?utf-8?B?N0tTYUgrSkFQSnBnaERob3hZZG04UUNBUVZmWUNXd1U4eUFySU83OGtuRExw?=
 =?utf-8?B?QWhSYzV2bXdUV1hxWFVtLzd1STJjR2NRYlR4V0psK09BWTIvQm9WK3FwcXd0?=
 =?utf-8?B?T25sbUlWR2ZQNXdPcjVzK2t0VWpJRmtaSW4vazhzaHNiVkNsbjgrNUF1NHFt?=
 =?utf-8?B?eGNoRTVBNVhRbjlCN0NlUnM2T3FOYldEby9pcDhxUkhxc1BTRUtCeWFkZXBj?=
 =?utf-8?B?OEhzL1Q2Vi9KYTA4ZTFhTUl5bjFlOWhaK3k2OC95bVd4ZlBLNmVTMHI2c0xu?=
 =?utf-8?Q?sXMlukE0ELb6D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF17BA6D09A6BE499FECD728D3A7B1AE@AUSP300.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0cf82f-dd66-4a3a-40f8-08debf566e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2026 20:51:46.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0252

U3BsaXQgdGhlIEtFWUNUTF9NT1ZFIGZpeCBmcm9tIGl0cyBLVW5pdCBjb3ZlcmFnZSBzbyB0aGUg
Zml4IGNhbiBiZQ0KYmFja3BvcnRlZCB3aXRob3V0IHB1bGxpbmcgaW4gdGhlIHRlc3QgbW9kdWxl
Lg0KDQpQYXRjaCAxIGVuZm9yY2VzIHRoZSBLRUVQIHJlbW92YWwgZ3VhcmQgaW4ga2V5X21vdmUo
KSBhbmQgZG9jdW1lbnRzIHRoZQ0KbmV3IC1FUEVSTSByZXR1cm4gcGF0aC4gUGF0Y2ggMiBhZGRz
IEtVbml0IGNvdmVyYWdlIGZvciB0aGUgbm9ybWFsIG1vdmUsDQpwcm90ZWN0ZWQgcmVqZWN0aW9u
IGFuZCBzYW1lLWtleXJpbmcgbm8tb3AgcGF0aHMuDQoNCkNoYW5nZXMgaW4gdjI6DQotIFNwbGl0
IEtVbml0IGNvdmVyYWdlIGludG8gYSBzZXBhcmF0ZSBwYXRjaCBhcyByZXF1ZXN0ZWQgYnkgSmFy
a2tvLg0KLSBLZWVwIHRoZSBmaXggcGF0Y2ggbGltaXRlZCB0byBjb2RlIGFuZCBkb2N1bWVudGF0
aW9uIGZvciBiYWNrcG9ydGluZy4NCi0gQWRkIGEgc3RhYmxlIENjIHRyYWlsZXIgdG8gdGhlIGZp
eCBwYXRjaC4NCg0KTWluZ3l1IExpdSAoMik6DQogIGtleXM6IEVuZm9yY2Uga2VlcCBndWFyZCB3
aGVuIG1vdmluZyBrZXlzDQogIGtleXM6IEFkZCBLVW5pdCBjb3ZlcmFnZSBmb3IgS0VZQ1RMX01P
VkUga2VlcCBndWFyZA0KDQogRG9jdW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL2NvcmUucnN0IHwg
ICAxICsNCiBzZWN1cml0eS9rZXlzL0tjb25maWcgICAgICAgICAgICAgICAgfCAgMTMgKysrDQog
c2VjdXJpdHkva2V5cy9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCiBzZWN1cml0eS9r
ZXlzL2tleWN0bC5jICAgICAgICAgICAgICAgfCAgIDIgKw0KIHNlY3VyaXR5L2tleXMva2V5cmlu
Zy5jICAgICAgICAgICAgICB8ICAgNyArLQ0KIHNlY3VyaXR5L2tleXMva2V5cmluZ190ZXN0LmMg
ICAgICAgICB8IDEyMSArKysrKysrKysrKysrKysrKysrKysrKysrKysNCiA2IGZpbGVzIGNoYW5n
ZWQsIDE0NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHNlY3VyaXR5L2tleXMva2V5cmluZ190ZXN0LmMNCg0KDQpiYXNlLWNvbW1pdDogOGZkZTVkMWQ0
N2Y2OWRiNjA4MmRmYTM0NTAwYzI3Zjg0ODUzODlhNQ0KLS0gDQoyLjUxLjIud2luZG93cy4xDQoN
Cg==
