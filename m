Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F60C04FF3
	for <keyrings@archiver.kernel.org>; Mon, 24 May 2021 10:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72873610C8
	for <keyrings@archiver.kernel.org>; Mon, 24 May 2021 10:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhEXKU6 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Mon, 24 May 2021 06:20:58 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36631 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232511AbhEXKU4 (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Mon, 24 May 2021 06:20:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UZvJBtZ_1621851566;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UZvJBtZ_1621851566)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 18:19:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dhowells@redhat.com
Cc:     dwmw2@infradead.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] certs: Fix kernel-doc
Date:   Mon, 24 May 2021 18:19:23 +0800
Message-Id: <1621851563-30425-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

Fix function name in system_keyring.c kernel-doc comment
to remove a warning.

certs/system_keyring.c:41: warning: expecting prototype for
restrict_link_to_builtin_trusted(). Prototype was for
restrict_link_by_builtin_trusted() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 'commit d3bfe84129f6 ("certs: Add a secondary system keyring that
can be added to dynamically")'
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 certs/system_keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365d..06c0c3d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -31,7 +31,7 @@
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by built in CA
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
-- 
1.8.3.1

