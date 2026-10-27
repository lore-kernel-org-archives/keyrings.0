Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793131949;
	b=1SYHaPpo9buZthMdV7rXAruHAf18rgBMHE5F8hoN7iGFuV5vxGEtsytfg+1bQH0HZm+O
	 w1QIUxQPZ2isWNlbxBXjWYTrJM5flvp5qtScNzwU0ldPJajOzm7Dsrp9QStM8XXPo9Xxo
	 l1OPFPDm6LKtEiGXt4QSA0SQ6RD9jd5HCUU3NKQpuEOj5IOOjyYlB86tCheSI5OFbOqey
	 q+Sm39V3sLlatuDCT95f17HGmp2mE+mhlCwejcAHpClbcywUvfMwGsZZkGpWJZO4WBg9O
	 KqOB07tl8RJfy7WHuqdHbHYN4E6EeNkbkwSb/Ui90hNwD9A16b/ZxuGnbrE463t5nmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131949;
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
	bh=Oybe5L6xfI4XZa50mB2aI1YpPe/X9kT3ClR/NEDODWQ=;
	b=uhW+PDw+Wt3QGYGV9CXEaq26CICWB/DEcDA349wCc/EQ1lcPcl42f9pzqEW+X2Z52D1L
	 BBvsplGpIRDE5/DkC9X52TwUjO6DEUvJZbjIS/dDVo36izVidMEFzYzSkMUWAJ0eG5ZX4
	 Xkad7qAgGh3CSxSeor2s/enQn/1poTdmK74wNA1w6RRFn0f4kI22auv/09bnhNoBW4lde
	 prK4qpWhIpuDDfxwiTCkXOFZM5/tONzZ2c7EWnm4UVg5A48tiViQRIy72u5xGpv8Lt8Oc
	 QVbcazyMd5n/idKGkbNrYkcUd45FhP07AapvXTJsYEravsnYcYFk9j1c0IdYmA1CKfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hGfPsc5J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.68
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8E606A31A;
	Tue, 27 Oct 2026 20:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hGfPsc5J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyvAfgEaNesqbjVxVXVpoMzXz6AobLlmYXoRJvA4LyG6Nj6zQui/AjGlWKrRAZaYSQNDu/3H1NZn55/Lw/xGcJpvIktDosv66p4NyfR7CbMefVxUGXUrrsO+XSyJjvx9HzOYRyHKZDmGdtOk23LKUyX1qQUkMHTb2GUwvcoxwvsjs56f/fJG2vNcXGAm9uN3Xzp8PeMNx2SxNfV4Nrh6DrAyTOxHIM/5U7EvqR7x+gBvUoxc5XYSwaa3zNGcbAkURH3jAc1YyHcWrZYdFJ5ontXCu8TUie5xyXXV5rDeWCwpqGn7V4DLidXM16CoK3mem39VPM7U+xCxlE9QkVDWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oybe5L6xfI4XZa50mB2aI1YpPe/X9kT3ClR/NEDODWQ=;
 b=kBMUGHCsrDeeHpYvvQQxfV0YipfbTh1IhlKWxhX/fx4u4V4GWRqEkSF5xx1ezwIFczsuhCrhRH0lYhV6ovBziT78cAeVF/mwKr7dmR4ewL5RCA7c6v0hjCVQSrxLzODjSWnvwnVQdTA6tJ/08+x7bHKkTGWCVlot01mq9kwE4nMruqDvG0MWRV+ekM5To4tnDYDud7fooN0VConKY4Owb3nQqKEe4afmHb4ean/wtBZ9aDv3AZyL9q+iG8wblo4HnJyHqLllBML2PkFlrDE1LTW96ogEDFHet27x4LC7uydCRdyPKyTbrLpK85JKi5tu2Mom95pgZLErYrvmqhGbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oybe5L6xfI4XZa50mB2aI1YpPe/X9kT3ClR/NEDODWQ=;
 b=hGfPsc5JvftS0Bz/xtAmU+v3sKvrmPRkIRCB2ZAbUiIb0zfUrDA6nkL0f9+G3gLGyM62O6XPSMZ7+4kDd5gk5Ynj63r+1E6Lnk0oKVkQLKlfu235mFZ0xvmvJAdRU3qwX9jgHJlOOMLrwVg5WkngS74IwgEILkV4Z+V31wpHGxNVyQqpDrEcvAdse9o1kq0mQKaEdESB5j6fOMGeLLq8ZCraikWyiDj09morRZfohbRXNT9QSbvgSyF6Haqw3QYncMVZwsq9SWnnDRILWqwgglZbvvyBsHDO4xYUmkl6QbiLkQ4r3ZNr2JoA0sO2WPX1czBJHA9XqaY57fFLHRykeQ==
Received: from DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) by
 SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:12:25 +0000
Received: from DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a]) by DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:12:25 +0000
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
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
Thread-Topic: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
Thread-Index: AQHdYBKBjBwQ1KDODEujGWIc0cwMXLcFf3KAgAwwgjA=
Date: Tue, 27 Oct 2026 20:12:25 +0000
Message-ID:
 <DM4PR12MB6136C6E1BE1E6D675AFFF0EDDE602@DM4PR12MB6136.namprd12.prod.outlook.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
In-Reply-To: <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6136:EE_|SN7PR12MB7153:EE_
x-ms-office365-filtering-correlation-id: e309b5ea-0392-4ae6-3550-08df34669e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|38070700021|261026121527099003|11063799006|56012099006|261009223027099003|4143699003|261022113327099003|10067099003|261022105027099003|18002099003|22082099003|261026140227099003;
x-microsoft-antispam-message-info:
 NSNEYtxYfQzpPPSljt5Ya37WtybBXN9GfgQEPjbT+2Vw8Lo2jdCN3iFE5Y8VPZSkVp8o/Blo0wdFZocy+EaXacZpT1W1885g168TE+4x2T1PGBGgtQRGdcWw8MHy4lTlINWEnJnXhHj8xhh8PftQ8yTED1jDK83JpgICgTpYDvQWqoXnlSnGjozIjVMeNXkbo7KhF55o7lVaMVZMSNC0V+GUvfeZFd+mBqW36xRXCfm5ZBQGpbu9jzbI4FWaSukuw93OmqKWkc7IUk8poPjpsEdaAzT7rDY5bSm3knDZclZM/3UB4n3TsJjEEa84DAm7mlAZ6q52OnoYBUgOQ8YSB8wuzyDAiZ65h2730CQ3KaxW+faD3330YChAbnh6Jio51CiXo8THKMrXwBW5dbPTT4uulkMc07/3uf4XCnLu09y6gsIZOeuBS3flc8DOTuccnFsfS7Lr93a2KuipbDraaHUa2FetdJr1VzDVe4ZvSxzttzbygFu2gbhEMTrjJa+quRpa1ATstXrIWdAEhz55HlAZz/HXw0V6VFXqoJmVlYxyeEiEOqs6pqYoRrFR2UzomD/X5+idxNVGXDo95pSsbc96ibU6sOqHLjBCKMX+Kj2gvgQEXq68F3Vj/p+/SayTfG/wOxFkb7mSBffQPo96I74As6OlgZ3ClE8gyH2FywjwbgMpjZX0Z+/nL0rFrCL+tTPIKWoAhzMKxSycfEEwbg3YElTzCDOkzx4wii3Fwi8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(38070700021)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(4143699003)(261022113327099003)(10067099003)(261022105027099003)(18002099003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzJnUGhpNU5QMkdxcFlpM3FKbklZYkZqczd0czNqRkgxdEJZa0Q1OGJJWTRL?=
 =?utf-8?B?L3ZFcjlCMXhwZHlIR3AvZFdXQjlzbUtuWmpHRjZpVlpKbXg0dGRib2hheW5l?=
 =?utf-8?B?K2t2cUw0eFljRE9PSG50Zk9JWTM0cDdqYVg5ZXViZkhnV3Bvdi8vcVRNL3A4?=
 =?utf-8?B?dkMvUUo0emFmSmN2ck95YXhZbXF2citkaE52K2c1akkxZVV0TXFIMGNBN1A5?=
 =?utf-8?B?WEVWTWxqOU5lZkpzajhxN2c1NS9rVk5JR3ZSeXBoaWdOaWwvQUh2RzE0ZjBT?=
 =?utf-8?B?S0N3T25MaEFRSkh6M0tQTkQvcnNyKzVhVzRidysydktKSEc5RVRyWFVya0tj?=
 =?utf-8?B?Szh2Z2F4dG1tNUNNa1EvU3RRVjhRb1E4RTF4dlcrN091S0ltbkl4QXRMdk5Z?=
 =?utf-8?B?aUVqWTk0TFVRQVhtZWZ0ODUzTGVnaWRRSWxBaStRWlBNMDN6UDdsVlJkei91?=
 =?utf-8?B?S3NuU0lwbTRLbU1Pa2pWT2VXb28yVXlHTlN5OGNRc0pydytrTTMweXVxMHNm?=
 =?utf-8?B?azJZaFFoU3Z3QzBHYVNDUGF0N0tUS2xqZG94eUZBNGpTa2hIa3JGNTlCYXk2?=
 =?utf-8?B?L0xWRXMwdlJTQWJ2aDFlUDNGUGpZYU1hUENGMFhmZ1ZDZDBqVkJlTUFVQ2p4?=
 =?utf-8?B?Mm5vbnR0WWxNWXgrV1IrTXovZmZ3cURTMlhubXQ3dFh5WFV6WHJIanBFN3pK?=
 =?utf-8?B?Ry9EWnpqWWhsMnZWbWk1d3dzeW5yMTd3d0FhQ1hrYVR5dHY5V3Z5RHhodFVE?=
 =?utf-8?B?YWt2SmR5SHRNWUdrekFKNG1PSFRIdDA1UnIxUERlSU1LaW1WcDl2aUxrYWlI?=
 =?utf-8?B?Ynh4My9PMUhSVFZTOTNLSHExajJRQmhDdCtBM25FOFg5a0RLRG1TZ1BiYkhI?=
 =?utf-8?B?L3BhWmJkeEEvK3Zya0xWU2k0WThWaHhpeExKWkhwRDVzVjFwK0Q3Q280anli?=
 =?utf-8?B?WEZhdVBkb3ZZMERxaEEwY2t1SFRqUTVZbFNjZGE2bGFacHdGcFVOWlZ4WFk3?=
 =?utf-8?B?REtjc1VTdjAyelgzZmlaSExXSG9aYnVBUXR0L2xLM29oL0FTdnlObFNCZkF1?=
 =?utf-8?B?UnNqdjJQV0I5UnpWZ1Z3YmVxZjZsMWN1UDVYOEhheXQrZkp2K2pzYTBZNlVP?=
 =?utf-8?B?S1BvQmhHclRzMjBjN1dSWXY5eEJsTnJna1lvNWtUV2U3SmFHNXZHUklTMkJG?=
 =?utf-8?B?WmpOZGxaaW5ndndEdlQ4cHAzV3Zpd0dVOGRBaU1DdFkrSVVSQXFJOHRCZEFx?=
 =?utf-8?B?MFhFcFFGRFRPNnhNRFVLZ2dRNnZrWTdKVHM4eHpNVnZ2bzYrOFB2VmVCRHhn?=
 =?utf-8?B?VWczeEw5YnhRb0xVQ1ZkNHBveTU3UjAxQWR3cDRUVHV5N1hFSmhPUDVZU0RN?=
 =?utf-8?B?a21mMGJPSUtpUW0vWk9PdkZyWmpKTjhlenBDWVVCM0ZUQUdzU1BmUzErUHRx?=
 =?utf-8?B?ZkxyaHh1cHZBaUE4Sm93U1RQYThmNU0yZEJvbzh5d2p3USs2SGZxMU04TzRq?=
 =?utf-8?B?NTVyMjhPZ2ZRVmpFbzFLSjV5OVpHOU95aXlnR0R3QzBSRmNmUzV3TGdrM2dZ?=
 =?utf-8?B?aDBMWVdYUXRBZlNTb0NQSjA5dSsrc3YydkdvYVVVRy9NRUpQa2FTOGRoS083?=
 =?utf-8?B?TytUVUwzNkQyMlpMNFcyUDBYcENlTWtkNlNnM1NSUHpRZWMxeVNNb1V0TENZ?=
 =?utf-8?B?ODBQM05VaVBMaThGa1BtZ0hBM1F1Z0VLTWxOMUpacDNnZEdYRTRXOWFkYUFH?=
 =?utf-8?B?UFVtSzJMV281Z1lkcWcvcWZHcFhORkdXbms5cGgrZU9rT1dtbU5TM2JoTGto?=
 =?utf-8?B?ajU2by9UTEdYTmNseHRyd0hKVm4ybitYcHVTakYrRWFZWnZDQ1VKMXBlMmkx?=
 =?utf-8?B?ZjBqbU9LZE9rSkNGSmpGMVcrWmYwUnhLQUJvTVNDWjdsOEhkaExocjRIVy95?=
 =?utf-8?B?eVlFUXFMakhFdUZYSXExTDhQNjAwbEF0THVZai9INkxyU0g2Y0xVWURuLytn?=
 =?utf-8?B?cTdBeFROQWpuRDBPeldFZnNrUXI1THVuSlZCZkt6b1lNYi9mb3BFcHhIOXN3?=
 =?utf-8?B?SGRmaWUxeE9vY2lLc08wdzFzU1lSMmlieXRtQXZYN2FQdGRkakYxaVA0STho?=
 =?utf-8?B?bVliSGN6NjI0ZEViazZZTytOVEhmTGJ0WWNQeU1yNFB3eVROOUgzNG1vaWRr?=
 =?utf-8?B?UXBBbzVsRkVJaFAzR3J3QWNuTnBlQzF6a1M2SWR4TitYWE1LWFJGUDhaQys0?=
 =?utf-8?B?UnZJUFFNb043aGxnSzVheno5Q2dtL0Z5eE43T3dvQXhqd01IYXJ5NjYwMThP?=
 =?utf-8?Q?r+Qhv1hgFvQlPdCDYS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e309b5ea-0392-4ae6-3550-08df34669e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 20:12:25.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziSszhzqaafmviMjl9zPg137kdv83ZbkYnGB2x92GJOy2RpMX8mywIPtk0WC0btSJDwkzw7NEnUibgkqBU+Fyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

T24gTW9uLCBPY3QgMTksIDIwMjYgYXQgMDQ6MTU6NTdQTSAtMDcwMCwgRmFuIFd1IHdyb3RlOg0K
PiBJIHdvdWxkIHByZWZlciBhIEtjb25maWcgQ09ORklHX1NFQ1VSSVRZX0lQRV9LRVlSSU5HIGRl
ZmF1bHQgdG8gTiBpbnN0ZWFkLA0KPiBsaWtlIHRoZSBmc3Zlcml0eSBrZXlyaW5nLiBJbiB0aGUg
a2NvbmZpZyB5b3UgY2FuIGFsc28gZGVzY3JpYmUgaW4gd2hpY2gNCj4gY2FzZXMgc2hvdWxkIHRo
aXMgb3B0aW9uIGJlIHR1cm5lZCBvbi4NCg0KVGhhbmtzIHRvIGV2ZXJ5b25lIGZvciB0aGUgZGlz
Y3Vzc2lvbi4gU29tZSBvZiB0aGUgcG9pbnRzIHJhaXNlZCBhcmUNCmFjdGlvbmFibGUsIGJ1dCB0
d28gcmV2aWV3IHF1ZXN0aW9ucyBzdGlsbCBzZWVtIHRvIGJlIG9wZW46DQoNCjEuIFdoZXRoZXIg
dG8gdXNlIENPTkZJR19TRUNVUklUWV9JUEVfS0VZUklORyBvciB0aGUgJ3Blci1ib290DQogICBw
cm92aXNpb25pbmcnIHBhdHRlcm4gd2l0aCBhIGtlcm5lbCBjb21tYW5kLWxpbmUgcGFyYW1ldGVy
DQoyLiBXaGV0aGVyIElQRSBzaG91bGQgYWNjZXB0IGFueSBpcnJldmVyc2libGUga2V5cmluZyBy
ZXN0cmljdGlvbiBvcg0KICAgc3BlY2lmaWNhbGx5IG1hbmRhdGUgcmVzdHJpY3RfbGlua19yZWpl
Y3QuDQoNCkkgd2FudCB0byByZW1haW4gY29tcGxldGVseSBuZXV0cmFsIGhlcmUgYmVjYXVzZSBJ
IGFtIG9ubHkgYSBwb3RlbnRpYWwNCmZpcnN0LXRpbWUgY29udHJpYnV0b3IsIGFuZCBiZWNhdXNl
IHRoZSBzY2VuYXJpbyBJIGVsYWJvcmF0ZWQgb24gY2FuIGJlDQpyZWFsaXplZCB3aXRoIGVpdGhl
ciByZXNvbHV0aW9uLiBGYW4sIHdvdWxkIHlvdSBwcmVmZXIgdGhhdCBJOg0KDQphLiBtb3ZlIGZv
cndhcmQgd2l0aCBhIG5vbi1SRkMgdjIgaW5jb3Jwb3JhdGluZyB5b3VyIGluaXRpYWwNCiAgIHN1
Z2dlc3Rpb25zOw0KYi4gcmV2aXNlIHRoZSBzdWdnZXN0aW9ucyBnaXZlbiB0aGUgc3Vic2VxdWVu
dCBkaXNjdXNzaW9uOyBvcg0KYy4gd2FpdCBmb3IgbW9yZSBpbnB1dCBiZWZvcmUgbWFraW5nIGEg
ZGVjaXNpb24/DQoNCkFwb2xvZ2llcyBpZiB0aGlzIGZvbGxvdy11cCBjYXVzZXMgdW5uZWNlc3Nh
cnkgY2h1cm4gYW5kIHR1cm5vdmVycy4gSWYNCnRoZSB0aHJlYWQgcmVtYWlucyBxdWlldCwgSSB3
aWxsIHByb2NlZWQgd2l0aCAoYSkuDQo=
