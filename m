Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DFC433FE
	for <keyrings@archiver.kernel.org>; Fri,  4 Dec 2020 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2183C22C7C
	for <keyrings@archiver.kernel.org>; Fri,  4 Dec 2020 16:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLDQCQ (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDQCQ (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Fri, 4 Dec 2020 11:02:16 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267BC0613D1;
        Fri,  4 Dec 2020 08:01:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DA72212807D1;
        Fri,  4 Dec 2020 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607097693;
        bh=531MZAcDtnYtUyV5u/GZDKSaWvEXqRhYBHHnJN96MOs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q0vGytywPUFIsb3aRsyE4Csin0afWe1s/TPUpGcrd5ivM28T7V3qTid7cBoUhlbSP
         O4B/o6ruNdQTE6CUcjFHMNQgVfIFXbvIzXMrKoSCgIdOVShFA9D0zz82oDOlE8GRWS
         7/q6K3CPnhxB2wMJhPk20HPZ7Fz6LOiW0NO8dA4g=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g-jYSrEeO_Yy; Fri,  4 Dec 2020 08:01:33 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 68A6212807CC;
        Fri,  4 Dec 2020 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607097693;
        bh=531MZAcDtnYtUyV5u/GZDKSaWvEXqRhYBHHnJN96MOs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Q0vGytywPUFIsb3aRsyE4Csin0afWe1s/TPUpGcrd5ivM28T7V3qTid7cBoUhlbSP
         O4B/o6ruNdQTE6CUcjFHMNQgVfIFXbvIzXMrKoSCgIdOVShFA9D0zz82oDOlE8GRWS
         7/q6K3CPnhxB2wMJhPk20HPZ7Fz6LOiW0NO8dA4g=
Message-ID: <4a10673aed90de1fe843a18f3790361239b8dbd7.camel@HansenPartnership.com>
Subject: Re: [PATCH v14 2/5] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Fri, 04 Dec 2020 08:01:32 -0800
In-Reply-To: <112051.1607089494@warthog.procyon.org.uk>
References: <20201129222004.4428-3-James.Bottomley@HansenPartnership.com>
         <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
         <112051.1607089494@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

On Fri, 2020-12-04 at 13:44 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > The TCG has defined an OID prefix "2.23.133.10.1" for the various
> > TPM key uses.
> 
> Is this registered?  I've checked a couple of OID registry sites
> (eg. www.oid-info.com) and it seems to be unknown.

Yes, TCG owns 2.23.133, although I still don't think Monty has
published it yet:

https://lore.kernel.org/linux-integrity/26ED11907FC0F446BB0296B5357EEF0E316CDBB0@CINMBCNA02.e2k.ad.ge.com/

James


