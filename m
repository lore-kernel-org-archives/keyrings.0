Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795131469;
	b=2kPSTokEmBj6x3sq0RiyPIrX1aeFso1v0lbNNJlg5JdzsouApOYhR1xt5NIvwCw+gTUj
	 tn+tio4YdMaajqgrg4/ksxRaU5E6c5OKaQRz1rz4clwxrn08B83mGWsx3kN32PV0oOcvn
	 ATv9Qc4DUR2Loka8gcsd8oF+TvT94oEF1zoHCh13v1V7GK+1ap6Ke6aLyNBLn9mPPj2Dp
	 MoTSl2rDnGDZ7Zcme5HI5zS0IFGt7lmVVXp1c9ZBuCf8x/q1YmfxWkLZLc7i8krkABqfd
	 LOclFlAySxZxu92qA4r3KxyPdkG5KPVTpvnDSl9PqDUf7Ce8p4TIDkBolM7r3QvtNdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131469;
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
	bh=3W3BEpopRHrA28FnbTo+KMgeFZlTTfszsznmzKm7qTo=;
	b=aPAPVCUKjgreQ/7NBI7zMMpPxUBufi+IFd/qH6ecSbhThZoZpHL4t/iMFKP/77iheIdK
	 cWF18L+uLIQAwCpL9DbV4kJYpfk7YHBNbUfJpLIF7J/bSSOSYD6sm4pv1AX+YGLn/X32Z
	 3KjjmzTGPzOo2jhF1CKa10oYcfXg/coKnJRjnnc94TNAu0Zxw2jPYLKu3LVGQZixgV0aT
	 +C7tFoC5eV1CQLPxF/AzfBt6804DtVANng39otfDVi0iNF75dTUNHy48kaIkGrVcuxXH8
	 QYhcifKYL0Gf3PYdsaEB/fDk4if7FmLb9x1FHXyNECP5BRlEv2JzyaR3Q11tjzxm3Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IcT+QyZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.47
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE939606A326;
	Thu, 19 Nov 2026 23:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE939606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IcT+QyZ4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdOFjry2z9Tk57IdRF0MYG1TSulLknvZTJtJn197ueuSl38uBc1tMFdObCseSXDo9bkWBFWxdkGf5jWiaL8FFOLUGA6Ua/6OHfdMQadWjEAOCx9YhpQvpr+mLv8MccFZO4kBFDqVIXukKwjRpdGybo4CJmvioYBkXP08/dn9mvMTE+MQuSJ1D+a5HZrRRYHor7dP25WiMAfWS9wxf55cDpcge2VNqCLR1Pu04sC6PfgFzik97zZ3k/7XrlcfvOoNqikes69mawKAphpgPGZWUd6ueWrjCWhd86rmk2gOUOexiUcKhYgSVqyg4vp3Rdx8PgBOX+/mX7zlXWP+7yQQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W3BEpopRHrA28FnbTo+KMgeFZlTTfszsznmzKm7qTo=;
 b=lqVdzjBGO1YEuVDxloNNCX3bCYWSVSQ9lRpWWYxmKcUMwbTa+HXD8vt9utGySyvepM2tiSgdq0qf3jglB+D2ZzEOLeW70VYJXXH+GqODRudFVMivhzG4fhAPz5BtqpOnneUTLgv6xwYGxu++/wS9N6L/s3RobKSefJdYLqgmDcsRmHwyX4U+V5NwQMaOTcfZXmiLJ/tfN3xmcZAyu3byiNNmkxmI6HtRc4WX5Os9wYnXDPzYczWBd1V+4lPnKKct108cnzUx9sobns2hDs7Q5y14gJc9RgYGimV0h96bYcrfk9FuJdACLtN35fAER7mplgUC/blkqaSygOs20NgXxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W3BEpopRHrA28FnbTo+KMgeFZlTTfszsznmzKm7qTo=;
 b=IcT+QyZ43/34P33dGQwLbFpKWKQGeOaXogpqIrAGJJbjkxIiD3BIIibw9d1tv43STlfm9nmVFSWNyB+RBK3xCle+7N8EncSb2NASrRFsOUBWwkoqFQWwE1/ehbMqIxNifdzY9pveIrUucEkcWqG+1jopdSQq21d2aYldveJ+P09HkQ3aG6UyEX21H04A/sJUt99Jrpg7G4U3aEpEnxf5gQHRLal0xQi4hkGiIz6YwJZ2Q9z+k689CsJkHfJL7NzBt3Wfm72HApwg+GH26AGNGf6u6U+CXFIFqrsH4cj/TQtpE8EItZmL4o2Ytx+4g4BebXoXlVPfTHPXSlgn9tE6Zw==
Received: from DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) by
 SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 23:37:44 +0000
Received: from DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a]) by DM4PR12MB6136.namprd12.prod.outlook.com
 ([fe80::75c4:de57:e254:243a%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 23:37:44 +0000
From: Manuel Huber <manuelh@nvidia.com>
To: Andrew Halaney <andrew@amutable.com>
CC: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, Jarkko
 Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E.
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
Thread-Index: AQHdZzzTq01P8UHk60+Ce2yq7RogGrcU+wSAgCEx93A=
Date: Thu, 19 Nov 2026 23:37:44 +0000
Message-ID:
 <DM4PR12MB613619C0D9857E94C7C06B0BDE792@DM4PR12MB6136.namprd12.prod.outlook.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
 <auOn9CzT_gku-5cH@toolbx>
In-Reply-To: <auOn9CzT_gku-5cH@toolbx>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6136:EE_|SN7PR12MB7299:EE_
x-ms-office365-filtering-correlation-id: 44a88353-1e3d-4028-84cf-08df46961c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|11063799006|261026121527099003|56012099006|4143699003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 hSN62qfkSeJGYthMdKD0U/ny4QirEzqbTjGoQqWM4Qkc7/DYJDxFfk+vAZx1DpUvZCuoyrS/VGDjQhROG+Kedxlbn/cicThK5wfvAALRqWB5YfyJT2srssAp87uFsRkjqdApVujSQz/1vK5N7fneteZqVrA9SqZxjTsJ04/EhHURtLqebSnsuyi7UjfVWjKoJ1yhhMnozLmErAchAVumO9Bkb1JOnTWu19gbKPLDWoxGBSAm3Fwv4eUV6jmuJzRGwBFM5tS4fw2cnNtW+xniyixMXI3fetJXua552ep8t+dpiGMnkzISHLhFbOPqje3SXQek1RukY2Ecrk/frNDSAnRjqoIxk571b1A7pme1/mOGg/Or8T3p9vbG/yxELFdCIZUR6nClX3In8kj6gNOAgiCSaSTgqehEmZngtoHYRBHWSl+wpcK8iggrTvJxT5UFsWswKvWyKlH7o0Vhj4yIQNLGI1WLtUVQoZ0CZ6wIdUG02j6mEq+6u+ygeV8MgoalkidwT64G4jiCb3pH3VTqwWYIvKmFwDovRwm7A+vyH1hWklNcyNKhA0BBwNzZn/3dlVJ9kRdzW2QVmSdXh8q9anfmO5EC6Ght/We2zGqkR3bqCnjdqC1pUJfyMtLTtKLnZ1/8JWkHZ6TA9OFekefeGBPDWwd7a2P8TxTBTGal/YsxqeLVjAmbTJnk6Y55Pxwdut42wbEL5PeZbxjISjHmvD9ru6khB9WBKWqQkZFTDYg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(261026121527099003)(56012099006)(4143699003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iuaxQHwfxIomh5uJUHU5tiBdTmZvV4mFHhLK9a1WPZdB+ZpP77GjqgK1kZcc?=
 =?us-ascii?Q?ouv8OAYJuhvLZMMlqmfbim8TV7quv9wu/cikLbKzlDjXwdAas3WQ7etFcjQD?=
 =?us-ascii?Q?avZLCqz4a8LWfZa+EIbS/QfUTpw+6o2NBTvLPhpHHNxbkMiamGuVwtxok1fN?=
 =?us-ascii?Q?N6k0gPk0U5A/3pBpPWnIPQkKmtpbwwvC5i2J6bCpqmoKuEykhPpxv1m//G2s?=
 =?us-ascii?Q?5FBRxOiQUwA2sf45tS3dm2KNEvUYnSt83UtV4iSzSet+ktKJ4lbZX2LUwzGz?=
 =?us-ascii?Q?HLFP19lS0MZyJPjaBiav2/xTlMtfGkdfVrICAy9pLko5RJBFX/zoXaU8mekj?=
 =?us-ascii?Q?eiJA4g54mdjVUlVtyknK9zDs7UpIevYKEkYMvxjdGbJdoZyU4mQay/dKnEm1?=
 =?us-ascii?Q?UmVrXw1yufBHiCljoubrAcXAQNJ+3gmOo19Wagki+vzK9OJRj1PV8bcpYoPK?=
 =?us-ascii?Q?DdOJLY9QoFBI7cDDt4dCQAuNrwHX3kuk5PnBXEl6ayAFQpoTVLCT5//Pzp5g?=
 =?us-ascii?Q?/EaxlBz28bE/YuXOqrmZLYjngnjY6TONKhcN8+6StH2H2ETeDbJCtff3I7i8?=
 =?us-ascii?Q?P1JykCEEnzKA7HhhtA7YNiXTANvJAO8NSInDa4uytHbdWdfO2kgBc95eSUS2?=
 =?us-ascii?Q?HPW8Vsq8yY2qkAHItkYgIPqE5fxOSQkVpvGSJ4Jvwy6nrvpmKqJ5UWSISmTl?=
 =?us-ascii?Q?uTPf84kxVS69u1ELrG9DM4+yxNzs4oClgPxJNJni+qlNcMvWKwrFHggVGxyB?=
 =?us-ascii?Q?5f+3V0iQrbQOWlhsJNQc3oAjmF+MNdH110eVELz+JPvpJxs0u+vKaXe8cC5U?=
 =?us-ascii?Q?cp6nfFZOz+M4rVVGWlFbm4qyuXKOSifRvLgv1ZibQ+JtzvRRJjjICrDHy6ba?=
 =?us-ascii?Q?ucG23Eb55CmalCxpvktHyVV44g17F/20pEsvnXoqacO1cxMmwfvbPTwrUpRd?=
 =?us-ascii?Q?PN0+5OILm4GSM4ndD9iZ8w7bQpExpv1J+jgxJYdu0Q1PNsxEEbl+KM3+lcB4?=
 =?us-ascii?Q?530lRY/U5te6VSBH8xl7B5PPA6+7x411K7fmWZ/x3/3puRULRy2tHUkZ/Dap?=
 =?us-ascii?Q?jCnP9zEQi5rkSgDUM70TUTLoCdZcTtGem5X9aykUAhTI6V3uvfj2q0MYT7SK?=
 =?us-ascii?Q?eV7wuINMjforgfzTHNv2AzVTMtn8xL/NMyPFLSV1YsaehMsrjxhrNUSP5Joq?=
 =?us-ascii?Q?O5E1RF2hwsdez1FXqE5LTuGUSdmpD6+SC/3+VVXLdijT8A7gQ1y5r54evflo?=
 =?us-ascii?Q?t1Gs/hLyJq+vuDBemJn0aKJW2xTHROlmmCsmnG3vNaNERhu8pnAi78QiIb2i?=
 =?us-ascii?Q?OLI543GcxZUhV4s0PeLKAesPy5kmv9c5ArfGZ0/iHNmJLnYj6uvxj3CMpMjb?=
 =?us-ascii?Q?79glPILoD9LY//D/KoKLANCvGi6l6gmkzrZCixTTj8DHXfMlwrS4tIlBJPRw?=
 =?us-ascii?Q?9rjsksOXexzSYt9OY3JkmMf+aYnwJvJa5g9Wz71V0tMQvXigkkp4ttGUbo16?=
 =?us-ascii?Q?2nu9EztGZ/iuia1S2Ru0J9XXXGE5Yn8/x9uKcwqyyU9W/BbpvlpYX2yMn2Bm?=
 =?us-ascii?Q?Wzju7n5Wl3mORQlq+lchpxjHL/L/75O3d+LrGgeqzYK5tsD90VgH3viNCirb?=
 =?us-ascii?Q?ys9AuFZKFu+nLZPbJiskmyI3bINo6fxaeI+2zQihtve1MDMuY1bdx70kbTYt?=
 =?us-ascii?Q?OyzvriaDNFHu4PB3erMRb5kDeZJiPbbW8G6JYMqsD0xQnfHT?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a88353-1e3d-4028-84cf-08df46961c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 23:37:44.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjpN326nlHShgjWQF5N1UNMQu/exIzIFn8Fbv2OBrmzQ+SZ0U/U8CHOsTMSGBapzmkS5w9zG8F+/G7gwfOo3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299

On Thu, Oct 29, 2026 at 03:33:25PM -0500, Andrew Halaney wrote:
> Not trying to muddy the water here, but I stared / thought about this
> a while and wonder if I'm missing something below...

I do not disagree with these points here. This current v2 is a result of im=
plementing the feedback on v1. If we do not want to use the pattern from v1=
 (alignment with dm-verity, BPF keyring patterns with a command line option=
), Andrew's suggestion for v2 sounds safer despite resulting in more code. =
Either variant - v1, or v2, or v2 with using the command line option - work=
s for the use case I described. Fan, did you make more thoughts on this in =
the meantime?
