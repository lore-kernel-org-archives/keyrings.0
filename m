Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121C4756DF;
	Fri, 16 Oct 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156928; cv=none; b=ZAabxF4emaGpkG4xMcvdyIVxYVsRDLtsRuc8DDG9wcQL59DuJDDwp+qKjlMG2GaULWWiTYNsHw/mWVjNChOWjqBIafdJKcgtxGh5T7MRntE4KB993f9HsVsTJ0MMmeTeTuTQImWRoSCa42PgjXOXj06WHuLPLdoKwGT6Ty6G+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156928; c=relaxed/simple;
	bh=A7txyVYnucQ+mXIF45spbjwttKKlMtGxt+1t/z8ssrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSlaK0QzTbYsEspOSws11kpQ+5yZzDM+VwyeLtq/A9+ir9KOSV9IO9Ld00Zw9Dkj6wgkn0c03UYXxcZ+hxa3iVwaKvagCu/8ewvTdNplEBeEBGiyVWl2hGp1ccPZ24Ht8WnFiRWQ1apuRUFLV2H4F9ZaI6KsreeBoWFQWJ1ikRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDu/F3sz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDu/F3sz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792156927; x=1823692927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A7txyVYnucQ+mXIF45spbjwttKKlMtGxt+1t/z8ssrA=;
  b=YDu/F3szXkxDMNkM4rpmV4HNY7tjTr7HzUD+TnwOLWlZyx/re1Bct/F5
   6BPNRMsKk75r+4HGFNcsoktxRcC2CHCP27nIvcX3vLHSRacTkUWLuHJ90
   Srg9BpMx8o6b2yjfWMcQ0KO0jRRjOdNOtY/RFj/n7prY4pNFuGp62g5lu
   OXLnnSWwhWYPEgXRhBr99P144qttT0k3taPtsM0xLI9nYTiQMfD5J/OzF
   Wc9ynpXheniTitIbLSruq1Nn38cT0YROcnPF6GjFIiK68HSGuAKt2qFCj
   J1aqG2f4y8SCpBd5ejblMMR3kZLdYQej4y705fc3frmbWjBXIgdvtcckW
   w==;
X-CSE-ConnectionGUID: vnQftWnqTwuMs2qKpwxuNQ==
X-CSE-MsgGUID: 7mFImgLaQIeRb8jdz3Xazg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="820266"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="820266"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:22:06 -0700
X-CSE-ConnectionGUID: NG1UJPDCSDKpNOKt4UMv+A==
X-CSE-MsgGUID: 7F3DT3sORvSDv1o3mBLYiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1831994"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Oct 2026 06:22:03 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHhsl-00000000IAU-1WH4;
	Fri, 16 Oct 2026 13:21:59 +0000
Date: Fri, 16 Oct 2026 21:21:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Rae Moar <raemoar63@gmail.com>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Kir Chou <note351@hotmail.com>, Petr Mladek <pmladek@suse.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	linux-kernel@vger.kernel.org,
	"(open list:KERNEL UNIT TESTING FRAMEWORK \\(KUnit\\))" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] lib/tests: kunit for associative array
Message-ID: <202610162123.hSusVMnq-lkp@intel.com>
References: <20261014160144.1835860-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014160144.1835860-1-jarkko@kernel.org>

Hi Jarkko,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on linus/master v7.3-rc7]
[cannot apply to next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sakkinen/lib-tests-kunit-for-associative-array/20261014-190138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20261014160144.1835860-1-jarkko%40kernel.org
patch subject: [PATCH] lib/tests: kunit for associative array
config: i386-randconfig-1010-20261016 (https://download.01.org/0day-ci/archive/20261016/202610162123.hSusVMnq-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261016/202610162123.hSusVMnq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610162123.hSusVMnq-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_iterate' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_gc' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_insert' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_cancel_edit' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_delete' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_clear' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_apply_edit' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_destroy' undefined!
>> ERROR: modpost: lib/tests/assoc_array_kunit.ko: symbol 'assoc_array_find' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
