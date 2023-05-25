Return-Path: <keyrings-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA12C77B7E
	for <keyrings@archiver.kernel.org>; Thu, 25 May 2023 08:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbjEYInf (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Thu, 25 May 2023 04:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbjEYIne (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Thu, 25 May 2023 04:43:34 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEE98;
        Thu, 25 May 2023 01:43:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjRZfMJ_1685004207;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VjRZfMJ_1685004207)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:43:28 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] sign-file: fix memory leak
Date:   Thu, 25 May 2023 16:43:24 +0800
Message-Id: <20230525084324.56718-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

The buffer allocated by asprintf() must be freeed.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 scripts/sign-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index b90fc9f7437f..94267cf72197 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -369,6 +369,7 @@ int main(int argc, char **argv)
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
+			free(sig_file_name);
 		}
 
 		if (sign_only) {
@@ -420,8 +421,10 @@ int main(int argc, char **argv)
 	ERR(BIO_free(bd) < 0, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
-	if (replace_orig)
+	if (replace_orig) {
 		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
+		free(dest_name);
+	}
 
 	return 0;
 }
-- 
2.24.3 (Apple Git-128)

