Return-Path: <keyrings-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D6C54EBC
	for <keyrings@archiver.kernel.org>; Tue, 10 Jan 2023 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjAJTMA (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Tue, 10 Jan 2023 14:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjAJTLi (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Tue, 10 Jan 2023 14:11:38 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0596DFBB;
        Tue, 10 Jan 2023 11:11:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673377846; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=fgjNUnZKnlS2NO43QnBV8y7avtKZwWUTLL/kVFRJkZPOzStFvsy+AgJ+42e4C5gKAAoOOLDIlH6lio9MAeFXvI6lrewPC2gBNVckzs3iLqE8K++zC9mfQVz891uB+6WHYdLtOGMC4zra+YvjyEt/hKOQrUNAJyOb5i96nxvd3ZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673377846; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=94w/84cEKuVEFn2g20pluke79PDKWPNFSLBsY9v/ql8=; 
        b=WRgOCrgiJHyBP8Je59WuVLMKYNSpD1l1zy0B1pLOt9dG5JlgkWJ1RLZ8BFnSrx9A6OtR/nGFmZcvuK0WE6jxZZCwb6y5rtyxeKepfIyBexUFI3GFXA2B22hnikIdkJCHZvi7VjsiRl944vCTLzoiIcj+krKDfm5Jslwra1DprXY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673377846;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=94w/84cEKuVEFn2g20pluke79PDKWPNFSLBsY9v/ql8=;
        b=LsKe4OZPG0vKr3M78UgPtfxUXOmZn6E226af1nX/CH1sPXYNvt/dwivBe676PFIs
        oY/i8i7Z390dKS9GBO5WpdB8AbUzqXBYV+ypC2ts9ziVu9cd6MX2XL5kNgdl6NSdohx
        ndBuAxm0sEL6U0r7NSSgGLT0hkhfzRaVMmG8SzsA=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1673377834655807.4120717855777; Wed, 11 Jan 2023 00:40:34 +0530 (IST)
Date:   Wed, 11 Jan 2023 00:40:34 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1859d17668d.7b9d5469421579.5464668634216421773@siddh.me>
In-Reply-To: <2121105.1673359772@warthog.procyon.org.uk>
References: <97ce37e2fdcfbed29d9467057f0f870359d88b89.1673173920.git.code@siddh.me> <cover.1673173920.git.code@siddh.me> <2121105.1673359772@warthog.procyon.org.uk>
Subject: Re: [PATCH v3 1/2] include/linux/watch_queue: Improve documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Tue, 10 Jan 2023 19:39:32 +0530, David Howells wrote:
> Please don't.
> 
> The structure is documented fully here:
> 
>       Documentation/core-api/watch_queue.rst
> 
> See:
> 
>       https://docs.kernel.org/core-api/watch_queue.html#event-filtering
> 
> The three column approach is much more readable in the code as it doesn't
> separate the descriptions from the things described.  Putting things in
> columns has been around for around 6000 years.
> 
> David

Okay. Apologies for that.

But what about the second patch? Should I send that without these doc
changes?

Thanks,
Siddh
