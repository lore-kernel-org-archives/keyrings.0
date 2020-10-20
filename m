Return-Path: <SRS0=hM9P=D3=vger.kernel.org=keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20209C433DF
	for <keyrings@archiver.kernel.org>; Tue, 20 Oct 2020 02:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39F3223BF
	for <keyrings@archiver.kernel.org>; Tue, 20 Oct 2020 02:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390679AbgJTCsh (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:48:37 -0400
Received: from namei.org ([65.99.196.166]:36578 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgJTCsh (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Mon, 19 Oct 2020 22:48:37 -0400
X-Greylist: delayed 3899 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 22:48:36 EDT
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 09K1hKiQ003665;
        Tue, 20 Oct 2020 01:43:20 GMT
Date:   Tue, 20 Oct 2020 12:43:20 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Tom Rix <trix@redhat.com>
cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, serge@hallyn.com,
        jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com,
        dhowells@redhat.com, mortonm@chromium.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH] security: remove unneeded break
In-Reply-To: <20201019173653.527-1-trix@redhat.com>
Message-ID: <alpine.LRH.2.21.2010201243060.17044@namei.org>
References: <20201019173653.527-1-trix@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Mon, 19 Oct 2020, trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>



-- 
James Morris
<jmorris@namei.org>

