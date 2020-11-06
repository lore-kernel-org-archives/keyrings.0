Return-Path: <SRS0=SIXh=EM=vger.kernel.org=keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28FC2D0A3
	for <keyrings@archiver.kernel.org>; Fri,  6 Nov 2020 14:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873022078B
	for <keyrings@archiver.kernel.org>; Fri,  6 Nov 2020 14:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFOi5 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:38:57 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:58309 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgKFOi5 (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Fri, 6 Nov 2020 09:38:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UERVqRn_1604673515;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UERVqRn_1604673515)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 22:38:36 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] certs/blacklist: fix kernel doc interface issue
Date:   Fri,  6 Nov 2020 22:38:33 +0800
Message-Id: <1604673513-29088-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

certs/blacklist.c:84: warning: Function parameter or member 'hash' not
described in 'mark_hash_blacklisted'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: David Howells <dhowells@redhat.com> 
Cc: David Woodhouse <dwmw2@infradead.org> 
Cc: keyrings@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 certs/blacklist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6514f9ebc943..02f1016ce6e8 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -78,7 +78,7 @@ static void blacklist_describe(const struct key *key, struct seq_file *m)
 
 /**
  * mark_hash_blacklisted - Add a hash to the system blacklist
- * @hash - The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
+ * @hash: - The hash as a hex string with a type prefix (eg. "tbs:23aa429783")
  */
 int mark_hash_blacklisted(const char *hash)
 {
-- 
1.8.3.1

