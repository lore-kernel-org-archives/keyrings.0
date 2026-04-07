Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC63B8944;
	Tue,  7 Apr 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570407; cv=fail; b=L/xGp9r4ZJGBKwNakT8md4+60Mk8HEyaEmnUvFIgvIILXA4BPv1MuCXBu5y9NqB6urZnsY8+tzAPocini8O9utFN0PPbyxShA3Lv9NNPM7bnXC3v6VCpJzGyJsqQH+okHxR4jxjzY8SYOXWMzUjJYP9hZ3HiAgozlxYLoQMtBps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570407; c=relaxed/simple;
	bh=sZMXTgZK/YMcv5uIrydNBM2IvBE+sp7l/hbHB2IR21E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f3GwAI1VFDXvxqjw+FJ5kkbUw6BWhh2T44QFPWusnBLAlO7FtHgYFlGWYFlX/05c83cV2/tecJf/Q/PzVUwgMhaRdkR23lbwnIT4l7GASZiyCQo7ShgW8rLktkVgi/0lL1YBWIyuaqRX1bSMf0yLbPifpctQRuqBT+wQxgOgdeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKQCWdoh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MB2JvLiX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKQCWdoh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MB2JvLiX"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6371Balh212566;
	Tue, 7 Apr 2026 13:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ShB5J2EsZYCC0yk6FU
	09cjgS0gSXFglDq9BnUsmVhQ4=; b=hKQCWdoh5+f7NPw1Biq49oUWEyF4wqPwPH
	5hoRAgXVWeiT+s9J+NJRK8EYfXRalo1yJRLBBwGYolHghN98nyMpd4NHvoEEevcg
	9PwA2YuG08LghIS5+ChvNl1xplC6ySKCpTOH1yQBE9omIjlB/8D2rBTIYhNkZ5rw
	AwRFrfPyaPNSOcZnXgmm8xd+Ozm6qQ4eCFe9z01Med7U8yX58yCjpvqmkuvt/NJf
	2HUhcZ8NYERkYelh3X3v8Q25Bozi+SEoL3TE4EsK1TgseQhmk6vt9mCckFs7Yv3S
	T6jOt0CS+kwjAhJk0qmr5rt6blu19fNdnYShvGAbh7ZN1LFNd6HQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqas521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Apr 2026 13:59:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 637DDb6k026500;
	Tue, 7 Apr 2026 13:59:07 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcme9x1uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Apr 2026 13:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnIzfBJ005Hdz/jTvU6NlN0sMTmpSEnvLhxE0fnuiui0wWNGKWFGx6kzMAvrd+edb3197JLK1cOisCQoyjHYvlxmedoucH18zxBcFec/d7lPkvEF/vI925575dmrSPSHOQadifgjBYR3Cr43Ub+S/FA3AUPg8A+Yd0fhLU3SVOyDf57ML9c6s5f02iA3w4ETekxf13PKoHMmhzSEy8XlHXGKYsxHIyMKBW+uswn0yTbSe7CZXUxRaJGsLg5bLLXj+MWp5aOSTiJwSSgHRWqOVIeO7Cl+0twP2UKBECh60GrwfUbkAhe8k0DdZU/TrR26amI7Rvl9nWgrcphG42H7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShB5J2EsZYCC0yk6FU09cjgS0gSXFglDq9BnUsmVhQ4=;
 b=C/g80qwU3kyglvY739JkOl9X4czZVZ0wHHpzBkdL7y2fH/WAVehjP5UfvK4axqV/mhoVPzxX2hGN1v1YkbkrIYldqjMfOdZTov9Nflag99GbzMx4oRKukBVInMDnATpvQSG7wttQSc0Xd5254uTQnfRRsgwZwC0s0FJpujMswj4dZG3tawuTccMhXavU7NzuspYJ7nbKwOZcaxU68/Q/SsEbljVSWWGm5beY1/hAk3QuTdpL7E7jLq5OKN6/uVrOV5ODykYI2ZTJEDI+dyMah/ngUD6/QOZrrAZHs5OIKOi02s2H5mdCSSDQh8hlbJ3ul027G6uXIuodiplqfxMeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShB5J2EsZYCC0yk6FU09cjgS0gSXFglDq9BnUsmVhQ4=;
 b=MB2JvLiXP4f5ZIY4FGL9fkzUfQy01dPg+3HKkk2URWhRDtNT1M0emvCed9CLC3OmHXvljAJCT7Z93ruJr6gpJGGn6KGbnXjqa8SunoSVqnJ1K67FDiK1N47sZSlxlEUrQZW1JfWObG4IXhRPzyyPY46XwsrJVkUStW2C3CkEpc4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ2PR10MB7786.namprd10.prod.outlook.com (2603:10b6:a03:56e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 13:59:01 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 13:59:01 +0000
Date: Tue, 7 Apr 2026 09:58:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list:CERTIFICATE HANDLING" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] treewide: Fix indentation and whitespace in Kconfig
 files
Message-ID: <2w7il2oprhkus5eyuxj3alzlsstp4yv23gazmxfmofzikqllrh@uwsx5nbj2hwv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Anand Moon <linux.amoon@gmail.com>, David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Douglas Anderson <dianders@chromium.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "open list:CERTIFICATE HANDLING" <keyrings@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>
References: <20260407053945.14116-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407053945.14116-1-linux.amoon@gmail.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0096.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ2PR10MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6f476b-2bfc-4069-51d8-08de94add25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/tEGSjuMMq3vZD9beFZtGOi1mVMNifqoI5EuXZ5Vss/m9Jj9ve5F0IqFb9Z82FcFsfhX3u/5AR0vY6TBr2mKoB2aaF0kn12yjVnrzEoRuaGGQxpG4y4CMnHEX5IsBbaLENLYJN7HJDRRWKBLHi4vU+t7lrT3X2QQweccC5ei1oVf67ZVc3dC8Qmr4WvMyP8xhfLjkHGs8aHra6OZ8gIrgZwa29AUeefpVA58zoHGMQb4xFDG4tEc3QHoMZtiRHASr46BaWCD9m+kmQzyOxFUICDOn8/elCRo/YKmqO06Yo5dCBl/rwU7VqX6s3qvoJRxhuXRP+G58+zPI9/WXAUKdbr4hxcv4CCiQ/Ih1Pisi7sEu9Roun2FF8fqMx08ezrQLPDEUpkVyekawNI5siJs3a+knPusAC1ClBsWbiNS6IdzC6Ibt3AYNQmJL4utU0KuiCB9LhdmzxToKa2YFn1gEHXJazj0E/+2HAQvH8V2ytUDt+XZMVjDYaoUxdwO3PEaFR33z6vIz5Wkon3f1o1TkU8Hjp1J+v3eSCm/XGb6tckB3JDK61BzfoXTQ4XB1dsrLfrLITDx3q3nXNia5uvZBECLWGi6EE+lP9e4C+Rk+SNMovDs9WU0PuCjFQcsxfWSznUH6Ob2dMhtdV3v9pCeIzJJWigeIC9lVIEmtC6csYQ+fAy3pbwJUgKgyxlRw9w9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Io49tU/KpNi17Sn95GUcsamB+WC0YR/Qil+4BVKv6auVmyG+F5DOTwLOL5CK?=
 =?us-ascii?Q?Sv5xTBC4r7WSm1PWOm8d+mcG8DVrtgBe3B2YhdGmXdkMbM8Zij1vrsaUGhYJ?=
 =?us-ascii?Q?cP4W+7dSXMIwGZiXUNVfEADZQqul/zddivS0VeqK5EYYo/Ch7RKG+mB3HI2l?=
 =?us-ascii?Q?5GZSb9vlCnPOkUH2tiQLOtfq6CMgCX6JVgZnwyFYUM0ay2m4yFy/zgYvlTpA?=
 =?us-ascii?Q?pjyTzPuIKp4bwvmvsWk8V8wc+LLUT8yXIu58pGYAdb1wP/XUVN8/gbK1H8Fl?=
 =?us-ascii?Q?mLBetJdVBfTrsKI9OiYLNhds8a+dkvNzT8lCzuHyHKhMT+sStEf81Ud6mEIM?=
 =?us-ascii?Q?fsrQd7ypNaamI8p/t6NqHg4Kw0m+XKoacwFFEMmGpUF/wOSAbqBoJE/H0CTI?=
 =?us-ascii?Q?G5oyWi+m14eva4oNkqs+p7+C6cXKHNehLlkZJeV/0NVsq5T0mjxg+3uK5f+I?=
 =?us-ascii?Q?PjAr7js7E866Riz5xsaoJvXLbZQHKUrNQng0shG8g0rnUWr+RsP0UB7l0+CR?=
 =?us-ascii?Q?p9C9RY9Mc3aVMwFlYsg8MtYMq9Omi5uA8himgU7klDerB7fsWi90UF3+WenD?=
 =?us-ascii?Q?C0nG0ewtGmhYy+4eWGanhGwoKkwDjDJiQr2MMBd+6EyiKRM6AEKrvd33iL+v?=
 =?us-ascii?Q?NMjC8IWLN1gvUAWsgcHsilk7FOgWpfurovuJYYW+ToYT84Ql2GadcdzvkdEy?=
 =?us-ascii?Q?tMag+o2zD/+jPiQ3gpDjFvnJZ3hjexSAiIKktSOAuu6AE/GxaDhRMAv8r0EV?=
 =?us-ascii?Q?9c2v+ew2pow4FbMRz+67QOSHlPkR4oMp5SD4XzlwaSnSJvLF945rOF5hvmgt?=
 =?us-ascii?Q?H1N527O9fjfpwivVVubyJdofBYtgx2UQ3vJuMz++VwK5Q3rZrAYyFT7JiZyv?=
 =?us-ascii?Q?FBK3b4dJ1EKT7hirWuYi/da/+AQPUn5hSFH4ZP77CaZfxrsSioguka1MQFWk?=
 =?us-ascii?Q?sN6VAxXIjftM1VoZ07wm3pk4SGIb+aLH/sj9PnaSLwG6NUysvoqDeT3qLdmZ?=
 =?us-ascii?Q?Exd5fPqhpHGJmipFKjDdBIuYQ8bJTZzWXH1mdTv3YRRbvmWkIHGbzkRf6taB?=
 =?us-ascii?Q?ZyZggI0sFUB3j+NUrL3Y0Fmv5Zzrf/jjHZhIMWxvL32qfBLuomPDlwDFRrU5?=
 =?us-ascii?Q?9oiLBhLTxfCamJWxbbg07maFDISolWgk/xhmZfjTDVecSUgDs/k3u3tm3B2X?=
 =?us-ascii?Q?a3H2qHSDu/AkQoefLAhncrjMleDFNKoi9lZl8SSvg3USM0saCGnjBp0tAPXA?=
 =?us-ascii?Q?Ez4UB2L/iSMxuGvV8oCaYwtZ4tZmF0veO9817dSBLRJA9a7m9GkxmviEkLQ7?=
 =?us-ascii?Q?8WdRbAilOZ+U7kw1jXNwt4MDBh7OuyxwXOi4E7n7jDF0x0n/v2jW4QvGranV?=
 =?us-ascii?Q?VFNsqppvs+UDhucpHBo9GIRgo8Ha8T4tiQIRGJYLWDK2n1kkGHbWP87u9Q0C?=
 =?us-ascii?Q?pBpfjx8r3bi6EXS0gimo7COdeajNhwTUsh6LBktyK11A6tpjkHiUBczkTDLC?=
 =?us-ascii?Q?WZXBDI260S6StjGTk79Qb5ssmKfNgu9h9Xt5SsULhl3I68yLWaqXtQPhH8J6?=
 =?us-ascii?Q?fJUl4kfG/qHiBb5u0kivIl/WGi4xP6/6BqaOB6j9BmO+p8BrdIj5Lb5NAlRq?=
 =?us-ascii?Q?B/mqQU6nFQgUY/GzjO45+Z4ihmVF9gNKj9RVS2yGYqCyFoQv2EFgqMfXE60e?=
 =?us-ascii?Q?doj7bWXWwDpvAkaaBRsmJ7xPUX+qKwdBgZ5YpeGZy9932QS1rJnoJ0keVPwo?=
 =?us-ascii?Q?W4Nd43VQtw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Bi0EjJFyMQCMBtmHe7MGDYKEabG+6hzxTyhRZbbv7tt2JzxDKopOksAw/L/JaWvHt0KFJlmOPPlCC5WBOnNbfOoQXOZuvAftoBvoha2FR1M6Wiy62QmjIGbgdMGiudyRhi45MO1tpuRGkWBIO9QZmMkSbb6LL+SbjCRmCVgul/a3YgaQiOt9VC0Ct3uDC2lPw+70h7XgUcGwqKFnSSuaX+KdQBECTzcpckJ+LpG3F0kjBmPB+Iguqbh1870xurCM+HfI6xYExtWL+TrTC7xjHRMeNxfQoaYAxVhpZe3IK+E0K4XjNWZowjku35hgcVHfS7u22F4/Xed/PUqiN58V7g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aS5mCN5sLyIQat4zIoDbdujgcvlMEF6P7hne9QMCJRdYifyXzgJaFiA8udvI6baQSCS1UotVLYB+lJmUyPx/VGdEV/BqbHUIa0wnvKIio0EyIMIaJaiJIIcxSUa0Il6jtRe1rHspQREP4bxFypP3BtrOQo+uNpKKDOuOybz/ixjAxxeo0GfGF4bX5ePojw8RUKCae+G2CCwzTOfdqnsNnhfF4Il5B8fHJjBUEJqDd5DWgqmn6qXaLnu9KlWCt50mHZKroS645zEhIdmdUcDKJDAaL+bdSyt/jSNul76k8axGkFxZP60sYWxDNwLiVSyZt2DI9cYpgFUzJsIOm3q3Y3SHnQk/D/2YHeZ43ryPdPYKuHFXprzGqyZ2HnrO3jD3NdgBDnIE+QzHYVn8Qs3aZ50JkwoK4OSXBsiusu4P+V5GJGA5CVO9HDlVuwz4Fw3gAA7v5O3EOFwBCx/yZsGbaBOCprd2ii8ggpvpFQtUDTBq3B3F8V/BA3E5xvqdKbficd4z9gHfTaryGAdEsE7g7XzIJNNgrkTwVxw0k2EwECdken703ZeWfVNdvvcZ6cEpeo4lguVPBkteigNBHofgPjjt8kkKFUS0c3c0DpRUvTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6f476b-2bfc-4069-51d8-08de94add25e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:59:01.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsT+XEqvtDfWCqOzAFs5gZAOSvmevWayrLDVplOdNDJ5qGEoxvdrtH+VKUzyJUxsm7jTuvDTas0a1Co+2LrBhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604070129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyOSBTYWx0ZWRfXwv2DvKnWVO97
 00hLxQxNH6H8N4aaD9Ob+EzTwUB0pmkhxy+a9R5LZYxewMXGbcGjRvqFP/X5SRxPvixWhI6ePY+
 GPTB2ik7/7WyNRq05mjRlRFFgr9XquJp1bDNNm4qG6btHnhxsXJ5XDVCofGTXvKh6wLVHF2Grf7
 yjCNWmM02ZBDRLUDrgEnxoKw3WDb5HgrtSttmkath08T6zkZlkdWZH7jqMKvkrf8lToeofuHbRJ
 u0mSBzzh6SssC7m9MYSeOTv4OCd7+oBrpHyxwxo4ENLv9fuOnQ/NWENFzk07kCO3du/AstqEP7T
 QD7EzfUXAEI0kTWYry007EVEX2dQ5FrVKy75dl13tgq3+fOzjTQwUqMjiHNoWEx9TcPjTaJXOoX
 Ew6I2XHd9mNIcXKRygCBjtk0D7Q9ZIEcEYgPgkLl6d+3VPtEnnEhli721vcWJQvT4edfxSrlTVE
 WYklJrdTeuuGghkGbJfdloWqirRPzQUHYH9SEOjE=
X-Proofpoint-GUID: UjqmoWFb2SPLPXYTCFbydoRXHo2q02el
X-Authority-Analysis: v=2.4 cv=Oux/DS/t c=1 sm=1 tr=0 ts=69d50dac b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=slG4UO-DAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=4ZsancCpMNpMkYE4fEQA:9 a=CjuIK1q_8ugA:10
 a=XLxOX7iA1twVtVaasZas:22 cc=ntf awl=host:12292
X-Proofpoint-ORIG-GUID: UjqmoWFb2SPLPXYTCFbydoRXHo2q02el

* Anand Moon <linux.amoon@gmail.com> [260407 01:40]:
> Clean up inconsistent indentation (mixing tabs and spaces) and remove
> extraneous whitespace in several Kconfig files across the tree.
> This is a purely cosmetic change to improve readability.
> 
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 
> $ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

For the mm section,

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  certs/Kconfig | 16 ++++++++--------
>  fs/Kconfig    |  6 +++---
>  init/Kconfig  | 24 ++++++++++++------------
>  lib/Kconfig   |  2 +-
>  mm/Kconfig    |  4 ++--
>  5 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 8e39a80c7abe5..9d2bf7fb5b9e4 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -6,14 +6,14 @@ config MODULE_SIG_KEY
>  	default "certs/signing_key.pem"
>  	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>  	help
> -         Provide the file name of a private key/certificate in PEM format,
> -         or a PKCS#11 URI according to RFC7512. The file should contain, or
> -         the URI should identify, both the certificate and its corresponding
> -         private key.
> -
> -         If this option is unchanged from its default "certs/signing_key.pem",
> -         then the kernel will automatically generate the private key and
> -         certificate as described in Documentation/admin-guide/module-signing.rst
> +	 Provide the file name of a private key/certificate in PEM format,
> +	 or a PKCS#11 URI according to RFC7512. The file should contain, or
> +	 the URI should identify, both the certificate and its corresponding
> +	 private key.
> +
> +	 If this option is unchanged from its default "certs/signing_key.pem",
> +	 then the kernel will automatically generate the private key and
> +	 certificate as described in Documentation/admin-guide/module-signing.rst
>  
>  choice
>  	prompt "Type of module signing key to be generated"
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 0bfdaecaa8775..74110311968aa 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -78,7 +78,7 @@ config FS_DAX
>  	  --map=mem:
>  	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace
>  
> -          For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
> +	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
>  	  file systems DAX support needs to be manually enabled globally or
>  	  per-inode using a mount option as well.  See the file documentation in
>  	  Documentation/filesystems/dax.rst for details.
> @@ -116,8 +116,8 @@ config FILE_LOCKING
>  	default y
>  	help
>  	  This option enables standard file locking support, required
> -          for filesystems like NFS and for the flock() system
> -          call. Disabling this option saves about 11k.
> +	  for filesystems like NFS and for the flock() system
> +	  call. Disabling this option saves about 11k.
>  
>  source "fs/crypto/Kconfig"
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 7484cd703bc1a..6fea1453c2941 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1036,14 +1036,14 @@ config PAGE_COUNTER
>  	bool
>  
>  config CGROUP_FAVOR_DYNMODS
> -        bool "Favor dynamic modification latency reduction by default"
> -        help
> -          This option enables the "favordynmods" mount option by default
> -          which reduces the latencies of dynamic cgroup modifications such
> -          as task migrations and controller on/offs at the cost of making
> -          hot path operations such as forks and exits more expensive.
> +	bool "Favor dynamic modification latency reduction by default"
> +	help
> +	  This option enables the "favordynmods" mount option by default
> +	  which reduces the latencies of dynamic cgroup modifications such
> +	  as task migrations and controller on/offs at the cost of making
> +	  hot path operations such as forks and exits more expensive.
>  
> -          Say N if unsure.
> +	  Say N if unsure.
>  
>  config MEMCG
>  	bool "Memory controller"
> @@ -1125,7 +1125,7 @@ config GROUP_SCHED_WEIGHT
>  	def_bool n
>  
>  config GROUP_SCHED_BANDWIDTH
> -        def_bool n
> +	def_bool n
>  
>  config FAIR_GROUP_SCHED
>  	bool "Group scheduling for SCHED_OTHER"
> @@ -1625,10 +1625,10 @@ config LD_ORPHAN_WARN
>  	depends on $(ld-option,--orphan-handling=error)
>  
>  config LD_ORPHAN_WARN_LEVEL
> -        string
> -        depends on LD_ORPHAN_WARN
> -        default "error" if WERROR
> -        default "warn"
> +	string
> +	depends on LD_ORPHAN_WARN
> +	default "error" if WERROR
> +	default "warn"
>  
>  config SYSCTL
>  	bool
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0f2fb96106476..4b0026954a370 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -589,7 +589,7 @@ config OBJAGG
>  config LWQ_TEST
>  	bool "Boot-time test for lwq queuing"
>  	help
> -          Run boot-time test of light-weight queuing.
> +	  Run boot-time test of light-weight queuing.
>  
>  endmenu
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ebd8ea353687e..10a4ce4247fa1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1304,7 +1304,7 @@ config ARCH_HAS_PTE_SPECIAL
>  	bool
>  
>  config MAPPING_DIRTY_HELPERS
> -        bool
> +	bool
>  
>  config KMAP_LOCAL
>  	bool
> @@ -1435,7 +1435,7 @@ config ARCH_HAS_USER_SHADOW_STACK
>  	bool
>  	help
>  	  The architecture has hardware support for userspace shadow call
> -          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> +	  stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>  
>  config HAVE_ARCH_TLB_REMOVE_TABLE
>  	def_bool n
> 
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> -- 
> 2.50.1
> 
