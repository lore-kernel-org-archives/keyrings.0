Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110994;
	b=I1uUk+L2aoGx1UtqGN0gO0GMgVmLN4XcpaUhgO3kmCXjsG7sYIx0eZdtKFDYyJuQouzZ
	 mnHIocV/lxJlhUb0ic3KBWsCCbxCJFGgKjEjRDsYjr70ACSHiPBrWv5sfoYvwt/1PupKd
	 26G1UVVxBoAF1zTED7S9C4sB3AEhqHPlQbUhCGOdQIE6KpKNqtaQQNts0UVTqF6hwT3j0
	 NzKAz6da4A/yPRdMqA+EDJyl/OcHhqjoZfscqC8jLn4wtl444KGHHLgk+yY9ca4doiBAj
	 8ZbaAoh42tTL0dr6k7IgSEq7BRDm5Mord8ltWdkVBNMJPKkCLOxtAdG25OrjnOGNVJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=uw8sMdP5PM9jbYrZ7pW1Y/f+exO5hRBL6op7zmi31DGf/GdWkIwBSByHZq/s6mL3zeCp
	 ugBbg52C+3SYASZypdF6oUYXtnsEL8zxxdbgmq5KqgwHfjmYStoc6YRdFUnzZ0w/791Hz
	 JGB5KnQmdxbwG0GNYRPcn69dIPaJ1IvnCjt4aPzSINQGBlsn6mAea2wuRzm/frwqcy76J
	 EQTcacGc7aK2sn4XHKI2mqi+RH6lwerrJwMT3GjcNI9zpLYjzzAgAEkalapSjQxKIBr30
	 rRXJVCcaDmHSm7sHS1MsGO5XTBzX73k4mjz8b7UevyCk0KctSDYN+UPYo0PcVIb8frQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=K6IBm6dt;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9E606A323
	for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 14:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D9E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=K6IBm6dt
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c2f48f3a96so1432609137.1
        for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793110993; x=1793715793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=K6IBm6dthAvYK4nfO7RbSGQoqgtvZuJnz47KOW9OlHn6tapF7ox79Cs33M8ivUPs9o
         g66sUlKDGPKafbWAkKip3IyHNb3VQYZFXxP584C2YBK2TOezdVDWcA+rIBgEnfAJzgFk
         7ApqszdPnGjJ+nkly2ugTA/j2D73V5t6vQFmHS/BnUjauf0UFSb6R+gxZgQZVu+hm9Du
         PQlGUAcjR9cM2dL9HftXTbk2KJMFemIdYHV1Rt+4p5jhGhjAOugdVEd9MS9jW7Bj3mHq
         NMBIUsUhZdavR/4mHHUPlzHCjF1gOzjgz7lVKpWpHrko0wHIo59mCRSq8DXH0pP4+Cqa
         2H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110993; x=1793715793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=DvBSmrvDGNFi6ZITTMdo3Z/W+iX/wDW0YImc4Noq2jkBQAr1DcKH0egunOshW4xcGn
         Uvb7nKabyMWeHA2yz/9mriszrGiBjuo4ctONxYmqO5+Q2GFH9OJwyDBtrdYDkdpfk/ac
         gXuWtyT2tqJBjNjhafMSuTfHr8tcFCtrf0NwkrMGRsNvjqxyRoUA9oZ3SXQaZcVgZ6e3
         SvYwYrgUWc6Kjdvvi9vJBTuWwAR9mfug7YnQ6/x5C6yvZefDQJSCEL9KGglwr4BEeAQ4
         59qr9FznPFsPZbF+XsALIvjL3XPqVPD7IxHRr0iwouYzKcFOdIebrlG33C+d7bUiflO1
         MO4w==
X-Forwarded-Encrypted: i=1; AKwUvBw2AvjUYM+1766hBTpenZj/aKziaLIyoUKkom21xPih7XXaehLObOb19qIqFqfIGtf1M908ESmaKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIHDtuMuIyfEihyx7//u9xQCw0HZhploCNFBVRfQWhpp7iKmkW9
	4pCKoqO8eET22vBObrU9MalpYIjgr6rA+MSjsPb7qPEn2cyWLVIeP/4p5MrI86XiLLpa8BTcxlP
	MQKdq
X-Gm-Gg: AYBFou0fv+2BpH56Nf9Kzh3iGuHn8WDq8ZtDFsDITKewK0VAgvYYDm+EgXGqpX/j8YI
	jb79puiPrLXLI65NwcU4vGZSCqUuNxC8WDo2VaXf9TGVkw4bbD1DgVXaZX1WyADEyNjJ+m1k8bd
	k4mEWbxxyTVquCB4Nv1BPwBObcF69rF8Ibnquvci1fLk5Agb9BXE2/dDZI0OWS3qPuW9PUGHfR3
	qVrUcfS9Zkpf4Jw8JSzreOBai6Tk2fJThWPbaAL+9zT8ok83A6PMliqY0UDbqLUzjIbGFYIBWaH
	ci9aL2DcUMH843JIEysi69ebQgyYL4YFE1nnO16w5J9IDOwflnGg/40BoN7zWGIFMXhptr71NEu
	l1S2e74O5Y+1dqlpllyG5pvdUIyPDy0HJcySMzyNL/JDD0emSmpqOsKIqlWsAh1nFpgxLcq/Jmq
	VJHzn138NDkhICcbkmaffsh0PpOfuqHluUuTtD3VEaQiZjwSjq7hGPBB5+Fnihc5O40XPpL/4q/
	K/b4LexOeFbzfL4iJQmLn+XKF85qd35R4dINHDsNfJfU1CIjNpr0rDapJyR8Th3oN4EphOq
X-Received: by 2002:a05:6102:54a4:b0:7a6:cd7e:72db with SMTP id ada2fe7eead31-7ce5cdced50mr3220516137.26.1793110992047;
        Tue, 27 Oct 2026 07:23:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3bc3816sm2631126137.3.2026.10.27.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:23:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 14:22:49 +0000
Subject: [PATCH v8 1/6] userns: record how far up CAP_SETFCAP reaches
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-b4-setfcap-userns-v8-1-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
In-Reply-To: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793110987; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEp/gu8q2MY179qa00LXa5jiK2xdeEumeDAk/Ue/Z8Wy+8e/8DrLP5/s0JDygHRepOswqn9KQP+
 qaVfiH/6N/Ac=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

create_user_ns() records in ns->parent_could_setfcap whether the creator
had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
when a task in the new namespace maps the parent's uid 0.  A bool only
describes the parent, though.  File capabilities belong to the kuid of a
root user, and a namespace that maps the parent's uid 0 shares that kuid
with the parent and possibly with ancestors further up, so what matters
is how far up the creator's CAP_SETFCAP counted.

Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
namespace counts there and in its ancestors up to the one at that
->level.  cap_setfcap_level() computes it from the creator's cred.  A
creator that holds CAP_SETFCAP passes on the setfcap_level of its own
namespace, one that doesn't gets the new namespace's own level, and the
initial namespace has 0.

verify_root_map() keeps checking the same condition: the bool was false
exactly when the level is the namespace's own.

No functional change.

Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h     |  3 +++
 include/linux/user_namespace.h |  7 ++++---
 kernel/user_namespace.c        |  4 ++--
 security/commoncap.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 622137f66f09..026974a5111b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -34,6 +34,7 @@ struct cpu_vfs_cap_data {
 #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
 #define _KERNEL_CAP_T_SIZE     (sizeof(kernel_cap_t))
 
+struct cred;
 struct file;
 struct inode;
 struct dentry;
@@ -222,4 +223,6 @@ int get_vfs_caps_from_disk(const struct mnt_idmap *idmap,
 int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 91232053775d..f3753b6b6d29 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -86,9 +86,10 @@ struct user_namespace {
 	kgid_t			group;
 	struct ns_common	ns;
 	unsigned long		flags;
-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
-	 * in its effective capability set at the child ns creation time. */
-	bool			parent_could_setfcap;
+	/* setfcap_level: CAP_SETFCAP held in this ns counts here and in the
+	 * ancestors up to the one at this ->level, see cap_setfcap_level().
+	 */
+	int			setfcap_level;
 
 #ifdef CONFIG_KEYS
 	/* List of joinable keyrings in this namespace.  Modification access of
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..a5a94367600d 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -125,7 +125,7 @@ int create_user_ns(struct cred *new)
 	if (!ns)
 		goto fail_dec;
 
-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
+	ns->setfcap_level = cap_setfcap_level(new, parent_ns);
 
 	ret = ns_common_init(ns);
 	if (ret)
@@ -921,7 +921,7 @@ static bool verify_root_map(const struct file *file,
 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
 		 * when it unshared.
 		 * */
-		if (!file_ns->parent_could_setfcap)
+		if (file_ns->setfcap_level >= file_ns->level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..4f49dba65426 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,33 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ *
+ * File capabilities belong to the kuid of a namespace's root user, and the
+ * same kuid can be the root user of ancestors of that namespace.  Every task
+ * gets CAP_SETFCAP when it enters a user namespace, so having it there says
+ * nothing about those ancestors.  user_ns->setfcap_level does: it is taken
+ * from the creator when the namespace is created.
+ *
+ * Return: the ->level of the topmost namespace, from @ns upwards, for which
+ * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even count over
+ * @ns, which includes an @ns that isn't @cred's namespace or a descendant.
+ */
+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
+{
+	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT) != 0)
+		return ns->level + 1;
+
+	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
+		return cred->user_ns->setfcap_level;
+
+	/* All we have is that we own a child of our namespace. */
+	return cred->user_ns->level + 1;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

