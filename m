Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFD4C433EF
	for <keyrings@archiver.kernel.org>; Mon, 27 Jun 2022 09:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiF0JVO (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Mon, 27 Jun 2022 05:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiF0JVN (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Mon, 27 Jun 2022 05:21:13 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A7363C4;
        Mon, 27 Jun 2022 02:21:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHWTzRW_1656321668;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VHWTzRW_1656321668)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 17:21:09 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 RESEND] sign-file: Fix confusing error messages
Date:   Mon, 27 Jun 2022 17:21:07 +0800
Message-Id: <20220627092107.20994-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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
index 7434e9ea926e..598ef5465f82 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -114,7 +114,7 @@ static void drain_openssl_errors(void)
 		bool __cond = (cond);			\
 		display_openssl_errors(__LINE__);	\
 		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
+			errx(1, fmt, ## __VA_ARGS__);	\
 		}					\
 	} while(0)
 
-- 
2.24.3 (Apple Git-128)

