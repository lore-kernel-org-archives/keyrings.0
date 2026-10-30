Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382497;
	b=hX50sIcuD+GDdbGoYG7YnCC46UQbq7uJTLxz8oePAsExzcOK4AKDjkH16J3fyqjsjACU
	 5xnmgpAv329PLU944JHx4sKyTF879/2rDqaBoMfD1fBbMpW4tldIgMXr+T2M48KA7jwRG
	 yMPCD5MYIf6tXeltlCIG4VnusAISIEGFxWl6aqYIkQwtzeUdhhVplMhYF1umx/f6OO1Q4
	 gDiQxNY/PljjdU6K8POsbhR9eQGKLDvPp1vbqYZLC3cvXXv+bYusrvi11BPLscB0O+e42
	 1/imEgRrntOSgGvPtzoIvzkEAa5qsQV/HQOys3kghyNNERP62f5bpPemcYg+Dj5jQPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QifswEpo/VzVa3gM1oejLCHs90gFC7vt6ot63/EwXeM=;
	b=iA2sdrZrlsNoRCYIcw9vLAbWynnpLVgTD6BHiAjKPJA06R2yt1ejaZFPaYICCVNTIFiL
	 /xyi9SNWcAkmj4g/kJXiFJ0k4WeidsRX6zCnDn9nmV09hTDqcr/g5hne6Y0K+hnfiLS1/
	 pQnZbPdD88jhb5ZLy8hcFhwP1sdcUp5YTHz8sMT2B25HRSfk51hbfIKybvdfQwTz8tD2U
	 xo1r6luVO5O7skd4u+PLJrmStvKKyyY7+I6ABthXPALJWbZBJgjiaC+W5cOVFY8/mF+oD
	 rIFMfT+pnoSKxBPKuCSQ5BO4Ji4/dDb8JDYRnlzzL+1L14XO55szmuYNV1Ioi4ghYdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmz6HFlr;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2F606A31A
	for <keyrings@vger.kernel.org>; Fri, 30 Oct 2026 17:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EC2F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cmz6HFlr
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35c95a3a303so122914eec.0
        for <keyrings@vger.kernel.org>; Fri, 30 Oct 2026 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793382495; x=1793987295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QifswEpo/VzVa3gM1oejLCHs90gFC7vt6ot63/EwXeM=;
        b=cmz6HFlrxjsYkh9KmIyQgYp4fuzvyDIEzoTziAXsNdNpg8O2PhgbACnW4IC/mVeDGy
         IE1gOc7WFqaZLUCuMA+jG4dQOIywUoCPedRGG++vuL/TMQF+RyxTBmoCMPyjyRead3J5
         Q00Z1hVkKtQNpMdOz9t0cgsmIaJS7N7Y3mgVNCyS6l+N+CD7D7uzMtYM5aNY43uAcd9S
         +iIvEI7IPWGJ59hi9MOflEo71DV5FI1Z1R5gop2B8czU+OxACB4iWhOdDdTwkfuSuEyi
         YTKd3U+gtyMV4Io5iSWCscaniS/3m6W8shGjHebI06iR7Yvr8wt4xO/UrrSsm+uHrWhp
         b10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793382495; x=1793987295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QifswEpo/VzVa3gM1oejLCHs90gFC7vt6ot63/EwXeM=;
        b=YSbFNsjeDTFW45/YbwZ/sMvUj6uTtqSJe6q7uNrArh/DZuz6uP5as3VFz7zJh8iQvJ
         NIxfYoRLURT/Sf/Xa4lsGUYenggaBDtAVwVsQ1Vr5UpEOBRdA4aqLmacZJoPDIsOt+MO
         24VDAOnexmkVuCitKsja4JfwAIGZ32fe4L113Pcp5kNgqqpIYBn5BtUBGBs67NeF/EwD
         9AQ56zCAVnkYqBg49J09Z69T7wy05j5ySk/4HCHV64Ow/44Rse78vuwuGaMtlhwCw/NI
         WLToN6pmXlX2sV7r/pEbOP7PPoL/CEO+fo26x932gGa6TWXBvXSgEmbVc+mGcOq0F3c8
         TXoQ==
X-Gm-Message-State: AFq9FYIKT4/ox/7qc4JsPNgnL0QTp/iJrcM+hR2TVyKvru+YHYYYwNss
	M0h4xlNfPy2QRn4Bi5tZAzhBxRm5MlWoKbipW/nhXphdORLr3E8aujPRe+UFj8vqxg==
X-Gm-Gg: AYBFou305z0JbrMLKLXU71q7hXbROyeBHucGzJ0+ul6Bc59VRKJnPHcGBdxgWSC0mYf
	gQjV8kgtXdDoCnVDbM1R5nEaOM1+6mVctCMHUQiUTbINE+WbkhFtE8ksnbVTFhw2FdKz3Ysv1PI
	lB+TECS+io1LbVCPQo3GEbpabp4kjAMCYrw9z7196CCbjf4j3yk2RPySrtCxXsE9HXnssJ9ALc6
	qrUXB5/ejRabLpOe9MrlS7D9eqiFalHqVrT4SqaBXBytx3oRHbzcbqguUbfAruJf4enAZrW9VoE
	V/g5tXjwGWQCaC4pVBjxL3zd/0DtsDQ/TI0eAB/UCgk0yQ6QeEjCK3C/vngNPNyC4IS3Hv0dMA6
	ACBs2AFcmHmrcZZ8T5ULJZJakOQVCkmrmp+o7zKPCBFq37GrUWaufqKPN8icv1NImX3u3gEh3lN
	Q4LIbaf4Tz1vwXUxhvxl31M9GaeDqFbobTEHNi7eWwrDZB+jbqeFncJcPy954b6j43xem6WGYEy
	BRjZexmEG+mnoZ3LJkFPJVsZ5ok6HccompgIrrQzYxyzxtGdARksE3zpD85q9NrZ31HsENA/Zxu
	Z/UvPUneN2ke/6byLXER/WHMr/f/eqGowZNScoK9
X-Received: by 2002:a05:7300:ce81:b0:357:ee3a:267a with SMTP id 5a478bee46e88-36a422062e0mr4357375eec.2.1793382495268;
        Fri, 30 Oct 2026 10:48:15 -0700 (PDT)
Received: from archlinux ([2405:201:ac01:5300:6b3d:54be:288a:1de1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm7631968eec.4.2026.10.30.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:48:14 -0700 (PDT)
From: Anvik Loitongbam <permissiontogallop@gmail.com>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: request_key: enforce keyring restrictions on constructed keys
Date: Fri, 30 Oct 2026 23:09:30 +0530
Message-ID: <20261030173930.40948-1-permissiontogallop@gmail.com>
X-Mailer: git-send-email 2.56.0
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

construct_alloc_key() pre-links a newly allocated key into the destination
keyring with __key_link(), bypassing __key_link_check_restriction(). If
the request-key helper instantiates the key with ringid 0 (or any keyring
other than the restricted destination), the key becomes positive while the
provisional link in a restricted keyring remains, so the restriction never
sees the payload, potentially resulting in a policy violation, where a
user with write access can inject keys which are restricted on the restricted
keyring.

Restricted destinations lose the provisional-link deduplication while the
key is being constructed. Callers that pass
KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavior.

Fixes: 5ac7eace2d00 ("KEYS: Add a check to restrict new links into a keyring")
Cc: stable@vger.kernel.org
Signed-off-by: Anvik Loitongbam <permissiontogallop@gmail.com>
---
 security/keys/request_key.c | 97 ++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index e6ba2d054399..3de6c9160651 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -370,18 +370,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 			       struct key *dest_keyring,
 			       unsigned long flags,
 			       struct key_user *user,
-			       struct key **_key)
+			       struct key **_key,
+			       bool *defer_link)
 {
 	struct assoc_array_edit *edit = NULL;
 	struct key *key;
 	key_perm_t perm;
 	key_ref_t key_ref;
+	bool link_locked = false;
 	int ret;
 
 	kenter("%s,%s,,,",
 	       ctx->index_key.type->name, ctx->index_key.description);
 
 	*_key = NULL;
+	*defer_link = false;
 	mutex_lock(&user->cons_lock);
 
 	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
@@ -404,6 +407,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
+
+		/*
+		 * A restricted keyring should not take an uninstantiated key,
+		 * the restriction has to be evaluated with the payload,
+		 * which is only available after construction. Skip the
+		 * provisional link and add the key with key_link() later,
+		 * unless the caller explicitly asked to bypass restrictions.
+		 */
+		if (dest_keyring->restrict_link &&
+		    !(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
+			__key_link_end(dest_keyring, &key->index_key, NULL);
+			*defer_link = true;
+		} else {
+			link_locked = true;
+		}
 	}
 
 	/*
@@ -424,7 +442,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
-	if (dest_keyring) {
+	if (dest_keyring && link_locked) {
 		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
 		if (ret < 0)
 			goto link_alloc_failed;
@@ -432,7 +450,7 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	}
 
 	mutex_unlock(&key_construction_mutex);
-	if (dest_keyring)
+	if (link_locked)
 		__key_link_end(dest_keyring, &key->index_key, edit);
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
@@ -446,15 +464,44 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
-		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
-		if (ret < 0)
-			goto link_alloc_failed_unlocked;
-		ret = __key_link_check_live_key(dest_keyring, key);
-		if (ret == 0)
-			__key_link(dest_keyring, key, &edit);
-		__key_link_end(dest_keyring, &key->index_key, edit);
-		if (ret < 0)
+		/*
+		 * The outer search checks Link permission on a key it finds.
+		 * The second search must do the same; otherwise a key that
+		 * appeared in the race window could be linked without the
+		 * caller holding Link permission on it.
+		 */
+		ret = key_task_permission(key_ref, ctx->cred, KEY_NEED_LINK);
+		if (ret < 0) {
+			if (link_locked)
+				__key_link_end(dest_keyring, &key->index_key,
+					       NULL);
 			goto link_check_failed;
+		}
+		if (*defer_link) {
+			/*
+			 * The key may still be under construction, in which
+			 * case its payload cannot be checked yet.  Do not add
+			 * a provisional link to a restricted keyring; only an
+			 * already instantiated key can be checked here.
+			 */
+			if (!key_is_positive(key)) {
+				ret = -EPERM;
+				goto link_check_failed;
+			}
+			ret = key_link(dest_keyring, key);
+			if (ret < 0)
+				goto link_check_failed;
+		} else {
+			ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+			if (ret < 0)
+				goto link_alloc_failed_unlocked;
+			ret = __key_link_check_live_key(dest_keyring, key);
+			if (ret == 0)
+				__key_link(dest_keyring, key, &edit);
+			__key_link_end(dest_keyring, &key->index_key, edit);
+			if (ret < 0)
+				goto link_check_failed;
+		}
 	}
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
@@ -495,6 +542,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 {
 	struct key_user *user;
 	struct key *key;
+	bool defer_link;
 	int ret;
 
 	kenter("");
@@ -512,7 +560,8 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 		goto error_put_dest_keyring;
 	}
 
-	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key);
+	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key,
+				  &defer_link);
 	key_user_put(user);
 
 	if (ret == 0) {
@@ -522,6 +571,30 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 			kdebug("cons failed");
 			goto construction_failed;
 		}
+
+		/*
+		 * The key was not provisionally linked because the
+		 * destination keyring is restricted. Link it now that the
+		 * payload is available so the restriction can be checked.
+		 */
+		if (defer_link) {
+			/*
+			 * A helper may have negatively instantiated the key
+			 * (e.g. KEYCTL_REJECT) and returned success.  A
+			 * restricted keyring must not cache a negative key;
+			 * key_reject_and_link() rejects those too.
+			 */
+			if (!key_is_positive(key)) {
+				ret = -EPERM;
+				key_put(key);
+				goto error_put_dest_keyring;
+			}
+			ret = key_link(dest_keyring, key);
+			if (ret < 0) {
+				key_put(key);
+				goto error_put_dest_keyring;
+			}
+		}
 	} else if (ret == -EINPROGRESS) {
 		ret = 0;
 	} else {
-- 
2.56.0

