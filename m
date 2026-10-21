Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615066;
	b=txugRm5yNA5NEKIkcaOSa2w9T4gMXZ0S3N/i093pmMlsM19ICtNdSfmBdy+mjcx++9a/
	 XgRiKwMYzo3s8ns7zagHGXvOtvwYaWIE4v8o36hYlKQzEXF3g1F1+Yl2EkieGBOVSmTNU
	 jfeLJyDbMU0i1rn+kKS3yDY2wYUk9zPcjfpmxkZe+0j+YsxjnDmRUTnFfeFQ5fZQ+z/F/
	 SISQKzHNJvbA7ELeLKnv4L7hrXh1r4BnCjm8YTVVpgJFWNGnTtIlDXq7DaAsStAKu2x6E
	 kWOESjhgVZnssGlWuy49e5yKKfaGy4QSBkpJQR8q4GBhPSm2BW+/+leHvYL5nE4uyCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=rtdA4gx5VZ7RaqR6oCB1/OWC7pUugQwtuvImmW2LRwY=;
	b=uDBOf/aOovMMeFvf81954QwEC9xOdpFEd7Nb2UTR1ivXLKii5+3SK0A8+KPx4f7wFWdu
	 DtaEt8zCTpp53WUIww6VlqeEcu8RNtnlt0rJpR33Cl/o9RuazGKS0x5XOtcE1zbew+y3Z
	 6NJHG4cWcJj73HO5NPRmpiu2TXryHaQ6KiqNEnBRrMqA9qXnNEvpWEgkpgElS2CY2dUnv
	 uxlZ1ksPD9n18RXZm4cAgvOEeWJgxNpSq1+pEDIiCvLqUMgC1aivMkhZZE8Q5QrzMPzZT
	 5MWpbmZYu3XQ/9pa+RabwwiLysyyLX1fflc2qqDWbrwwsT2PIlK63VLk0krzzP39BSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rdF7cWEU;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45996606A339
	for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 20:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45996606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rdF7cWEU
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b83459526so14111946d6.2
        for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615065; x=1793219865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtdA4gx5VZ7RaqR6oCB1/OWC7pUugQwtuvImmW2LRwY=;
        b=rdF7cWEU7h4+3COzQHcH4E7/BjJxAUq6BOdlSKx9dzh6ORlNKocXQAuyaBzeYJKKok
         EIu4L/+eISBUO05LTKlgh9uErqLriFSCkS8+1KojVHBG795ynCcWHPKKz+ZOy9WZSM+X
         Qacp7zcCd3STX9Qf/uy3MmaAcaSVflFqBPnfMx5ZYawqBe5f26nQ32RUlRGG6ePLse+e
         yMTTOKUOc1z/DM3bFGXSKyDwos/VgxJqUC1EU0eBcCYDF8UHE4OQrbrJ4mKk6YdnUN+U
         fNyeB34Cp7lStAKDalAUJKgdnXOIO3w8cFq9Ow99LpV/y0yiPZv1NsjWyVvxeezqkMI7
         HXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615065; x=1793219865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtdA4gx5VZ7RaqR6oCB1/OWC7pUugQwtuvImmW2LRwY=;
        b=Wb499zJELd/BTXTpH9LVXOtVDJpTGILsxHBzT96UwQxc2zRb3enACSxg8oqKlQLT4c
         QqWupIza36D1HZghXoBGR7Sr+Q95LN5RVxd3qx/kFOJ0m60ubbBfgEziPQVEdeZElUxa
         VgrFd8eiujH3lP4nDU38m23sXvBaeh2q8gSJdaPTd99+Ztq8gkIjPnhCIXBjAvvldIec
         dkXy3c80ICipHJp7NMP4718bNulFPoC3CVD16xm6FNZPNMF8Iiimo989KMwpr926fCJl
         HGGMQaDy+3IvOFWojDls1UOx5IN4YWsdK3UrYQYojUBJ3Uaie1mzah4Sx2dzrhyK8rfd
         kaRg==
X-Forwarded-Encrypted: i=1; AKwUvBwr4y0JGoCHMS/5FxrG5rp/zFdljMfLpgnC1BwB3j5JP0tifSaBsyGu5C2qwXMC3XSS34jgprEAqw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIT1vFWSN8v3mXJwRA51isS0Un+5wU07dz8UGTPxTvE4zCMIBt
	S4xbVaC/RDm4VDm7aKqS7QcSZSz1+Xs272eGSDkAU7zKthl0irwLqcqb1+pqC3Gut20=
X-Gm-Gg: AYBFou1ZgMqFgzUuR3HMpv29TJVQjkdvjoN3Eoz6ajOnD6PHn2irE8v6VbDG+oNuW0s
	ny42cIQUjMpaUl5w0S3b/IFQIhZ1CEihCMFSjjSonXtk5RemKshfYDESPxnvQw5t6xF+gSMWeAo
	mki6XDNht+it8hUasblnvyN3grlmIC5LRF8/TooG8H7SKPNLXfwSOgNwSons5vy5kc63rYNekHT
	IYYpZg5YwYmrltbj14+9WHJrP81uKQpn7ULJWT+36wiyyFh6amadbe2J0AQftp/iG6ovdSqXDeL
	vPAWBVzui6M/nXjz+/EDTIZ1XZq9mBP0tJqGIE7PkvrOnb3csc0oQ798SPoISh4+3PtDXM9SYW0
	OjNKVJf5aIZHetQKmETBufkVUCZRX/CDfK+IwsB6hzZW2XuGomU10l8SbrZODZq4+t7MI/MeVz0
	IUq5rNrHAzLB3sMpRM4SSrqUa21zKUtB4909Cqnx7j1NnRC+zk8by6EjuXTWq6REwDlPtQQpsgt
	oXDU9lm/x0B/1X38BiFFQqnz9Kl+CO9ZMGvpHI72bpCkPYwH+QtwRdJpOov9a7xW0pmz7N2
X-Received: by 2002:a05:6214:8593:20b0:91c:1438:17c2 with SMTP id 6a1803df08f44-91c14381b32mr33368206d6.16.1792615064999;
        Wed, 21 Oct 2026 13:37:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10cf9f32sm33272296d6.45.2026.10.21.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:27 +0000
Subject: [PATCH v3 3/5] userns: check the opener and the writer before
 mapping uid 0
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
Message-Id: <20261021-b4-setfcap-userns-v3-3-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=6487;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=gou9ZlC4AH/3zuuFb+dZz8p975sbGmavF7hL2edIjO4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMI2MrBigiwjHUFvBpTdvfLJ67YnSceCTASUJE2fvs/mn7ksFxir0rNldwjEwQXtyQapImvsE9m
 wCY7DtED0RQY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

verify_root_map() looks at the cred that opened the map file: it asks
whether it has CAP_SETFCAP over the parent, or, for an opener inside the
namespace, whether the creator had.  Two things are missing.

The writer isn't checked.  For every other privileged mapping
new_idmap_permitted() wants the capability from the opener and from the
task that calls write(), but a map that consists of the single line
"0 0 1" takes the unprivileged branch, where only the opener's euid
counts.  So an open uid_map file is a token for mapping uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  fd = open("/proc/<pid>/uid_map")
  B gets fd by inheritance
  or SCM_RIGHTS
                                    write(fd, "0 0 1")
                                      opener had CAP_SETFCAP -> allowed

And CAP_SETFCAP over the parent isn't always enough.  The parent may map
its own parent's uid 0, so its root user is the root user of ancestors
further up, and the capability has to count there too.  A task without
CAP_SETFCAP that unshared a namespace, which a privileged task then
mapped "0 0 1" for, has CAP_SETFCAP in it.  It could unshare again and
pass on uid 0 of the initial namespace one level further down.

Find the topmost namespace that shares the parent's root user with
cap_root_level(), and require that the opener and the writer both reach
that far: by ns->setfcap_level for a task in the namespace that is being
mapped, by cap_setfcap_level() for one outside it.

This only affects maps that contain uid 0 of the parent namespace.  A
write by a task without CAP_SETFCAP to a file opened by one with it, and
a map by a task whose CAP_SETFCAP stops short of the root user it passes
on, now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  1 +
 kernel/user_namespace.c    | 29 +++++++++++++++++++++--------
 security/commoncap.c       | 23 +++++++++++++++++++++++
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index e4199b03668b..2eaef87748e9 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -227,5 +227,6 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
 bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
 			  int level);
 bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
+int cap_root_level(kuid_t kuid, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7bd3692c2f3e..f948cf31ecdf 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -888,8 +888,9 @@ EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
  * @new_map: requested idmap
  *
  * If a process requests mapping parent uid 0 into the new ns, verify that the
- * process writing the map had the CAP_SETFCAP capability as the target process
- * will be able to write fscaps that are valid in ancestor user namespaces.
+ * process that opened the map file and the process writing the map had the
+ * CAP_SETFCAP capability as the target process will be able to write fscaps
+ * that are valid in ancestor user namespaces.
  *
  * Return: true if the mapping is allowed, false if not.
  */
@@ -897,7 +898,7 @@ static bool verify_root_map(const struct file *file,
 			    struct user_namespace *map_ns,
 			    struct uid_gid_map *new_map)
 {
-	int idx;
+	int idx, level;
 	const struct user_namespace *file_ns = file->f_cred->user_ns;
 	struct uid_gid_extent *extent0 = NULL;
 
@@ -915,24 +916,36 @@ static bool verify_root_map(const struct file *file,
 	if (!extent0)
 		return true;
 
+	/* The parent may in turn share its root user with its ancestors. */
+	level = cap_root_level(make_kuid(map_ns->parent, 0), map_ns->parent);
+
 	if (map_ns == file_ns) {
 		/* The process unshared its ns and is writing to its own
 		 * /proc/self/uid_map.  User already has full capabilites in
 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
+		 * when it unshared, as far up as that root user goes.
 		 * */
-		if (file_ns->setfcap_level >= file_ns->level)
+		if (file_ns->setfcap_level > level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
 		 * user namespace to p1's.  Verify that the opener of the map
 		 * file has CAP_SETFCAP against the parent of the new map
-		 * namespace */
-		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
+		 * namespace, and as far up as that root user goes.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    !cred_setfcap_reaches(file->f_cred, map_ns->parent, level))
 			return false;
 	}
 
-	return true;
+	/* The file may have been handed to someone else since it was opened,
+	 * so the same goes for the process that is doing the write.
+	 */
+	if (map_ns == current_user_ns())
+		return map_ns->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
 }
 
 /*
diff --git a/security/commoncap.c b/security/commoncap.c
index 8a9d998b1897..b06914223039 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -216,6 +216,29 @@ bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
 	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
 }
 
+/**
+ * cap_root_level - Find the topmost namespace in which a kuid is the root user
+ * @kuid: The kuid to look for
+ * @ns: The user namespace to start from
+ *
+ * Return: the lowest ->level among @ns and its ancestors in which @kuid is
+ * uid 0, which is how far up file capabilities with that root user are
+ * honoured; INT_MAX if there is no such namespace.
+ */
+int cap_root_level(kuid_t kuid, struct user_namespace *ns)
+{
+	int level = INT_MAX;
+
+	for (;; ns = ns->parent) {
+		if (from_kuid(ns, kuid) == 0)
+			level = ns->level;
+		if (ns == &init_user_ns)
+			break;
+	}
+
+	return level;
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

