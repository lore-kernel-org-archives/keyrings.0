Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FBDC3E8C5
	for <keyrings@archiver.kernel.org>; Sun, 29 Nov 2020 05:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7209020825
	for <keyrings@archiver.kernel.org>; Sun, 29 Nov 2020 05:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2Fb2 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Sun, 29 Nov 2020 00:31:28 -0500
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:52326 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgK2Fb1 (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Sun, 29 Nov 2020 00:31:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B352F180154A5;
        Sun, 29 Nov 2020 05:30:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glass65_2d09b2427396
X-Filterd-Recvd-Size: 1523
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Nov 2020 05:30:45 +0000 (UTC)
Message-ID: <d9e5515497f5215294cf79bec973155d0132f25e.camel@perches.com>
Subject: Re: [PATCH] keys: remove trailing semicolon in macro definition
From:   Joe Perches <joe@perches.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, trix@redhat.com
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 28 Nov 2020 21:30:44 -0800
In-Reply-To: <20201129044514.GH39488@kernel.org>
References: <20201127191543.2854306-1-trix@redhat.com>
         <20201129044514.GH39488@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Sun, 2020-11-29 at 06:45 +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 27, 2020 at 11:15:43AM -0800, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > The macro use will already have a semicolon.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> I'm in-between whether this is worth of merging. The commit message
> does not help with that decision too much.

It seems worthy of merging to me modulo whatver improvement is desired in
the commit message.

There are 3 existing uses of request_key_net.  All have a trailing semicolon.
There is 1 existing use of request_key_net_rcu.  It has a trailing semicolon.

No object change should occur.


