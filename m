Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3E43E48B
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493440; cv=pass; b=gHXsttWKGnugKq+XBsHkU8aTG1dpCK6uinjw5l27nNq+RHFOhmegAp0QQ231qxys4SC2rhFnzQLT63Vw5JwXX4qNpUSuR1bE2mWRNIExXtRv37D/h1RGWC9wx5dZQqxILDy4cdMz7FO51lC/xdALC6rz1IgBjI33PT285h1G4ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493440; c=relaxed/simple;
	bh=ZG5duU1P8U10Jt/vUPRIROkdZRUqr8jWeoOZPPmEDUQ=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=GrgCTNVOEjZ8uByD6f8t+VPmdYg+vi/VKA+8rzHaffq6dESpKm6vy4Nu4gvU57bNLkxUcSDANciG8D+c1f4DExiRbcUCJPUAlh6ktvck6URz+H2vm5cgf4hkEP8lwgZGSDtiWuD8MWIXbV+PLdBsbTA3Rd0CuEluq1RPMbso2Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy44AQsN; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy44AQsN"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8253bc5a613so4144335a34.0
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 14:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791493433; cv=none;
        d=google.com; s=arc-20260327;
        b=bW+dxsf/J02oNlxcGuyhICIJf7nCgO3UYa+jVReELVEHYynyZFHeTZppdampyyfduW
         PGRIVrb1Wv63XbIW0Rm2F4JsieD52gDzhfNYnjVww7TIf2mFakPe8ZopXYJrxVO3VTKJ
         LGA3UBB6odexhnLtpm/LKsWAsKey8o/F2jGkUnM+Cn4c0sBZOI3zTurYOJPLESonihQc
         zrsqFOkr6Zkuu3dAq488M5vFQmN2bjweKPZggn7mob+b72vS+RVbrDEmYirxIaU9HOe1
         oacgF/O+O1ga5uE8xZ0uwZeO8p/Nteq7gi7/7cnP4qYd0RBNalAZfWtKmIHeV3cAeTpl
         PVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=QIJAQjP+AkGIzt9PFWNtuaamgSjcZwMMzJzbJCTJsv4=;
        fh=c5XDIN3DuibLQY/ANT9mKKJq92UbeDeIB/WmlVRRHgk=;
        b=TMIK1WEUSGStX2kN5kS+1OcWTMMG4zHbbWwhtPC3XTP8+9GRjE39cdDiMF2fkNF6aS
         rFijVNgJ3sURYppEE7UrKlmDn7BIW5U/ClJOyThwSg+QUwxYLMKS7HNbBmvR90RDJWqH
         +YJTCFv1Ujg4Uqk0CvAW/pRcyJRekBvE3Ejq/AbQjYN5RMOOHMl1LQ4wPe4UV1z09ILc
         0DaCxU/VwFXMofXK0322uYwsNa2ZnAg5ujpGQWjw3M91zYVmwsV8aIfBUz2gc73HARWI
         uEACLoOTR+Mng/Yb1cpHJ3LTZ0qYRMvz6FNCsz4fLBCzdN10K6UBkb0FIGkvv8WmmL2T
         9C/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791493433; x=1792098233; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QIJAQjP+AkGIzt9PFWNtuaamgSjcZwMMzJzbJCTJsv4=;
        b=gy44AQsN4GnSLDsik+4oFo28vklRp4/UzBMulShDf/oeHHmyNrIot7Lkkzj2DS27no
         j8q81I+lO5xEK9GplRBB3Ud5mHn69E/l83gAuasCx7smghlkS4wTAHciTAwBVGrNqhuV
         OHq+sw+knIlfSB50qY9mmBCgymqJrNKrpbf0o9OxuZeOEByYoUFlzk4Y9heWqlnrLhPQ
         iXD7Dbcm4OHH0CJ3hLGCkbvbKc7X9r616HrvKdVp6oPvXVAikAooAtrFIWJ+mv62hIXO
         bXAnP2IHnniLEiurEY20VvC4i680sdOpEPgfLX9ZPsDoW6AoQrXAW8LlEvW4Ir/nSZYA
         pE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493433; x=1792098233;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QIJAQjP+AkGIzt9PFWNtuaamgSjcZwMMzJzbJCTJsv4=;
        b=H9jlDN/nGGzccxsC7xrmOIRpAcW1mnQLozrfGr6O5DvSfJ71A2IijVW8GB5Dt5jPns
         +qg19HKrBqN9WosYxxP774lVcJxJFhSPuCO76GWRt6t3jnu12AGSVFUR5FSzy5mfkWPm
         x+4czQyVcvuUuwmH086qy/TusOpV8vlD7Q+3+GiTu9sInCQJKcDTASnPW36VvF/U8+In
         ecIJxEX1NKJRUNsj/p97WVL8NYMqb2WAuTk2Ftuo0aEL+YfWVmQKeLnn/m3VgrbnK1+X
         eCgrjZIZiLd+/Kpf7u8XzH5D/MkZFihiSSMyVETgoIeL9fAblsHYnmnAP8nBwGarpwCK
         hEQQ==
X-Gm-Message-State: AFuF++lz7F6V6LZPRWthtg4ZqjMk5MXVWa4WnYIw6wXg/cXEFAILHzmh
	Iro7piThaVDVjxmY0fayWYbZFDdm/tvzwKqqR4uciTxlL8KldEzCtnYNpw4jnl68doWjqGkFNJh
	v00+Rfkmx/XVPQJ0ioWK0zY6GRSG727pS2Z7/UD8=
X-Gm-Gg: AYBFou3UEL9z4nOA8fN26BsaCgWTGGHsLyVqPJw4wfDItpWn64Kn5/z2/tKNYtkbiFZ
	sfaoAj6EJWuET+c/uJkIiMkVuBoHEEcAxcgCealn5+yZDX8bZ+PI98aJ+Mg1n85wY9C/59/WYAe
	yG9A0XHXX/fcXqD+fJqVPq9KnQnazwhX8uCUJodjiTYTfKwj70kx8vAJJQtCQexFeHP+v3oJC4X
	VfFlySm4g+Pra8XQn1KupMulkbOZEGik7FkyOLG6Z2H+IwvhnnTCHwxPAjAfJOs8jPTytLtKsd6
	BmIkW00ByOjll7ZJROMJLFe+4igtGd6rSYrqTnYeECa9+FlSYrNlErgDS/7w4QEmA7gMzjmco/t
	RYFqohTRXKb5PGIq7wvEsqhFmp005t9kSmc4oH6CsfgrOpn31Dw==
X-Received: by 2002:a05:6820:4c11:b0:6b7:83d6:292c with SMTP id
 006d021491bc7-6e7a61afaa1mr6143868eaf.47.1791493433102; Thu, 08 Oct 2026
 14:03:53 -0700 (PDT)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 14:03:51 -0700
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 14:03:51 -0700
From: adrimg3196@gmail.com
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Oct 2026 14:03:51 -0700
X-Gm-Features: AclHuK-yOsE5WA1CSKbxQDoxjrSMa7_x_yi5GK9kQ27I2qltivFphZUxWe9KXgg
Message-ID: <CACO1+RT+m==BY+ZPkE+fo536D0qu3wog4xE1dfuXQ56g+=Qv=A@mail.gmail.com>
Subject: [PATCH v3] KEYS: Fix key_reject_and_link() race with keyring restriction
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, jarkko@kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"

The restrict_link check in key_reject_and_link() is done before taking
the keyring semaphore, racing with a concurrent keyring_restrict()
that installs the restriction while holding the semaphore in write
mode.

Move the check to after __key_link_lock(), so it is done under the
semaphore, matching the pattern used in __key_create_or_update().

Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into
a keyring")
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
---
Changelog:
 v3: Add Fixes tag and Reviewed-by; resend with clean patch (v2 was corrupt).
 v2: Resend with full patch (v1 arrived without the diff).

 security/keys/key.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 1234567..abcdefg 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -590,10 +590,17 @@ int key_reject_and_link(struct key *key,
 	ret = -EBUSY;

 	if (keyring) {
-		if (keyring->restrict_link)
-			return -EPERM;
-
 		link_ret = __key_link_lock(keyring, &key->index_key);
 		if (link_ret == 0) {
+			/*
+			 * Check the restriction under the keyring semaphore.
+			 * keyring_restrict() installs it while holding the
+			 * semaphore, so testing it beforehand races with a
+			 * concurrent restriction install.
+			 */
+			if (keyring->restrict_link) {
+				__key_link_end(keyring, &key->index_key, edit);
+				return -EPERM;
+			}
 			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
 			if (link_ret < 0)
 				__key_link_end(keyring, &key->index_key, edit);
