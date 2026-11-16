Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860933;
	b=pDu6bDuGHbJwwqywvar9CcH6/1ce33YcenXeuGMNkFEdcLSo3WGsPTlVdJlQ6fyaqCQH
	 UEVpXxSFom7G6HZYU0RdsFqdLFdcxSldQxCoAJUOtedr7TW8OMa0qNMr+/QhJqMM5MRJA
	 QWyF1yGW/JuZKOOb6vu6s8Qt8zs3T3nDc+pUqNJevs13ZShrcmIQo6b0HDpzKIYyHqhVo
	 a2LimKuIUqgF7gwRLcsecilAavkEKRaD7JbQfSvbXSh1QkqT6WXebIY6zzF86bouM38aF
	 5zGrOKwnf1aHtiTGUcjroAIlnP/XxhMH3tjCXIY35Q/Z8V7xbce3JG6YO0+TU8ET85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860933;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xS1o3rZDvoPcOnNn0jdvkSHcQJPQ12Zkrym3PMtGPos=;
	b=rDdJ9OxXkd7+UirdaC19He8krei1JIg+ZYWub5b43ROfarWEeoBIJBrIbKvupkwAncid
	 wuMJvqLC1GgugvRwRVy/TaG1UFx+Ch8qdfwz/tBmvwX9T+rMs9LJ/mGS8kxQQaJMBRopY
	 60KV39H+jD/EXYXRQvB4T51GcWAB5mOBSCeUgA1kD6LSuisGhX0B25wv0plxYxDln0WFZ
	 8poNPEwMfRDYeHCeEhhpsu8ehEWsjeML874Y3otaGVlg9WCIxlCk12AG72flY5a19VcBv
	 FSKLPCyfDodWIjry3bxsBypsYjP0CFCJLurmR97Zt+FdY7kmbr6i6Y9XqnOy7BVTZIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ikdZBT/H";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B47606A333;
	Mon, 16 Nov 2026 20:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B47606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ikdZBT/H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794860933; x=1826396933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Bns3dpZyOx5SbBohcAl653V45jCd0xP5FBRlRQ1zuU=;
  b=ikdZBT/HeUJA8rQ64NnxTb4Nvqrnr1XsFdBpL8m3MAKjrMm8UKA9YyWK
   wujK/9ljmcvLqAkhgqEqCaAsZZP8uJ3gvTgRCsxxG4F3btoI+9DQDVrzY
   3EEeqB69qVcYSPzKoVw605xxvUDg5aK0YEXMSm+hJl65tt3e+G9AVLVZW
   W0/6/DJo/D2M76TWKaIoSP/Kj2vMO9wntkIO2oENLS7GWaGb78acA4cZT
   zFFHhEb2PAz1pxifdDYDpTl3JA79Mx6/HxxHjRs62wpXt0iA9xTaHg+8V
   7W/eTZsNyGhTNM6DY5E2yDEJ8sX93tvFWZP4sbeg2deHJdJihGsBysTJR
   A==;
X-CSE-ConnectionGUID: y29jIW7RTVC+XTxGYy2kRA==
X-CSE-MsgGUID: R/vVhO92RAibefRr5NmptA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3510979"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3510979"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 12:28:52 -0800
X-CSE-ConnectionGUID: v/ptN20pSu2PJ0fEedtNlA==
X-CSE-MsgGUID: JG26hXrvS2GCbk9hXPN0ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9689087"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Nov 2026 12:28:51 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xT3Jo-000000019Ny-0ZuM;
	Mon, 16 Nov 2026 20:28:48 +0000
Date: Tue, 17 Nov 2026 04:28:43 +0800
From: kernel test robot <lkp@intel.com>
To: William Chuang <founder@logarcheon.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, dhowells@redhat.com,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	William Chuang <founder@logarcheon.com>
Subject: Re: [PATCH 1/2] lib/assoc_array: add KUnit test suite
Message-ID: <202611170414.5JNJifXz-lkp@intel.com>
References: <20261116054112.39078-2-founder@logarcheon.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116054112.39078-2-founder@logarcheon.com>

Hi William,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on akpm-mm/mm-everything linus/master v7.4-rc3 next-20261113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Chuang/lib-assoc_array-add-KUnit-test-suite/20261116-054121
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20261116054112.39078-2-founder%40logarcheon.com
patch subject: [PATCH 1/2] lib/assoc_array: add KUnit test suite
config: i386-buildonly-randconfig-1001-20261116 (https://download.01.org/0day-ci/archive/20261117/202611170414.5JNJifXz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170414.5JNJifXz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170414.5JNJifXz-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_destroy' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_delete' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_apply_edit' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_gc' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_find' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_iterate' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_insert' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_clear' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_insert_set_object' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_cancel_edit' undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
