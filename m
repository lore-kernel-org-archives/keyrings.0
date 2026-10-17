Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36872377ABD
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222308; cv=none; b=RnQrr3IaZi8pYJFygnb9NYLlGZMqWBHAfINdLG01tcV8qM1RQVOW4o1OEqt7A2rS5+SWJJJjrlzHyPo+7bg+w/b3Vewy9mOiVCGrdDLzKgsnUPrRFErSOs+5hsaTevNRhXX3X/udgwUFfbo20naa+xGxAGcvVWnI13AJpkOhXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222308; c=relaxed/simple;
	bh=ByjrDEW+cLHIanPR1r9ZCilmfQtfffG3r6vZkp1Qvgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rG+KGwqCP0hSIDJNVbwLlxDt92LTVC4sWV7nRAV0EGfpWb/+IE3jeFd7RW5rkiuh3QE07elAUuXimbsSWzIxRXuQzGN/EmKoKbwjxynRd43IiL36k2nU+vLOXWBr5h5bLhBQdBEI6MbhnjiyPTcaFgMyyBPTPXKAYoM/wFbeH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1RSJXnZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1RSJXnZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89f0a21880aso297963b3a.0
        for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792222305; x=1792827105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hGJqskAm5ijlynAeAUmg/yteXxLufBW9O9YFEmU6Qk=;
        b=e1RSJXnZ24+lkTH1+xssf5wkeiBfq8/U7/Az45uAm+zHRUOCnti2GFO+tpQRpoARM8
         qS/aTL+U8kIr2G5waPe+nVn8M1J+P9ZNNpbpVRfR2WzQEMiDBCL+XSM7DLP/6ICgUVLC
         bxgt16biVtowpz63XgIVCHuMZGR8T8zPENSF9rU1YG8Von7HB9M+eZZKW868xFcKwRki
         XQlp48NaN6+5Mq3EV4kmPxMG6Cpv2B4JR1EjAx3967kjsnm88ZlddJeTXMngC1y5ZUyP
         fsa+8BSZ+VwB0mSXiR2iMVw9M0PUtq+C8X4YlaYvCncLcAjWK8rsiaqSP4ZMcGMqux6s
         eQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792222305; x=1792827105;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8hGJqskAm5ijlynAeAUmg/yteXxLufBW9O9YFEmU6Qk=;
        b=FI/X1r+ulBvftFNoeReJs8+0a07jjtwn2DEA5/uIi0il0hgfvKPYYA4mGGUiUF/jHJ
         dLS0tyMQwB2rQ44UEB5bDxb+f0b0oc4UVyDnG5hOxVe6eLoiGXIobG1vA8AjBijcFxuA
         Yp2JQCJmHjmwAH0XzORx6bB1f9YDjJuxlN27bHcihHaBDUD0IKyvvWpiBe1bylZhTsRB
         gFkGUb/QLzJ3rv5VnQV30AXF3xl6oC4swaTUtYQrYktBUoN3O1ye8asoSvkw8mfs3eQv
         PDJE8OxdyAEe4E5Fk40YMt/UOdp2I5dTT4oEAmpVIKZgevTwuhzH9mfse8HFHBcx2a8c
         R3ZA==
X-Gm-Message-State: AFq9FYKl2WtdU3/n0SX1dz6PZlNY+/+/8/sNQjjo/jtgilE/Mkr9uspZ
	vzCx7DK61MJOuwJuWZhWL9Q/qYKC/J4TqPiLYTIPap1Wu5YhoIbJb8Ss
X-Gm-Gg: AYBFou2Nty+EhtByeiqNrRyShG99jK7zx9g/meGbyTzRs4noDHQjYYt37HjHd2vPvFn
	YMAvebBMlDANSx3SJnFOJ8V85/KlkWnYfPNOmYYRRXvWMF+oYIdyDH9sgvZklpgONR+7Nconna7
	jHaLDKDgSpq1al378hG3/FleBWameZVzyhHGLD68mhVZlJIW6qwu3F0JmEWoNn6QrCuVlTpU8la
	DYQyomITpRGomW6B3cj8vyvybixgfkoBQAqAzqMLMXV1x95ZgA66EU8aGKX4M0c3g14evdNPOb8
	pbEZROPLL3K1rzBCn3h8hKnqFA7maBX1HR12Krt779YIbedYdOWQXRG+/so8uJ+x7cv6b/7YGzV
	p6keE9Y6r+HRJq6BBINQoyKHUJJmx8SgRBgipT9scPGk4dEKu0YFyzX+iEy90GurQjO5xND4Fj4
	m0VaxcOtzwradT4jkcay1INju37/MPrTuHl2SpmfTaeuzBuohxwVmIu4zJFuRQf7xEfA==
X-Received: by 2002:a05:6a00:4506:b0:89e:584:bb77 with SMTP id d2e1a72fcca58-8a04d350f4emr1539150b3a.58.1792222305449;
        Sat, 17 Oct 2026 00:31:45 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm2051607b3a.53.2026.10.17.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:31:45 -0700 (PDT)
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
Subject: [PATCH] keys: Protect the read method check against type removal
Date: Sat, 17 Oct 2026 15:30:56 +0800
Message-Id: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The key type must remain alive while its read method is checked.
keyctl_read_key() holds a reference to the key, but checks
key->type->read without holding key->sem. The reference keeps the key
alive, but does not pin the module containing its type.

With AF_RXRPC built as a module, a positive RxRPC key can pass
key_read_state() and the Read permission or possession checks while
another task unloads the module. Unload is possible once the module
refcount reaches zero, e.g. when no RxRPC socket remains open. The
reader can be delayed between loading key->type and reading its read
member, allowing this order:

  KEYCTL_READ task                  Module unload and key GC
  lookup_user_key()
  key_read_state()
  key_permission() / is_key_possessed()
  load key->type
                                    af_rxrpc_exit()
                                    unregister_key_type()
                                    key_gc_keytype() schedules the GC
                                      pass and waits for it
                                    GC takes key->sem for writing
                                    GC retypes key to key_type_dead
                                    GC releases key->sem
                                    unregister_key_type() returns
                                    free_module() frees type storage
  read saved type's read member

The last access reads freed module storage and can fault in
keyctl_read_key(). The later read invocation is already protected by
key->sem and key_validate() in __keyctl_read_key(), but neither covers
this earlier check.

Take key->sem for reading around the read-method check. The garbage
collector retypes the key under a write hold on key->sem, so it must
wait for the check to finish; key_gc_keytype() in turn waits for that
GC pass before unregister_key_type() returns, so the module text cannot
be freed until the check has completed. If retyping happens first, the
check sees key_type_dead, which has no read method. Release the
semaphore before returning -EOPNOTSUPP or proceeding to buffer
allocation, preserving the early unsupported-operation result and
keeping user copies outside the semaphore.

Oops report as below:

    BUG: unable to handle page fault for address: fffffbfff8048bc5
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    RIP: 0010:keyctl_read_key+0x1aa/0x600
    Call Trace:
     __do_sys_keyctl+0x2a7/0x4f0

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 5a5efa26ed0e..756368422b7c 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -863,10 +863,13 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	/* the key is probably readable - now try to read it */
 can_read_key:
-	if (!key->type->read) {
-		ret = -EOPNOTSUPP;
+	down_read(&key->sem);
+	ret = -EOPNOTSUPP;
+	if (key->type->read)
+		ret = 0;
+	up_read(&key->sem);
+	if (ret)
 		goto key_put_out;
-	}
 
 	if (!buffer || !buflen) {
 		/* Get the key length from the read method */
