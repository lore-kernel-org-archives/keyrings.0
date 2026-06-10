Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB340FD87;
	Wed, 10 Jun 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098672; cv=fail; b=lm0jYmg4kHDtG7I5S7rOVd4jQDY9j+ocpSF6Az6CrMvGB7WG8WKZE00hU26RGCdC9+HVaVJ4/Lw3sT61x+q2Zh2Ccy2M/oBMCHztf4Ai7kgDtdxlxmhFzT2P9j0gyiIeAlR6PLJsk1k49pcUQ8Llz1Y38ukxMLvTU2KI2rtf1x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098672; c=relaxed/simple;
	bh=1B67xZ+pE8Rj0uZyoNz7diP3HQRqUfrBf50Jc7FGNzk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qbJVD7NjAglSsM42sZQ0Ig8rZm9d0xv7rXCj6Zx2zqHD1E37A2HBq3TxgRBXX4uCwHljwrXdmufUGEK07ImAUFnFLt5hBaPdu0gCx4MqpPjxmk9XmzsZQbi6QuuITVs6Tfr/K/f4EXCdNw6af5M2DeOTmilwvfZuzoUXqMfo2mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=re7dAGUM; arc=fail smtp.client-ip=52.101.101.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="re7dAGUM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qds3QH9/NIulGPoaFP6R1rhdXtUjY2A/UbXXcGwF3fX418CIKQIF/HmmQiXJfK2tkx0lqlU0eUGOfYONCpSnRP5dgw0NYAfMdPZJv2puncDnuGwDQPNYBBiEliKyW+tzyptfzzTciEbSWc8mKmGUR9E6MSAWA5BAVIL4vh3LFQGqKmIhMx13Zrjmz6E/N/q7Y81hyAI18UsPTbnXG4eqMa8cmD7WEiBokbyHznLSjDnSzW7ddPyfKZMAwUgnxOKJEdI3kQrvPdGZWbxzj2BDeDvKOBEeaYoFh/O4lXo87Yrlgtt39hSMskK6YDBoVXJnXPJuuB5My1OWpG/bDaupTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B67xZ+pE8Rj0uZyoNz7diP3HQRqUfrBf50Jc7FGNzk=;
 b=lokiBGqHjWiBehPgyMd/MHA/4TZXf3jE0ha6DP50qsHz13TPIOoCfZvGrfTm51MVDmjO8Tb6/PZO0c4I+W6vxBcGr10+frXisltMQf2BvKHylVTW3PiLYO02azoUc5RPpnPJ+hfvtMCNlU++rpWxj9Q1BjjlCQ/nYPb/poLzINY9e5+aHwEQDX/0NL+ujfO5eKm5UkXsX8vZibOVwz58U4B7+TE57KHjlECfhgDX5t+5NFgoJrK3XSG+uqZdXUxR5t80KqndlDAsVgjV7sgI7W9ftO4fmNjWhWo+azjgASbCiJh1iRHsxOEykbxr4pSZ4XlalUfnOEe8XQmGbRA6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B67xZ+pE8Rj0uZyoNz7diP3HQRqUfrBf50Jc7FGNzk=;
 b=re7dAGUMFMI4/6gZe2A/VtsK+iDzhEJ6k3n7gAGUEytm7z/qbFmS2eqxZ+grEpgzpUCUeXl0Y6REFFl77buJHdUE/IUuVSLEjV+CKG81xcLzTeK0ilDZ1z6WeDxKkK7zV96qWmvvD49SmyOGQWB9oFpaQxT+vuaebAAnUBNh7Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB2035.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Wed, 10 Jun 2026
 13:37:42 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 13:37:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 14:37:41 +0100
Message-Id: <DJ5ES5DZ15W8.2KLL7VS1JMQOE@garyguo.net>
Cc: "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys: allow request-key path to be configured via
 Kconfig
From: "Gary Guo" <gary@garyguo.net>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260607134928.2832202-1-gary@kernel.org>
 <aiZJ94eugtNHcILD@kernel.org> <aiZMT5UYhVDlLVHq@kernel.org>
 <DJ3LJFFPMAOW.QA3EZSAB2S5A@garyguo.net> <ailfPUbn8gbUqB1D@kernel.org>
In-Reply-To: <ailfPUbn8gbUqB1D@kernel.org>
X-ClientProxiedBy: LO4P302CA0013.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::20) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB2035:EE_
X-MS-Office365-Filtering-Correlation-Id: c6575b64-f3b0-4926-c955-08dec6f57249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gKTsZzZ8Ev+eKCXfN3mrL4FK7Ls3OxOTToql2wME3cHAXKs5+UcSr3KMD8huSqI8EOrjn8O6/wPImBqMhG5AjwyrhGUxm5iE8/mFSIPs+oDNx70Qc74Rt3ayEfJskWaOi4mTvn4X9coy7FKXvMdemQYtqyY+GmMdhjmOJ60AEkLNx7IeeNTwAlmR3bM1uXkxvsHo17xkTySDMXiYfLDEr1LuU98F2yKQOVrkItgaa+2r0L+hUghCbnjOTex79qVYupcw7qmzNb54rIbnr3Ji3tPCwbxCd5Djjnpe/O4g2pZQw65wNGQb9ZXf3VtXEHzOHv/jQVehCx9VyCJSx028aDuWRkJp9+uHS4feWU7FH5z8Y1oKLLtqZLv/s32nNX+2XvTqIaN/boL7DVk1L9IRYWPcqLECgfuag9OSvp/PerYHZu3RPQlbVt1If+eiaa2GxRoGPhD0oOUMG25LEvcK3Mq0WB4fEEjUlptnbGG0ccc00rfE/0ltxIRQzZEty2RSswuUMJNnmlVNZHPuFIxPJFs89A58OMXrIbYSeUD7ulILvXtt11SZT2oV5d8u1wDQa7xcJQog4+55m88be5UxFSzg13PMR0T3EY19vzi1qkMOaOON6Wsftv6btLJyroAd2pWDtk0qJky9AnJ9qd0lOHZB06rUwkaS9/ExgveOlAqoAWtf5QcJCTMaDnz9ylFm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ZSZFJWU0ZGUTJhdWJNZGFQQm5JbFB1bHAwdHYydGZnV2tqRGtubEd2S3NJ?=
 =?utf-8?B?aDlJZ1B6SUdPbUZBbkVIN3RobkpHdGFoWVNpU1FLUFgxbHJTVi9Lb1M0L2xq?=
 =?utf-8?B?N3FEclVIQUNPL2RDNHJBTzZyQmFjSDlCT09QU3A4Z3NXRGVlRDFiR29CMk1Y?=
 =?utf-8?B?UTNER1JMR2lqVWhXWXFzTDJzOHpKTnljcklBWURPMVhISG5kSjlKUnZiU3BZ?=
 =?utf-8?B?aTdvM3RYSVRQMW9wL0hhNWxmZHFQVWNFNmU4eUhrMEp6K3FKTS91b2YzaFZr?=
 =?utf-8?B?c1JpZ1lhK0owWC9hTVB0Z2QrNDhVdExUYmZReXR3a0g3aUpxaHNqeGtDN0Mx?=
 =?utf-8?B?UktaWnBWK3d6QWdzWWhDU080N0VYdVJBbGIwdVA5SFV1ck5KejVVOWZTVTJH?=
 =?utf-8?B?R2xDZ1hieDQwRFkvOERMbzFRMmNSbjBTdVczMzc2ZVdwTWMvS2U2OFpITE1U?=
 =?utf-8?B?U29RTmxreWFWN3diSmVQcHpvQ1I3c3ZkVW9EcVNIa016Mlg5cEc0blVORVho?=
 =?utf-8?B?WEltaGpaUTRyNVEvRUhjRGtRUm9pd3E0YUJTR2JZb2RSVVh6QTJvdDFqSzFH?=
 =?utf-8?B?c00rS0VuUXVOWVVkdmI1OGFZTDRESUI1Ym16SVFxRlFBNjdlL3NEc1ZWQkFP?=
 =?utf-8?B?N2VpejBIbHpmb2dxT2VYdXY2d1VaNkFkWm5RMUo0TlRIZFIvMmJiMlRKWUNH?=
 =?utf-8?B?VkdYYWRoZ1JUcW9YTmxGVHRDZUJEdzBGOVpkWEF3TlQ5cFVkQ3ZZdEZzTjFQ?=
 =?utf-8?B?a1ZFc25oQk1TZnN3RFYvOW92S3BrM0NKTmw2TVpqbFZFT2hJTC9qNnhBVndk?=
 =?utf-8?B?djQ0UXFIS2hPWXZHTjJUbFY5bW5lR09YdW9uVis0aTBYekZNV3NRc2h1Zzc5?=
 =?utf-8?B?UWp6UmcxVGpzaVNkeWNwcW1MSGt3Z2R1ZVRKUXprY1R4OFNQSnpEaFhRNWtG?=
 =?utf-8?B?WENwL2N2Tk4vMnVGVTRsdHhrandmUUhndzZIQkR4anhsWE5MdVRYWkRIN2NE?=
 =?utf-8?B?L0JsYXgxV3NvR2dqQ05zK09JbUQrSUVlMUc5aHI5WC9LR2Y5ejRzSU1FdW82?=
 =?utf-8?B?d1FqaDVKRDNsUy81cTBQVmlFRHdYYXd4VUZYdzQyby9CcDhLdG9jRXUxZTg2?=
 =?utf-8?B?K1BGKzZ1ZDZqZFVEaGR3WHNycVFYQ0gzQ3pWNGZzRDBZZUN0YWNYcElYaEYz?=
 =?utf-8?B?THR4WEY5SzJxdFFsOXNQTWhaWWtFSTFNWnE3bEpUTUp1YmZTUzdQdC85ejYz?=
 =?utf-8?B?Q2U4cStBV2xJenJFaFlzeGx0ajlXZW5RNjcxcHNXcjMreWxHM2xVMHBaeHZa?=
 =?utf-8?B?YTlnOXhEN3ZqYWJ2ZjF2QnZheTFza3dJR1B4NGM5d1pVS0hUcDRxVUNzZUVk?=
 =?utf-8?B?aFkvRVgybzdRSGVkdnZBU0RNY2dnaW5CY1EwVXpIdXNZV0RxbW5seS85bUt6?=
 =?utf-8?B?WVNmRXpyWDJJTlhkL2plVHRnWHBLRCtYc01rQXFITnVyVlIwQ3Nsd1BVSWdJ?=
 =?utf-8?B?Q2o5bFhzWXJPeVV6bVQ3ZTllMENrVDV5QjREQnlPRllzbUZrWlNybmxzWkFS?=
 =?utf-8?B?Y2JwVUtvc3dKdkE1WGlGWWt1MjFJMUNqZHdsOWowZE5NaEJ0eEljK0lEUVRr?=
 =?utf-8?B?Z0ZHZkQ1M25NT0liU2Jqa1FBUDJQZDczM05CYnJuR2ZleXArczRQV3c1V0pE?=
 =?utf-8?B?Z0d4ZHhiUFpid1ZoZ3ZhSkFVY0F3TXFDOWpVRXJzSDhoVll2MEtMVlZNTTYv?=
 =?utf-8?B?NWRmemg3NFRybEVubnBZbnhBU3BYdEE3OUxha3ZmUlc4RUtBMUthaWt5QUtr?=
 =?utf-8?B?SjdTWXRQYzU0SDNkR045eXNsOGVWL3NFQm10YjhVM2o2UURJc09VaXRvOHph?=
 =?utf-8?B?ZDlaMnBvRW5VUlZudk83NkNmMHl1M1FBdmVHOTAvTmpoM2g2ZVFJbzlnSHBY?=
 =?utf-8?B?OHdQZlRyS0VGSytUR3ExN0cxOTFGVDVwa2xhcEwwVGUrdlZXdEZwaW44QmVv?=
 =?utf-8?B?M3A1NSszV29mTnU5K1ZBQ3hBUkVwZUYwaEYrNUJidHhrZUJtNkJjWVBOOHBU?=
 =?utf-8?B?NXZiVEk3akpXN29Od3JRNEQ5aU1xNEJrR1ZXNHpSZUNkSVN1K3AxbmlLYi8v?=
 =?utf-8?B?S3JtdHp4T2N5NWZYLy9CcGJicGdvMnN6VCtobmUrNS9uOW9hazdTQmQvajMr?=
 =?utf-8?B?RFk5emxtdnRYRW5Rc2xKUmZ4VXhSb250TmYraHNnR1JpMHVERlQ0SFNodWpI?=
 =?utf-8?B?aW0wc0dNWGp2bG9ycEp2amFLZDJkR2FGZE9BcnhvNTBEQjZBYVVyTlpMMmlC?=
 =?utf-8?B?WGxZU0JPaGxUYXZLVE5VUHBlckM1ZjNIQksxamtiK0x5RFFHY2VBUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c6575b64-f3b0-4926-c955-08dec6f57249
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:37:42.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3SdyvaVOXpnOfxORm1Tvkm5tvqsmWIIiJoFsrTcViFZN3booMwVL0IHQXWh8XQmg64HduOJ6/d9LOMwUChsCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2035

On Wed Jun 10, 2026 at 1:57 PM BST, Jarkko Sakkinen wrote:
> On Mon, Jun 08, 2026 at 11:30:06AM +0100, Gary Guo wrote:
>>=20
>> This is really just for distros to be able to configure where /sbin is l=
ocated.
>> Given usr merge and (some distros) bin/sbin merge, the canonical path of
>> request-key binary is very likely not /sbin/request-key anymore, so it s=
eems to
>> make sense to me to allow this to be changed rather than always go throu=
gh
>> compatibility symlinks.
>
> I doubt there's a huge demand other than NixOS. Just basing this on that
> no other noise have been made so far.

Just to add on this, both Fedora and openSUSE for example changes their
CONFIG_MODPROBE_PATH to be /usr/sbin/modprobe after /usr merge. They still =
have
the /sbin -> /usr/sbin symlink available, so it's not like they cannot work=
 with
/sbin/request-key, but I would think that if the option is available then t=
hey
might switch to use /usr/sbin/request-key, too.

After all, why would one perform a symlink walk for no reason?

Best,
Gary
