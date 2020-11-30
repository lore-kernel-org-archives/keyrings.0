Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609BEC64E8A
	for <keyrings@archiver.kernel.org>; Mon, 30 Nov 2020 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06158207BC
	for <keyrings@archiver.kernel.org>; Mon, 30 Nov 2020 11:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgK3LO5 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Mon, 30 Nov 2020 06:14:57 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57078 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgK3LO5 (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Mon, 30 Nov 2020 06:14:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UGzuhIU_1606734853;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGzuhIU_1606734853)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Nov 2020 19:14:13 +0800
Subject: Re: [PATCH] certs/blacklist: fix kernel doc interface issue
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1604673513-29088-1-git-send-email-alex.shi@linux.alibaba.com>
 <3096975.1606730658@warthog.procyon.org.uk>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f8b65cac-2e42-c5e7-14da-37ac8946717d@linux.alibaba.com>
Date:   Mon, 30 Nov 2020 19:14:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3096975.1606730658@warthog.procyon.org.uk>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org



ÔÚ 2020/11/30 ÏÂÎç6:04, David Howells Ð´µÀ:
> Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>>  /**
>>   * mark_hash_blacklisted - Add a hash to the system blacklist
>> - * @hash - The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
>> + * @hash: - The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
> 
> You should remove the dash when making this change.  I'll do that for you.


Hi David,

Very appreciate for the fixing and reminder!

Regards
Alex
