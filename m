Return-Path: <keyrings-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE52C4361A
	for <keyrings@archiver.kernel.org>; Wed, 23 Dec 2020 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D25223E4
	for <keyrings@archiver.kernel.org>; Wed, 23 Dec 2020 02:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgLWCZA (ORCPT <rfc822;keyrings@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730351AbgLWCZA (ORCPT <rfc822;keyrings@vger.kernel.org>);
        Tue, 22 Dec 2020 21:25:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0134C22248;
        Wed, 23 Dec 2020 02:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690284;
        bh=dFcys3ZL5MvO2jIt6slZwoRGePr4D8Y6S3Ao4OJr5K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+4cbDXZA+c2Ic3pJwKGfDachglIZ4iK4/pAoTXkXGxdUtc5QsbymCEFhW7PAEsnB
         XCTzX5gSeE6bGx5khPDQGXwK3dqQyfICF9+ilt+0MGpzbsEd1vGSfSJYxOzZEYsnZs
         6DKkJPPxO4H7ITdV4Y/2gJplT+iBzSfPVb9UGb2JjCRZ6Q+sKMtouKjHBj9DBqwPQe
         mmQSPeZplkeXnB3wnGX46dvRFW9TdoZZFLj32X8Pn2aY+6ZJdJerr8qBRXKOasJD50
         F9WLKNabxTXT7+T8122kWgSWvbdzZ+3zqGbbzggYKXrakyW4ms6lhIosB/RiWB2B/n
         COIiSdlTq0Fbw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 23/48] rxrpc: Don't leak the service-side session key to userspace
Date:   Tue, 22 Dec 2020 21:23:51 -0500
Message-Id: <20201223022417.2794032-23-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022417.2794032-1-sashal@kernel.org>
References: <20201223022417.2794032-1-sashal@kernel.org>
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
index 5de0673f333b7..865629c5484f5 100644
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
index fa475b02bdceb..beb30cca5a4b9 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -1071,7 +1071,8 @@ static long rxrpc_read(const struct key *key,
 		case RXRPC_SECURITY_RXKAD:
 			toksize += 8 * 4;	/* viceid, kvno, key*2, begin,
 						 * end, primary, tktlen */
-			toksize += RND(token->kad->ticket_len);
+			if (!token->no_leak_key)
+				toksize += RND(token->kad->ticket_len);
 			break;
 
 		case RXRPC_SECURITY_RXK5:
@@ -1180,7 +1181,10 @@ static long rxrpc_read(const struct key *key,
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

