Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32ADC56202
	for <keyrings@archiver.kernel.org>; Tue, 24 Nov 2020 20:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A61220708
	for <keyrings@archiver.kernel.org>; Tue, 24 Nov 2020 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgKXU2O (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:28:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgKXU2O (ORCPT
        <rfc822;keyrings@vger.kernel.org>); Tue, 24 Nov 2020 15:28:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 62DF81F45356
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com, jarkko@kernel.org
Cc:     keyrings@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2] watch_queue: Drop references to /dev/watch_queue
Date:   Tue, 24 Nov 2020 15:28:02 -0500
Message-Id: <20201124202802.645739-1-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

The merged API doesn't use a watch_queue device, but instead relies on
pipes, so let the documentation reflect that.

Fixes: f7e47677e39a ("watch_queue: Add a key/keyring notification facility")
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Add Fixes tag (Jarkko Sakkinen)
---
 Documentation/security/keys/core.rst | 4 ++--
 samples/Kconfig                      | 2 +-
 samples/watch_queue/watch_test.c     | 2 +-
 security/keys/Kconfig                | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index aa0081685ee1..b3ed5c581034 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1040,8 +1040,8 @@ The keyctl syscall functions are:
 
      "key" is the ID of the key to be watched.
 
-     "queue_fd" is a file descriptor referring to an open "/dev/watch_queue"
-     which manages the buffer into which notifications will be delivered.
+     "queue_fd" is a file descriptor referring to an open pipe which
+     manages the buffer into which notifications will be delivered.
 
      "filter" is either NULL to remove a watch or a filter specification to
      indicate what events are required from the key.
diff --git a/samples/Kconfig b/samples/Kconfig
index 0ed6e4d71d87..e76cdfc50e25 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -210,7 +210,7 @@ config SAMPLE_WATCHDOG
 	depends on CC_CAN_LINK
 
 config SAMPLE_WATCH_QUEUE
-	bool "Build example /dev/watch_queue notification consumer"
+	bool "Build example watch_queue notification API consumer"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build example userspace program to use the new mount_notify(),
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 46e618a897fe..8c6cb57d5cfc 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Use /dev/watch_queue to watch for notifications.
+/* Use watch_queue API to watch for notifications.
  *
  * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 83bc23409164..c161642a8484 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -119,7 +119,7 @@ config KEY_NOTIFICATIONS
 	bool "Provide key/keyring change notifications"
 	depends on KEYS && WATCH_QUEUE
 	help
-	  This option provides support for getting change notifications on keys
-	  and keyrings on which the caller has View permission.  This makes use
-	  of the /dev/watch_queue misc device to handle the notification
-	  buffer and provides KEYCTL_WATCH_KEY to enable/disable watches.
+	  This option provides support for getting change notifications
+	  on keys and keyrings on which the caller has View permission.
+	  This makes use of pipes to handle the notification buffer and
+	  provides KEYCTL_WATCH_KEY to enable/disable watches.
-- 
2.29.2

