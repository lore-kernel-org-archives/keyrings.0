Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029311;
	b=UPTRM75bGWMaROrQg5NRx3vRjIGkUTt1o1SY7VlWcHCjMTjfFd0WVFN95WNsGPKtj+sc
	 64Qo5wpR0+1aoWWqZ42gDn0VYJfz1VBxsQYAsS+RL4iIZAkj7kpZJFNjJYQ8Es32rDmIt
	 1ayCQZycuPVw/I95NLm+cP7GdosCc4MH7wjrmvLAirHug/+ZQyTsCsHXGOV3E4nbuDiOh
	 S2mhw/0ZT6BpjPB2ehgiVKkdP6kiL0zNPHOnAzhEZLFVYJXjy2Yv0Oi9nfQlWKCgtOiqL
	 Mv81t32zc+xGwP7wj2DT7w7FYMAsgHhAIFMIciNHLCQ2SNV/LfY6WdNOERJKrkjGP9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=AuwTobvC0szyRaK2oVFPukt53KMiT13k0OpVWgKcxuPuwDrXFPW7OxhEZZ0MmV1eEifh
	 ZIZ7/JfV3pHbC4ZrGjrnIUv1DqndkS0NDPaUsHG9tEquNnXGqzG2UqVxmovcOlCyjdkyR
	 4JaKb3EeFcaCrlSPfIeZkmfPQeZpMfgTtUS8KEIGASHsZSJYhrl0lwCZ56ng+rLHnvOJT
	 rDrJiXisbjVgJvaeH/YjId+8Nw991xYS5UMqQ51ur0ZzP1NqGx8pARcY9r9HoqLN6CpeQ
	 yfUTKQgjJWTkNPuSePtA3+SJVM/xF1HjCuwnyEHaiX8UNwXRpKXsFzlYCo3ul+Pr0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=W0JfkAqw;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864DB606A322
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864DB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=W0JfkAqw
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8726acc5eadso23651517b3.0
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029309; x=1793634109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=W0JfkAqwQN04hoUxZFnksS7EkEmxDHR4t+VdypjVHnojfA3fTzZ0ZSUHBz2gGavrCy
         hTx9j4femId2e/zxmTU0aQOfujQUqcOUIQxfB5ZwTxDl7bb6Uj+wRDhPRpazVNqRB2Na
         W6NVGRNCE7G6LG3tGZeg/KpX1tFtnYLAvVHfGwGgYpKag2oNE6leJTjCWda/U/lEoeQU
         P1USqfhKykIui3qxuklsftUpp8mi+UP/qEghTq3RJ6mTVFm8g0uBD0XvVZ7Z8XEOAdUH
         NpecKjEuiksVlwR2jlUxy4dA9H47F0cAEd6Ukl3ts2ZLEi8enYSOIQ/jVkc43ofdzHCh
         Dgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029309; x=1793634109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=pBJ0fuhCNwaXCyWy0nchyWW5DJ0uJjUujvFtWIysYHv2AiFsqujaja6L5UmLjrOpAn
         1kFq8DPn7efPOlDbA5cRGTnIIo+2aRwlGH5E7ZOWaev+ldSLOzeu1cS5P6++VQFT9rl3
         hFF3/J2+0F0PxhBnjn041yObTolMP+F0LWhLtQuOf0tZicptGGwQpoFILtrmQTGDevq6
         7MCapAggJQLnw94icgZWDSLjnNeerFFElpx62i1vQQ19ESQoaRmZ19A/ahDdew9Ccvyd
         j3hxMN+0WU/XjWCrpHIdo5gaxsezif3isllgP64i7aEzP5czwWBvFyhg+Hb+s1jza+m7
         PElA==
X-Forwarded-Encrypted: i=1; AKwUvByQISZfss+omvlbwVqqIbRQE+xgtsp8GrsKD9hL3BDVOojK5N0T3utTa/S+hwlfx1Xxm34MYDgiqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK5CGYhtnKRDICfBTuPP8GhKghG7QXP7/OMHVis1396SsmEHeZ0
	ZsSi01lzd0wqMSNA+GCGNnZG5nqOvkLzZKNrFCxpYSBBi/RsBZItx5U19C4McH9+/eg=
X-Gm-Gg: AYBFou15LtyYhLzPKtnN55kvL0ywO+ggYtNA0MpZBba6Ue02wo7sVD7Gz6FPd9HSI8G
	mWwVGSVkeP8J23q53ncj7dtNooVrNp2YfOSbDdryAnYe/U8Jwzn81drMTlaiHWf/oC//Qj8VK9i
	vo38gUciroAPn7qRNJdG2iE0XBTAe6UCFKANhjK7ozvgkwZSrpd6agEvcMqpQwvB9pgZI3qcD5D
	Tljy9Jb3u4JP2sX7tone4oHy8/5R1z2Xi5tLgyL09HSzJmlUFVxQUHMSCMQcv34xtYLH7VZ3b/7
	Wa9hezELoZPTVmq6xeTETJURY7H79YGstJL6IeOKwK5XsnCMmDYxlyhXOmmXQnbeIEXqmwC+ioh
	JMJ0gopTwZmzxfCcJZ+MfMS8pzN9Hqz92ySWpzpthldN3opEYZcogBsKDg7blwjalGheddhyzzB
	tfLIO7nHkWYDX306bvDZAJTOyDhJR0lH2JzvLHA3EexZuuhmhw5rIYW8jsqNfuQQlHbmhHyb/BT
	p4ik3H6zM1WEJCi/fXofNB/XAJS66COUNqAq3P6K+RW3znMsKrP+8uVsBZMiT5vD/d1ocPq
X-Received: by 2002:a05:690c:e3cc:b0:8b0:d4bb:c9e7 with SMTP id 00721157ae682-8b166c476edmr51670507b3.46.1793029309522;
        Mon, 26 Oct 2026 08:41:49 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e9fc27sm33333417b3.34.2026.10.26.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:37 +0000
Subject: [PATCH v6 1/6] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261026-b4-setfcap-userns-v6-1-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029304; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKSnBbvW3gF13nvIsPskfwe1ZydkKFeNw4K491+ZSU/vInlNTM6w8ghwDho0lRX7PjFU96DUQUQ
 X2TXyzz7jgwM=
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

