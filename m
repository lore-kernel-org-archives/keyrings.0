Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F55C4332F
	for <keyrings@archiver.kernel.org>; Mon, 12 Dec 2022 00:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiLLAxJ (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Sun, 11 Dec 2022 19:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiLLAxI (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Sun, 11 Dec 2022 19:53:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49E15F78;
        Sun, 11 Dec 2022 16:53:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D929BB80884;
        Mon, 12 Dec 2022 00:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A1CC433D2;
        Mon, 12 Dec 2022 00:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670806383;
        bh=i25NifDmKXiZMFx/NkvrxhOa+pPsxs5GuEdk96SEk3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+Pk8n3AdxbVGq5XSCvZzbGHmhMrEau03AmWDuoPX5Kxs5y3mBbCjDUZLZs4ON/fV
         Fr/qFyMSjGQTT1B+WxUMkhYW9DgubNsSU/RQOt8FdpIuxQgq/SHG8OOpz38Wieuk7w
         VNJWFGGKJUcwcQYttxa4nN0BFlBAKOVteZdN+vI6NjD4Tkufbdm0+jL6kA0zySZY15
         gZDHMgT3BmSNctX4LVFT2QbiCJLnRyVPg1FpzK1dZsfdGZE/HJdV5KyePurDOhtFrM
         N1gzePiW4iHXDz7wgzEiOG0rCYeuD6s72mHw+eKsDWlo/a6Jv52VKx4CJpw3yn7t7V
         XW0uIZI/EtKIA==
Date:   Mon, 12 Dec 2022 00:52:59 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        keyrings@vger.kernel.org
Subject: Re: [PATCH 01/11] tpm: move buffer handling from static inlines to
 real functions
Message-ID: <Y5Z7awuHL9Wsn2l/@kernel.org>
References: <20221209160611.30207-1-James.Bottomley@HansenPartnership.com>
 <20221209160611.30207-2-James.Bottomley@HansenPartnership.com>
 <Y5PqRdlEdBjj72KM@kernel.org>
 <704a88efc2a7cf5c2679af2ca37a682efd6ceaa2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <704a88efc2a7cf5c2679af2ca37a682efd6ceaa2.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Sun, Dec 11, 2022 at 03:01:57PM -0500, James Bottomley wrote:
> On Sat, 2022-12-10 at 02:09 +0000, Jarkko Sakkinen wrote:
> > On Fri, Dec 09, 2022 at 11:06:01AM -0500, James Bottomley wrote:
> > > This separates out the old tpm_buf_... handling functions from
> > > static
> > > inlines in tpm.h and makes them their own tpm-buf.c file.  This is
> > > a
> > > precursor so we can add new functions for other TPM type handling
> > > 
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > 
> > I don't comprehend that explanation at all.
> > 
> > Please, add a bit more detail why this precursory change is required.
> 
> It's the usual submitting-patches requirement of moving code first
> before modifying it.  Since it's the recommended way of doing things in
> our process docs, I'm not sure how much more explanation can be given.

It doesn not contain any reasonable argument for not continue
using inline functions.

BR, Jarkko
