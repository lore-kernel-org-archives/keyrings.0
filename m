Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8424CC433E6
	for <keyrings@archiver.kernel.org>; Thu, 11 Mar 2021 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384D264FD0
	for <keyrings@archiver.kernel.org>; Thu, 11 Mar 2021 10:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhCKKtg (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 11 Mar 2021 05:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232286AbhCKKtW (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Thu, 11 Mar 2021 05:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615459761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZJSx94FqW1TXm5NcCQ7bCllPHLm9/0IrJRVFHUeK0g=;
        b=PujKW7dvGc0W81pPWGI4f/An6a9QHI6ZzGHyoNF2DPWfQzD+eLEUtD7WJyfytnZf8wKNgN
        kTxv/6eYgkIp6jRjKsFzZ8OJqRfZRDYNdBLeFDshJzmb2T4Xj6/zzcsPQm21JMCIOVpcV+
        SWcn8+tBZeOJRpp3Yf5lmmOyOrcxJjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-94k_pcR9MRiLFtXeAiLxCg-1; Thu, 11 Mar 2021 05:49:18 -0500
X-MC-Unique: 94k_pcR9MRiLFtXeAiLxCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D77C480432F;
        Thu, 11 Mar 2021 10:49:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2B2F1B471;
        Thu, 11 Mar 2021 10:49:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <91190.1615444370@turing-police>
References: <91190.1615444370@turing-police>
To:     "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 'make O=' indigestion with module signing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <972380.1615459754.1@warthog.procyon.org.uk>
Date:   Thu, 11 Mar 2021 10:49:14 +0000
Message-ID: <972381.1615459754@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

I wonder...  Can you grab branch keys-cve-2020-26541-branch from:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/

and try that?  If that breaks, can you try dropping the top four commits?

David

