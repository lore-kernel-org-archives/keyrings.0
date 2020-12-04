Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E6BC433FE
	for <keyrings@archiver.kernel.org>; Fri,  4 Dec 2020 04:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4692122515
	for <keyrings@archiver.kernel.org>; Fri,  4 Dec 2020 04:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLDEu5 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 3 Dec 2020 23:50:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:3386 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgLDEu5 (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Thu, 3 Dec 2020 23:50:57 -0500
IronPort-SDR: Vxy8PoX28wHj+bSiVRAe8bi64Dc6mGrvtBmzVD0WGHNViUgMrDZqOoH3WnZTxGh+a3fWsoV4hP
 qWakEcdTpW/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="160382208"
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="160382208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:49:15 -0800
IronPort-SDR: vWV4gCxUZ7mswyKojm/wl5EsVXmPLFVSifh1JS5mZYKGg+iHQG7YrrtKxzrq+g7b77JJBHAOLL
 JQxDszWNZxAQ==
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="315981218"
Received: from kramerha-mobl.ger.corp.intel.com (HELO linux.intel.com) ([10.252.53.177])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 20:49:12 -0800
Date:   Fri, 4 Dec 2020 06:49:08 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org,
        kbuild-all@lists.01.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20201204044908.GD84413@linux.intel.com>
References: <20201129222004.4428-5-James.Bottomley@HansenPartnership.com>
 <202011301002.yYRCOdq5-lkp@intel.com>
 <5e94c7199c675bbfa7112f8b79fcb91f8d2d4fe7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e94c7199c675bbfa7112f8b79fcb91f8d2d4fe7.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Mon, Nov 30, 2020 at 11:58:43AM -0800, James Bottomley wrote:
> On Mon, 2020-11-30 at 10:10 +0800, kernel test robot wrote:
> [...]
> >  > 331		if (payload->blob_len < 0)
> >    332			return payload->blob_len;
> 
> OK, I can rework this to use the signed version of blob len as below.
> 
> James

Do you have the patches in a git branch somewhere with this fixed?

I can take from there and apply.

/Jarkko
