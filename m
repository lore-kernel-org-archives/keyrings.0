Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727801;
	b=Ht72IPyGaGGwoK52EOA8m+FK+Kp3BB9qMXWelCiXMejPGyx0xYX+aGrcywPLxxJfY65q
	 C8jwwcGKq98ROUcw3kkdEahr8P9MJpSc0Rs7FuuIvEek9zB3Z6TRQbf/c1SYPEp8fyAFU
	 GJQfpy4PGkbuAc2xl4HfR8hw43izT7FZEvevClG0IcNpEGhArU6haOX86npki5Fy0ajQ/
	 KLPypCsGc6LBnUOlVwhaCFWEFtlnwjvb+YLMMuu2I+nsQ9NvVqwKsepdLqb+8kVopx+hl
	 cvkmW7++T1NOHOcCLouMwESGdcrSuKMf5/HaehxACly1sbLeeiwYkgVtWN5Yxacspbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727801;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5nCW4MAO5U33E60itT1BNYSCNPq+U7Gmtnf0gOZEkcs=;
	b=5k+27wBPWnRvQ2ZpjTdhez/Y21m9Niq3H+z0zjZE5d/nox70q3C4fRVHMmSvMPI7XWVV
	 aNEoNTSqgT+oU00EhyoQOr4Dsbw3EyjOwPNHbfQlMc8ZhNWildlRi5Y3EAXf8S8FFKYiC
	 u0aMC2n253EEvXgg1b6XAVq/OX1v7MZZS+ibKuXyG/+9uyGxNNBJr92Jmpt97oWLCYee0
	 BZPlgLeoMwyYPEnHJDw78+e3QWSt6alQoVoVKJkiZe1X3iAbZ5fB48A7jmtQFXT/0HGs+
	 FhQ3ICseCo/tpkBPfAi0LxzhROhXWPT/MKV6OnoBp6ZTwXSAnOcF/ghlk1pV7BdtnOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RFCPfX6o;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C85606A326;
	Thu, 26 Nov 2026 21:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4C85606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RFCPfX6o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795727801; x=1827263801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+b15UN31lbPZUO5Fe6FPuB2I9AA36yHOS5UK/Pyl0sw=;
  b=RFCPfX6oZca+iTCx98JcUXUmvqFmjgq6iTKPpDmXA/hyF6ps1vZ41eSb
   CuJKGuWJop2d+RJId+nSxZWqgP5bEp609FYP9pxMBhXzQOQ+89mzQC6vY
   yc5/wmJxOWLiU9Co5kslMy4JmSLaCDlKqMqX4nUYuwGT+keo53R9ThfJ+
   cNpu2HikD8MihSO/HTj//gkaur644ijjgh27r42JXE1TseGSM4iV1V8vR
   7zgVJczP7Gk8W2Cz+JME1EysDcUxU0IYL/UYWk0WOZo5W3ANamIj6nsQw
   78Ib/LOb60mWf9P8Dql5TbVKMkdN4wHEOZgoCJrOV5SkXB7XQjTFrFMBU
   A==;
X-CSE-ConnectionGUID: 79mQUgnMR0SN4ELZgZOxRg==
X-CSE-MsgGUID: QnSSJprBTuu7W6NeIBIhaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4599560"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4599560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 13:16:39 -0800
X-CSE-ConnectionGUID: 9EmEOJZOQTioQ3ydyd6Vhg==
X-CSE-MsgGUID: D3JfsdMOTOOZuFRZPvpAsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12167196"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 26 Nov 2026 13:16:35 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWgpT-00000001Uu6-3uKA;
	Thu, 26 Nov 2026 21:16:31 +0000
Date: Fri, 27 Nov 2026 05:15:40 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Martin Belanger <martin.nvme.dev@gmail.com>
Subject: Re: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned keys
Message-ID: <20261127044024.YlqHcQQx-lkp@intel.com>
References: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
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
In-Reply-To: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>

Hi Hannes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 68099cf27253a8c89d703a282d3d811446d9453b]

url:    https://github.com/intel-lab-lkp/linux/commits/Hannes-Reinecke/nvme-auth-modify-nvme_auth_transform_key-to-return-status/20261126-151219
base:   68099cf27253a8c89d703a282d3d811446d9453b
patch link:    https://lore.kernel.org/r/20261126-dhchap-keyring-v4-v7-14-ee438ffea527%40kernel.org
patch subject: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned keys
config: hexagon-randconfig-1001-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127044024.YlqHcQQx-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project fb29ca8163c3309160711e5a14eb46bc6d4fdad2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127044024.YlqHcQQx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127044024.YlqHcQQx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/sysfs.c:891:17: warning: variable 'old_key' is uninitialized when used here [-Wuninitialized]
     891 |             key_serial(old_key) != key_serial(key)) {
         |                        ^~~~~~~
   drivers/nvme/host/sysfs.c:853:27: note: initialize the variable 'old_key' to silence this warning
     853 |         struct key *key, *old_key;
         |                                  ^
         |                                   = NULL
   drivers/nvme/host/sysfs.c:996:17: warning: variable 'old_key' is uninitialized when used here [-Wuninitialized]
     996 |             key_serial(old_key) != key_serial(key)) {
         |                        ^~~~~~~
   drivers/nvme/host/sysfs.c:959:27: note: initialize the variable 'old_key' to silence this warning
     959 |         struct key *key, *old_key;
         |                                  ^
         |                                   = NULL
   2 warnings generated.


vim +/old_key +891 drivers/nvme/host/sysfs.c

   848	
   849	static ssize_t dhchap_secret_store(struct device *dev,
   850			struct device_attribute *attr, const char *buf, size_t count)
   851	{
   852		struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
   853		struct key *key, *old_key;
   854		char *dhchap_secret;
   855		bool generated = false;
   856		size_t len;
   857		int ret;
   858	
   859		if (!ctrl->host_key || !count)
   860			return -EINVAL;
   861	
   862		len = strcspn(buf, "\n");
   863		dhchap_secret = kzalloc(len + 1, GFP_KERNEL);
   864		if (!dhchap_secret)
   865			return -ENOMEM;
   866		memcpy(dhchap_secret, buf, len);
   867		nvme_auth_stop(ctrl);
   868	
   869		key = nvme_auth_extract_key(dhchap_secret, len,
   870					    &generated);
   871		if (IS_ERR(key)) {
   872			kfree_sensitive(dhchap_secret);
   873			return PTR_ERR(key);
   874		}
   875		down_read(&key->sem);
   876		ret = key_validate(key);
   877		up_read(&key->sem);
   878		if (ret) {
   879			dev_warn(ctrl->device, "key %08x invalidated\n",
   880				 key_serial(key));
   881			if (generated) {
   882				dev_dbg(ctrl->device, "revoke host key %08x\n",
   883					key_serial(key));
   884				key_revoke(key);
   885			}
   886			key_put(key);
   887			kfree_sensitive(dhchap_secret);
   888			return ret;
   889		}
   890		if (!generated &&
 > 891		    key_serial(old_key) != key_serial(key)) {
   892			dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
   893				 key_serial(old_key));
   894			key_put(key);
   895			kfree_sensitive(dhchap_secret);
   896			return -EPERM;
   897		}
   898		mutex_lock(&ctrl->dhchap_auth_mutex);
   899		old_key = ctrl->host_key;
   900		if (old_key && old_key == key) {
   901			dev_warn(ctrl->device, "using existing key %08x\n",
   902				 key_serial(old_key));
   903			old_key = key;
   904		} else {
   905			if (ctrl->host_key_generated) {
   906				dev_dbg(ctrl->device, "revoke host key %08x\n",
   907					key_serial(old_key));
   908				key_revoke(old_key);
   909			}
   910			ctrl->host_key = key;
   911			ctrl->host_key_generated = generated;
   912		}
   913		mutex_unlock(&ctrl->dhchap_auth_mutex);
   914		key_put(old_key);
   915		kfree_sensitive(dhchap_secret);
   916		/* Start re-authentication */
   917		dev_info(ctrl->device, "re-authenticating controller\n");
   918		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
   919		flush_work(&ctrl->dhchap_auth_work);
   920		return count;
   921	}
   922	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
