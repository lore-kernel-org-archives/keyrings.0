Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253770;
	b=hSMXSxDAGJYxyAhxWuaGcc+CHiX12Xvi+xQgGfW66MkdFXB0cR5oR7cVoAWImya5czBE
	 gkQV9CUkTr1alYweZRwuXhIpPu/r2pOxdO1YgTS18NxRe0GXrcuinyN7kipcz0tUyNczG
	 732fph+uDKHizlEJPjPw6fFwUpNvPwob2GlxWwwN/6Q2Kgopkf24GRiDZPLPMCtlVDq7P
	 NuJi0xSHAO2p+88brA/50CtmVvqJFfgrlSEuN7iwNDmet9IbWvNq0sNs0LxtMFisviScm
	 yonNJRu6zaEwBgJSdZ7YqZBtplUkmt5VE40y+AUvdbpGI0kY8t6O3n9nHysppep56Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=S7QCKovtSRmz2zqep4Ju41CT+lBr0nj7AVsN7jaK33I=;
	b=IPch59HwHILikoNMAg1llOKz/nCMzqUCWFrV/krYHLH6C3h+e59ODyOJ2x10n8oLtln7
	 N95jA6d84E3yHfWa8RpY1JX5SOUT85UZgsq5IQzL118qA+TKlfJ6/9zHhzDeGYKOEOWmW
	 c3/JUCMiYS4E0G2LPMcDB0M7vuyWDyOheAvELxxiSHZ3OqmbSA9ilINsXLF4u5iiZ0Kag
	 /omlR1WyRiUVEOkHk6bYw2t4/P5b/USnGKXEKO77b9gyfQ3MAbB1Z5li2XXOponzwCwNZ
	 efJNVWE3f5oHoYUtbCOtqaIx2pTlghbYAiArwc0v/gd+Mp8wtoP5JJBeq4mYfHYt0iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dnsh+z96;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CC60A2601
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 19:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 089CC60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dnsh+z96
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e6eb77f0bso108563485a.3
        for <keyrings@vger.kernel.org>; Mon, 09 Nov 2026 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794253769; x=1794858569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7QCKovtSRmz2zqep4Ju41CT+lBr0nj7AVsN7jaK33I=;
        b=dnsh+z96MhkHoxK/3+cgCXE2K7av8U/waEdp4BPWbPltsVOV9WICfQ90cMdOCEsRnV
         HgL3afFrLi1/LJgWhmavusyfO2vN2R6qLm86fmja+GOMaT+eS7fWBnht0A8B5BGI3pu4
         0mkG+CBTw84Ra6RyucKNgyDvSThrLqgDidSqZQU4hyQU3QoLTnIKHbvya7ioa92/f2bZ
         8XLPrI09ZxQa5l/dLe5SgdyFuUv3Zfa0hso8KXLU8dV+7pg0HaOVXtP3Rh9wfmH6jTNn
         kzh4YjmzBJ1UEayLAtzjHZegRAgVMqlVVdNMWxaUADtMGKRv9D1hyk8BvWWRtfFvr2aT
         4DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253769; x=1794858569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7QCKovtSRmz2zqep4Ju41CT+lBr0nj7AVsN7jaK33I=;
        b=O3MPYUYy9jcc7BQY73ey4I3BxWwU2zaqacL5elyRkim5udK8bT9ymUbGtpjTY0DWC7
         JVDky/XWoQUTAXi87rX+fWFEg66hz5EiVir/V70xOvkhkHgYO7Lj06M7G6nnWeFpZcOm
         e4tinldrEVHQDZ1r9WJi6RJnA4s4ASlVxS4PvtORMq33hvW87oeyd4IOLM4oUbav5TPx
         J1HFVnMjnX7KdI1uY4k13TRzY4RfLMOscI7irozIOF9ULnjI3DbA3dpfEGtqsSV9soE2
         xofyGLq4CWB8hETbmufxQaVejRkfTYybZSRIucOsoByHwFmZQ/l03ATzYFvoib39CEMz
         MYEA==
X-Forwarded-Encrypted: i=1; AL+hErG2EZiajNXby5IIWSEBT8XVvPUlMxYAEApKyXtI+Rn8/HShhA2+P1nFk4WUprujS+kRWihaR/hpmQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8wmHv4FGRXNCuwTOzYEa9qKGK8sIaQLaDfolP9sOSZ3DfW+2cX
	HtevVwCVinx96gRhntKe7YbSpWt6l6iWElzJI6FhliJvWz0X8fdBp40pI3lFP6Y3w+A=
X-Gm-Gg: AYBFou09xtxSYCgf2eEGTumBB8oYAivO/OKSWApbcb9bLi9QrodHAOJ/tqrWSQ7XZWi
	KRtVsu0ATFVlqUJ2xa0Vm9Lu55uXUBtBjAz22r72tmPtyXY5/Sd5ONUTS2Dmd9A3zESb9tS6tER
	5/1xe1YeVHVAPPKrDMcsBbNihKJ/SgukO6WtGYCUDZSShd2Xs4L4ru9KJPIw98ulooN9vHr6QtY
	QHoSgTwIv0QO0PlpVaGHczj7+7tTAZyA+QUbED+rjL9Yk7JhPw5hqtMEA6NYimagZXfLMotwOtA
	nGBupQOEvreUAhDopPnBdaOa8RfZZr1v9gvN3k/L9J36oE+BlrsOtCPZsR7YAqSXnPYNsVlNnGv
	pQBxk1W67XuMS3iFtIg3TlAUu+37qIlgL4aoojQtWKjv5d6YMeJxK8+mE+zHt9qrWP9Knjr6yYo
	SmatJi9V8q5mN5KJcQG9ex7ysQe1YIWSQOWCIv4HD46UYBBinVTInshJmZFGpj01gFqrYLO0YBf
	y1n21cvKOOw5jQ+h9creeBWMVRZOzes6qhy3K06avn0Em3yi/EfE35DkQQ8NBpFZoHEkUx2SCp7
	llRSwC0sai1W54pXtOJI1+FDn8/pjDXL52Jfk7/GfeBQDg==
X-Received: by 2002:a05:620a:2687:b0:943:faab:a15b with SMTP id af79cd13be357-9479f31c515mr87878885a.32.1794253768911;
        Mon, 09 Nov 2026 11:49:28 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73ab4bsm50511785a.14.2026.11.09.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:28 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 09 Nov 2026 19:49:10 +0000
Subject: [PATCH v9 1/3] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261109-b4-setfcap-userns-v9-1-0d3f00976ce2@toxicpanda.com>
References: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
In-Reply-To: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1794253763; l=4765;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=MyoI12J2mS6a6d5ICXvJmRkK2bMGU7JBMjtmZLyO6gY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGSqonFJbbSZ2NZMQQ+dnrbmFs4WNW7xsdPuq7j31htqLMJlL5iWw6jhY5KJWRmspfONjO1v8tf
 e21CpO1x36Q4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A uid 0 task that gave up CAP_SETFCAP can get it back by joining a user
namespace that another root task created.  Commit db2e718a4798
("capabilities: require CAP_SETFCAP to map uid 0") keeps such a task
from mapping uid 0 into a namespace it creates itself, because tasks in
that namespace could then write file capabilities for its root user.
setns() gives a joiner a full capability set in the namespace too, so
it can do the same there:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      A had CAP_SETFCAP -> allowed

If A's namespace already maps host uid 0, at any uid, B can set
security.capability on a file right away.  Either way uid 1000 can then
run that file with CAP_SYS_ADMIN, which the selftest at the end of this
series shows on an unmodified kernel.

The check doesn't look at the joiner's uids, which it can change while
keeping its other capabilities.  Containers that don't map the joiner's
root user, tasks with CAP_SETFCAP and unprivileged users are not
affected.

Fix by refusing setns() when the joiner has no CAP_SETFCAP and tasks in
the namespace can write file capabilities for the root user of the
joiner's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  4 ++++
 security/commoncap.c       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 622137f66f09..9ebcdab56937 100644
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
 
+bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns);
+
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 50c374ed4687..34becacaccd6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,10 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Don't hand back CAP_SETFCAP to a root task that gave it up. */
+	if (cred_borrows_setfcap(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index d47ab3022343..0ece141c68a6 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -131,6 +131,36 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
 	return ret;
 }
 
+/**
+ * cred_borrows_setfcap - Check whether a userns gives back CAP_SETFCAP
+ * @cred: The credentials of a task that joins @ns or traces a task in it
+ * @ns: The user namespace
+ *
+ * A task without CAP_SETFCAP can't map uid 0 of its namespace into a user
+ * namespace it creates, see verify_root_map(), as tasks there could then
+ * write file capabilities that are honoured for that root user.  Tasks in
+ * @ns can do that for every kuid @ns maps.  While @ns has no uid_map yet,
+ * they can still map uid 0 of the parent if the creator of @ns had
+ * CAP_SETFCAP, and other uids of the parent without it.
+ *
+ * Return: true if @cred doesn't have CAP_SETFCAP and tasks in @ns can write
+ * file capabilities for the root user of @cred's namespace.
+ */
+bool cred_borrows_setfcap(const struct cred *cred, struct user_namespace *ns)
+{
+	kuid_t root = make_kuid(cred->user_ns, 0);
+	uid_t id;
+
+	if (cap_raised(cred->cap_permitted, CAP_SETFCAP))
+		return false;
+
+	if (READ_ONCE(ns->uid_map.nr_extents))
+		return kuid_has_mapping(ns, root);
+
+	id = from_kuid(ns->parent, root);
+	return id != (uid_t)-1 && (id != 0 || ns->parent_could_setfcap);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

