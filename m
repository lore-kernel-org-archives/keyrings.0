Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792692140;
	b=fS+4EYhcWaWPCH1+vAmMbH737gKcauNlvQxvklwlqApSjmXaRqqyIoi02jRUGRfuxIbB
	 qcwoe0045+k5yMQaPQ5Omf6nq6jNl+gdesjuwXVQ4OoAYIxzOZXTGnL0+70DJwT39jSXV
	 dcfW0E3Yku72LCsHrwR3/9rNBiFSVIyP+lAx+G+uUZaENZ7NPbMM+D8mhEe3mVwoL2CzE
	 zTnkfsbzaTXpBo3QK+G5Y6bTT8suLy/Cl//bOnKbC4u9Uq3cpRrb3lFpl9pwzDbV2R6R4
	 gDydw8F1X15bgGfEgss8oGAa5Dd2gVS/E18Duk6k6xc2PfIe/AByIu6MceqFrrQoTOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692140;
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
	bh=qQxZ4YawVftdcXvT6GudfBCwbvQilT4eVG/WyFtKbTo=;
	b=RycGT04ICFKK1RLDJzCe3C9mKQaVkUYZEsIjBLA7AQioAL8RzrB8T3jOqlhRpl5KRrS6
	 fTwskbBpPGlfJVuC7+JdXiWH07aVj5z4x5hataUHQiyBHGmVkohS/LcYdB74vsZWp7t+V
	 W3clVVCfgz9Pj1jLZdXQ/vwN/cqtPa0zzVml+uvgAOx5nmYsdLMuO62NNukj2GXuQffQ/
	 YKeBoMjQofJdZwDT3JuOwfOCj1rEhE6dJgDUrpJEG8DRmXeL5oNF/VxhBBRPapyJanSKN
	 5gN/XywSpi3ul0NdqArb08eD+V8dlGDSCyokT3P1Cnjh3sCu9NPFmWMaX5SHmMctnqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s3u7yvq4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.20
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797E606A31A;
	Thu, 22 Oct 2026 18:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D797E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s3u7yvq4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga2mR6mAPlpUe5Nz6OwGVkWHyGBdNJ6HDF9Ev1vwXxYTV9SYokuS3/dessWdhOAqDO+NKFrOsCQj8OVga6IXc8Fr1Yc5ts5pVHKPQthcLHRVLQ2E30CyjdsSfGuswhbcywX76fIFZFH7p/u+UogTi2K58GP08/JYoWlYZeefTA5+IaKm+kXGgBN7JIe13FfwFbouD2JRmaJDGV7sRPfAlla3+jogwAazUe9z2/RR4ocwzdUVW+3PZS69mRhgFnO8fygmaOD43IMgUNFR8lCCdYhh/vDG/xnZRrSdOH96xlcZHHQJUjipYH1enoONKEKiElYv6lhXuDpl/R0CJq6YBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQxZ4YawVftdcXvT6GudfBCwbvQilT4eVG/WyFtKbTo=;
 b=J/ECvEdyd16RvVQaBMCjm4SNuHQXdecc0Act10E//lqOcaiYGcyJaGE+CF9S1Q4N16vpeJK868OsCu024iLlq2unigHa/MJOgIM/u7m+Tq9A6LYYswds7c5lm1xN+RbgFhP8m4Uo8lyp0gwc3oxsSck/F3RSQ+G60E5kIq1fWzWUv+XvDUKKCzX2Jw72BADlA2Q/8/Xefa6wdjscV7AOCFkA9UuUvph5HEWWpeVPVvuW3uZTA7E1Rfg4RhCDEtHor+lsAk+WcMLuuQG03+VxPnSjRgsWoJZfcdHv8eVj9bGwR6JXZF2wqLRyaypx+CSdrDxXL8SE4/pduAUTKqqY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQxZ4YawVftdcXvT6GudfBCwbvQilT4eVG/WyFtKbTo=;
 b=s3u7yvq4buonnx3DL8E7cdwFvv+BhtuhNoHbw7kJszFBMkepw7fnCiT9VUUCO1/DK8mVJkKohIpQwtfSEo1lEqKhbQh/VfueobPmygCqP2Ifr8oI0FxTF7Bg7DisFzo9YJYZ1cvuutkTjQSzTibfR4evYR2Jq5I2P3+YqeIEv5pC9zo5RtObH5XxMPMZHY/b7l7nd6ij2ZnZOREA5V1LEzvotIL5SefoiftpMvJEfpmTVuj5YVyWV3JG7RqTI5pV6p/EDjcNLrk7OFOQPRqVr/lJk9OjrqdQ1ufc+kn38uUDhLMm2ZmNIamyhZH94GuLlEZL9zAmiZ9bVBY9h6vfIw==
Received: from DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) by
 IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 18:01:56 +0000
Received: from DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a]) by DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:01:53 +0000
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
Thread-Index: AQHdYBKBjBwQ1KDODEujGWIc0cwMXLcFf3KAgARUqTA=
Date: Thu, 22 Oct 2026 18:01:53 +0000
Message-ID:
 <DM4PR12MB61369D00ED2FCFEDAE0E4597DE652@DM4PR12MB6136.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM4PR12MB6136:EE_|IA0PR12MB9045:EE_
x-ms-office365-filtering-correlation-id: d5fe09e0-8313-4a4d-afc9-08df30668e19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|261022105027099003|261022075727099003|56012099006|4143699003|11063799006|38070700021|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 hNooncykU+jDJUl1KhkApkidJRXrpJZ21pGIjzX/1pLKDW2NqXRC7rjENlltgEK7YmphDLsLWWw8FG+cHtFgAVpva/OK4MnDHO6Xw8xyAO38qn2AEZIydIOp3Myxq6hfh75vDuN2KKRI5D+J+dTYeZBATCqOeZPWUwiV7x6vtrctMwG1Xj8jueTFA4KdsHJ+FTBIAtK9SNNtitv55MJ+jzJIOqqLtvx0xIIG0/5tt1eyQEH+3uxh7KECWqs+erRCHRFpFIRmgn47AErmqBtbju45RzniKtLL9vOVAFJsI5AC2nmHUjJ4G+sje958x8SH10EebhaeW5vv4WOIsfdGwLglmTNZj9Acn58Vs1bU6hrQ7h3K9jorVVJiH9nJ8m2Pu7bA9l1J9YCS52W8tDLZldE2OZAh6+8YAttwdr5kH8Ysnc999LQBKDP+Foi2BfDd65HTf5oe3o+Dso8BcdNrd9BJfQqjadI/0QtvEuYYIjgiG+psgK5iNqxop3dAL7na8kZOmV3Yyn8Rrv5zdrLgRBTXvgBf303QYc1a6wOMRsnxV1+0BWYyY9kKxYTeWWQNi68dIPq9cIwvJG9+0NM8CtlaUJdeXramDYhMm8PDp95gl4FnlKvlXYVhloilvG1Haui1pa05Hhu/HAdFIwAl2id6ywskJgpJmt/HL86h6Kj9WeMcIfua6R1CzufEgWDpmzcPNn0/wEK0Puwcmq2LxArJE5as98+5ZV5dk+m+TLM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261022075727099003)(56012099006)(4143699003)(11063799006)(38070700021)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnB4UUhOVktmdVpZQXFsSjIwTVNFMTcyRHVqczNrZk9yNHl4OG14SXdCY0hV?=
 =?utf-8?B?b2UxZXRhUmxoTlkyZnk2b1N2bDFCeldFSFBERlpQN1ZLTHVNTjBTT21kWk4x?=
 =?utf-8?B?SFFrVUZUUUg4T3dJcXpTbW9ZRzBqMk4rYjVZSTZyaEhYZHZRMkdmYTlVWk4x?=
 =?utf-8?B?UlMwVmtNMU5STWZsc3ljR29PM1hvdDBJdnlpcTFodXUrdml0WmFNcVpqK0Fr?=
 =?utf-8?B?cjVsL3BoMEVSeGJSUTdEVVVzSWVKSURXZ3RSajhpaWNvbFBNODlHVmc0TFg2?=
 =?utf-8?B?eFQ0cUpDSlNWV0dOYU81T2VjTTRKWUh0eW1YUEpOVkpJaWRGV0F5alhmRjJO?=
 =?utf-8?B?RnlkSFRCQkRpZVAwa2tudzdHbGgrcnd2OENqZzA3OEtwdGhRUHFZK05ENmFM?=
 =?utf-8?B?T3pVNUpYd0dqQnROdzYyVlh0ajMxNlNJQ29LOS9EM0dpdHNBNW5hbW1KbXZx?=
 =?utf-8?B?QVdMdGJkUklEVlNNTllzTlRUNlVOcVBRSXoxN0NFMVRHTURWV0J3ZmVNMjNV?=
 =?utf-8?B?SURUTTB2NHBpdEdrTnlWNThTWGIzZk90cTNDMkpiNUVPNjZrdEg5QWptQ3pE?=
 =?utf-8?B?SFB3RzdkOXMyZjVGTVZlemZ3dENpVlF3bFE0MXczNlFCTUlESnR1dlBMM2Ji?=
 =?utf-8?B?SmJ3Z1hzQ3RjekN4TmdtUWl6U2pxd0F5Qzc4aHRma2k1T0pVRmZWU1hDMFlu?=
 =?utf-8?B?QVFWQXovNE14bjdUekZWTThwVytJVVVxNzMvUWUvakM3QUQ2NE9yQVFlMmV1?=
 =?utf-8?B?TnFuaEthbm5nNHBsZFR5TExkb3ErbmFuUmhTeUtPUVIwNHFaN0dXOThDMDVB?=
 =?utf-8?B?bm5UM0pxMUovU2M1SFM4ODJsQ2FCTk5mZTNTTysvZUQvY0l0TG0xS0FheUpU?=
 =?utf-8?B?UVhaWlUwK3BTOU5OVU9OMHl0TXplT0VMU1MzeG5oVmpZUEpVSkJ2bUtpOC85?=
 =?utf-8?B?L3Q4MDJHeWF2WUVvOExDK3RlQkk3Skwxekx2dldEQndVc3hYeVBRbVRodzZJ?=
 =?utf-8?B?T1JCNzlEbnNMQU10eFZrZ0dSV0lsYVdFQW4rTlkyV0cwMUx0dlNzdy9IeUdX?=
 =?utf-8?B?bWZCRVY2SmhoQXJHYTU4eEJHRlQxMTZmV0tzNTZEeHlmWG01L0dyMXBGNlh2?=
 =?utf-8?B?Q2YxSnhzS2h3NlZMQlg4N3pLTWdYMVBZZUt3Nm1Geitpc2NJZ0hKQzFHeDlp?=
 =?utf-8?B?VnA1NW1UR3JjNkRhNHU3ZGhmYklSUGpOVCttWlp3Y2tmOTRaM1Z6UGFJMlpv?=
 =?utf-8?B?bjZGMTJ5dm1ycFo4WGYrelFHVWcwd1ZDeWdBV0xSSUk3eHlsSS9IN1JnRWtI?=
 =?utf-8?B?T243MHJ5Q1QzSHpWaGo3cUl0d1BzeUhiTkFtVXV1NEJ2NFBldGtCeFZDVDZr?=
 =?utf-8?B?U2ZuME1jK01ISFBKZ3M0UDhGUnZuQXBqbzBPNUFDYUt0eDNZcy9WSG9VcGl2?=
 =?utf-8?B?VHVFWnhVZkJXbFJwcWg4OHpWRDlmY3ZkYlZDU3JPQVd0UWowVTY0VnN3YWlw?=
 =?utf-8?B?aDR4VTNIN2k3cjI2UzhEdkNtVThyUjZGa0hCUVFlK1JRdVM0L05QbFFlTy9y?=
 =?utf-8?B?WTBDTEltTG45WmNaUHJtWFY5d0ZhQzdmRE5jS1FKVVlBN1VRQUc4Z1ZvTG0z?=
 =?utf-8?B?MlQ3Q1FsbjhKZ2hiQ0NGbGVUelI5V2VudUw5a1diMDh1Z1lwcEgxSnNiNEhX?=
 =?utf-8?B?NWRGbmRaenlJbWZZWjN0aGJEck1PZk9CdjJpbC8yaVV0Q01qQkhOWUJBVFZP?=
 =?utf-8?B?dzV1d2MvN3A2ZzhMVmkwQm9wM0JxNk9La01QZ25WWlpkYmxWYnVEZ3NzOTFl?=
 =?utf-8?B?SC9rYVYwck5mTFpWUVloL0o2aFF0TCt2RDJTeDlSS3JWa1NveUltZ2lZSEhN?=
 =?utf-8?B?QU5KL0U3dTVXZW9WSXZ2bVMvbmFFSWlSTGxLcHVCOVZ6RG9YSmZzK1dUYUNF?=
 =?utf-8?B?alpCQmN1NzhoR0lxQXhaWDA1WE1EeFlXRzFobVNEVU90RU5LSXBsZS9RWHh0?=
 =?utf-8?B?OXdvaHRaY0MxT1BiZ1NQQ0FXaWlqRXNhUE9tQ3lBb01kTVF3RGQxdm0wVjFY?=
 =?utf-8?B?Ry95Zjd1WFhmclo4aDV2OVZpWXhzMmRJVER2WGhTVHRmZk1ST1VlT1hrWmo4?=
 =?utf-8?B?YVE5SHdKYWI1dmZDa3hYRzM3NkVXVEU5RG96K1pkV0VYUWdjSEswWi8rN1dW?=
 =?utf-8?B?a3VBcVBqcmpHNU9UY3dnMlRobWdsMDc0dTZNZTZyQWZhblVjUENROVVZdVh1?=
 =?utf-8?B?UFd1Y2owbGQxbFdrNGFzWGtSd1YrUHlhWGdobVdoZEY1OWlaMk1oVFZRb0cr?=
 =?utf-8?Q?iHkc56M25Ty5isJBfG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fe09e0-8313-4a4d-afc9-08df30668e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 18:01:53.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3fLlFxOnvnXDkxKd7jvXtCL4fNHz9ZINTxsADSuPagZ5/5TKfp6mxoYG1hLMVqeVjOKC1yYy6pFE0gOS+Zsi3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

T24gTW9uLCBPY3QgMTksIDIwMjYgYXQgMDQ6MTU6NTdQTSAtMDcwMCwgRmFuIFd1IHdyb3RlOg0K
PiBZb3UgbWlnaHQgbmVlZCB0byBleHBsYWluIHdoeSB0aGUgZXhpc3Rpbmcga2V5cmluZ3MsIGku
ZS4NCj4gYnVpbHRpbi9zZWNvbmRhcnkvcGxhdGZvcm0gY2Fubm90IGJlIHVzZWQgaW4geW91ciBz
Y2VuYXJpby4gTGlrZSB0aGUNCj4gZmlybXdhcmUgaXMgbm90IHRydXN0ZWQ/DQoNCkFzIHRvdWNo
ZWQgdXBvbiBpbiBbMV0sIHRoZSBzY2VuYXJpbyB1c2VzIGFuIGVwaGVtZXJhbCBWTSB3aG9zZQ0K
SUVQIHBvbGljeSB3b3VsZCBiZSBhc3NlbWJsZWQgYWZ0ZXIgYm9vdC4gVGhlcmUgaXMgYSBtaXgg
b2YgZXhwbGljaXRseQ0KdHJ1c3RlZCBkbS12ZXJpdHkgcm9vdCBoYXNoZXMgYW5kIHBvc3NpYmx5
IHNpZ25lZCBkbS12ZXJpdHkgbGF5ZXJzDQp3aGljaCBjYW4gdmFyeSBwZXIgVk0sIHNvIHRoZSBm
aW5hbCBJUEUgcG9saWN5IHdvdWxkIG5vdCBuZWNlc3NhcmlseQ0KYmUga25vd24gYWhlYWQgb2Yg
dGltZS4NCg0KVGhpcyBzcGVjaWZpYyBzY2VuYXJpbyBpcyBLYXRhIENvbnRhaW5lcnMgb24gS3Vi
ZXJuZXRlcy4gRWFjaA0KS3ViZXJuZXRlcyBwb2QgcnVucyBpbiBhIGhlYWRsZXNzIEthdGEgVk0g
d2l0aCBhIHN0YXRpYyBkbS12ZXJpdHkNCnByb3RlY3RlZCByb290ZnMsIHdoaWxlIGl0cyBjb250
YWluZXIgaW1hZ2UgbGF5ZXJzIGFyZSBkZWxpdmVyZWQNCmR5bmFtaWNhbGx5IGFzIGRtLXZlcml0
eSBwcm90ZWN0ZWQgYmxvY2sgZGV2aWNlcy4gVGhlIGthdGEtYWdlbnQgYWN0cw0KYXMgdHJ1c3Rl
ZCBib290c3RyYXAgdXNlcnNwYWNlIGFuZCB3b3VsZCBhdXRob3IgdGhlIElQRSBwb2xpY3kgZm9y
IHRoYXQNCnBhcnRpY3VsYXIgZ3Vlc3QgYmVmb3JlIHN0YXJ0aW5nIGl0cyB3b3JrbG9hZCBjb250
YWluZXJzLg0KDQpUaGUgZmlybXdhcmUgaXMgdHJ1c3RlZCBpbiB0aGlzIHNjZW5hcmlvLiBBIHB1
YmxpYyBwb2xpY3ktc2lnbmluZw0KY2VydGlmaWNhdGUgY291bGQgYmUgY29tcGlsZWQgaW50byB0
aGUgYnVpbHRpbiBrZXlyaW5nIG9yIHByb3Zpc2lvbmVkDQp0aHJvdWdoIHRoZSBwbGF0Zm9ybSBv
ciBzZWNvbmRhcnkga2V5cmluZ3MuIEJlY2F1c2UgdGhlIHBvbGljeSB3b3VsZCBiZQ0KYXV0aG9y
ZWQgaW5zaWRlIHRoZSBndWVzdCwgaG93ZXZlciwgdGhlIGNvcnJlc3BvbmRpbmcgcHJpdmF0ZSBr
ZXkgd291bGQNCmFsc28gaGF2ZSB0byBiZSBzaGlwcGVkIGFzIGEgc3RhdGljIGFydGlmYWN0IGlu
IHRoZSBndWVzdCByb290ZnMgYW5kDQpzaGFyZWQgYnkgZXZlcnkgZ3Vlc3QgdXNpbmcgdGhhdCBi
dWlsZC4NCg0KSW5zdGVhZCwgdGhlIGthdGEtYWdlbnQgd291bGQgZ2VuZXJhdGUgYW4gZXBoZW1l
cmFsLCBwZXItZ3Vlc3QNCnBvbGljeS1zaWduaW5nIGtleSBwYWlyLCBwcm92aXNpb24gaXRzIHB1
YmxpYyBjZXJ0aWZpY2F0ZSwgc2lnbiB0aGUNCnBvbGljeSwgZGVzdHJveSB0aGUgcHJpdmF0ZSBr
ZXksIGFuZCByZXN0cmljdCB0aGUga2V5cmluZyBiZWZvcmUNCmFsbG93aW5nIHVudHJ1c3RlZCBj
b2RlIHRvIGV4ZWN1dGUuDQoNCkEgZGVkaWNhdGVkIC5pcGUga2V5cmluZyB0aHVzIHByb3ZpZGVz
IGEgcHVycG9zZS1zcGVjaWZpYyBydW50aW1lDQpwcm92aXNpb25pbmcgcGF0aCBmb3IgdGhpcyBz
Y2VuYXJpby4gT25jZSB0aGUgY2VydGlmaWNhdGUgaGFzIGJlZW4NCmFkZGVkLCB0aGUga2V5cmlu
ZyBjYW4gYmUgcmVzdHJpY3RlZCBhZ2FpbnN0IGZ1cnRoZXIgZW5yb2xsbWVudC4NCg0KSSBlbnZp
c2lvbiBvdGhlciBzY2VuYXJpb3Mgd2l0aCBzaW1pbGFyIGNoYXJhY3RlcmlzdGljcyBtYXkgYmVu
ZWZpdCBmcm9tDQphIGRlZGljYXRlZCAuaXBlIGtleXJpbmcgYXMgd2VsbC4NCg0KSSBjb3VsZCBl
bGFib3JhdGUgbW9yZSBvbiB0aGlzLCBlLmcuLCBvbiB0aGUgaG93IHVzZXJzJyBkZXBsb3llZA0K
Y29udGFpbmVyIGltYWdlcyB0cmFuc2xhdGUgdG8gZG0tdmVyaXR5IHByb3RlY3RlZCBpbWFnZSBs
YXllcnMgZXRjLg0KKHRoZSBlcm9mcyBzbmFwc2hvdHRlciBpcyB1c2VkIGFuZCB0aGVyZSBpcyBu
byBmaWxlc3lzdGVtIHNoYXJpbmcNCmJldHdlZW4gaG9zdCBhbmQgZ3Vlc3QsIGltYWdlIGxheWVy
IHRyYW5zcG9ydCBpcyByZWFsaXplZCB2aWEgYmxvY2sNCmRldmljZSBhdHRhY2htZW50KSwgYnV0
IEkgYW0gdHJ5aW5nIHRvIGtlZXAgdGhpcyByZXNwb25zZSBicmllZi4gU29tZQ0KbW9yZSBicmVh
ZGNydW1icyBvbiB0aGUgY29tYmluYXRpb24gb2YgY29udGFpbmVyZCwgSVBFLCBLYXRhIGNhbiBi
ZQ0KZm91bmQgaW4gWzJdIGFuZCBbM10uDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
L1NKMVBSMTJNQjYxMjQ2QjBCRjU4QkMyQjZGMEE3OUQzMERFOUYyQFNKMVBSMTJNQjYxMjQubmFt
cHJkMTIucHJvZC5vdXRsb29rLmNvbQ0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9jb250YWluZXJk
L2NvbnRhaW5lcmQvaXNzdWVzLzEyMDgxDQpbM10gaHR0cHM6Ly9naXRodWIuY29tL2thdGEtY29u
dGFpbmVycy9rYXRhLWNvbnRhaW5lcnMvaXNzdWVzLzEwOTQzDQo=
