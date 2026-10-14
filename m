Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4B4A4F1C;
	Wed, 14 Oct 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011456; cv=none; b=GaR9QY9FjiRBcGhC0YuuCEWP16sw4JWXF1jA0IKg7ce0+bat/pdzplW5AnsezZhjHsMCfm+ZFa1SS4okSh/mqdARNaSB+dNnHfAVdflhjQRtRV2ULRanL2OaQZ4sSpfjdVc23atAv1LTPxUxhGB8AFUbGxbjTH6BoZQOTZCnDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011456; c=relaxed/simple;
	bh=LgfXvygZHFJvmfBaXhUTWYvU2EJvFX8zOuzCXAYW+Is=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=YHl9vkNGZ2hQlI+DATyTY9XVT4gGArSrzCml3Wjk5HzVtTtwRdurFtNedqA0y5uyyHWexsZCHJ9j7n0njZistzs10knrmWOh6XCHYsHAUwHli2RPIAobvaQESj6+HcipNlZ3iYD/X6niXC10C/mppxPdViZ4yy8MzX0vFyyNI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=rOMfpMsE; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=h4WxwYJ/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="rOMfpMsE";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="h4WxwYJ/"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792011447; bh=LrJdjhfj6oEWAw3FjBd63GM
	ryVpg4rJg5unfuR6JQGs=; b=rOMfpMsEdaZWSH/GG84wfEAMZ/J1zLgKTnmdPSN4T9/VnrMd88
	7q+F6RGhReC75rRUq1pGLmOO6+nojui8cJjASmiqYCIgXClBuo9sGTC6vkApVsn0Fousiq75TVa
	RfM7zSaI7uXoCZsgih4PECUhlz9ii48RcN+yFRjhH6X4hqUHYFaGn0aXSKYUBJ9ba/4v4ONfAJr
	49/fJU9njZIO9g2laSdBNFtxcxGu1uL2RYUXQkdXFcipgS1sn6qSyHODs0goevfO58Q9ElSUzOn
	u24GvXLkeaSvwdDbI2wfIWThGBmNZXaDsICpJ20Sa9wxm9seXTB/5dK228SsjMTBEmw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792011447; bh=LrJdjhfj6oEWAw3FjBd63GM
	ryVpg4rJg5unfuR6JQGs=; b=h4WxwYJ/A6iegW6s+b10ABGJP16VzERqoQqqoRUWwafRjdbsKV
	SDvzc6xNoXb6rSC1EmrsiNziLYRYbmtGQyCA==;
Date: Wed, 14 Oct 2026 21:57:28 +0100
From: Bradley Morgan <brads@mainlining.org>
To: josef@toxicpanda.com
CC: brauner@kernel.org, dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
 keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 morgan@kernel.org, paul@paul-moore.com, serge@hallyn.com, sergeh@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/5=5D_userns=3A_check_the_op?=
 =?US-ASCII?Q?ener_and_the_writer_before_mapping_uid_0?=
In-Reply-To: <20261014-b4-setfcap-userns-v2-3-fac4d19281d7@toxicpanda.com>
Message-ID: <3789784A-6B41-480F-B370-B0C5E67EDD91@mainlining.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 October 2026 21:47:48 BST, Josef Bacik <josef@toxicpanda.com> wrote:
>verify_root_map() looks at the cred that opened the map file: it asks
>whether it has CAP_SETFCAP over the parent, or, for an opener inside the
>namespace, whether the creator had.  Two things are missing.
>
>The writer isn't checked.  For every other privileged mapping
>new_idmap_permitted() wants the capability from the opener and from the
>task that calls write(), but a map that consists of the single line
>"0 0 1" takes the unprivileged branch, where only the opener's euid
>counts.  So an open uid_map file is a token for mapping uid 0:
>
>  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>  fd = open("/proc/<pid>/uid_map")
>  B gets fd by inheritance
>  or SCM_RIGHTS
>                                    write(fd, "0 0 1")
>                                      opener had CAP_SETFCAP -> allowed
>
>And CAP_SETFCAP over the parent isn't always enough.  The parent may map
>its own parent's uid 0, so its root user is the root user of ancestors
>further up, and the capability has to count there too.  A task without
>CAP_SETFCAP that unshared a namespace, which a privileged task then
>mapped "0 0 1" for, has CAP_SETFCAP in it.  It could unshare again and
>pass on uid 0 of the initial namespace one level further down.
>
>Find the topmost namespace that shares the parent's root user with
>cap_root_level(), and require that the opener and the writer both reach
>that far: by ns->setfcap_level for a task in the namespace that is being
>mapped, by cap_setfcap_level() for one outside it.
>
>This only affects maps that contain uid 0 of the parent namespace.  A
>write by a task without CAP_SETFCAP to a file opened by one with it, and
>a map by a task whose CAP_SETFCAP stops short of the root user it passes
>on, now fail with -EPERM.

Ok. Look. I feel there will be nits on this exact review. But I review
more based on "is this code correct? ", because the users are my priority 
right now until I learn maintainers opinions or liking.

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>
>Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
>Assisted-by: LLM
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>---
> include/linux/capability.h |  1 +
> kernel/user_namespace.c    | 29 +++++++++++++++++++++--------
> security/commoncap.c       | 23 +++++++++++++++++++++++
> 3 files changed, 45 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/capability.h b/include/linux/capability.h
>index 026974a5111b..90f9f976d216 100644
>--- a/include/linux/capability.h
>+++ b/include/linux/capability.h
>@@ -224,5 +224,6 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
> 		      const void **ivalue, size_t size);
> 
> int cap_setfcap_level(const struct cred *cred, struct user_namespace
> *ns);
>+int cap_root_level(kuid_t kuid, struct user_namespace *ns);
> 
> #endif /* !_LINUX_CAPABILITY_H */
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index 330085a7d7d4..7dba6594516d 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -888,8 +888,9 @@ EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
>  * @new_map: requested idmap
>  *
>  * If a process requests mapping parent uid 0 into the new ns, verify that the
>- * process writing the map had the CAP_SETFCAP capability as the target process
>- * will be able to write fscaps that are valid in ancestor user namespaces.
>+ * process that opened the map file and the process writing the map had the
>+ * CAP_SETFCAP capability as the target process will be able to write fscaps
>+ * that are valid in ancestor user namespaces.
>  *
>  * Return: true if the mapping is allowed, false if not.
>  */
>@@ -897,7 +898,7 @@ static bool verify_root_map(const struct file *file,
> 			    struct user_namespace *map_ns,
> 			    struct uid_gid_map *new_map)
> {
>-	int idx;
>+	int idx, level;
> 	const struct user_namespace *file_ns = file->f_cred->user_ns;
> 	struct uid_gid_extent *extent0 = NULL;
> 
>@@ -915,24 +916,36 @@ static bool verify_root_map(const struct file *file,
> 	if (!extent0)
> 		return true;
> 
>+	/* The parent may in turn share its root user with its ancestors. */
>+	level = cap_root_level(make_kuid(map_ns->parent, 0), map_ns->parent);
>+
> 	if (map_ns == file_ns) {
> 		/* The process unshared its ns and is writing to its own
> 		 * /proc/self/uid_map.  User already has full capabilites in
> 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
>-		 * when it unshared.
>+		 * when it unshared, as far up as that root user goes.
> 		 * */
>-		if (file_ns->setfcap_level >= file_ns->level)
>+		if (file_ns->setfcap_level > level)
> 			return false;
> 	} else {
> 		/* Process p1 is writing to uid_map of p2, who is in a child
> 		 * user namespace to p1's.  Verify that the opener of the map
> 		 * file has CAP_SETFCAP against the parent of the new map
>-		 * namespace */
>-		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
>+		 * namespace, and as far up as that root user goes.
>+		 */
>+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
>+		    cap_setfcap_level(file->f_cred, map_ns->parent) > level)
> 			return false;
> 	}
> 
>-	return true;
>+	/* The file may have been handed to someone else since it was opened,
>+	 * so the same goes for the process that is doing the write.
>+	 */
>+	if (map_ns == current_user_ns())
>+		return map_ns->setfcap_level <= level;
>+
>+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
>+	       cap_setfcap_level(current_cred(), map_ns->parent) <= level;
> }
> 
> /*
>diff --git a/security/commoncap.c b/security/commoncap.c
>index a51b9d51d96d..f52f1c7a87be 100644
>--- a/security/commoncap.c
>+++ b/security/commoncap.c
>@@ -157,6 +157,29 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
> 	return cred->user_ns->level + 1;
> }
> 
>+/**
>+ * cap_root_level - Find the topmost namespace in which a kuid is the root user
>+ * @kuid: The kuid to look for
>+ * @ns: The user namespace to start from
>+ *
>+ * Return: the lowest ->level among @ns and its ancestors in which @kuid is
>+ * uid 0, which is how far up file capabilities with that root user are
>+ * honoured; INT_MAX if there is no such namespace.
>+ */
>+int cap_root_level(kuid_t kuid, struct user_namespace *ns)
>+{
>+	int level = INT_MAX;
>+
>+	for (;; ns = ns->parent) {
>+		if (from_kuid(ns, kuid) == 0)
>+			level = ns->level;
>+		if (ns == &init_user_ns)
>+			break;
>+	}
>+
>+	return level;
>+}
>+
> /**
>  * cap_settime - Determine whether the current process may set the system clock
>  * @ts: The time to set
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
