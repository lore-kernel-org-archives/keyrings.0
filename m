Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3A348C7D;
	Fri, 16 Oct 2026 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129019; cv=none; b=E3y/CF9b5ci8pASJEmby+DvigS6pUA5N5zQI0T8c93/uXZVomswj1xO5R6e1oWvtS52cBx2oQ6jVKz9tOM44K8U5EkEJaoeKkYRdmowovB9sNw7T8zpI4CcasziH/igN63gnsCxH/IZlW0DEQ2K+6aECuq9lsAe6DyB+MBDg2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129019; c=relaxed/simple;
	bh=OxsimB+IRUojLvT+hziSkxVdTCzcdvyp81HuqPLZG/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP+s23pj0YxJTegXfeFM1ZEnDQ+R8BWt+3hMfemCUAWFQUC6+Y8jX/ha+mJiu1pQo0IWnJMAhePv1xaIxoScDUH44tgAmZfvTa6kzIKvfO6VljhhgLxHwRV6eSOKOEXB4jrAUHS4nj7ZTTN0o0Cef/4R0vGplx3Bgg0h3mcVZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFvy02k4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFvy02k4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792129017; x=1823665017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OxsimB+IRUojLvT+hziSkxVdTCzcdvyp81HuqPLZG/s=;
  b=IFvy02k40L6WlN0E6Q9Ei3c7kfpQppWK1wrQf3yIck7ebJPhNf2lp6Zn
   puFGZszpoeRSzSBfzhgilgED09XCaGxQNozKbPHsipg1wRjL8bhYt/9OS
   kPO8T5gTowL9qxsNw/5OsI4YfQgvk+PZd6ZKJ0BD54s+fZL70gWeS5fgM
   zRUUtES/g/R2SCqwG4oM1KJE5rF4Px7G9a+wsE2cJoYVtvxsUBtE5kUrL
   SzQQf75mFcfbAR9xf+nS+lYp/g6mIhHujql3eURcZuy3RjUGlNlGoLAF/
   Y0lZqgq0WWRxMFKn0h9/7Psu/7xl1tzrzjVAKx5A3fBIRXN1qF7M756Q5
   w==;
X-CSE-ConnectionGUID: c7Vg7lllTnCJ05eeJ5FPCg==
X-CSE-MsgGUID: BcupQumpRBubh7rLvp4JBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="915287"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="915287"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 22:36:56 -0700
X-CSE-ConnectionGUID: cV+8eTvqSQ2EgdgT1mW2lg==
X-CSE-MsgGUID: jlVQO0VBQtCYTbTBdJ3bkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2236954"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Oct 2026 22:36:51 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHacZ-00000000Hfu-0y6G;
	Fri, 16 Oct 2026 05:36:47 +0000
Date: Fri, 16 Oct 2026 13:36:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>
Cc: oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
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
Message-ID: <202610161338.iIHVeJyP-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v7.3-rc7]
[cannot apply to next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sakkinen/lib-tests-kunit-for-associative-array/20261014-190138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20261014160144.1835860-1-jarkko%40kernel.org
patch subject: [PATCH] lib/tests: kunit for associative array
config: arm-randconfig-1001-20261016 (https://download.01.org/0day-ci/archive/20261016/202610161338.iIHVeJyP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261016/202610161338.iIHVeJyP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610161338.iIHVeJyP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/tests/assoc_array_kunit.c:62:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000010UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:63:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000020UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:64:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000030UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:65:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000040UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:66:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000050UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:67:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000060UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:68:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000070UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:69:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000080UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:70:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000090UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:71:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x00000000000000a0UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:72:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x00000000000000b0UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:73:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x00000000000000c0UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:74:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x00000000000000d0UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:75:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x00000000000000e0UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:76:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x00000000000000f0UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:77:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000100UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:78:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000110UL,
     ^~~~~~~~~~~~~~~~~~~~
   lib/tests/assoc_array_kunit.c:79:2: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '16045690984503098046' to '3405691582' [-Woverflow]
     0xdeadbeefcafebabeUL, 0x0000000000000001UL,
     ^~~~~~~~~~~~~~~~~~~~


vim +62 lib/tests/assoc_array_kunit.c

    19	
    20	/*
    21	 * As a quick remainder, these are the basic building blocks of an associative
    22	 * array:
    23	 *
    24	 * - struct assoc_array_node: a tree node representing a nibble of the search
    25	 *   key.
    26	 * - struct assoc_array_shortcut: a tree node representing a sequence of nibbles
    27	 *   shared by multiple search keys with no divergence among them.
    28	 *
    29	 * The keys in array will be created in order in tests, and is a constructed in
    30	 * a way that splits reach the level 8:
    31	 *
    32	 * - 0..16:  Share prefix 0x21 at levels 0 and 4.
    33	 * - 17:     Splits root shortcut at level 4.
    34	 * - 18..34: Share chunk 0.
    35	 * - 35:     Splits shortcut at chunk boundary.
    36	 * - 36..46: Share prefix 0xbeef at levels 0..12.
    37	 * - 47:     Splits shortcut at level 8.
    38	 * - 48..63: Distinct leaves at level 0.
    39	 *
    40	 * The numbers were picked partly based on trial and error, and partly trying to
    41	 * find smallest possible numbers reaching the level 8.
    42	 */
    43	static const unsigned long assoc_array_test_keys[ASSOC_ARRAY_TEST_NR_KEYS * 2] = {
    44		0x0000000000000121UL, 0x0000000000000000UL,
    45		0x0000000000000221UL, 0x0000000000000000UL,
    46		0x0000000000000321UL, 0x0000000000000000UL,
    47		0x0000000000000421UL, 0x0000000000000000UL,
    48		0x0000000000000521UL, 0x0000000000000000UL,
    49		0x0000000000000621UL, 0x0000000000000000UL,
    50		0x0000000000000721UL, 0x0000000000000000UL,
    51		0x0000000000000821UL, 0x0000000000000000UL,
    52		0x0000000000000921UL, 0x0000000000000000UL,
    53		0x0000000000000a21UL, 0x0000000000000000UL,
    54		0x0000000000000b21UL, 0x0000000000000000UL,
    55		0x0000000000000c21UL, 0x0000000000000000UL,
    56		0x0000000000000d21UL, 0x0000000000000000UL,
    57		0x0000000000000e21UL, 0x0000000000000000UL,
    58		0x0000000000000f21UL, 0x0000000000000000UL,
    59		0x0000000000001021UL, 0x0000000000000000UL,
    60		0x0000000000001121UL, 0x0000000000000000UL,
    61		0x0000000000000001UL, 0x0000000000000000UL,
  > 62		0xdeadbeefcafebabeUL, 0x0000000000000010UL,
    63		0xdeadbeefcafebabeUL, 0x0000000000000020UL,
    64		0xdeadbeefcafebabeUL, 0x0000000000000030UL,
    65		0xdeadbeefcafebabeUL, 0x0000000000000040UL,
    66		0xdeadbeefcafebabeUL, 0x0000000000000050UL,
    67		0xdeadbeefcafebabeUL, 0x0000000000000060UL,
    68		0xdeadbeefcafebabeUL, 0x0000000000000070UL,
    69		0xdeadbeefcafebabeUL, 0x0000000000000080UL,
    70		0xdeadbeefcafebabeUL, 0x0000000000000090UL,
    71		0xdeadbeefcafebabeUL, 0x00000000000000a0UL,
    72		0xdeadbeefcafebabeUL, 0x00000000000000b0UL,
    73		0xdeadbeefcafebabeUL, 0x00000000000000c0UL,
    74		0xdeadbeefcafebabeUL, 0x00000000000000d0UL,
    75		0xdeadbeefcafebabeUL, 0x00000000000000e0UL,
    76		0xdeadbeefcafebabeUL, 0x00000000000000f0UL,
    77		0xdeadbeefcafebabeUL, 0x0000000000000100UL,
    78		0xdeadbeefcafebabeUL, 0x0000000000000110UL,
    79		0xdeadbeefcafebabeUL, 0x0000000000000001UL,
    80		0x000000000001beefUL, 0x0000000000000000UL,
    81		0x000000000002beefUL, 0x0000000000000000UL,
    82		0x000000000003beefUL, 0x0000000000000000UL,
    83		0x000000000004beefUL, 0x0000000000000000UL,
    84		0x000000000005beefUL, 0x0000000000000000UL,
    85		0x000000000006beefUL, 0x0000000000000000UL,
    86		0x000000000007beefUL, 0x0000000000000000UL,
    87		0x000000000008beefUL, 0x0000000000000000UL,
    88		0x000000000009beefUL, 0x0000000000000000UL,
    89		0x00000000000abeefUL, 0x0000000000000000UL,
    90		0x00000000000bbeefUL, 0x0000000000000000UL,
    91		0x00000000000000efUL, 0x0000000000000000UL,
    92		0x0000000000001000UL, 0x0000000000000000UL,
    93		0x0000000000001001UL, 0x0000000000000000UL,
    94		0x0000000000001002UL, 0x0000000000000000UL,
    95		0x0000000000001003UL, 0x0000000000000000UL,
    96		0x0000000000001004UL, 0x0000000000000000UL,
    97		0x0000000000001005UL, 0x0000000000000000UL,
    98		0x0000000000001006UL, 0x0000000000000000UL,
    99		0x0000000000001007UL, 0x0000000000000000UL,
   100		0x0000000000001008UL, 0x0000000000000000UL,
   101		0x0000000000001009UL, 0x0000000000000000UL,
   102		0x000000000000100aUL, 0x0000000000000000UL,
   103		0x000000000000100bUL, 0x0000000000000000UL,
   104		0x000000000000100cUL, 0x0000000000000000UL,
   105		0x000000000000100dUL, 0x0000000000000000UL,
   106		0x000000000000100eUL, 0x0000000000000000UL,
   107		0x000000000000100fUL, 0x0000000000000000UL,
   108	};
   109	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
