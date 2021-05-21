Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE9C433B4
	for <keyrings@archiver.kernel.org>; Fri, 21 May 2021 00:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEC2613AE
	for <keyrings@archiver.kernel.org>; Fri, 21 May 2021 00:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhEUApe (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 20 May 2021 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhEUApe (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Thu, 20 May 2021 20:45:34 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A68CC061574;
        Thu, 20 May 2021 17:44:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D93BB1280663;
        Thu, 20 May 2021 17:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621557851;
        bh=eaTcIcyun0cLoLSEo/BhBfVrFq8gp6IA/NCfnMvpiG0=;
        h=From:To:Subject:Date:Message-Id:From;
        b=quCV6hpVDQZcTwXc3jUkqKbP89oeceF73j3aomLTWI+yAdldMCMWWyBQlxXQThRYk
         qQ9z226HZA7ZuILhwekAHCwGSiXXJqjs1HRgEkb1883p3BFemDOmSHrbOYWS000ibF
         nNzEKq3NAUzOlqeLPKFhk66vimchN2j7Vi05bQco=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7i3F7_iHEsd0; Thu, 20 May 2021 17:44:11 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5FEB61280613;
        Thu, 20 May 2021 17:44:11 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 0/4] Trusted Key policy for TPM 2.0
Date:   Thu, 20 May 2021 17:43:57 -0700
Message-Id: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

Now that the ASN.1 representation of trusted keys is upstream we can
add policy to the keys as a sequence of policy statements meaning the
kernel can now construct and use the policy session rather than the
user having to do it and pass the session down to the kernel.  This
makes TPM 2.0 keys with policy much easier.

The format of the policy statements is compatible with the
openssl_tpm2_engine policy implementation:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

And the seal_tpm2_data command in the above can be used to create
sealed keys (including with policy statements) for the kernel.

The current implementation only has a limited subset of the full TPM
2.0 policy commands, but it is enough to implement keys locked to PCR
values and expiring keys.  The main missing feature is support for the
TPM2_PolicyOR statement, which means all current policy has to be AND
chains (key doesn't unlock unless every policy statement succeeds).

I can't fix the checkpatch error in the first patch: the thing its
complaining about is a sha1 sum, just not a sha1 sum representing a
kernel commit.

James

---

James Bottomley (4):
  security: keys: trusted: add PCR policy to TPM2 keys
  security: keys: trusted: add ability to specify arbitrary policy
  security: keys: trusted: implement counter/timer policy
  security: keys: trusted: implement authorization policy

 .../security/keys/trusted-encrypted.rst       |  83 +++-
 include/keys/trusted-type.h                   |   5 +-
 include/linux/tpm.h                           |   6 +
 security/keys/Kconfig                         |   2 +
 security/keys/trusted-keys/Makefile           |   1 +
 security/keys/trusted-keys/tpm2-policy.c      | 466 ++++++++++++++++++
 security/keys/trusted-keys/tpm2-policy.h      |  31 ++
 security/keys/trusted-keys/tpm2key.asn1       |  13 +
 security/keys/trusted-keys/trusted_core.c     |   8 +-
 security/keys/trusted-keys/trusted_tpm1.c     |  15 +
 security/keys/trusted-keys/trusted_tpm2.c     | 124 ++++-
 11 files changed, 740 insertions(+), 14 deletions(-)
 create mode 100644 security/keys/trusted-keys/tpm2-policy.c
 create mode 100644 security/keys/trusted-keys/tpm2-policy.h

-- 
2.26.2

