Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022082.outbound.protection.outlook.com [52.101.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D23BB9EF;
	Mon,  8 Jun 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914613; cv=fail; b=h84lHlX9YyapWjW/efxh2FlD89xuap1zXm8CH5katRr8CVgX8pgvKF/q5Fa+1ny+duHfURHs9mSZ9oEAFOt0H5F+K0NRhv+SpwTG3XansHdngliL7LcZTPkH+Omch5ehNggvMnGK1ccHrRtChPQlNTw9zt5T2nPC/UCWPlPd2Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914613; c=relaxed/simple;
	bh=e4jHVWja/YnYmanlmP6ze1WWqFg+woB9QxAEKxAfD24=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=q6VCYdAQffLWQu6lIiY5Vuk3nLGyxGdjxXcaxM2uBYT41kTjqbiYMyy+A9Ap9AoQEde79AFYK817+mU1eQOGJlUqdl8PbisMtEMOFFhSOu6aketX6g59gFEbv/y7nc/K5KLKuFQimJaOYFfUei5ZY7/KQx59WnKT6m3TT6wIyfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BSUZAMvM; arc=fail smtp.client-ip=52.101.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BSUZAMvM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQ7IEyVSt9Ve8416qqeblZ1+Jj4MPTBjMYUjAuWYHllgz3lhK4dL3q2vUAsfBZUOo/0BwZKUIIOQ/nTdQfbm54vF8n7Qr58HcbFxio9FKqxYQOu5dy3Lqj5IJFIyUHDLIRmDJZ2KS8fX3VFw2ih737qlRbBd3Xm9fbBwfMIzI5bXR2sV0E0EgfMKD2JktqYV6XRzT55fzW92QlJ0JQbH8m1Y13ED/egwD28DRs6xPdrTEYPLbPfqjTSfJ/EHCXBGZXhRF5zfF9cRIH2VwJE4ZGeimI21J60yBOsTkKTgwJPg66WMVUlxAnYKI0BMfzbf1q8RweMCd3k6lXKy8tmZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMQ1NCdz+Cl8H07sKYU0k7a85TPlEbxo+X0DTIu4NtQ=;
 b=PxGqKZOJmFbXdE9k5ydTeClw3jorARUhtTUh7OC4KNDrJcfdvkE8Bv8aU2ZpJEEZ2uaUckl0mOYrV6/Gr2R09YMT+hh6+lSPUhEfnBFJ36u8O8TH/xUIysYviyIYqvSTR8BWSak7SIAlU+tRp1toE//9/XkzVaAJK0Bc7YZFyf8JuKDUMoLHX1eGYyJqYCy/PTyDid4ojC3KGroYjblJ1e3/5YIIJGbi1dodYeRjGi0pPEfp5+ereL5AOwwaU1QVIfQpidFLxQqX+zBfAF9a5nLMOlHzak5we6YR6oAKdrAI7Odqj6RB+JIqxEBwNxUlidf812nDIyyAE3ri8+N2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMQ1NCdz+Cl8H07sKYU0k7a85TPlEbxo+X0DTIu4NtQ=;
 b=BSUZAMvMOfeDoz8Bz/sStgMyvkqz50Q3veUQ6DphLTsttJrJ6B4hZ3cjGQ8s7DtKuwE9GBlxMwlmgFRTR5xzi9H/Al+1b7wyaxn5v4+DiN8CqfozzNMGUmVG7r+ELuWvp+i9aO4uC/FuOa0UiEH+nfXGvw5RJJzFiyJ8fXlS8VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB5963.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 10:30:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 10:30:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 11:30:06 +0100
Message-Id: <DJ3LJFFPMAOW.QA3EZSAB2S5A@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys: allow request-key path to be configured via
 Kconfig
X-Mailer: aerc 0.21.0
References: <20260607134928.2832202-1-gary@kernel.org>
 <aiZJ94eugtNHcILD@kernel.org> <aiZMT5UYhVDlLVHq@kernel.org>
In-Reply-To: <aiZMT5UYhVDlLVHq@kernel.org>
X-ClientProxiedBy: LO4P123CA0388.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7ffe1e-3a1c-4473-40f4-08dec548e8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PUpNfJ1dPPyAzUQ7wZi8s9KSmg4TzsBPA7klbscFYRVXIhsDO9g1p/JTDCKJ5U82TdeupkHY5ylfXL6C0HynROQvEweojhTatPC7tNd9uqEuIOopuXftd4p4fgdgv2fmRfMlylhrZGFOX7yICLSItA6c+1X9cnVNBhaS36iwTDjBG0ndJrmbqcgocOnAznDniv4W1lMFd3tnYtDhL7c5uM8nj4BN8bRTqWtBgrBIMFzuxWYuEWA1LBiOxKQHC28tK+5/mmPXu/I+nJ7/0KPQlkTrbJuNXvKKbH/vRw9/QKqAVPXiWBUGdVRePJiRPiL8IfkjM54bzrbcu8j3oTj8Exjuwu7E9N3Opyvo3ZdD1IKR9APjSmVlafUPCGmTgJ2K01eQJ3n8zXtrBHPea622+nEKAnsauRbWsFsUD2EmP/Rrzx6r3Z8ATUR0RqATpffHJpsp2VwHuM/MktaYOdTkT2tNr9bU2NN+6CXPEDHJV0xv0TVkIz4s+1pKW9zMXznKapKtt6xKRC0wixK0P1BWdNe9BWIluTORhM81Ius1QjUpVWoYwW1HfwFavR+LStdAujcHBEwC8EWR46FmISMaCYa/bNukuLchANTjR95zQAIM1Q6L08Nl0QE33JmWccoP0j0vog/0tusbg7msTpHy/V8pKKqidf+KAoqWavTI4bTCwhCjJOCzwlOJr4Qmv82D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0pPMnduSDl0dWdhMHRvT1VabkkwamVuU3JuQnI2YnpwNUZMS05GV2tsZ0dI?=
 =?utf-8?B?ZlgzTW1zTTFodFhMSzZXaklueFpNTG1zZ09MNVFHUUtmZlcxc1pqUFJ0c1A2?=
 =?utf-8?B?dHMvdkN6NWxkVE9uN24zMFFYZXMwbkNFanp2Qk9GOWpudmJ6V0pvK09SQ0Fn?=
 =?utf-8?B?WHNIZ3dZNmJQKyttQlB1eVZMdmJ4R0NJeGRQajFZNFZEWDgvTERUMS93cUsr?=
 =?utf-8?B?UXhIRHZUa2FVbWdtMGltSEhhVlAxYW1LUzlNYVZkVktaQ1I5Rm5GMERidmdE?=
 =?utf-8?B?QXB1UmlBdHVjRDY1aDFaaTk2ZFVSUmpBZzc2UXJZeCtYaTU2WHVFbGE3MjBP?=
 =?utf-8?B?MC84elYvNndHK3pwQXVTbUowS0JrampTb2xTS3V3VHRoSUJEbTlJY0xQdmpj?=
 =?utf-8?B?blVNQU1ZVnhWQ0pHa3lQOStmYnQ2bEVWa2dLZUhrMFBBYitOT3o1Q2RpbHhm?=
 =?utf-8?B?TG1VZTYzdjBpWXRESlVtQ0Z6MUpEalZqbnNDYkh0ZnV6akh4aVRncDN4OFJV?=
 =?utf-8?B?Qjl2Qm1meForZ2JiVkZMdG5HcjVSditxMXZVQ0dscXZ3bloxWlNlYmRBQzYx?=
 =?utf-8?B?aGlrOHNHT25sSFh4Q3g1RUp3Y3pIaFZhbzZIczgzVHBuMjZkZmFXblJUYWpE?=
 =?utf-8?B?R0FXd1JUaTlEWFlRQmNibCtZdkJqcURScnNtTWlmbW5hNzlscUo0WmJMRHp5?=
 =?utf-8?B?eDVqQ1FQWXRQNGpYb0hwcXl3UGV4akhUak5RR3JrbWVWYWpFdVViNEI1eDJw?=
 =?utf-8?B?c3FReUZZbXZGcW1mWS9TdW91RWRtKzVxMFJpMDdvUDVIb0RxaHZmR216WDJB?=
 =?utf-8?B?YWlRMk1NMlhNMjBTMjNlbmxBSHpURnE1a1hiOG42ZVhiekQ2cUJjQ0FpTG5R?=
 =?utf-8?B?RVB3OG51ZXlhcVhKSEJJeWI3cXZib2hYOXJQeEpBWmRCUnBBb2NGUWNodWEz?=
 =?utf-8?B?aWN0YXVVWUEyVUtxWjRIV21SelMvYzZJMVlDVVMzbjRwcGRkcjFaMGxKaGw3?=
 =?utf-8?B?Z3U3WnA5RW9aemlzSDFJV0duTCtsQjN2dnJRdDZnWkt5L3JMMUl0QVl4ZW9u?=
 =?utf-8?B?UkoveGpIUlRQcG1KS2diUVl2aGtBUGVraGNja1lHWHhNaXo2VURVam92bmhK?=
 =?utf-8?B?Yldud2NubEpUMkF1Z01GVDd2TVJIZituT3BRYTlnSGtkQStTR012UFBzTEdU?=
 =?utf-8?B?MWJlYkJ1dVp2MUNpczlUaVZVOVZIMVl1eFpvYVhkUkl0eHZvWHpmMEduWW5Z?=
 =?utf-8?B?MHFIL0IvbnVwTU5rMTM2aWJZRm5kT3BmNkhJRTBubUFLRlJhY2t6Zk9IU1pG?=
 =?utf-8?B?TWFUYWhtaVhBZUtSaDI2ZGdjemQ4WW5rN0RJaVNMT2dlaUN5UU9KQXo3VmR3?=
 =?utf-8?B?dVM1d20vNFVtYUpNdTJUL2xjekVVVzJXM2QxTW1PWVNHa3NqN2pCSTRGcm5h?=
 =?utf-8?B?VFB1N21ua2kwRUhweW0zbXRoWGl2RTJvcmcrUkVMdjRldkhvVWlYVHp0TXoz?=
 =?utf-8?B?bS9WVU5zSFlXVzMzV2FsNzRTekVaL01VMlo0a1ozM3luL1J6R3djbHJ1V1B5?=
 =?utf-8?B?M1ZKN3ZJNXlxRlpvRjNxaFYwWVFPMEpWc2s4RkVHaDJjTmRqQkYrdU9pTHRK?=
 =?utf-8?B?SGd5TE9jVm1UaEsvSWtnYjd2NEptYWZVRXYyNDhDRmtzN09UVEtFUHBDRHEy?=
 =?utf-8?B?dEszUXgrdG80NkE1TVFqS2JxSTMrcVhHOG51RklOYXZPOHM2QkhrWUFVOEJV?=
 =?utf-8?B?aG40QndQMHRlNHBqVkREaHlITktsQ29EU2o2bVVzWk1ITDRBTUdOQUdQK1JO?=
 =?utf-8?B?b0ZGWW5hNk1XVlRFc0Y1YjZZeEs5TXRodEJRZlFMTll0OUZaY1F2Tmo1MDRo?=
 =?utf-8?B?bkxPWTlldlZJaGVFRldtZkVhbXhWdmRxTDlqVW5DamlzQkJseGZHcXJrTVZS?=
 =?utf-8?B?YUQ4a1pmTUJTL085ZG5UZnU4azJYRVhCODRRSmE2dHoweUcxTzl3Q2wxN0h4?=
 =?utf-8?B?MGdOTzNXL2dNcmVhUTUzSmJrb2pEbHdkZFc2V3p3RVFUcUxNN2VWc2FCK3l0?=
 =?utf-8?B?VTlDbEN5L1NwYnQ1ZWRPZmQ5WnVSaEpNcE93ZnJHOFpVSGdiV2pWSEhKdi83?=
 =?utf-8?B?Qnc4V3NVbXAyZERGaG5PaFNVMExRMnNiNTRWRldtbnJVRC9ydWtaT21FNlFj?=
 =?utf-8?B?eWtoeEZqSm5Pa3VDZVJ1SmlabFZ6RnN4VHJsQnBlb3ljR1I0d3pFaXlON0ll?=
 =?utf-8?B?L1Q4S1NmdWl0a0ZYOUkvRjduSFd4UHZoaWtzdWpNR0cxNkhMY1pFSmVWQ3gr?=
 =?utf-8?B?VUJzdkFWQUQwdlJRdzlCRDVBeG95S0dtWE4xZ0poVi8rOHEranpPQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7ffe1e-3a1c-4473-40f4-08dec548e8b5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:30:06.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8dYFNi67h312O+zLh+0ZXayff6p9lxTdonvscXSGjdvGtjAyHOPgDzl6uZtblgHgDf3yh1pAg3T46RU3/XChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5963

On Mon Jun 8, 2026 at 5:59 AM BST, Jarkko Sakkinen wrote:
> On Mon, Jun 08, 2026 at 07:50:03AM +0300, Jarkko Sakkinen wrote:
>> On Sun, Jun 07, 2026 at 02:49:27PM +0100, Gary Guo wrote:
>> > From: Gary Guo <gary@garyguo.net>
>> >=20
>> > Some Linux distributions (e.g. NixOS) does not have /sbin present, and=
 they
>> > currently carry patches to replace /sbin/request-key to some other pat=
h.
>>=20
>> Sorry but no configuration for introducing API divergence.

What is the API divergence here? Distros can already patch the kernel or pl=
ace a
different binary there, so I don't see what's being gained on not allowing =
to
change this with Kconfig.

Also to note, the actual binary being called can already be swapped out by
CONFIG_STATIC_USERMODEHELPER_PATH, although for the NixOS this is not the p=
roper
mechanism as it affects coredump too which isn't a fixed path binary in /sb=
in.

This is really just for distros to be able to configure where /sbin is loca=
ted.
Given usr merge and (some distros) bin/sbin merge, the canonical path of
request-key binary is very likely not /sbin/request-key anymore, so it seem=
s to
make sense to me to allow this to be changed rather than always go through
compatibility symlinks.

How about a something like CONFIG_DEFAULT_USERMODEHELPER_PATH which default=
s to
/sbin, and then request-key uses that concatenated with "/request-key"?

>
> Not sure right now but one option might kernel command-line. Then it is
> known at run-time, can be signed etc. Compiled value has no identity in
> the same way.
>
> And I don't care if NixOS has such a problem as I've not have any stake
> making of those decisions.
>
> You really should explain why it makes sense to have such feature i.e.,
> why is it useful. And if NixOS considered, why is it useful for NixOS.
>
> This all should be in  the commit message.

Sure, if you need some more detailed explaination on how NixOS works.

NixOS intentionally not use FHS directory paths, so packages refers to thei=
r
dependencies via cryptographical hashes in rather than fixed paths for buil=
d-time
known dependencies, and themselves also live in a path with hashes in them =
(so
two different versions of the same package are in different paths). E.g.
/nix/store/wjzk0s5dwk0i7swh3rmh1pl10k6v1w6d-keyutils-1.6.3/bin/request-key

The full system is also built as a package with all installed binaries in
$pkg/sw/bin, configuration in $pkg/etc, etc.. The current system is symlink=
ed to
/run/current-system, and when a new system is activated this symlink is swa=
pped
out and therefore all paths are updated atomically. For request-key, this i=
s
symlinked to
/run/current-system/sw/bin/request-key

NixOS carries a patch which uses this path instead of /sbin (which does not
exist on NixOS at all).

The motivation is really "be able to switch /sbin". I feel that all the abo=
ve are
secondary motivations and is too verbose to include in the commit message.

I am not a maintainer for NixOS's kernel; I use NixOS and just want to deve=
lop
kernel and test out kernel on my machines without having to patch them.

Best,
Gary
