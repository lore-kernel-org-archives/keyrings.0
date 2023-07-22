Return-Path: <keyrings-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E054AEB64DD
	for <keyrings@archiver.kernel.org>; Sat, 22 Jul 2023 03:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGVDJ1 (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Fri, 21 Jul 2023 23:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVDJ0 (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Fri, 21 Jul 2023 23:09:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FF3A9C;
        Fri, 21 Jul 2023 20:09:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R7BFt3Stkz18LhY;
        Sat, 22 Jul 2023 11:08:34 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 11:09:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dhowells@redhat.com>, <jarkko@kernel.org>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] keys: Remove unused extern declaration iterate_over_keyring()
Date:   Sat, 22 Jul 2023 11:08:32 +0800
Message-ID: <20230722030832.33680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
this is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/keys/internal.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3c1e7122076b..95a82eec1816 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -112,10 +112,6 @@ extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
 extern struct key *keyring_search_instkey(struct key *keyring,
 					  key_serial_t target_id);
 
-extern int iterate_over_keyring(const struct key *keyring,
-				int (*func)(const struct key *key, void *data),
-				void *data);
-
 struct keyring_search_context {
 	struct keyring_index_key index_key;
 	const struct cred	*cred;
-- 
2.34.1

