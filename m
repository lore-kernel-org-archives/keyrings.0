Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C73BA24F
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522673; cv=none; b=ApWjhPw4YDZZpShWWhe6APj7OTc+GsMyUME0tAPxHrbLlgBGxipywkE1DHCJ52aH/FuVVTQUwonzI525snY/g+KlMA617cW3Tvrs02Mu9uvpiR6DxqKLa6NR4rUA/TFn0jOf8TPFPLgrbBDg2SY27Zl0uvFgRwSpoMYlm+78fTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522673; c=relaxed/simple;
	bh=fIG6kNVbSBDcIDJq3p3pVkq328vRxzchYU1SH8Kzvhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MhvQCqSb5o3/QTWWRiCZkfGOaa0ri8KI/Oaou1DFs7Z5M+9Wr9JeiUWZzHRv/1U76xO2ngk3AV4Wxm5Zxj8YANOdGhYg8vxT64ALoXp996ry/VCveRM+QqLw9BneDKhXCvOVLqtr3Nn0EOHz0FYiUL293ZAOfOExsOOznY4phEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rthjuziN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rthjuziN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2066812a12.0
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 22:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522671; x=1792127471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE3/kQE3CWaeZ8e1J8lpY+d3lLDFtCRTYFUR1YExG5s=;
        b=rthjuziNL9aQraViHXIBDfRDuuhmkSGKHCDOWWqBy3zIDTVNFKO0DX5orM7oystYm4
         oTdAmuiZtZG6QTOt+9UVMx5lwI/dM9qMF8l+HBCP0n7WGrXr76wlGPiOM4V1RUsVoNyD
         GPKnlgqool1h9J3015snqngIBzK0nXoVeNoNP8+cruMee54v//GqUcDdatv/GZquTFNM
         C1M0+xn8yr6xihflBlhbszh/4nyWgScvOd1wXSnNXjs9iI0tcwTcI+2mo7SLt4Zt2QjZ
         oM8QBoPItFuQNocyM+VFZPhNXn4vnB1/0zMKvB/ArmO9TO4H7PATCZFAdJ+I65lPoBJI
         ciCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522671; x=1792127471;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lE3/kQE3CWaeZ8e1J8lpY+d3lLDFtCRTYFUR1YExG5s=;
        b=M6/yF+CMlugZ6UFkUWklEo8fAr/+B2Sjf5fGPt+sCJx2AEA0SzYD9jGS9b4mA6hmhN
         D1+GhL2rkJsmXhlnFrY3Qse2jAZkbdXqLS5cS5fLkZN6wAazolh5tZQyp9SbFtwQpqSu
         uyzx1ks+jJH1aA4m9o6QGM61yE5JqSAxyuTBSKjb2r+vwmnVjDukRyZgDmDN5LC64sUr
         KGNYxLTYR5kLwEnmwhYZ4Gngtj4pV2+o6Jm+ESLtGMCeq02GA36ZoZtg/rEIys6hAY0Q
         nPAs2fBK+zJ/2Eblk5Ul4zBSsZoiCTHcAWT+758xRxQcEMT5xki1ULxfEKrIR8demM2q
         +gtA==
X-Gm-Message-State: AFq9FYIGd/4HvQr5w1mJvFd4jvNxDGK5RZwSsw//aSy3LpT3jUJsUS1a
	XprHYcR1fb5Oo1xusYSEO7VY1Kmp7eNL2BbgHcqpOMgnrAeSG+YopuGb
X-Gm-Gg: AYBFou2PCqx9TVtmX9l5QdW9oumOxlAblJ3VbINAu7R3jmsLPowj3PLvxIZ68KAqqvj
	e5sC6sR5sZq9FDGLe9XjS/98hw+1nWBn+aQaHsoE3dfgbofv3KhdIOiU0pbTUQlmfPCmueEXNG3
	S2fjWb3VWOlCD6WStvmVqw2+v7usMF8EfvunuJ5qgSXnUkd3wIKhTMoGdVv+dLe/Ydk5AyQ+Jqk
	MZ/8jVCuDP2Uj+twZ/Fjl5/Ue2fNH6dmGfV+dZUq8fbGdITHb/g0Zn8yCqmvsSlgFt4x5wqL9mN
	/8Idg67EFbsDh2ZY0i8VVgNetKAMZ5LWH3mr9iaFBw175iFfpoj0vUoi8N5ZiIuAqZJkCEv527t
	T90Uga89N5gEFmQl5i7ngvuSuICXGHyRZEk8FTXFhPHCtiyujywqTLGhg5qHyWKbJYYKK7ZOwYT
	/HBHAQvBgQf/laWuCeDw4/FTtND0X/r3G7sIDM83r9HT/K7/soSHKnsdZKorUN4Znnew==
X-Received: by 2002:a17:90b:1e41:b0:3ab:de4:7fa5 with SMTP id 98e67ed59e1d1-3ab3a9726admr840824a91.56.1791522671042;
        Thu, 08 Oct 2026 22:11:11 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f73e7fsm1925492a91.0.2026.10.08.22.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:11:10 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] keys: Protect the type name while describing a key
Date: Fri,  9 Oct 2026 13:11:03 +0800
Message-Id: <pm-key-management-objects-candidate-0009-v4-6b537c5732fd957c33fa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

keyctl_describe_key() must keep the key type's name alive until
kasprintf() has consumed it. The retained key reference keeps the key
and its description alive, but does not pin the module providing its
type. The name is passed to kasprintf() without holding key->sem.

kvasprintf() uses the saved name pointer in two formatting passes, with
a GFP_KERNEL allocation between them. With AF_RXRPC=m, a task that
passes View permission before type retirement can overlap a privileged
module unload in this order:

1. KEYCTL_DESCRIBE looks up the key, saves key->type->name in the
   kasprintf() arguments and completes the first formatting pass.
2. While the formatter is delayed before its second pass,
   af_rxrpc_exit() calls unregister_key_type(), which removes the type
   from the registry and waits for key_gc_keytype().
3. The collector takes key->sem for writing, retypes the retained key
   to key_type_dead and completes retirement. Unregistration and module
   exit return, allowing free_module() to release the type and name.
4. The formatter resumes its second pass and reads the saved name from
   released module storage, which can fault in string().

Hold key->sem for reading across kasprintf(). The collector then cannot
retype the key or complete retirement until both formatting passes have
finished. If retirement wins the lock first, formatting uses the core
key_type_dead name instead. Release the semaphore immediately after
kasprintf(), including on allocation failure, before copying to
userspace.

Oops report as below:

    BUG: unable to handle page fault for address: fffffbfff8054794
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    RIP: 0010:string+0x23f/0x470
    Call Trace:
     vsnprintf+0x330/0x1110

Fixes: aa9d4437893f ("KEYS: Fix the size of the key description passed to/from userspace")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Trim the Oops report to the fault location and vsnprintf frame.

Link to v1: https://lore.kernel.org/r/pm-key-management-objects-candidate-0009-v3-43bbf21d1c452f23d829@gmail.com

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d14ace88e529cb77de5386f1f3a99905d4b7688c..5a5efa26ed0ece3a5ab22e37ad7bda7a5a744b83 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
 
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
+	down_read(&key->sem);
 	infobuf = kasprintf(GFP_KERNEL,
 			    "%s;%d;%d;%08x;",
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
+	up_read(&key->sem);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
