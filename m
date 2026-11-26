Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724615;
	b=Ex+5hpk29vRW+tY0V2eExZR3OBj17KP/quHZef788Xpg3FIHiM7TKNr8L/EIAHawAGz+
	 X0oGkxe27pGO+LN4qMZDXI16tteVLi4Z+C1xEM0U4Of0WmUo1mEJyx3gCsMrcDx2UAj+C
	 YxEb0CL1KESiO6/LojNrcDjM7Q31USwx6VUL1Aw6+TKDQGqtNc2e1OnmjwnjcXbKjhgYB
	 TsLX+CjnUuYTLTish1mnhwYWUBy30cjw4F2TP+NLFf1Y1AUtFg7fg9GJ4gRso8FO4MdEm
	 GSqEBLpe+lYwJ4wLLURWFp9doUVL7xi+QTlaAT3l4R6au2JF5vI1nyMx/Q0fLksTi8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724615;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=U06Pm+QNLCfQEC/0EPTt5m6/AIUiEW5bix7eerP4ShM=;
	b=FVD/Z9J9Vu1BfxeAAJgZr748NZ1o+Bj/CIOuxV67p1E9JPtdWkscoQZii56z3Hd7nANK
	 H3e6du1kWqnEqZUEDp3/umEIHV5z2cS4dJqozTIUWHXiIKOBPwuMw/rJmORWUpZJkQoWw
	 us8u6YfPqSnxlE7srKNM9ccgFaus1VFpP4AkRI/Xy2aX3QzXS9iusyz81PtHHadoQM/+Y
	 QyG2bhQ/UxIf8t7q6cIZNHH5nPzf7ubXRDFHH7s3aFmVdLwQ/yEp+NgBh1goXSVmyr04f
	 tEBRvrE0z19UjgypiWuO4kg6sPI40bBMQuq9MzxmDWscWAEkZeQgUNW1EswBj7QGdwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3J8FkAN;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B9606A31E;
	Thu, 26 Nov 2026 20:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2B9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3J8FkAN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795724614; x=1827260614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/dNvAQSpVvJI3DOV3ndv6IHH3ZCcFMm5U2yS/NNIk8o=;
  b=a3J8FkANqStS4Z83xGhIC6GqsX7ENurswKPHuKuAi0BfKGON8F+ZNdu4
   /7Hj+KOVbBHM2TnGBTXJjdwY4B8sYKoWUvuDxdh06Y2ZTzGiUtr5TdGAV
   I0UrK8VDJOcs7lybuR8EJObuOdIMBRh0pnvkbQXUoTFgG4DX9o/bIVj8Y
   ytbxViwYD2NLddhP1m5cBapxek7NyWk7UwVEsqyoAJ4Sut6HaYE7EYCrG
   Ui0wgzEFkGwtt4gDwetMHh06xIbgy2sbmVIn9lL3Mnye+jr/P9WPdgMj1
   65d95Cu+agEy/ASAY2Oze8zlV/OMJJqrvJOVsLqBKLUOWPBtvBwBu2Fj6
   w==;
X-CSE-ConnectionGUID: h9vuLA0rQqiEVZK6yJSn8A==
X-CSE-MsgGUID: CATA6f/aR0+qqSLeEJMWOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4534785"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4534785"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 12:23:33 -0800
X-CSE-ConnectionGUID: OvdX03tQSPe00cOodiFvLQ==
X-CSE-MsgGUID: pljUvq+7S6KkPcSYVDwl7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12129448"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2026 12:23:29 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWg05-00000001UmI-43U4;
	Thu, 26 Nov 2026 20:23:25 +0000
Date: Fri, 27 Nov 2026 04:22:34 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme
 keyring
Message-ID: <20261127041445.UXBLiTUG-lkp@intel.com>
References: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
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
In-Reply-To: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>

Hi Hannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 68099cf27253a8c89d703a282d3d811446d9453b]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261126-151219
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261126-dhchap-keyring-v4-v7-5-ee438ffea527%40kernel.org
patch subject: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme keyring
config: i386-randconfig-1003-20261126 (https://download.01.org/0day-ci/archive/20261127/20261127041445.UXBLiTUG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127041445.UXBLiTUG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127041445.UXBLiTUG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/sysfs.c:9:
>> include/linux/nvme-keyring.h:47:5: warning: no previous prototype for 'nvme_keyring_unlink' [-Wmissing-prototypes]
      47 | int nvme_keyring_unlink(struct key *keyring)
         |     ^~~~~~~~~~~~~~~~~~~
>> include/linux/nvme-keyring.h:43:12: warning: 'nvme_keyring_link' defined but not used [-Wunused-function]
      43 | static int nvme_keyring_link(struct key *keyring)
         |            ^~~~~~~~~~~~~~~~~
>> include/linux/nvme-keyring.h:39:20: warning: 'nvme_keyring_name' defined but not used [-Wunused-function]
      39 | static const char *nvme_keyring_name(void)
         |                    ^~~~~~~~~~~~~~~~~


vim +/nvme_keyring_unlink +47 include/linux/nvme-keyring.h

    22	
    23	#else
    24	static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
    25			const char *hostnqn, const char *subnqn, u8 hmac_id,
    26			u8 *data, size_t data_len, const char *digest)
    27	{
    28		return ERR_PTR(-EOPNOTSUPP);
    29	}
    30	static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
    31			const char *hostnqn, const char *subnqn)
    32	{
    33		return 0;
    34	}
    35	static inline key_serial_t nvme_keyring_id(void)
    36	{
    37		return 0;
    38	}
  > 39	static const char *nvme_keyring_name(void)
    40	{
    41		return NULL;
    42	}
  > 43	static int nvme_keyring_link(struct key *keyring)
    44	{
    45		return 0;
    46	}
  > 47	int nvme_keyring_unlink(struct key *keyring)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
