Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748403;
	b=nxNSFhO2n+fXM7DUG+kRbhngvCaHOji4Tua4UlIzc7DFlhPEWQO/ZJmbUpluST3GNDOH
	 PPJxj3CwXKhpPEpjv9sxY3bnYWhgWSZLLUCjBZbBnwO8aiu5ckTsmR2sxEdCSKjNj5daA
	 mxLqTfxy+CiznqNIRsSAputj/vieDoW+dGY2gjIsrQ+GA5SJRzPYgAZOe+uR+gwhiPUIm
	 Am8zXHme++GXPlWLx8GRmlya80LTYHhdRVx200r1xZmZBj68Cf3aCcr0OG33cRutRUw7M
	 CZqKk+KDS4xOszidBhLscWTr0Dh+sQKFVWVC3I4eQcnssbcCcfqM3PKaVKTA7sTW87g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748403;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=BS+yhTYj4vK3YDb5NCzbtC6qzi+fzRiTH0kBAne+IUA=;
	b=wCu8ZB7bBNBqmsm27LabghBc5tr89YEzy3dtMRspxQBHH5bMh9hob3JW8WePuQgony4/
	 psCN4NYa3H6g5oW3sMcCCmIRAgkqJ8J2bLwWKiSKzfaL2eq1wBYLUxdFPUtkHJplu2wEu
	 jvbHpLpkZcK7icIFxx2FDUyZRLw+ggonnZIm5M8wn35xXV6sdJEAdXJvRqeYjtl9wAiUq
	 Pv6PU5Vwx8ZIQE5XOIdPBkYXRgbhY1aYy69y6w5efT9urQS7TZrLX9lPT76SIHxBYxJIW
	 GXna6EwBvKV7q3RH2s384Uf2rnaT5LQYeLYhYCucze82cF1IOcbNxibGQsdhqvoC3ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KuVacIf9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6E606A32D
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 03:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE6E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KuVacIf9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BS+yhTYj4vK3YDb5NCzbtC6qzi+fzRiTH0kBAne+IUA=;
	b=KuVacIf9HMLyIssOrZI5Dr4ZbFOpCyI7RpsmBubMPUta8k67y07GGbKcSSBU1iJNF5wGMy
	un1WSYI3VVHhu0+y7Nu3UmvxKL2rWya3f9zNkbcN3JH6zLQI8YhrBZ0TNRtzUg6kMHYmab
	DUfGuCTXyw62lykD0tua9hVZDwdhk1A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-U_Vk9U-PONG2pOyhlaijlQ-1; Fri,
 27 Nov 2026 02:59:58 +0000
X-MC-Unique: U_Vk9U-PONG2pOyhlaijlQ-1
X-Mimecast-MFC-AGG-ID: U_Vk9U-PONG2pOyhlaijlQ_1795748397
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD0E9180054A;
	Fri, 27 Nov 2026 02:59:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C3C31956056;
	Fri, 27 Nov 2026 02:59:56 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 7/8] ima: define the ima-modsigv2 template
Date: Thu, 26 Nov 2026 23:59:10 -0300
Message-ID: <20261127025912.1383750-8-bmeneg@redhat.com>
In-Reply-To: <20261127025912.1383750-1-bmeneg@redhat.com>
References: <20261127025912.1383750-1-bmeneg@redhat.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the "ima-modsigv2" template with the following format:

	d-ngv2|n-ng|sig|d-modsig-list|modsig

the counterpart of ima-modsig with support for multiple appended signatures
that records the content digest for every signer instead of just one. The
existing ima-modsig template and its 'd-modsig' field are left unchanged.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 Documentation/security/IMA-templates.rst | 1 +
 security/integrity/ima/ima_template.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 161aed3da8b7..38d6d27344e2 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -99,6 +99,7 @@ Below, there is the list of defined template descriptors:
  - "ima-sigv2": its format is ``d-ngv2|n-ng|sig``;
  - "ima-buf": its format is ``d-ng|n-ng|buf``;
  - "ima-modsig": its format is ``d-ng|n-ng|sig|d-modsig|modsig``;
+ - "ima-modsigv2": its format is ``d-ngv2|n-ng|sig|d-modsig-list|modsig``;
  - "evm-sig": its format is ``d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode``;
 
 
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 584f970e553e..721af4b1828b 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -24,6 +24,8 @@ static struct ima_template_desc builtin_templates[] = {
 	{.name = "ima-sigv2", .fmt = "d-ngv2|n-ng|sig"},
 	{.name = "ima-buf", .fmt = "d-ng|n-ng|buf"},
 	{.name = "ima-modsig", .fmt = "d-ng|n-ng|sig|d-modsig|modsig"},
+	{.name = "ima-modsigv2",
+	 .fmt = "d-ngv2|n-ng|sig|d-modsig-list|modsig"},
 	{.name = "evm-sig",
 	 .fmt = "d-ng|n-ng|evmsig|xattrnames|xattrlengths|xattrvalues|iuid|igid|imode"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
-- 
2.55.0

