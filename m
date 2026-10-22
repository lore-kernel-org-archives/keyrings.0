Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792689767;
	b=WY0VEfUlYMb1ZTH31XziqIOLTDTH3uSIqAbbimQ+KjbvRE5fxGwPC9AV6p7nspMdgcOq
	 kJQwApCcXZQzpZJAGx2/Kr31nAy/rjQL/z8KwKor2o1Jb9TcLvqBLrE9zkoANlOI1NBJw
	 9V3o55V2xoGbjMYCMHzta6GsfokouFy8SqL716SvzlVvuUQjGiNH4s0Zw8npiZ67yM2K/
	 dbiWM07AFMt5nHUxVTG28Cjt1SLlfZEw5XnYrZs6RUrd3CCmeDfdETaky/AJZ6YtP1O3k
	 s1oKhV7h8dfCQeQ1AUDPyYo3A7EJLVzWkntKTusCpj2aZ6dRPO7LYBlTlynOMCkkNsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689767;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Fx5Bxgmy6musxjlPcZzRxS7FCbnNUJaOawhMxNunoyY=;
	b=V7BoWOSeiLPceNsafgynuKWjF/Rp58Mbaoav2rdq69PqEWnEwqdTW1IVLVvRyb1IhXml
	 SRO9p5G3z7tdbqfOifL1LfJG3D5J9IabualIphw92Hf5kF4dG8U8Zwu2otFNydOTFi3BA
	 8KKOvCJ7B2P4n2CLB76r9fdAY7PoSZx2+848K/N/hPNGWXKMI2npWUk5uaGG+hUcWeMNU
	 n7NsMrVoEnYwcONYlkQEfimn0z0pLknn7a9swKinlxvYdid5FE265TWHBGPoQNrKv9VdF
	 4aqFihIZoRitsSeQpHrEDFxbtgLXtOYoL1qb74rndJf7i9w/u//vuNDA/lBJP/Tb6+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gls1vxRN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.64
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0D606A319;
	Thu, 22 Oct 2026 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B0D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gls1vxRN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0BQf+M3xv6Dk/0f/pWU2Wezp8D7Ldcbp9Zq1RhgMc6+Y9hbebIjNUOa1SsEXLu4edcyLAMT9CO9hOOD0lGdokaaBQZMPt+zKrylgh/IfCyCAetXQaoJ3Pbukv9aDAcAvC3gNwGqIWxsUIZ6USkvw4AkwvrdsbDq4mqJDTBBmocP0uRlFG33Fqr/laqRxhHdyZhtLo8CNvOsesqI9BooKE0EsrFvMOQJRc/N8mYT9blskrImkQ+T4M7qH7/ngKBLf3qjpmg4gbYiLmQgHdXkr8ax9kOc/j4Z5cuMOECpSM93DxmDDnxOloIFpzmxyCjsegcW2QjA9bSZuHSeYvDvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx5Bxgmy6musxjlPcZzRxS7FCbnNUJaOawhMxNunoyY=;
 b=QFtULarUc26lRLSfqF0yLmY1hbxZb0FZ71RqY4t6/zhEmSbhS/F4YWE9rNvQNsKQq9ATUvzIK2QwmygXCz9Ftkuuwf9yw5k+ZLA+3rPSLzTW3P8H0vChVbVeRwDUG4HISuIc8banrG5OSWJxpCoB+j/0U9aNk3n0uNRObduPGwJ4QE7EvvOYVZ2HAOzcxMK7g+W8904ZsA8YQEuR104h6mwUs5hvWG1hTRuQVUKvu9Ia0Av4k4aZhg/gkKD4z2ycyW5ufytZB5DhShuxT4L7R9VgS+6ZPhi/t1HSiwLCBQ9bpwISr/+Yu9sAMlstCwZe4Q1/KHo/4a67uDwPCEIzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx5Bxgmy6musxjlPcZzRxS7FCbnNUJaOawhMxNunoyY=;
 b=Gls1vxRNGCYaTlYoNZseQrbkc457yJ9l2yoDvBmovoBA0ntf1J8jpV+EdoCfyO2YCvgjU4w9tHPaOOd/N7todMoaLNvlN4gzUqon7euRvO+gJnsHN8R9yEjLuGhNVNF8Wn8v4DdOmjOCX/2AIX5UHe5VgX111X2UuB1dN4qpgaRxPOmQadnGatSdiDKuyBNKr0d+awGKwC5X/32mdo9zY+skx1zSuBHSoiN5K1cLAKvGBoCMYgzlCgWk9/yR/zwunC3e3I7I1nDYpdAQboF3+2pm1BDFD7ARLw7JlacJm/47oVSvMdNFBBWoMunhCw0d9g8fHmzBTb7DI/J9jOmcjQ==
Received: from DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) by
 SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 17:22:42 +0000
Received: from DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a]) by DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 17:22:41 +0000
From: Manuel Huber <manuelh@nvidia.com>
To: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, Jarkko
 Sakkinen <jarkko@kernel.org>
CC: Christian Brauner <brauner@kernel.org>, Andrew Halaney
	<andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 4/4] selftests/ipe: test the IPE policy keyring
Thread-Topic: [PATCH RFC 4/4] selftests/ipe: test the IPE policy keyring
Thread-Index: AQHdYBKD3df1QxRQHEyGcDuwVcFtSrcFgvEAgARNbSA=
Date: Thu, 22 Oct 2026 17:22:41 +0000
Message-ID:
 <DM4PR12MB613649AD2E3435FC01EF4062DE652@DM4PR12MB6136.namprd12.prod.outlook.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-4-156f0b93e843@nvidia.com>
 <1c39ea06-4b5c-49c0-a508-06955c549556@kernel.org>
In-Reply-To: <1c39ea06-4b5c-49c0-a508-06955c549556@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6136:EE_|SJ2PR12MB8979:EE_
x-ms-office365-filtering-correlation-id: 26793fcd-72fa-4f8e-53bb-08df30611424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|38070700021|261022105027099002|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 9HDsFYheecwz9bl+9NpSCwtaXrcEcdZA+abWBd6UMvrgNyopbK5J5VE8D/4Mond8jyIXYYrWnHUCBRuDkrFI3z5klJAxT7r9P2DE9fsqZpWTeobfIefTPt94hNAuZ5J9fZXoSV3uxrOK4JjHobPGGk3p7nuE9NXdrmcU8rwT2qwoCNGfJAsXF/eHkPT7RisM5F6cJJET2XnPBK3al4yO4xnRiyxrhgPJlmxqXUdCd4gsrxd1WKs/RLiLLkFFrZPbYg1dWnsiuoL/2InEh6cfeWQThku3+VSJkg4XFlypI3spdLhxL8j1fuaCsEnGmp0OkCjKSq/UVvbL9RtgJ2JF5zwB8VG02l5EyfknTytlloS2/t1L/tIxyyo/lAQxTexTw+Jf3xnp+1w8ad/QDDxrxa4dIH2etmBzM3tzOjEZ1q619hx6gRLyWdQdZ9XujHF2kpR+WvW7QsuxkQHlBalpbRYbZL+XX+GNklfB5SqwuXHAfwCbAckStNaat+pmSCRAvQvbtqkYTMBodUmli6z1Be/8Y69FHEN/RRKKQHrWr79DP+SrUSLYEaGQQP/Q+4E6Roc3ceEhzs8wht1McEIRtgMgRfjIARPnd+FceiaTjTbURRU1hUYk4xcIlZlmHJ9XuzoKvtvH9p9hVD1LrBc7jrLp4vWDcQIAt22Vq1XIyOAcx+ja99+nIqn5Bh7Q9dpNZtwY6H0My0TIw24ugBKpEEyVV9+0YfJ4QPu2RyZpDY0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(38070700021)(261022105027099002)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFpqejlWcy84K3BCbHFuYU50NVVpS1g3ZDdFc0ZXa0lsZ1ExSkcraXFabnNH?=
 =?utf-8?B?MVpxZDhXd1RKcHZXeEY1aXYwOWx1WU9KNGZvRnhUUHJTaUp3QWcxZHZGOXNm?=
 =?utf-8?B?VHNKeVdUTXAyNlZZWHJnbFl4bkw3ekNDUjh1dXlSU0xCTW8vTklvSXZvTENF?=
 =?utf-8?B?U3pOVkwybktKV0pCeUg3MDZIZnRaSlJSaVpQSWpyVTQ3bTY3UUw0SW8zRUQ0?=
 =?utf-8?B?S2lzMGNjNFhLWDA4RW4yWHd0Q1pKSnZ3THlLS2xTNVRwM0dURFVNR01XZUVo?=
 =?utf-8?B?dFF0aUxIMENqV3h0SFZWaURDU0hTMDNQUkE4UlZNdWExRFJ4aXUyRVdmNHFh?=
 =?utf-8?B?TEtBTlBiNXAxakVDdFZzSnl2dDRwS3diS1BkeGtxQzZRdFk4NXdkKzRtZGYz?=
 =?utf-8?B?NmFSRXBxbG5jdXhkbEJVaDR1QzZ3ZTQ3dExZNDU3djAxRHVvUmM4OFpkYXVw?=
 =?utf-8?B?Z0pVZVNxWi9nb00zWUEyTkxUSmtsenpCTncwMmlOb1M1V1lRWUY2VHQxdDVm?=
 =?utf-8?B?VktIRkoreVZEWWZyWE1iOHJqbzM0dGVtclNYajdsYnd6NWJMZXM1aWQrVFZm?=
 =?utf-8?B?aUkxU3hoeENsMFVJN1NISnZHRU4zU3N4M21nN3IvZGx4Z0lMQ3I4aG02S3Zp?=
 =?utf-8?B?S1g2ZllnRzFwelNjZHFQbjhiTWJrY0wyRkt1NklIQVpmanVjZkpTeWtmVklm?=
 =?utf-8?B?T0tLMHoyZmRiS1Q5TVVJaHdXZWRQSlV0VnZ1NVIzaTZxckMxQkJibFMvRDRN?=
 =?utf-8?B?alNoRXM2TUZBaWN0ZHhiVVJSK0RGTmhtL3FMb212L0hHaG5uRHlpOWg5Uk9z?=
 =?utf-8?B?dk0wWCtBSHpOR25SdFp5WldTTVYrbkVXZkVRdy9HYTh0UzRSYkRXOEc1N241?=
 =?utf-8?B?bnREZ0lhdWJ4bE9Gd2tLZ0ZuL2ZhTjRKZDR6S1NQbVZTazdHYUJKVHdiMFh4?=
 =?utf-8?B?SlcrZ2xRZDhXZERDV2d4SjVOWDhYd3hMMnZDd3NNTFlPdjlRd1F6WWc2SWt2?=
 =?utf-8?B?UEM5d0dVWGR3RTBGdE9vbjVIa0xyUTZNY2hEMXBFcmpRM1ZEa1VEQTlaQ2Qx?=
 =?utf-8?B?cm1YYlRCNGF4TjBRb01kL2xiZDJLYmVkZkd1WGhTT1JoMGo5NERHdkdZNWFG?=
 =?utf-8?B?NXlhTTRqRWJ6VTlnWlRWYVh1Vlh2SEZBczlQb0RqWjZtNFh6TzMrclVFUjZO?=
 =?utf-8?B?cXlHbG04SG9jQ0dGRjlxL2g5eUllWkFiUmI2eTFFYlhxcm9iMm8xUjhWU1hO?=
 =?utf-8?B?VEgzZzlJcE9oSHV0QVFRWFNnaEtKa1NFVFpOT0dDeXJlS2xvZm93RTBtQU5U?=
 =?utf-8?B?dGJ1bVh6amhUNW80TDdlalZYemRPQTArSTZXaFU4MVhOOUZjUmxFRDdqOXNU?=
 =?utf-8?B?ZDlZRHphRWREdmZXOXZ5Ym5ocG56QXpkODR0ZUZneGszOEtFUmFUV2lNemR0?=
 =?utf-8?B?THNjQ0Zsbkl2VTNwWXRpVWZZbEd1cUZ5dnVCYTJmTVdidEVia0VvVmpleXI0?=
 =?utf-8?B?Q1BOQWxSRk15K2NNSTVWTEVXZFZhOWtZcTIyYXNUVXRIdkxjMFdzYndrSUZ4?=
 =?utf-8?B?QWo2T1JHOGlVblAzV3ZrQzVDVG1hZVJMVmZFYXJjR0lrcnpQdVp1SWxNWFFw?=
 =?utf-8?B?Y09lSmM0a1Z0cWR5bVgrcnkvZGhGODRDeFNuVWpacHZOZkM4RE10ZUVEU25Y?=
 =?utf-8?B?N3c5UHlHYW45Y3ZNZHEzQVJhRVJ4dEU3cHloQ1dnVHVQNFN2ZXF5WVA4eU85?=
 =?utf-8?B?OWlyUFNrVHpaWUNpZTAxbTFoN1hTM0lZaTJIUWJ6c0FhK3VML2YvTUZBNXJp?=
 =?utf-8?B?UlZhTTVlQ0ZKZ2dvY3BXVHBtM25nUS9nNVBTTlpVcWlDRjZjdlFSZkF1L2wx?=
 =?utf-8?B?WkdXLytlWXNKSTJqcDNtazNhTlV4VUp1bDIrSWxYMkY3WjFuTU96WWdFUCtJ?=
 =?utf-8?B?b1d4M1JKR01QUXkvZkE5c0taWExGMFgxeDlGMXgzZHRtc094MzhmbVZDQVRw?=
 =?utf-8?B?ZHlSWFhKUGxNS2krdXVOV28yTlZxelp4UjVOb0ptSHZMV2Y5TGZ5WnlYeXlM?=
 =?utf-8?B?M1RKeUVDTnFqVys5TUpjKzNvYVlCVkxYM0t5ZFBuNEIrSk9IS2dIQ1ppWjZF?=
 =?utf-8?B?K0xtbGxzdzFySkh0SXpSUkVLTXRrMXRYdHg2RkhleEx5VnFsT0oxWDA1NzJ2?=
 =?utf-8?B?Wlp5a0RJcUp6RDR3cUZyakJVM3ZWdDVXZUZJb052MXd5UUxSeVdrbWNNbUFS?=
 =?utf-8?B?RDRFL0NZREJoQkhSMnZ5S0dMMDdzRFhaN2Uzc3NBNGl0VHRSNXFBVFc2cGYw?=
 =?utf-8?Q?s1yN+VgcTQM6BtcjF8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26793fcd-72fa-4f8e-53bb-08df30611424
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 17:22:41.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RQlpKJhqjL3ekhMf4JfP1t8mBdVx5RRikQdHeN+If1AIPhEAu2j9L+GmOnJ0Rt01TdjEaHVkuvsVDKXtNNzJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

T24gTW9uLCBPY3QgMTksIDIwMjYgYXQgMDQ6Mjg6MjhQTSAtMDcwMCwgRmFuIFd1IHdyb3RlOg0K
PiBJUEUgZG9lc24ndCB1c2Uga3NlbGZ0ZXN0LiBPdXIgdGVzdHMgbGl2ZSBpbiB0aGUgSVBFIENJ
IFsxXSwgd2hpY2gNCj4gYWxyZWFkeSBoYXMga2V5cmluZyB0ZXN0cyBmb3IgcG9saWN5IHNpZ25h
dHVyZXMgWzJdIGFuZCBhbiBpbml0cmQgdW5pdA0KPiB0aGF0IHByb3Zpc2lvbnMgYW5kIHNlYWxz
IHRoZSAuZnMtdmVyaXR5IGtleXJpbmcgWzNdLiBQbGVhc2UgYWRkIHRoZQ0KPiAuaXBlIGNhc2Vz
IHRoZXJlIGluc3RlYWQuDQoNCkJhZCBtaXNzIG9uIG15IGVuZDsgdGhpcyBpcyBjbGVhcmx5IGRv
Y3VtZW50ZWQuIEkgaGF2ZSBmb3JrZWQgdGhlIElQRSBDSQ0KcHJvamVjdCBpbiB0aGUgbWVhbnRp
bWUgYW5kIHJ1biBpdCBhZ2FpbnN0IHRoZSBrZXJuZWwgYnJhbmNoLiBBbG9uZyB3aXRoDQpteSBu
ZXh0IHJldmlzaW9uLCBJIHdpbGwgc2hhcmUgYSBicmFuY2ggZm9yIHRoZSBJUEUgQ0kgd2l0aCB0
ZXN0cyBhZGRlZA0KdGhlcmUgYW5kIGNvcnJlc3BvbmRpbmcgdGVzdCByZXN1bHRzLiBJIHdpbGwg
d2FpdCBmb3Igb25nb2luZyByZXZpZXcNCmRpc2N1c3Npb25zIHRvIGNvbnZlcmdlIGJlZm9yZSBw
b3N0aW5nIGFub3RoZXIgcmV2aXNpb24uDQo=
