Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5C1C04A68
	for <keyrings@archiver.kernel.org>; Thu, 28 Jul 2022 08:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiG1ILU (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 28 Jul 2022 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1ILU (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Thu, 28 Jul 2022 04:11:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD63AE5D;
        Thu, 28 Jul 2022 01:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5387C61B46;
        Thu, 28 Jul 2022 08:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8E9C433D6;
        Thu, 28 Jul 2022 08:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658995878;
        bh=c23ZgkhJmhmN1wnP5D1JbbpVm4WFz2aOVz5hhH/OAds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6e9VtqnnXePXNjtw/HfVPKcu1t2JMIo6Iv9/mcYraldHi3VQmAugHjzmBeHVwKJ0
         EcnRRZBaYls2zcLrnVc1N90lnqVy2u0IwgA7ZTzu1OYDIFUbOR/px12dG6syjgta5T
         YqDUOCRtt4vEkZJ02v/sq5ezmt3GO7kkWCoIR9tNq5rD68ewo0db8PiUZaLdlvHQar
         CKP3cFp3dpSkig2mT1gUfpQ8CfPrveelpo7RK8+F5wybjDK3yVoNMrr2qcKBfdZj98
         SoqtG4M6AkV06JNl6Z+4pCe3X7ZKy5Ec/VALfOZdfs48PHwzoCVk/HVj16BEz0wN3R
         aQTXlXvF8zkbQ==
Date:   Thu, 28 Jul 2022 11:11:15 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings <keyrings@vger.kernel.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
Message-ID: <YuJEozyceOKQ63/6@kernel.org>
References: <20220723135035.199188-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723135035.199188-1-code@siddh.me>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Sat, Jul 23, 2022 at 07:20:35PM +0530, Siddh Raman Pant wrote:
> In keyctl_watch_key, use kfree_rcu() for freeing watch and wlist
> as they support RCU and have an rcu_head in the struct definition.
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

Applies to any patch: the commit message should *clearly* describe

1. What is wrong in the current code *behaviour*.
2. Why does the code change save the day.

> ---
>  security/keys/keyctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 96a92a645216..087fbc141cfd 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1832,9 +1832,9 @@ long keyctl_watch_key(key_serial_t id, int watch_queue_fd, int watch_id)
>  	}
>  
>  err_watch:
> -	kfree(watch);
> +	kfree_rcu(watch, rcu);
>  err_wlist:
> -	kfree(wlist);
> +	kfree_rcu(wlist, rcu);
>  err_wqueue:
>  	put_watch_queue(wqueue);
>  err_key:
> -- 
> 2.35.1
> 
> 

BR, Jarkko
