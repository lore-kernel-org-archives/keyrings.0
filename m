Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49784C433EF
	for <keyrings@archiver.kernel.org>; Thu, 19 May 2022 20:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbiESUvs (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 19 May 2022 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbiESUvg (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Thu, 19 May 2022 16:51:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC24EF4F;
        Thu, 19 May 2022 13:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7A06B8288A;
        Thu, 19 May 2022 20:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3687DC385AA;
        Thu, 19 May 2022 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652993464;
        bh=gResFGt0OUUyfoww+2TLimDFy+zUQwPWohGqdQAsLk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ji+KbvckQL+YS+VdJs7DTARHnwAIGKaWBqEj64fkNAlf8XgGg1IAH+ULw7RM7Scvl
         yLa6p7vtEPr1FEnbYpg4+feCcHvNNP+jrR3P2fun+g9tyZGIryi3p+hwhO//H6ReHY
         JvMDN8XgQ028YoDKhrBKstFlM2lwpW3ydfH4PBcw9yi4XmGdskx//va6JpS1nIbHOD
         87R8DOU2xbNAcSsi08sd7PEfI40X2znw1Mw+FhodDeCTLQV+MT3E2xA+uJsAPdj+Ap
         adsQPvzMIPqlQzhLrHSvFeCHraBWOD9rU0pIvQIs8TaIk8G0+Pgg3Zb8i95TepUUsm
         b6eTlIfED8RYw==
Date:   Thu, 19 May 2022 23:49:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, keyrings@vger.kernel.org
Subject: Re: [PATCH] keys: Use struct_size and size_add helper with alloc
Message-ID: <YoatVbXu5g6f7gD7@iki.fi>
References: <20220519024702.215223-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519024702.215223-1-guozihua@huawei.com>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Thu, May 19, 2022 at 10:47:02AM +0800, GUO Zihua wrote:
> Use struct_size helper for calculating size of flexible struct to avoid
> potential issues and improve readibility. Use size_add to calculate
> addition of size to prevent potential issues.

What issues? Please explicitly state the issues.

BR, Jarkko
