Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773031;
	b=295lWYI9xE/+zwEcsnp0T05Hk5SwtkT8TRDvzOb7taPwriOKqnJqpuUDFGEbtSnUT3m1
	 M/VBNkrXWWCnvuI5Y1i8BC+CYAwGMgB0eo6V0JCfo8vWq4Bty/T2MY8qqH+cwPXQC+orp
	 wmNnDp2dJVRFK8XOsgFyQm2t0T0sq/5lFhJ7PpFYR3P2c1aZKnvYNVR2f+ULwBgB8JeWh
	 3mhyzbGlZ4jrCnDhR+zVX7a56RYWQ+sttIeeYwrn7lAajFvlhTCHsQ2E2Ml/i0ZvAWtI/
	 ReYyIQuYZ8fJtoynFgw6ao7bKvMCz9sGeZ6grRSLKTdtv29o5p9bDxbW6EQ8sGv3Evg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=1UZjft8nQvz6OiTVQxK0RQW/RseaKSMhOjO4XZ1MWImynD5KzJmLPLJN/NnKd5uc6jyT
	 U8Q9/OVZKCqTpz9mIwNVerV/Wo3FoO/ITaGfqKmSEtLfI30HN/2LO0v1lTc+z4c/RS75P
	 usjVku71yy0tO+E/FY4gf9K7RsWVr7vSRaY0l1ieH6ilQs6y4yqC1R0IMXfVPgIQcbRbJ
	 GYs3gmwJrnY07AIwhqTliguvwXQtDGKHeBhVV1V6Sg0VUFvTwEkYr7veU70crcGWPV0zt
	 FlnyeSha6lsgEHxszbW6CqYFAu/ukcBBoHdzoaBlRaSZTJkwpPKmZDTsI3WEEoZWBPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Eg0DI9sn;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34068606A335
	for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 16:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34068606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Eg0DI9sn
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-537548b811aso2377181cf.3
        for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773030; x=1793377830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=Eg0DI9snt5My0sv+YEzPYCpV+u/w6o3PwIj2s/JtkMmoJzU5N6Y3sQmwmrVs5eCfST
         5hCAkRXPtWyk7Xz4w6Ohk25k+nW14MWApZ7Ti9eDCuF1+lKap8MS0kEXmui2WkdM5LNY
         XM8UwR54MhqsMmExkuTv/ykzg4HPsgHPuCSrt5SBZvhYzzYhPWnEiO3r+UcIgutH78TX
         xid3EaYb7wg6IColU8rtKtETLMniDB/Xv5k/oBlXP79u2EZi8tSwNDzwqRoHORuvv9X5
         rcUudSTwhDjS6xTER0AnhlhCnbrikDMJFeD9aii676jErJ5argoG9qNRuJIVRHt4dGL1
         NxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773030; x=1793377830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=RYQGeCR8HY+4M8lN7GZKPB89+kdJL8v/asUYj68iQS9kI33RZ89olijqTXKS60Kn//
         8HosGQoIoJjxZya9HbIv45q4DSyDsl/E6G0EMJTZXGzBfXpArIu8QlphsCG+DXeGBbsU
         bs3aabW3Ek9Y8Duj1pAw6XIpMEtTAlFz+P25Z9FTBvtfcVCbIGU6JXnFCco6AX9VmThu
         5QYi0tWe2AeiKZ9oXzJoCiw9ELi8SBwNYYX7FUwUhi5vWDgWWKxTkwnVEy0RxISU9bTW
         0qa713mp2iZMij+XgXiBEnM+GWVMIlxBiuaxFAqQ/4ExqG+XKtj9A8doH8ttlli6L5Ds
         IRsQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2mNrCSadnXuilJQC15UHIwNIr+yfTR1R6Una5RC8/aSJti65bt7ltyefyLpO0FNjeEE7EXwJq0w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIknXrwyxVjR5jCz1JDUqzWOo8qGhjMcFwa/kqp7TiHITJbmsVV
	T6nJ/n4WRNoHwFxSoLFFbg5jY/WLwpO5ACco4ES+kQ2Orx7Wb/d9oq2M7S+BGs0RM14=
X-Gm-Gg: AYBFou0kPgYpTF5c4kR4tgg4NQclmetHqgS2H+QjLlt8TnJoloCiFZD67bCxOHG2ie/
	AduGYjC1OoDmLYtkyUYfjHYbUMFmdBCtu8Fga1mzAPyfJgQx3M9exKOAD2F1Fb0zH01PR/CnNCj
	RG2qTIEap9k3+s9knnw32t3g3GSzaHIOnT6D1UNo0VEd41T2dL+13Q1YJWDy8j/DiITK3qoI0GK
	0VMLvuumuTZopN5V/qLuJzTQIZxdhEFbYmlKElLQXD11l/jNIjtGN7k+bcfCNt0LwQGsXwWSAQF
	l+7ksmsQANMlUxw/+BubjGd4RQadbwPUd8HZbiD4XE8XlJkOrwc/pz/rPF9gpIabhNbb0z/mcC7
	FyF0wVsIUNLJZiTDVKaTI7wEg1A9qqAp4KPTeBnLxATLwGfnV9hvFBmTGTsN0qeDx+2xf5vzcJS
	tECA8cJ2cUvWnKceYCMSUoFAMcernO+UMTPW9HgakOSPOGpiSJION+q6+A2JVm/fUQdqP/QRcF1
	RIVmW9U/X6F6e75NLHiHVOK4g/dQcgI5llxqhX+OstZ275gJy9hbJ8XPXsyox+TW4ZlQ2Us
X-Received: by 2002:a05:622a:c86:b0:536:2e47:f5ab with SMTP id d75a77b69052e-536c2136769mr38971691cf.9.1792773029863;
        Fri, 23 Oct 2026 09:30:29 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836c4c71fsm1340051cf.25.2026.10.23.09.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:08 +0000
Subject: [PATCH v5 2/5] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261023-b4-setfcap-userns-v5-2-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP2Uui21+ven36CKL6xikVUA2x0eTMOw5aUJbW4U7EVNW7o1QZuGQlTLSPgO8CVPWQ1SorTk+55
 4NE3zF8AYyAc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  A task that is already in the namespace has a
full capability set there and can't be asked any more, so
verify_root_map() goes by what the creator had, now ns->setfcap_level.

But setns() lets other tasks in, and they get the full set as well:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      ns->setfcap_level is A's -> allowed

or, if A's namespace maps uid 0 already, B sets security.capability on a
file.  Either way B ends up with file capabilities that are honoured in
the initial namespace, which it could not have written there, nor in a
namespace it created itself.

Refuse setns() into a user namespace whose tasks can write file
capabilities for the root user of an ancestor that the joiner's
CAP_SETFCAP doesn't reach.  That is the case when the namespace maps
such a root user, or has no uid map yet and its parent maps one.
cred_may_setfcap_userns() checks it, and cred_setfcap_reaches() is the
comparison it and the later checks use.  Then every task in such a
namespace is entitled to what its setfcap_level says, and the checks on
the way to file capabilities can go by the namespace.

An idmapped mount can store a root user that the namespace doesn't map,
for example a "0 100000" container whose rootfs maps 100000 to host uid
0.  That is a deliberate setup and up to whoever creates the mount, so
it is not considered here.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace that maps the root user
of an ancestor, and was created by a task whose CAP_SETFCAP reached that
far.  Containers that don't map host uid 0, tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces are not affected.

Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undurchdringlichen-35666eb62cff@brauner/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  6 +++++
 security/commoncap.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 026974a5111b..e4199b03668b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -224,5 +224,8 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level);
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..7bd3692c2f3e 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,12 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Tasks in the namespace may have CAP_SETFCAP that counts outside of
+	 * it, so only let in tasks whose own counts as far.
+	 */
+	if (!cred_may_setfcap_userns(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index 4f49dba65426..8a9d998b1897 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -158,6 +158,64 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
 	return cred->user_ns->level + 1;
 }
 
+/**
+ * cred_setfcap_reaches - Check how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ * @level: The ->level of the ancestor of @ns it has to count in
+ *
+ * Return: true if CAP_SETFCAP of @cred counts in @ns and in its ancestors
+ * up to the one at @level.
+ */
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level)
+{
+	return cap_setfcap_level(cred, ns) <= level;
+}
+
+/*
+ * The topmost ancestor of @ns whose root user tasks in @ns can write file
+ * capabilities for: within @ns->setfcap_level, and mapped into @ns, or into
+ * its parent while @ns has no uid_map yet.  NULL if there is none.  An
+ * idmapped mount can store other root users, but that is up to whoever sets
+ * up the mount.
+ */
+static struct user_namespace *setfcap_top(struct user_namespace *ns)
+{
+	struct user_namespace *seen, *p, *top = NULL;
+
+	if (ns->setfcap_level >= ns->level)
+		return NULL;
+
+	seen = READ_ONCE(ns->uid_map.nr_extents) ? ns : ns->parent;
+	for (p = ns->parent; p; p = p->parent) {
+		if (p->level < ns->setfcap_level)
+			break;
+		if (kuid_has_mapping(seen, make_kuid(p, 0)))
+			top = p;
+	}
+
+	return top;
+}
+
+/**
+ * cred_may_setfcap_userns - Check whether a cred covers what a userns can do
+ * @cred: The credentials to use
+ * @ns: The user namespace
+ *
+ * Tasks in @ns can have CAP_SETFCAP that counts in ancestors of @ns, see
+ * cap_setfcap_level().  Check that CAP_SETFCAP of @cred reaches as far up as
+ * tasks in @ns can make use of theirs.
+ *
+ * Return: true if it does.
+ */
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
+{
+	struct user_namespace *top = setfcap_top(ns);
+
+	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

