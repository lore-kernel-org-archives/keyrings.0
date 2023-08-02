Return-Path: <keyrings-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C8EB64DD
	for <keyrings@archiver.kernel.org>; Wed,  2 Aug 2023 02:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjHBCQP (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Tue, 1 Aug 2023 22:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjHBCQO (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Tue, 1 Aug 2023 22:16:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49C1B1
        for <keyrings@vger.kernel.org>; Tue,  1 Aug 2023 19:16:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFwVV5SdQztRZH;
        Wed,  2 Aug 2023 10:12:50 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 10:16:12 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <dhowells@redhat.com>, <jarkko@kernel.org>
CC:     <keyrings@vger.kernel.org>
Subject: [PATCH] key: Make key_sysctls static
Date:   Wed, 2 Aug 2023 10:15:42 +0800
Message-ID: <20230802021542.13473-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

key_sysctls is not used outside the file. Make it static

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/keys/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b72b82bb20c6..b348e1679d5d 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -9,7 +9,7 @@
 #include <linux/sysctl.h>
 #include "internal.h"
 
-struct ctl_table key_sysctls[] = {
+static struct ctl_table key_sysctls[] = {
 	{
 		.procname = "maxkeys",
 		.data = &key_quota_maxkeys,
-- 
2.17.1

