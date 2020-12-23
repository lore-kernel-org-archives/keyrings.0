Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E28EC433E0
	for <keyrings@archiver.kernel.org>; Wed, 23 Dec 2020 02:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD90224D2
	for <keyrings@archiver.kernel.org>; Wed, 23 Dec 2020 02:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgLWCje (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgLWCXt (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Tue, 22 Dec 2020 21:23:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8201622202;
        Wed, 23 Dec 2020 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690213;
        bh=mCL/6JX8PjkAtZ/N2abdTYj3YjbBv9fu3lg3hFY6z3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvdZjY5Xp8bG923LQXrYCFdAxRGmZ7DFH+35CXhjQZQJBIHESMzkB3WDrInhRWncp
         Cne3JfYaPbQTu+CMtHPo3GuVyT7HRZxGbfj4ENBxut0Q80hjZXvNMrk2SdKxw4WuNP
         hI7rOP9Zfc25V8opQTi431f6BPdFB1P2HcDBw3AOtCwGc5z0/ro6ZcY/OgeteFp8My
         AQLebre9s3PBc5CmIajl1e1LzlZGxsVjZ8DDAhsdGcYtvF5syWPgzBLNPh8gbEfvsR
         SGWOzfy3gu1K3lLlK1xjZGw8dSIwBYnXdVE8Tc4CwpIYIw8uZWd4dADKhqUT1i5MZ4
         KaJVTV41ASGhw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 32/66] rxrpc: Don't leak the service-side session key to userspace
Date:   Tue, 22 Dec 2020 21:22:18 -0500
Message-Id: <20201223022253.2793452-32-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022253.2793452-1-sashal@kernel.org>
References: <20201223022253.2793452-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <keyrings.vger.kernel.org>
X-Mailing-List: keyrings@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit d2ae4e918218f543214fbd906db68a6c580efbbb ]

Don't let someone reading a service-side rxrpc-type key get access to the
session key that was exchanged with the client.  The server application
will, at some point, need to be able to read the information in the ticket,
but this probably shouldn't include the key material.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/keys/rxrpc-type.h | 1 +
 net/rxrpc/key.c           | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/keys/rxrpc-type.h b/include/keys/rxrpc-type.h
index 8cf829dbf20ec..1cb996dac3238 100644
--- a/include/keys/rxrpc-type.h
+++ b/include/keys/rxrpc-type.h
@@ -88,6 +88,7 @@ struct rxk5_key {
  */
 struct rxrpc_key_token {
 	u16	security_index;		/* RxRPC header security index */
+	bool	no_leak_key;		/* Don't copy the key to userspace */
 	struct rxrpc_key_token *next;	/* the next token in the list */
 	union {
 		struct rxkad_key *kad;
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 2fe2add62a8ed..dd8a12847b712 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -1077,7 +1077,8 @@ static long rxrpc_read(const struct key *key,
 		case RXRPC_SECURITY_RXKAD:
 			toksize += 8 * 4;	/* viceid, kvno, key*2, begin,
 						 * end, primary, tktlen */
-			toksize += RND(token->kad->ticket_len);
+			if (!token->no_leak_key)
+				toksize += RND(token->kad->ticket_len);
 			break;
 
 		case RXRPC_SECURITY_RXK5:
@@ -1181,7 +1182,10 @@ static long rxrpc_read(const struct key *key,
 			ENCODE(token->kad->start);
 			ENCODE(token->kad->expiry);
 			ENCODE(token->kad->primary_flag);
-			ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
+			if (token->no_leak_key)
+				ENCODE(0);
+			else
+				ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
 			break;
 
 		case RXRPC_SECURITY_RXK5:
-- 
2.27.0

