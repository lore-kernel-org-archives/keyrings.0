Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C91C433EF
	for <keyrings@archiver.kernel.org>; Sun, 26 Jun 2022 06:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiFZGPF (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Sun, 26 Jun 2022 02:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiFZGPF (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Sun, 26 Jun 2022 02:15:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1211141;
        Sat, 25 Jun 2022 23:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67551B80CCC;
        Sun, 26 Jun 2022 06:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A737C34114;
        Sun, 26 Jun 2022 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656224101;
        bh=Jpu3++f8wiVVRZVw7p4MRwv6QS1KuAJRMQEMHQYlthc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYgSY/Q39mwyb9mf64LrADKkJi2YdmWLIA+loemMrfo+dZeNxTlxPNk2YTNcFge4G
         KIDMebcWwAytMRyNmgSHHCiGj8o7lTNuAvsyhozwDiXxBghM7JwRROvUPjGwgk6Ega
         W3vjcD59yIsX/WW9ez9yHbAZK3ky9gk+k/OgW+kNurotKgBwKaJLiUsoBQ5aUNthJb
         tjHMLDwkWimXLt65y/6K7tCwcqHN8pS69BVs1r6F1RWFQ34DnaMlOIap6ti3FDTrvD
         olu4tgFQ/IuH1Gqt9/3t9ZEbPIT4E4dMnG48L8EVAWjQ9pQWeXNa78Jnt0xm2krhoS
         TI3tlKHBNZNmg==
Date:   Sun, 26 Jun 2022 09:14:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        James Morris <jmorris@namei.org>,
        James Morris <jamorris@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sign-file: Fix confusing error messages
Message-ID: <Yrf5YU1IktrMBdLx@kernel.org>
References: <20210624104824.82616-1-tianjia.zhang@linux.alibaba.com>
 <eb589e46-f46f-689d-72bc-1ce552cb5313@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb589e46-f46f-689d-72bc-1ce552cb5313@linux.alibaba.com>
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Fri, Jun 17, 2022 at 05:24:55PM +0800, Tianjia Zhang wrote:
> Hi Jarkko,
> 
> On 6/24/21 6:48 PM, Tianjia Zhang wrote:
> > When an error occurs, use errx() instead of err() to display the
> > error message, because openssl has its own error record. When an
> > error occurs, errno will not be changed, while err() displays the
> > errno error message. It will cause confusion. For example, when
> > CMS_add1_signer() fails, the following message will appear:
> > 
> >    sign-file: CMS_add1_signer: Success
> > 
> > errx() ignores errno and does not cause such issue.
> > 
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > ---
> >   scripts/sign-file.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> > index fbd34b8e8f57..37d8760cb0d1 100644
> > --- a/scripts/sign-file.c
> > +++ b/scripts/sign-file.c
> > @@ -107,7 +107,7 @@ static void drain_openssl_errors(void)
> >   		bool __cond = (cond);			\
> >   		display_openssl_errors(__LINE__);	\
> >   		if (__cond) {				\
> > -			err(1, fmt, ## __VA_ARGS__);	\
> > +			errx(1, fmt, ## __VA_ARGS__);	\
> >   		}					\
> >   	} while(0)
> 
> Likewise, No response from David, can you pick this? thanks.
> 
> Best regards,
> Tianjia

Ditto.

BR, Jarkko
