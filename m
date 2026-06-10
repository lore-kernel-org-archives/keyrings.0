Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021100.outbound.protection.outlook.com [52.101.100.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181740B37C;
	Wed, 10 Jun 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098313; cv=fail; b=CsiDOx8j1gKwdxzrvtfLka8/6a59vveOEuFenmdUaLLP1CavxAV3zz9oQCoRrUFzMEOnQgIFHFCrxQMRgQkE0vFjUF1cdtyAuDYmYNuYbjqKRGel19kbG7RKqlg6iF0a/Resv3hHO/TNofSXpu9SyhhwY0vKa5kHsBHsTBKparQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098313; c=relaxed/simple;
	bh=f3y/dxWleHLa2IcAwGp5/qOmP5o7FYS9MNNugswNc2g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NPreBZqTTozhqAFLooc7u51R2QnQOIyUcn3n5wZWtUG+7/BdRE7HuDafqt5TJrGJL6AHIoKseb8z+W2t2vuau30Nm82m2QfC/hBgROrzqdLyGHYfjbdq9TJ1rDpjfI9ARtLtvoulWeRNLb2UclOzTXRxZ2CZzgo86XqqeQxlx50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MUjcOnfI; arc=fail smtp.client-ip=52.101.100.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="MUjcOnfI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9dD2D50uqJ0e/aOUIPKbbv4d5G4/YSQP0g3UDhpSOGl3y+BwJzsdkRzYCkXP8Hyk449mSyF5WU0c/om9SHeeXsbtiwN+y73A81tF9T0/aotj8GRH+CkH5w+JJz7bHMGc7nKTyECN+DLPGwmAUOKM0F5jpdWo1ljSaYL02PGmkgCPSK4h2VIf2KgD17uoJhSq5akzQgrGQ2QfND4aZqRB1pImakFU3WWz9AcnX1i7nN8SHBeafk3+mGAHUu4utSwGSxSlRVDXOfDscPkljE4Fz8LQ+1dYRBzrQXO99rqf+X/OHWkyqQCyeV49V4J5At6JzdbxUkFC/Codvv20TGGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3y/dxWleHLa2IcAwGp5/qOmP5o7FYS9MNNugswNc2g=;
 b=GM6zvy8PN6jhfq8zKgO1XLaaTMH+eh3YGP5j/EL28EoMWgrrcTR9yW/vUMFwjYc6me5906ex1OmffXoEHLoORu8aQxZPVIvH2+v7NI3B9BAqux81pUtOf7ztkPjmFTHpd4xZKLRGiBzWNMCC4DEr6R/sHf72LYxRtN1+vW88lnAC8ynNhinkxbQdYqPpxnavxMmMdnq58Oe9CKeZKWqLkyccKDq4SdjNUWW2OFIhJMzEc3SeaxLcy+PxImSlQrZGuo4W1Nj01CxqSEJkRd44MMGz29IAMaKFungmbtXqmyT03y4UAHmLUpe7lJOtcMTczxXT+Zc99DzfoUOOilhRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3y/dxWleHLa2IcAwGp5/qOmP5o7FYS9MNNugswNc2g=;
 b=MUjcOnfIXe9KmDpHlei4Cci9hPizyFeHOsDvMS6YooniH8KDY8u9oapkTCsMbf794spVFzI4DpCZzNYG0UJQ1kxX2NpstxUikl5j5va1ri+aepDOKFKIH3CpQJ9zfz40JbrISak8G8AhUuyHdSTnhC9W5yb/7tF9xDFh6pIvLKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CW1P265MB8447.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 13:31:41 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 13:31:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 14:31:40 +0100
Message-Id: <DJ5ENJM9BACZ.27BGMVKTKHAZD@garyguo.net>
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
 <ailgG5JF6Qu_6v0P@kernel.org>
In-Reply-To: <ailgG5JF6Qu_6v0P@kernel.org>
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CW1P265MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: cde0fc61-140a-41d3-9bc7-08dec6f49b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|10070799003|1800799024|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uM/4R/yn3JIW5SlLsPJ0WvBIH9k7hufufbbzxHv49ovGFi3TzAc2SOBlALXK+gkUb5u6esqiOhIdvB+L2jjYzNWZc2Ky+M5eNZ6cKxQnE3RKp8peWagnyicl/4GaP/GTaPTyRlj788SCoNXbSBzwcP1DR218T8G2zDZkZzfr2lqUptJuCqCFrkh4FZfvFUcdAHeFyC7H2d9G/09LUt5eZIqfrbiwQhAPZUUmDrQRWW9whFqTcbGvAQBQ6n7qoCX+ijG0VMMNda4HNSthk1KNX7i1TBKt/4bJXKYwoIDZIipherypsNsjW8GvgtP6fDtXxEr/neRkyDLaxOiOPH+VeDNfGKIJDxD+dOAomoPfb928FrRyI28j90O8sHy8cfLMAAHlXpt7D4HCB3aGO5ikPc5yeatdRUy+/Tn5H6Hp981MJfO7Y7yQyBRySZxzI5HeZuz234y9gU0602kTRlkbiAxKLS45jyDYIqcsWQhsVm8bC4sLc3zfEYnKSN8Uk30fra0DkPNL0ediU/Bck0Z70J2GNDeYXlm20EMTMQz+5ctXNsBjsdLt843J0ZMU5Ks3pOOleVQCc0Vc/3oOprzCKS0nMbVEr244jaAzzDBZS20H4s3uJwHKt9lKdST4Um8+8hoLFiBfu4pjTpteFc4+Nh8TkvzH6ivnFfveOjZqNt5uJM9zHGv+5QKGxLeYHb84
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(10070799003)(1800799024)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2ZzV3VCSjNpMFl4cVZVL2grTHlvNnJ1ek1jRG1wY0laTHhCSlFQa0NWMlVK?=
 =?utf-8?B?Vk1EanZsWmQ4QlpLVnM4VGRQeW9kR3lxeUtEL01vM05pck8wYk5jNUN4bkE1?=
 =?utf-8?B?MTI3UktYZEt6TnZLb1ZnNHpJd0tDSStuU3NCRWJrRTRuYmdOa3pIUGlNSktj?=
 =?utf-8?B?N0FQZDY4ajA0SElvS09mR3dwTkZ6YjBnK1NHK0lrL1lEeFRaQjh2RHZSMklS?=
 =?utf-8?B?VzhxYWJZK0duSFhTSFpsNFBxb3d1djk3R0ZWZktYQzFWZnFKUndoUmdUb1kv?=
 =?utf-8?B?ayswbmkzZDd2bzlQMnU0VXdqQ3B1WWdMcTJkU21YRmQ0b3l6YXBydktoNFZk?=
 =?utf-8?B?ZUlFazJhakpDakdudGNpRVl3c2JOQ3lGSHJ5dGhjVWVsV2VRQXpZRktlRmVL?=
 =?utf-8?B?dWVBTmhWQkZPQWRpVTBnRjVZZExia1B5MXNSYUFnUXo1SDRCbEMzVmZ0ZnQr?=
 =?utf-8?B?c3FIV1c0eGNkWVlzTHAzMElDZXF1eVF0a0FMbVRwemNqa0F3Zmkwd1RzU0RS?=
 =?utf-8?B?UGZwNVk0azJqVXllU0cybmlDMlcySFVDMXMvVE1DQW5oS0Y1cldUUnpiVXdt?=
 =?utf-8?B?Uk53dEtMZlZxdFJSVUplQVhmNVNKMjhJZ1MxaHA0YmtPOVIralZNaytOK0Mv?=
 =?utf-8?B?VEMxOHd6MXA3OStoRTdqcTRkR0xwYW9Gemx4OVlYRXJMa3pDKzRJUXlQU240?=
 =?utf-8?B?aDNmdnR3SDY3UGlFSVl1dHBJZzFEMXFlYmR1ZWlvcXBLYWtRL05mRnhndith?=
 =?utf-8?B?emlML3FVOHRDSHBYUVo3ekZtWE5jMUlDaHRJRzhadUVGckFtVTJMZjVTOHJi?=
 =?utf-8?B?RHRqRjhrL3J4OEs2alE1SG13WmtRelpIbHZQTUx3VElZVlNtdk5SbzJWQkhP?=
 =?utf-8?B?dzNEYXJwbUVuM2dNS0MraXV3SjVjaDhick5HajAvSzNjZDU4c1BXa3JPNDl5?=
 =?utf-8?B?TmhqNlFaaGozN29INTNQaG5SSGZ4WUQ5eCtyZU5YQmllTTlXVEdjVDIwcnhM?=
 =?utf-8?B?aTlXUzdEYm5sbEFxUTMxTGtHWTFGQjZhNGlBQXl1NitTbGtBQ1o2ZG83N0ov?=
 =?utf-8?B?SnZkaWE5QnlKbTVVWkhRMEdzbWw3YndkUTRMdlMwNG82aXVzaG5tQk1PVDhy?=
 =?utf-8?B?Y3RPbDlBOExTWnY5RTloYkV6WFI3dlJRV3VCV0NrR2pFY1orQitiTXY1ZlQr?=
 =?utf-8?B?WTFTaU9pYm9oL3dzN1ZvWWVmdUFSUHFjbVQ5Q04wQS9VaUN4UnV1cjBHaFZJ?=
 =?utf-8?B?dlNqYlcvM3BuR3hDRThLYU9MY1p2c1lnT1Jxa0FXbkNlVTJmUDZ2RzdEemtI?=
 =?utf-8?B?dUNHcHkwWnhQRjZGL3VBa2w2Y21jbzBockhQQmFFY0YzSTRhdWRSaVJpMFMz?=
 =?utf-8?B?MGNwWE9WeXVLNkdaa29pcFFCaHlwdmRxa29pWTcrZk8wOWg3QU1iZS84QTFj?=
 =?utf-8?B?MFJyVDVGbHpSdjNKeWl1TUQzV1E0SEluRXR6VmRPSnhLZWUySDd2RFUxTjBY?=
 =?utf-8?B?NEwyL1gyRlpGU2dBN2NqUnRKbENoNnJxUjRMTjU0eGNZTlJQODJDa254dVd2?=
 =?utf-8?B?Wjc2SlppMk1zRFAwakp4TkIvSjAwMVFYKzE3L2w5OGlMTFFaclNMclVrL2pE?=
 =?utf-8?B?blpsVVY3cno3cGt5ZTQrcDdQczRGMUcvOEsvdk5QeCtGdWRCVGsrT2lKcGth?=
 =?utf-8?B?UTdWd0xTQTNNa2ZETEZTQjlZWGwrbFZCUW4yTW5wWm5KbmJtcEhGMUgwYmo5?=
 =?utf-8?B?UnRXVnUrQ1dLTm9nY2g0NVhOLzdweE5DcWpBOUdsc29kTmdCWE93dlN6d1Js?=
 =?utf-8?B?MTdXZXhGeUUwSkdnclF3MHdsTXJ2Z2owVlVmbDVrS0FEYm40MTVBWm1ORmdH?=
 =?utf-8?B?b3lZN29xR0s4OEVHR1M0T0tETTAxbFo4ZHVBRW10U1lZOTl1UlhEdHg2Tlh4?=
 =?utf-8?B?QmZSYkcwUUVPUFN0ZklMZ00xRUhIQVJKTWhhVjhqcEpJREtXUFk0bmc4WFF5?=
 =?utf-8?B?VHFnY3IzZ3BPM05JVzRjYTc3SFhla2NqWDJiakQ2OFdCcldqaC9QUm4yUTRz?=
 =?utf-8?B?ZXg4MkdraERUeGNwNmVYQ3lqaHN2a0VqU1h3WndIWmErV3lWTzFURVF5TGt1?=
 =?utf-8?B?WWdyQ0JtM2hPb0ozMjlXUUFWMFdnTEUvTlUwSXROYnY5MGJHLzJPQ1NQdDlz?=
 =?utf-8?B?MXIvUE40T0htSVk4MVE2UDhKQlZVNWQwdktkSURQVmREMjdtb090Yk5HdG9E?=
 =?utf-8?B?bXQyaFc4aExuV3hBVCtia2hOZ3V4djYyQlZuOEdBMlRtOC9yU0NJV2ZCc3pI?=
 =?utf-8?B?WDlFQUJFYnRCMkZ4WXhnZFMvdjR4elRLWldTUU9ObUx0YXVRQlREQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cde0fc61-140a-41d3-9bc7-08dec6f49b37
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:31:41.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijAmlJ5RXARdrrlcaMpzYDzDmBYidZm47GROc658VBQNfwbDTgatVlch0bl63xn36t9U6EgRZKFNc83Eo9Z4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8447

On Wed Jun 10, 2026 at 2:01 PM BST, Jarkko Sakkinen wrote:
> On Wed, Jun 10, 2026 at 03:57:37PM +0300, Jarkko Sakkinen wrote:
>> On Mon, Jun 08, 2026 at 11:30:06AM +0100, Gary Guo wrote:
>> > On Mon Jun 8, 2026 at 5:59 AM BST, Jarkko Sakkinen wrote:
>> > > On Mon, Jun 08, 2026 at 07:50:03AM +0300, Jarkko Sakkinen wrote:
>> > >> On Sun, Jun 07, 2026 at 02:49:27PM +0100, Gary Guo wrote:
>> > >> > From: Gary Guo <gary@garyguo.net>
>> > >> >=20
>> > >> > Some Linux distributions (e.g. NixOS) does not have /sbin present=
, and they
>> > >> > currently carry patches to replace /sbin/request-key to some othe=
r path.
>> > >>=20
>> > >> Sorry but no configuration for introducing API divergence.
>> >=20
>> > What is the API divergence here? Distros can already patch the kernel =
or place a
>> > different binary there, so I don't see what's being gained on not allo=
wing to
>> > change this with Kconfig.
>>=20
>> There's lot of out-of-tree drivers too that distributions. I'm not
>> finding anything usefel in this argument.

Out-of-tree drivers are, well, out of tree. This one requires patching the =
tree.
Unlike many other distros, so far the only patches needed for NixOS is patc=
hing
out /sbin.

>>=20
>> >=20
>> > Also to note, the actual binary being called can already be swapped ou=
t by
>> > CONFIG_STATIC_USERMODEHELPER_PATH, although for the NixOS this is not =
the proper
>> > mechanism as it affects coredump too which isn't a fixed path binary i=
n /sbin.
>>=20
>> I have not seen actual uses of CONFIG_STATIC_USERMODEHELPER_PATH. You
>> could probably use it with busybox?

I think it's used for hardening.

>> >=20
>> > This is really just for distros to be able to configure where /sbin is=
 located.
>> > Given usr merge and (some distros) bin/sbin merge, the canonical path =
of
>> > request-key binary is very likely not /sbin/request-key anymore, so it=
 seems to
>> > make sense to me to allow this to be changed rather than always go thr=
ough
>> > compatibility symlinks.
>>=20
>> I doubt there's a huge demand other than NixOS. Just basing this on that
>> no other noise have been made so far.
>>=20
>> >=20
>> > How about a something like CONFIG_DEFAULT_USERMODEHELPER_PATH which de=
faults to
>> > /sbin, and then request-key uses that concatenated with "/request-key"=
?
>> >=20
>> > [snip]
>>=20
>> I don't frankly care how NixOS works per se in details. Scope this into
>> message to problem that it addresses.

Well, I reckon that's what's going to happen, so in the commit message I ju=
st
included "binary is not in /sbin". But the idea is that there's a good reas=
on
that it's not in /sbin.

>
> Not 100% NAK but this does not have "universal logic" embedded into it"
>
> "Distro's use it" is popularity opinion, which has no place over here.
> Mastodon, Threads etc. work for that so much better.

I disagree. Distro is really just a collection of users. I would rather tha=
n
phrase this as "user's using it this way". If something needs to be patched=
 to
be used, I think that's rather a good reason to make the change.

I think "user wants to control where UMH lives" is a pretty good motivation=
, but
it looks like you disagree. Anyhow, if you don't like the idea, I'll just d=
rop
this patch, as I am not the one maintaining these distro patches anyway. I =
just
think it's the best if Kconfig can meet user demand and more people can run
unpatched kernels.

Best,
Gary

> Perhaps if the motivation-stimuli-solution type of logics gets carved
> crystal clear we can move forward. I.e. you need to work on this. I've
> given my feedback for this version, and it is not good enough, sorry.
>
> BR, Jarkko


