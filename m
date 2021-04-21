Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B9C433ED
	for <keyrings@archiver.kernel.org>; Wed, 21 Apr 2021 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB68613C7
	for <keyrings@archiver.kernel.org>; Wed, 21 Apr 2021 22:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhDUWnY (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Wed, 21 Apr 2021 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhDUWnY (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Wed, 21 Apr 2021 18:43:24 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03B6C06174A;
        Wed, 21 Apr 2021 15:42:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BA59B128014A;
        Wed, 21 Apr 2021 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619044968;
        bh=LXNWijd3Tbtc5YeYLverXSaOp867ZvVgPJ3g/XXTL8o=;
        h=Message-ID:Subject:From:To:Date:From;
        b=c09zmdozt/wPqUQxqah1tdxrThSwrEkbKg8/NdhxMKD64fAZJGuONbHXVvMJBimZN
         CtnKxGr3euH8eF+aC4ribE0MVEHi3rEFt3KnhJduOueyYjXuiDkcus2A1QF+tKWs9L
         ze+yW+KcmWmeVlhNTXSFGRrjEqdPsRplAoSttoLY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ovvH6J0W4cSP; Wed, 21 Apr 2021 15:42:48 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5AFCA1280129;
        Wed, 21 Apr 2021 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619044968;
        bh=LXNWijd3Tbtc5YeYLverXSaOp867ZvVgPJ3g/XXTL8o=;
        h=Message-ID:Subject:From:To:Date:From;
        b=c09zmdozt/wPqUQxqah1tdxrThSwrEkbKg8/NdhxMKD64fAZJGuONbHXVvMJBimZN
         CtnKxGr3euH8eF+aC4ribE0MVEHi3rEFt3KnhJduOueyYjXuiDkcus2A1QF+tKWs9L
         ze+yW+KcmWmeVlhNTXSFGRrjEqdPsRplAoSttoLY=
Message-ID: <30acbe05a0569bd3b3a9f968c4863e1f42b6d320.camel@HansenPartnership.com>
Subject: [PATCH] KEYS: trusted: Fix TPM reservation for seal/unseal
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     jarkko@kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed, 21 Apr 2021 15:42:47 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

The original patch 8c657a0590de ("KEYS: trusted: Reserve TPM for seal
and unseal operations") was correct on the mailing list:

https://lore.kernel.org/linux-integrity/20210128235621.127925-4-jarkko@kernel.org/

But somehow got rebased so that the tpm_try_get_ops() in
tpm2_seal_trusted() got lost.  This causes an imbalanced put of the
TPM ops and causes oopses on TIS based hardware.

This fix puts back the lost tpm_try_get_ops()

Fixes: 8c657a0590de ("KEYS: trusted: Reserve TPM for seal and unseal operations")
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index d225ad140960..617fabd4d913 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -248,7 +248,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (!options->keyhandle)
 		return -EINVAL;
 
-	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
+	rc = tpm_try_get_ops(chip);
 	if (rc)
 		return rc;
 
-- 
2.26.2


