Return-Path: <SRS0=TJ41=EC=vger.kernel.org=keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C34C55178
	for <keyrings@archiver.kernel.org>; Tue, 27 Oct 2020 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71DA2080A
	for <keyrings@archiver.kernel.org>; Tue, 27 Oct 2020 01:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503844AbgJ0BYh (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Mon, 26 Oct 2020 21:24:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:50539 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503842AbgJ0BYh (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Mon, 26 Oct 2020 21:24:37 -0400
IronPort-SDR: lG2OCie9uMcdM5BnP7/krBB1D1/q7Ffu2Dy5Ap0aTA/VlbSi63psk7kdQkl82fA5aofMKCi0ok
 n06kphYu2Qiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="165421119"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="165421119"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 18:24:36 -0700
IronPort-SDR: 6NmLwTBEWfrCpL1SxpFnfrcWRhcyVnrqQR3aGmAH2QtYp0AKqSGFTdzE7kLcYB5BBCTImMdMOq
 iCwemuy/LOnA==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="535587383"
Received: from ksprzacz-mobl1.ger.corp.intel.com (HELO linux.intel.com) ([10.252.59.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 18:24:30 -0700
Date:   Tue, 27 Oct 2020 03:24:25 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     trix@redhat.com
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, jejb@linux.ibm.com, dhowells@redhat.com,
        mortonm@chromium.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] security: remove unneeded break
Message-ID: <20201027012425.GA20485@linux.intel.com>
References: <20201019173653.527-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019173653.527-1-trix@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Mon, Oct 19, 2020 at 10:36:53AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
