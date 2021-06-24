Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB16C48BDF
	for <keyrings@archiver.kernel.org>; Thu, 24 Jun 2021 10:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CD1613FF
	for <keyrings@archiver.kernel.org>; Thu, 24 Jun 2021 10:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhFXKur (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:50:47 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49678 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232127AbhFXKur (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Thu, 24 Jun 2021 06:50:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UdWJwFH_1624531704;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UdWJwFH_1624531704)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jun 2021 18:48:25 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        James Morris <jmorris@namei.org>,
        James Morris <jamorris@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2] sign-file: Fix confusing error messages
Date:   Thu, 24 Jun 2021 18:48:24 +0800
Message-Id: <20210624104824.82616-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

When an error occurs, use errx() instead of err() to display the
error message, because openssl has its own error record. When an
error occurs, errno will not be changed, while err() displays the
errno error message. It will cause confusion. For example, when
CMS_add1_signer() fails, the following message will appear:

  sign-file: CMS_add1_signer: Success

errx() ignores errno and does not cause such issue.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index fbd34b8e8f57..37d8760cb0d1 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -107,7 +107,7 @@ static void drain_openssl_errors(void)
 		bool __cond = (cond);			\
 		display_openssl_errors(__LINE__);	\
 		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
+			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
 	} while(0)
 
-- 
2.19.1.3.ge56e4f7

