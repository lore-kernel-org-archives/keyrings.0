Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773029;
	b=TkIbSNuhg07mwyqEliVdawWUWUP1A9ifIAUz0y9457xxt+ktM9AbdbzEo0e2GJXfjxeR
	 lYWbOOrIGdvQDW+l7ItwnXJd57g2rL+NZOqXQXmF1dC0dNaYXie97HjxA+MTswgNAoZ/R
	 iu4m2pFsD9RSOGFNajq5dh4fLQA7dpyKCMCnJkWygLztKv+E2BjRoiUVAlltW/ApMW5iH
	 W571rL4/4XeVM+bskBUETf9FtW83pzQxvTbFO2LjgV1ZHoPynS59qGNNhBpS1a4Ncx11V
	 r8XfJihoMC8j+fP/vK6iKwTWCHwTfVdf+Z1x5CGB+iq9ZzyCXRqKn43Dr+SFdElgE1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
	b=lrBO5SwWVL97wHLsh/pEZ2EGUkj+kN9E9dCbIilgBDHU22QkpdAxiULQOznYbdMoFYvT
	 LMDu3qE79v2dVMY9QC2u2Eud3HfSSNJFg1oPELDPAz9lFL3PNI6VszCJkbDJTVpgOQnt+
	 xJLFSZhSs1sO/Qe5ezlEajvdTHv2RxNNF0Plc1M1+3nw1pDtGsNdvLzYDDl4zBt/vjrag
	 0y3x6SnkfoGNk7w36a0akUU2eGbOmmL0TcwkuIu4ucNHuZB0m9539q2zEhusm2VGeOTjV
	 1e18rkmoUZ5xm5ceCb6SFlMnHAIQ7xtY+h85KmAJsvg5YpCmp3nYe3rDddpFnUFDqdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="kUZKiK/x";
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F3606A32A
	for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 16:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073F3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kUZKiK/x
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso9453816d6.1
        for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773027; x=1793377827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=kUZKiK/xbZEF4FfAj2jy9vESHWp0r0+v0JYi16PQhPQSxkJdrjB/ZzAKq0tuVMPxI0
         d43gcmVVZNoyCoi4WQZRxiLSlXwwYeWfjAKxPd6Kb+BJsX8IZoKIp37uJxcOlXE6PqB2
         lzDWuVaWxKJQsR8nZNvfZxeiXozif1mXDKZ40oSS+/zdbtkEHkTDBmQNzZ/c0hWlZpnj
         n74gk5KPzTx36Vwop5xszcTe2kq6p6jO0Q+DXUTLSZQeoZsXWp82MfujcCRuAIntyeZ8
         OSilgolIeEvEiSooZVNwvoI1mVTq2Khe8EerLx+9FMt1jirr+FxjshZQNq+xEvkAuvQe
         h4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773027; x=1793377827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HByHUi2YpmsLQonsK5yG9lvFZV5+xRUKZvYtQ5pzKU=;
        b=fxyuB8dLsvLtBUj6DWnh/jq3RLqSY47+DKvFRXlUtH7WHZ95fPqHQY0ysUycocA3sF
         Dq5hV1MlZ0yF4soOnIfPiC876oNQCTtFjdcHUU3irt+jfDJaRLbjSDAFJJBn032IsMlD
         C6l6ZzspwbNOKJUB5bBHnX5fA+GCUvhLW0rFROUOdG0s+sn/pBKWW8noLQ2Wf5k8zxhR
         K9jYfn5YcXq3+Bfowo72jq3SYLymG6iTHAbiR5o6TmeKVIXgmoC8CcLc82hot251X+w8
         i3R1Kll3WcMzM8i2JcRBBb2BZk0cB60yPjYNv6AUyPRmF5uQ2OFoelWm6UPjXUK9mTDs
         Qi0w==
X-Forwarded-Encrypted: i=1; AKwUvBxhKsKoM5XTvdPnkD1YlbokGyks3p2DAkdFVw1MpK7g4vVKkgZh50qNn0E5qVM3z7xLAp4urbn0kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLrXFnk+8Y4cSTnIn7bQP3LtbBCMSWA3k20rXvP5+DDFvNUJ3i1
	fbl1TPMVBPrukSPvPUC0nqpfzdQLWJFOclxcfq+4mIoyyJMrrqyqbJGbYlr56iA5wvQC9xiElk3
	3vcVC
X-Gm-Gg: AYBFou3RRl2NqJq1eGCyMggqWQNWbc+HWYTncY4kPs6BZ30snUJ+tGXxsjSTVLSNZQ6
	p6vMCxsghAMQMs44jHSrWeU5Vt29+Re6CrQck2LAM7Dp/KcpyFqsheYfOkZPAN0VUx66qhkuyH5
	mlSEXkX2hpkTdoexYAGFKJDW8RlAi0u2tsZJ1h6Kjh8sZFvaozaR2QINcH1/7CiF289goyTv/d3
	fnXqNfmNqsDwuMavDOzCncuUtH+6o635OpIkxi3QphJDv1SzT/fal0j4Q9UNUdlmw99YeR9bYaE
	EePrmx9xyXgwDZrujgDkFVbboSUXrHZ1I9638L0ga7Ug38U5la5cMfyUDzeQ1pW12DAqIV37HF2
	Um0E8JSfXTn05Xrg938YO+2oK4gGhy3raTbycjj44GndWYeqnz/1484AvBFAIQ1P2/e029YYthu
	7q5qtSe0YkxSj71x14Lvf3cItFptb/Cxqs80e9dyvb0ekciKrCPlAxQIhwofrbv+a0ias0tVmhA
	/lWOf8pIkYIhTCTJiI3yX2Rr9fn4ZComaKKJXoG2I5J6D0sAWCRPzwPjmTu7b1jPJtdU/aViA==
X-Received: by 2002:a05:620a:1b85:b0:93f:5892:e5fd with SMTP id af79cd13be357-93f6f58503fmr467858185a.1.1792773026841;
        Fri, 23 Oct 2026 09:30:26 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b12680sm57600485a.26.2026.10.23.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:24 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:07 +0000
Subject: [PATCH v5 1/5] userns: record how far up CAP_SETFCAP reaches
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
Message-Id: <20261023-b4-setfcap-userns-v5-1-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=5250;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8IuY/d3QkcyzNsZWg+ftGcwOPwv9NKh0B+T0u35iHR4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEBTalhVY8lQSjDhhv+N+ALBQMAXX8ndn55BXbUWWRuAtchNVj3NXxJeTlGL32K8YWf0xyfJvib
 e6pgn1ZiZzQY=
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

