Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3544BA1C1
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010897; cv=none; b=Yw1I9Epw1KW4qYEUioiw4hojLo0p+X+d+vI6yGO6mq0T4pgi7c37bRVm1537RYdQoBmOvPDVZxRt1y2O3YwSY+vUAE9kn+4MrudX7dXxsFyax2pAk8+Kp/CEx/QZURnMvhI/iGusxaAAtllxBhl89NfTQkaPREQM/iWbgYnOhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010897; c=relaxed/simple;
	bh=8sz1j/DD6WxQjBo90lfB0OuhFUgi5AfzmKju90FziQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTsVhsMMb2vKs5FYBFt/G1kPHzwXJ5VstUFFCrDRL+xhsk3Mhr1RhJsZoBEnRWANQY9vpaypk0mlD7PEFexGuuR0ODVbDyN0WGTxvb5QG+9wGEAh5U0zyXsi+WiK1Vt7Cn+9twdrXRpSdZMQfHaksrVPcBsl0QnaLoAYZiYavoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=CjBYaPKh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="CjBYaPKh"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53440816851so8656181cf.0
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010895; x=1792615695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lyDYY+tJ26xvGx3zliM7a3edHKALJomeRr5oBEGsPg=;
        b=CjBYaPKhHVLuaOpBGzMz9f6uugSzGGKP4S3D+XBNm6bWlLZlphS3kOQkaqbmO5vbWx
         w99AwOQ9WlOo7FhAy2vUpUE3oCly3TXClgXtQeTI8S4rGQG06oxsrrDy6I/lJB3rFQlI
         aMnTbQQ///cZoBfxBh4vVn/aD9UzDhtIItIvs0QuRa7r/4zE3Ah6rB4aVGkSomjNZhuF
         b8NCwGKQEv+/+DFRYI5rYDL52BuxARGE5wmY/ZY65o1Fb1KzVRMj58Np421ZpINY6nRn
         rjyQIzMYz9hSiGNOJKqECnSoGNpdJlesy2xxrG3Q8BY9s34DlsZJMWuU/wXA+clXkoO2
         5GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010895; x=1792615695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lyDYY+tJ26xvGx3zliM7a3edHKALJomeRr5oBEGsPg=;
        b=iBG1KZchJh/WPkh5VzMHoXGFggcBw7oFj95g0BfvHIK+8+u8EvQCU21VJVVry6pg5j
         sce0MzeaAfIytf8s3GETfDXXa9QxENqfv3uPNAEreB0nxT7+y5QMcNLtwTqpdUdOOD2B
         oUmFnN01QrrOMx1i6LtSCl2GtKH8yaTjp15aKzpksELnGbSycrU7hfsR5U8wBN0FFwQT
         +L8uKFVagwJR0BrGMFCk2cakZC5Yv39JR656JdjQIbn+ZLwNs6G2N4TwbeNxu1nOXfWy
         W+sI12iCYK1P14G7FiW1yDtph4TaRutpuAIdkMCxlsdInwjJPkjbEXtN8P1woxvkLSji
         J7mg==
X-Forwarded-Encrypted: i=1; AKwUvBx4KwyQIkb7VUQUA4v3KHMrE9yurxgfpYItjKw5jdvssTXBs+iqs1kZxob9D1s54tUPoFPOf6RTCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIzwquVYVvJcjUFSGhRvJR+4FoiBVXSgli8WfPWb0T6II1RrYac
	mOndFW20rZK96r8kRlFHhWFqEBDGg6w4BMh+IHfusmlGEvYrfUUQ9EPtK2dJPxt9xHs=
X-Gm-Gg: AYBFou0CjmpI+lgdBfEXCa8wJD8zbm4ci8gf8r+ETjyHxOWROy1iy9rGjo+5M9itd9X
	W9oHRbpUsssKVusDkkiUXplc73z4P/j7qLxLF0pjpRrEBi1/lhXBgWa+tHVrLVN4jupA5Hkr6aW
	+ZdZGpJZRmdGZPu7Mc2z7hmEzrfPn28AMT8xNa3e7OC4oNos49fQDmV+w3zSdOgES9Mj/98hAYO
	7f3tqgc7R0moMZfrf5XGXaraaoydldu/GMOvE1trR7dEsH4Kqd0L/bN8wTj+XRwaxi+cGo4WBWE
	JvRQObb0Sg+sYNCbqM9l9vbJ/vR6jT8nMnXXLS5Mfrc+8KgYXZidtVP6ZmQp5cuko4l30C0QtdL
	0nw8lScL8aqqGIIpnO5e6J3i3ELwC79EQfDcNPYZ+mEp1+WVwhSHljTO6Pkg+Z3mpJWZOqQUjtU
	R8Njiyg8auvBVDY0W5RyHBSk2SDI+F4r4tIcYjenD0/lCKjyvYDiMNYwfTxrMpBPcQWQBI25S3a
	i8LHiy+TfdAkLQ=
X-Received: by 2002:a05:622a:5a11:b0:535:85e1:ed5c with SMTP id d75a77b69052e-5359fae84e8mr286672971cf.25.1792010894889;
        Wed, 14 Oct 2026 13:48:14 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361279a933sm6502721cf.6.2026.10.14.13.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:48 +0000
Subject: [PATCH v2 3/5] userns: check the opener and the writer before
 mapping uid 0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-3-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
In-Reply-To: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=6333;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8sz1j/DD6WxQjBo90lfB0OuhFUgi5AfzmKju90FziQw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFLUc10A0ngb/khkJw2po+5G9mbQvHdY67VFdyeSnSkSkE4bIFSM2BO2ucK/miJ8BQvXnfFFQww
 F1pF2LK8TygM=
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
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  1 +
 kernel/user_namespace.c    | 29 +++++++++++++++++++++--------
 security/commoncap.c       | 23 +++++++++++++++++++++++
 3 files changed, 45 insertions(+), 8 deletions(-)

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
index 330085a7d7d4..7dba6594516d 100644
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
+		    cap_setfcap_level(file->f_cred, map_ns->parent) > level)
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
+	       cap_setfcap_level(current_cred(), map_ns->parent) <= level;
 }
 
 /*
diff --git a/security/commoncap.c b/security/commoncap.c
index a51b9d51d96d..f52f1c7a87be 100644
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

