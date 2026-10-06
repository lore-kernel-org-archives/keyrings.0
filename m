Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BEB49E156
	for <keyrings@vger.kernel.org>; Tue,  6 Oct 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301490; cv=none; b=RAt1nrdpq2WKz6oa7KTV6kC/iuJOfge2YORnoCcn3lllWu+NHof+NEEQY4UGP3qtX6lWFCgfeUMvNlAK0UMr+LGON9vQt7gUcwKoDJxpHYD+088Lx6VMdoN6O75KMNaSaNNLiM4tMKBCn/reujwBv+b1U/kWqdjOr5gEbcZPXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301490; c=relaxed/simple;
	bh=mij3C0cjsbygtTJRBmhy3NFEaig4SfdxpjjpfjwpeRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jA0SZnTpAOxNuQqZ14/b9oIRT2J6cM3o5WAkNX/aMvH7+liN14O09Rvkp3WgJGEIBZ+pkDMeAzWDkegfEgcKUDxgq6HpUQ55Glt+s/d21YaFsdAOo0XrAwel6W46ud8irFVWAHP9MZFP9UcOcIq9ZF9m9hANaySxhRDtx3IgGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=eG1A67mz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="eG1A67mz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53440816851so33805261cf.0
        for <keyrings@vger.kernel.org>; Tue, 06 Oct 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301486; x=1791906286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2sCzGhhqb/iySgCjAmMuDIRnuxawG1nlxFkgQ314Xk=;
        b=eG1A67mzE+XZ3vME4Xr9Aafuw+v9Qxq6c/K2fAI5zaqunOj/RlDrFj+kQMMqun53s3
         NzoZtN7FlBezny9Se9uDOKt7JAhiqNh7swfh5h0aW8QopqWIolBktwId7j27T4Wls8bd
         VsIhuWFT5CdK8EpXtFoZKPnQg2XJW3q3+D+FkjTE+XGuzM7NuboGUV9owSS7uWJBxiwW
         WT3hxvshd4b/VkFse35nRTGd4f+5BchofoSDG2jznqiD0tMzY4g5Mfhat4cjnTJjMBiF
         f868Axi0QYOt2p+3sb2Pj33T4McSA/m88+owkFpbmR3/UnVXx8cvFacwCBaX7OXQZU5j
         pn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301486; x=1791906286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2sCzGhhqb/iySgCjAmMuDIRnuxawG1nlxFkgQ314Xk=;
        b=ZXQ0ZRA4BJ/YqqTKq1CSy9RIrFycTGxNfxUAFHNySwYrkY4q/JvPVzR+dtV5r9E8m2
         6fmet8gErmF6mfkpMNhplHXlhZzpTxdtPOiJlUY+aLezLXsylWI0aP4qGz1vcpo+/Tu7
         2BwzAa/q0D1nNnZpd9EVHFAPq9lby0UsS8GgkI9a0MtEj5CllzjTi9KM/g24EbdKB4sI
         DN6bHszx0ekDflKbPKswGbk336FYwHjyeiRwswfvVVqd2gmGS0mwRuOB2/TyDIanZmFD
         hrI/ISyTtuZ3xe1YWKbb8PPFdhG+fv4gorPxFSCLSo957vrPw+P4PlufI0PzyoQYX1KE
         /Fqg==
X-Forwarded-Encrypted: i=1; AKwUvBwcgdFOIWyu5QdJzIGDWgPlTInbqYSBK9uqE0jU4gujVahZe0fJZkYnwJYLbTgiUiOHUudVJz/Axg==@vger.kernel.org
X-Gm-Message-State: AFuF++mNops3ZuhsiFdcN3b/GACOQlrsqesPyAf25APT3JV8ZD5TMVKp
	EWQ85lNM3PD3BEv7fHjOjByavY0uazwInTUiekXOD7WTXM++juBos8YwXe66yj15hrRC1r5BvqL
	v8WaJ
X-Gm-Gg: AYBFou0HgUEjcRYWhMNWBF5FREGD+P/SHPtTmBmAFayH8eCsYKF+6aZH57O4Bf3s7Wj
	LlR2LMMYNaYeUMBRVo69TLD2EH5R+EZNbkxTi2CUSNCVQ4g0LVnKwa/xFJYYyeHvBlsyRseJQ/x
	vPy0iZeFZVEONHBomk5fsK7EDahtx1VwfHXNWdjiReMqIaX4oXEdVyL7VtzxGsHAxnCdeeb5Y8W
	ZcRkvwh50Xrr388acixipJsYBEIsYzjgK1IDlEZoR2k0OhmBNeog5ygG+USrW3QPKtqmSn3Quai
	zg5x1cAJxfr+cWQTgiTS+gnLBf8J/Op7VeMLJGGS6uM8vDV8uuDI/l9JFmrLZOuF1beL9zt5rMG
	W1u9M7ixXd/7ptu1ea9bYtPXiiUW+hVU+BSf2sIgDmb6I9tbozIXXrUvNsDKirj20xQJ53zPNot
	LT96JtAgF1xNsdYhGmAFdyE4+w+9FcJmu/HCeSuPbBWsj6Ql5Um361j/ER/k3r73BrEVuyRh33Y
	QhwhU9qf9RBMVw=
X-Received: by 2002:a05:620a:4496:b0:93e:8232:f6f9 with SMTP id af79cd13be357-93e8232f730mr864086285a.33.1791301485944;
        Tue, 06 Oct 2026 08:44:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca27f50csm1156934485a.34.2026.10.06.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 15:44:18 +0000
Subject: [PATCH 2/5] userns: don't let setns() lend the right to map uid 0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-setfcap-userns-v1-2-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
In-Reply-To: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301477; l=6169;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=mij3C0cjsbygtTJRBmhy3NFEaig4SfdxpjjpfjwpeRE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGseaXIKgnbupOq4erXBXN/Mdy/RR/TriFShi8hyPJVAS5hViYwwe44vvCWuXA0w1TrNZi/USEW
 oZq3BaVnZeQM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  For a writer that already sits in the new
namespace nothing can be read from its capability sets any more, so
create_user_ns() records in ns->parent_could_setfcap whether the creator
had the capability and verify_root_map() trusts that.

The flag describes the creator, but it is applied to whoever opens
/proc/self/uid_map from inside the namespace, and setns() lets other
tasks in:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
    ns->parent_could_setfcap = 1
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      map_ns == file_ns and
                                      parent_could_setfcap -> allowed

B could not have written that map from the parent namespace, nor into a
namespace it unshared itself.

The check for an opener in the parent namespace has the same weakness one
level up.  If B enters a namespace that already maps uid 0, it has
CAP_SETFCAP there, may unshare again and map uid 0 once more, and the
kuid behind that is still the root user of the initial namespace.

Use cred->setfcap_level, which tells what the opener itself was allowed to
do before it entered its namespace: CAP_SETFCAP has to reach up to the
topmost namespace that has the same root user as the parent of the
namespace being mapped.  The old conditions stay, so nothing becomes
allowed that was refused before.

The change in behaviour is that a task which entered a namespace while
lacking CAP_SETFCAP outside gets -EPERM when it tries to pass on uid 0 of
the outside.  The creator of a namespace, its children, tasks that join
with the capability, helpers in the parent namespace and unprivileged users
nesting namespaces below one of their own are not affected.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  1 +
 kernel/user_namespace.c    | 31 ++++++++++++++++++-------------
 security/commoncap.c       | 23 +++++++++++++++++++++++
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 026974a5111b..90f9f976d216 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -224,5 +224,6 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+int cap_root_level(kuid_t kuid, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b45df3a8d82..bd5f9cea7430 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -900,7 +900,7 @@ static bool verify_root_map(const struct file *file,
 			    struct user_namespace *map_ns,
 			    struct uid_gid_map *new_map)
 {
-	int idx;
+	int idx, level;
 	const struct user_namespace *file_ns = file->f_cred->user_ns;
 	struct uid_gid_extent *extent0 = NULL;
 
@@ -918,24 +918,29 @@ static bool verify_root_map(const struct file *file,
 	if (!extent0)
 		return true;
 
+	/* The parent may in turn share its root user with its ancestors. */
+	level = cap_root_level(make_kuid(map_ns->parent, 0), map_ns->parent);
+
 	if (map_ns == file_ns) {
-		/* The process unshared its ns and is writing to its own
+		/* The process is in the new ns and is writing to its own
 		 * /proc/self/uid_map.  User already has full capabilites in
-		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
-		 * */
+		 * the new namespace.  Verify that the creator had CAP_SETFCAP
+		 * when it unshared, and that the opener, which may have come
+		 * in later with setns(), had it as well when it entered.
+		 */
 		if (!file_ns->parent_could_setfcap)
 			return false;
-	} else {
-		/* Process p1 is writing to uid_map of p2, who is in a child
-		 * user namespace to p1's.  Verify that the opener of the map
-		 * file has CAP_SETFCAP against the parent of the new map
-		 * namespace */
-		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
-			return false;
+		return file->f_cred->setfcap_level <= level;
 	}
 
-	return true;
+	/* Process p1 is writing to uid_map of p2, who is in a child
+	 * user namespace to p1's.  Verify that the opener of the map
+	 * file has CAP_SETFCAP against the parent of the new map
+	 * namespace, and not just because it entered that.
+	 */
+	if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
+		return false;
+	return cap_setfcap_level(file->f_cred, map_ns->parent) <= level;
 }
 
 static ssize_t map_write(struct file *file, const char __user *buf,
diff --git a/security/commoncap.c b/security/commoncap.c
index 513473f859be..b406ede2fadc 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -157,6 +157,29 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
 	return cred->user_ns->level + 1;
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

