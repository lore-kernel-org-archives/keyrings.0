Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837416;
	b=MfZXVX6z60tbNJTTIBBVCPz2dZOcoy8pHVhk8uUbJnB7+mxuDMxO7Rqj9s9hvI4KG+CF
	 oqzPThn+n/t2XmuMlNq2OwApb05e1Tqu1L7IhYbUTvSG9RIgKMMuv7tS0FAN7FnSNqUoG
	 KUSB0w+JVX49GQ/rNNRQCqKN+DfxNV27zNGajQxSw9FvkGqD7dlSNYoLRTaG8SEtDirKS
	 tfvlNVTNe3gG5IElVgP1Fz8V1s4DyWwKKsvq+cGpLtNHXCv3+hqoC0+y8aB8KhCD6glYQ
	 CqgXqzJ0RTuR+g6cLbSy0baHiOVUvIx7OlYE7rAPaPE529NXGII6oPoRTN3+dyTaX1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837416;
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
	bh=RbLaBmegHuTWz4ig9duBlXPz0JYHFjAvKSf+rWhU910=;
	b=XTSVUk2V3byMjvS3tecdtXGox39kj3jhIBg66TwrGSrVuUmKIjS0rBL547sNElkEkqiq
	 +dgsuOQjBLNlhXXwLk3gyrxrlmXRLCZplfOD1UgcE4j75J9hWukuk7QHJ81E9I/L3UdkM
	 Z/Nt0/3cEzGBcR82Q41fHJP1GnVF3bZT4R5ZpQYiGZdyUqhs8STvlJgVbstLGzvn4qGNu
	 vcduCST5uGpOzqqppn9anJLHDTFySErB0PRvN7HeBySC91+TpFifguTJf6dER910aaqZS
	 a5vdDkXJeWqA7vk8WoakGCBgeuFHmbTywldnp5w1jUA/OmxI95jfSJlmaDrPwfGYNKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=atzIIchk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.35
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BF606D81C;
	Thu,  5 Nov 2026 00:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9BF606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=atzIIchk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiuGCOrL7Bsdc0I+Yh+VcChnZMcBNVw4plNFQlgaH3Fnb07tIWBBXq1ZIMEIZRg36SQUw7cv144p6wKQ1fFhdY5FaTY71t14h9tlbjpHunWXK+MR4PGW2k4VoXbv/IEmRbTVGaP08QLGIgZKy+OtXjptTVSbNPChD5IZGnHm8aYKWIZ7Z6znAjoxuXYb4LRiTKJAAAhyOWAKZHDyTXQep4BuFtDKpDB+N40rQydFLx4RmJxmKtySm651qn7tM5sBaTuoUAKueMTDmHu8dRJyXkBHQSdlBMY4BIJ3M61ejzIshPwB5WXq9rMg6DL9/fIByuUegnvKBY2PXWHCVLaJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbLaBmegHuTWz4ig9duBlXPz0JYHFjAvKSf+rWhU910=;
 b=sXPIkk0HH6COXKS2g/NEFOZCSYi3g/x3nqscPFymfSVIZyKpe15Cbb+VhojTOZt4DqE6b24NFvwpwcm/KgvlU5X99y7e6bFv/zb0TRSuINsFZfpEHR7rcBKk4e8LS6cqJvILe/i9HFewBiYEHLsatK2WJtGOPsaJvmGSwd7YGVNujQGaz93xjz61xhOBAuo6Tczdx1pmpQrnOczpWYv8HCDUr+a9MDiswWHExcISyNkZQUry6wTHeoxwGKn8hWMT0QghAljgbLsqyNSFm8v+txVgjCiCVQLqvKsCsHYe3AuYduQ+kNYNAXGaH0iw+EmpWCkCdq8SlfnOhlMUUoa4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbLaBmegHuTWz4ig9duBlXPz0JYHFjAvKSf+rWhU910=;
 b=atzIIchk2CJadkjk/kMSc3mDB/rVrhZyCC7eHkbofXx59o7VjmTcDQ3C6ltINqDTbX++zOpPnloIBFNKtI8VOoVsiKPiiS5BCWVsmLy3On3id/GI/Pxvff1XVuen24Uwft5VPU/TD2oTIvMOZcV91/VkHMgd9L6NxLmcLeWg+GuSPTeV3+QVfronHNmw7MtqlJeBvDoQA+EPgO0apaxANo7urU+hAdHsQjRuaFSRgy8Jz+HOxJHeWLfVeU1fIKDaHFC7eD5imW1oKRj+QndT63PxVN6Eueil4lHrcFFDHbOJjem+lyySeTnpSzE0QRI8B/UyKycSjaZ7FApP2LiSiQ==
Received: from SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 00:10:10 +0000
Received: from SJ1PR12MB6124.namprd12.prod.outlook.com
 ([fe80::18d1:68c9:ae0d:7d82]) by SJ1PR12MB6124.namprd12.prod.outlook.com
 ([fe80::18d1:68c9:ae0d:7d82%6]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 00:10:10 +0000
From: Manuel Huber <manuelh@nvidia.com>
To: Fan Wu <wufan@kernel.org>
CC: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Andrew Halaney <andrew@amutable.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luca
 Boccassi <luca.boccassi@gmail.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
Thread-Topic: [PATCH v2 1/3] ipe: add the .ipe policy keyring
Thread-Index: AQHdZzzTq01P8UHk60+Ce2yq7RogGrceY9iAgAAyxbA=
Date: Thu, 5 Nov 2026 00:10:09 +0000
Message-ID:
 <SJ1PR12MB6124F08E6BA4F0D1D7BBD9EBDE772@SJ1PR12MB6124.namprd12.prod.outlook.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
 <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
In-Reply-To:
 <CAKtyLkHtZeToq7YN7n2jffK0DmR7Axu3cQ+Kac_+RYvtsF=+cw@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6124:EE_|DS0PR12MB7826:EE_
x-ms-office365-filtering-correlation-id: 69b0385e-1b6e-4d85-14bd-08df3ad1275b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003;
x-microsoft-antispam-message-info:
 ICnszfWUsEBHv4A0faAIxDC73i5Y+ES0cdqQG8ZtYmwr3n74lt51UQSEzQamcgIPdrDIhMxGtd1xG/De9slPZNyi7+XkGK3yJh6Vkvo2YCkaNluhVRytfoOeqx/VL5AJeVxhG5ChzeG30thxUARqMbJaK+cFNWHYh3aQDYn8gcS9FDjwrWQoyKnIdgX5FN0aRq8ew8SOZF2l5MbFVLWOwK0Hg6FE9FUKvlD+LGmr9IerJ7zuW7E5Ax1Z1Q4O3HJo51jVts4vxt4QHyjlNyZwr3VYHEFHtMdsb6SiBdJcex1CKnlJ3aUD7rPKCeLBxQfk1Jaa198yb+xjxgUVSzSFOVuRjvI3dyOhCOi/ajFdWJKz8ynkpfRshcTf3oT58ZVSU/mHgk3/5hKaaaHz1+P+ZrsWqEOsIb/behwyZRmzZmuoyaBgUe0Mw4yi2b8L/LVTfA+XfuXradH0DvaKtcFHwoSdZvkvawCXwlPrbjwZBKt6pK7oZCTyjsPa+DKBCrXSw4C1RQ7C+bfEtWlUOULQvodxeBM0dVjZCNNQXbxfmnNez72Ko+k3qQUV4d+ZbvfOhayIrkCVTE7/tbG/nifq0pwbzGD9j3hcp0JaK/DbA5ESXAbzLqok+Ww9omVQIpLTTgMyY/Dv1PR6dpHRzzJmWG05HHravLHFA5TUTY7QH5JeFKhtdUh3DSgrh0eBX5UjS/EMV6KScCaPy41Ug1GG7LNJiXv9BQPKJ81w3Jw1Il8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6124.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDd2K29qRS9BRkxVZzhiTzc0Zml4QWdaTjRIcGpuOXZMeUdtcXluRzlJbnFQ?=
 =?utf-8?B?WGFDeGFlZjU0MUJvNWxoU2tkbUxVNE5SUjUxK003UkFCbFR2Y2lvK0o3UmZB?=
 =?utf-8?B?YkkwUG1iOUdDUThsazZQc0IyanFKOUJmK205ejVjYlBiK0JmNm1UMHMyTnFV?=
 =?utf-8?B?NVRpcXhmYm1uWkh0cWpBQllSVk9JZzNiaCtuKzVneEdZV1R0eUwvV3FueXlm?=
 =?utf-8?B?UDYrZkxhUXhMMlNuUGduYVBWMDB1Wk4rRjhlQkRmRlM2WUFRNjJmOFIwR0hN?=
 =?utf-8?B?WmwrbkRYSVFjVFNueEVVVjJZTlhyYzlJV1VVbmJuN2crdlRlSC9saHk1d0NW?=
 =?utf-8?B?Yjg5MnRrRTYvTys1RmJtVnEvV2t5d2l5YWFyVmwzOWNyRStpeFdybXZZR1Q3?=
 =?utf-8?B?aWNpTmZrUlNmOWxTLzhEUXpiREp5OUJqRm8veTgxODFtSysvTm9KRzV0T2lX?=
 =?utf-8?B?ai9DeWMwZk5xTEFTNyt3VDBxYWFCeWovcVY1c01GY3JoYkVudlZ6cmlqdFlL?=
 =?utf-8?B?Mi9EQ0dTMHQzSHVDZmZXZEVTbXVpSXEwSmNOcHhncFdUZDltUXk1ckw5Wjln?=
 =?utf-8?B?MUN3WVdIM0ZKWk5kUGdhK0FZaG0yQjh5Rlcyak5aSlowOHBiRXlxWTdPUDN5?=
 =?utf-8?B?N2IrUUFWRjdEMG9WWGxHRkF3Q3h1R3NDdkR3eGdsUm50R21nU3E3NnNNUGhP?=
 =?utf-8?B?NVZHSzBTd0tMN1NUMG1BdFN5bmJDajd3YlppSXczVSt6TFBJREJCcmpNcWJz?=
 =?utf-8?B?dXU2WWhzOXRhVXJPVFBFRGc2elhJc0JXbjd1Vmk5a2V0cEJoV0xVb09CV252?=
 =?utf-8?B?ZGpMWlhISlFhUWxidExjSU1iMGlDL25nSlJZeDFYM0dNbmJBb1kwUE1zYmxl?=
 =?utf-8?B?eGFadElLejNXUmZYV1diS1FEMTlhQXhjclVBdG9sb2xWS0IrL3VuMmJpaUps?=
 =?utf-8?B?SVYyeE9KZjBOcHROaHV6QU5HUmtRaElJemVWaTNwTHlXREYvUWtwM3d4bUMz?=
 =?utf-8?B?aW1Na3h5MWhyTlJoT29COS9ncmlGclFIWDN3bEZYMDM5Mlc3ekloUGR0cTlZ?=
 =?utf-8?B?TytJZ2tCak9QM0ZUL29jSDk0VW9QS3pyNXRjOUF4WE9xK041ZlBmTlpCcmpN?=
 =?utf-8?B?RUZqRUNtZTNLbE1zUVBzcmgrSzFhNlZzUzhQNmZvWVNjVldQY0dEWWl6UGRm?=
 =?utf-8?B?YU1Bb3JLYXBnYW9mRU9kTHpFQis1ckQyY1hSdDIvNkRkUFZlQ3NKS1dlUmwr?=
 =?utf-8?B?cnZ2b1JLUHZEYnpwdk5RSjVURHpZR1g1amVqb0loNjFoV1gvdE05L0tMSkNE?=
 =?utf-8?B?TXVUcXduVlFoWWFQaDR2eHRzcE1BV2RIb3Jmc0ZScFhuN0FLaVVHajFXWGVJ?=
 =?utf-8?B?UUh0Tm1BVlk5UTVsRTV0WHRDVHQ1VEhNU2o5TlRmYUs3Y2RMeGdKRWZvc1Y5?=
 =?utf-8?B?YzVHQmMwYytETkVQd09qSko0Uzd5NnBleDZlbTF5Y2w5ZEVSNEJFOUpDN1R0?=
 =?utf-8?B?M3J1Z3JkMnErekxQcm5GQXNJeFQyTUM4ZnVVQTNJZUUyOFRVTDF5eFRuc2pF?=
 =?utf-8?B?SlVQVkczRFIrZXJxV0hqODFCT3RXMmhRNXBiRTE2VzRWeVQ4TnJvRmRFTXhT?=
 =?utf-8?B?am1kbnliZDcwLysvU2Jlam1uN2gvRmhqb1VtM0VSQ0RlZkEwS3ozME1WVnBi?=
 =?utf-8?B?RG42dnBydjFrZVFDWVF5WTdYcU5nZHl3dXdHQ3lIMWcyMmU1VFJsZ0s1U0JD?=
 =?utf-8?B?MnNTeGZNQzEvSENyb3gyQ09xUzhrenptc0lBRGU1WkhuMDFZbStKTDNlSUg1?=
 =?utf-8?B?ZmQxejJGRGZnZS82MEFVTzhTbW1FTWdkMURkLytVdDU3UzZwemFJZGFNODRs?=
 =?utf-8?B?QXVHYllXNVFqcmVKTXFoa0NHSCtJc290a29wWHMyTG5OS0tpVDhoaXZCWDFt?=
 =?utf-8?B?QURwTXRZakVFTklPRlo1OUtSWHByMzVkdjhKNkI0NS9Cd0lFRzBQRG5KOFVG?=
 =?utf-8?B?NE81L295MDJPaGxOQkpVZHJabVNXaTV5Qzl2WnB1L3VuZmlhblZiRnlXUW1k?=
 =?utf-8?B?dm05Um1CTllnYmpNdzlmQ2VaNVFPakw0ZkdZcmpzWHJETlpzQWYzV0ZobzBC?=
 =?utf-8?B?RmY3TkNtRyttNjMyVjZuUWpyb001YkFUa2ZlRmZ5SEFtaUpkTy90YWpyVE5i?=
 =?utf-8?B?YzU4S1BkL2hLRytGM3FWQlhuUjl1U0FlWmk3OGducDRSdis5cmcrc1RiVFZo?=
 =?utf-8?B?dC8za2hVK25oRTN3SGsvdTY5MEcxWGNjVmNvaU00YS9PUkVpSktUUElzOGVL?=
 =?utf-8?Q?8CVtxrvAKjOMVN96bF?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b0385e-1b6e-4d85-14bd-08df3ad1275b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 00:10:09.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TKJWzd8o/JO0eXKfS3ajsIP8LHlOpxcKCoLh0Azg+VWkuljOYucQ0LgLmEQjq2tpCenoVgRGUJ+oamORj3kIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826

T24gV2VkLCBOb3YgMDQsIDIwMjYgYXQgMTI6MTQ6NTdQTSAtMDgwMCwgRmFuIFd1IHdyb3RlOg0K
PiBUaGF0IHdheSBubyBwcml2YXRlIGtleSBldmVyIG5lZWRzIHRvIGxpdmUgaW4gdGhlIGd1ZXN0
LCBhbmQgaXQNCj4gY29uZmluZXMgdGhlIFRDQiB0byB0aGUgVk0gaG9zdC4gV291bGQgdGhpcyBh
cHByb2FjaCB3b3JrIGZvcg0KPiB5b3VyIHNldHVwPw0KDQpNeSBtYWluIGFuZ2xlIGlzIGNvbmZp
ZGVudGlhbCBLYXRhIGNvbnRhaW5lcnMgWzFdLCBhIHVzYWdlIHNjZW5hcmlvIGluIHdoaWNoIChL
dWJlcm5ldGVzKSB3b3JrbG9hZCBjb250YWluZXJzIHJ1biBpbiB0cnVzdGVkLCBjb25maWRlbnRp
YWwgVk1zIG9uIHVudHJ1c3RlZCBob3N0cy4gVGhpcyBzY2VuYXJpbyBpbnZvbHZlcyBoYXJkd2Fy
ZSBURUVzLCBhdHRlc3RhdGlvbiwgYW5kIGZpbmUtZ3JhaW5lZCBwb2xpY2luZyBvZiBob3N0LXNp
ZGUgaW5wdXRzLiBXaXRob3V0IGdldHRpbmcgaW50byB0b28gbWFueSBkZXRhaWxzLCBoYXZpbmcg
YW4gdW50cnVzdGVkIGhvc3QgYmFrZSB0cnVzdCBhbmNob3JzIGludG8gdGhlIGd1ZXN0IG9uIHRo
ZSBmbHkgd291bGQgdW5kZXJtaW5lIHRoZSB0aHJlYXQgbW9kZWwuIFRoZSBwcm9wb3NlZCBJUEUg
a2V5cmluZyBnaXZlcyB0aGUgdHJ1c3RlZCBndWVzdCB0aGUgYWJpbGl0eSB0byBjb25zdHJ1Y3Qg
YW5kIHNpZ24gdGhlIElQRSBwb2xpY3kgaW5kZXBlbmRlbnRseS4gQWxzbyBub3RlLCBvdXRzaWRl
IG9mIHRoZSBjb25maWRlbnRpYWwgc2NlbmFyaW8gZm9yIEthdGEgY29udGFpbmVycywgdmFyaW91
cyBLYXRhIGNvbnRhaW5lcnMgZmxhdm9ycyBhcmUgdmVyeSBvcGluaW9uYXRlZCBvbiB0aGUgZ3Vl
c3QgYm9vdCBmbG93LCBzbyBJIGNhbm5vdCByZWx5IG9uIFVFRkkgYmVpbmcgcHJlc2VudC4gSGF2
aW5nIGEgc2VsZi1jb250YWluZWQgbWVjaGFuaXNtIGluZGVwZW5kZW50IG9mIGZpcm13YXJlIGNl
cnRpZmljYXRlIHByb3Zpc2lvbmluZyB3b3VsZCB0aGVyZWZvcmUgYmUgaGlnaGx5IHByZWZlcnJh
YmxlLiANCg0KWzFdIGh0dHBzOi8vY29uZmlkZW50aWFsY29udGFpbmVycy5vcmcvZG9jcy9hcmNo
aXRlY3R1cmUvDQo=
