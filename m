Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E714352000
	for <keyrings@vger.kernel.org>; Fri, 29 May 2026 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025670; cv=none; b=HeIyuYhODafmsVTfLJqPs77BV84tdID5Vov48ugZ3F7BsWz6ppyhUS1j8gacR5dT7RBiMG3RHcFA+RRZLecd9dunvTGcw7bIUFjFhL9Zzl9qwi4lqvFdlh5AQXpGGHlSa2lf1A+Jgix8ScP7DIFylVpwqZc6bNrgGeR/OcYZps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025670; c=relaxed/simple;
	bh=/X9Gx9nrlqqYvQNamVBrEU//0++TS8PHZQfk3nvxaZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8vJaolQyD/LjaeqaVvHeaUquoATmyPU8M6qmxtQrr9MxY6YcSy8x7qRH97++ewB95d/k4nQ5JxkdAd49f6+FSKxtFwzFP/pybkRcu8mqNjRmcTS5X6frFxOBQkVmMnkGW1wtYd/hEk7cXcUWziwEhSpE9hz9SOp0lt+U6ghljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khzVJKIy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khzVJKIy"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8571a0d6c0so196514a12.0
        for <keyrings@vger.kernel.org>; Thu, 28 May 2026 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780025669; x=1780630469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sgklvG/C53PAwo2/sITXhbGcqoDKxJ+Vu3aUEy7pgU=;
        b=khzVJKIyzoldyqXjx0vtdgTgVinGQXl+ICHzf/maHvnabr/BCEJRjSMdvIW0FboD6L
         PysVk3ByfyB5OK8viJ4yUvE+jeN8b5aWR5GBV1d/FbU0bL9NvC0+HVeMr4YYY04KwKOw
         UXpKvGNDavxIRffcKjR1unIrKcB632gFyRcXGnRuM0PlzFR31wsJ9pdXt7o1cit7/4Q8
         eCJZp1okJdc925AdpEWGNcuoo1aAS+voGAhPNqwtjzEmtzzEOXVhH7EQFFgFcHj961rG
         UPkqPbbTxswj5GKFmchNN1qPUGR1dxuj9G3COzQZBFJoXoEnypNd4F0fqVttlAw5ufu6
         E61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780025669; x=1780630469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sgklvG/C53PAwo2/sITXhbGcqoDKxJ+Vu3aUEy7pgU=;
        b=Pay102YxZOIhtPBdD62JypNncMjmacBJuF0Sd2OaKKgOrFHJZ4UniGIf7qvGTCxBKt
         k42jwFh59H/s0qYWTG9FaMiGyihIrZwAMd6MgQYRdsc9VrHW9HiMsxIOAt9caqCQwv52
         8OvEtki2CC/lI3WDU34ZRVxpdc9RbmPHtAgpVy58f6bDdtMtEq4NhJ4XYEv4jHmlGrCd
         TfQ4eC9PJ6sObkgd0BzId8XNkp4qh/hbcwjUUGViJuEHW1QP9JtlBhtTsK55HiZd5tJX
         MnWyqSQovbzpfl5PtdYwoV2F8ihRwjBJCELukcpc7fYrPkyma1itumY0axfEpMXro172
         jMTg==
X-Gm-Message-State: AOJu0YzIbKZ1mttwfgEQxEb5Z1RIzJxSljMRs3rnDtk7XoLnMCugJfAM
	Snxl6x9tdIOK8HTl81rY9lSXyds4m9k7/TM5cpd3ltPppvpsIRJFMy19ACLW8DJc
X-Gm-Gg: Acq92OEXnlZWSOSfiGw+EIqR6DMDno41djr9haktNI5uvGIrqCN8GmZgbLc8rktew3d
	dvhTd0wUwg2xV2FJck3cN3pMdrvODt3Yw/Ib90IbKcLGUxD0svyBI3MyXMzSqV1mNbPviL8wils
	/p5W6lB++G68L/SNLCw9UQiBiJZAAZQUNtjTxKRS0VNYYflwmzpD2tHiJb2aNECPsjrQAvrHZML
	wM1c3OR7FtLarGVCKste3tpdsTqWlrL10H6ahm8S7bzAeaiYY7ELTR5Es2MOv6F0+ddcOnP+62z
	i2kb2eAIERIZRU5whz49mLBKe8WNSxwEu9ZtsC+/0sm9jgc5exhldJ8Lgs/Z5rpfXAmsD8hsSaW
	QYUTLR8Ki54AaeBM3PQcG/Ig4W1vMxPtvcTvOscHHheOQCiepKvTALLg22oA/+U6W+g0vARCnl2
	qfUy914sqR48Wk7v1QjoVfGI6c4wNEx7YbA4JDqhecPc7WXMJVQjMMWl8laYDtMsMhNKHzjLAKt
	V9buczSTPdjrBvXlElmkTn+Il/nNOPZx06GbsA++DmdmqZfOglHedAbJFSCYccMYMOy/AsAKaEO
X-Received: by 2002:a05:6a21:1519:b0:3a2:d79c:4149 with SMTP id adf61e73a8af0-3b412314c2fmr1086635637.28.1780025668501;
        Thu, 28 May 2026 20:34:28 -0700 (PDT)
Received: from bass-virtual-machine.. ([163.61.198.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7c04sm306821a12.1.2026.05.28.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:34:28 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: keyrings@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org
Cc: ebiggers@google.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] KEYS: Use acquire when reading state in keyring search
Date: Fri, 29 May 2026 11:34:06 +0800
Message-Id: <20260529033406.20673-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The negative-key race fix added release/acquire ordering for key use.

Publish payload before state; read state before payload.

keyring_search_iterator() still uses READ_ONCE() before match callbacks.
An asymmetric match callback calls asymmetric_key_ids(), which reads
key->payload.data[asym_key_ids].

Use key_read_state() there to complete that ordering.

Fixes: 363b02dab09b ("KEYS: Fix race between updating and finding a negative key")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing READ_ONCE() used for synchronization.
A similar fix can be found in 8df672bfe3ec.
---
 security/keys/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index b39038f7dd31..243fb1636f10 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -576,7 +576,7 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 	struct keyring_search_context *ctx = iterator_data;
 	const struct key *key = keyring_ptr_to_key(object);
 	unsigned long kflags = READ_ONCE(key->flags);
-	short state = READ_ONCE(key->state);
+	short state = key_read_state(key);
 
 	kenter("{%d}", key->serial);
 
-- 
2.34.1

