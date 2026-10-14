Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038D36DA15;
	Wed, 14 Oct 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011360; cv=none; b=M/gJOE+UBd+Q8cJ1+YZK9JfbK9DKQV7T+/ITUH0n9IyczviRKXwtWi3ObTlJc9iEfFNgIk4anHdvdMSjz1JDXxguV5p2x8eVIDjHvdk6gG81t6j82W6ghm9q+wqsq8QXcp3KBDqhvqwhaU8U1iY0898KZMgTaMprJ4erkyMcnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011360; c=relaxed/simple;
	bh=GqFmgvdylaoaC+1+rRZIx99YFQeJm7aOKUcQbNMPn98=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=F6DueMoG0Agmkevvz8tMJswliLPYxcEl8KyPUzv6gAndumNfahDNVSi1eJ8pM+FZPs+24dcaNeDQURp7S8Sg7Vc+4QSu5BXyjNd3utMUiXR235HmP6Kc/d4evbtA3n/mxdiRWD+BbBdsYCzpwu6JnPNek0n8zS41wyXatNOK5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=DbVoMmK3; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=/1RyinPZ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="DbVoMmK3";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="/1RyinPZ"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792011354; bh=6P41Vaxm9IIsKwbBFd6ciPx
	AignuzuGIZzXHrnj4B68=; b=DbVoMmK3ThOdQ4D1bBkgFrnnuLISweCNRqEO48tEljHo22Fz+0
	D8wI5UOA+vXJ7ylDFohwJh8flaMePHoQ2eytJ3A4/uW7TZ9YT5JrWIv/25ZCEoC1sNAAp3NvBpq
	VyI+/eDcv668XqDwcwvrGiUcLohR3/Zds2TTioh0Crl60e9NfVN+iz2djrEq/pjN/npo90sflYi
	X0V45sIdgr5l2xvAZb0i6VERR+VaI7JkGCWexPyGb30KAaAYrxld0+UxrE+SzuzXxMIQNAZFx1I
	aXGU69Ex4NauZ5vb/4ZUsY5rkamfR05MZiSJJjfAXE3Wy4c7SXJk0H2jI9Poo28Wg1A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792011354; bh=6P41Vaxm9IIsKwbBFd6ciPx
	AignuzuGIZzXHrnj4B68=; b=/1RyinPZIgxp54oyLfQit5EAPFcd4G8nILn5i6alTf4fSTF5Gn
	Aiqu+jSO6GT1GQ7yswiFwkfXL36TMPK/ZqAA==;
Date: Wed, 14 Oct 2026 21:55:56 +0100
From: Bradley Morgan <brads@mainlining.org>
To: josef@toxicpanda.com
CC: brauner@kernel.org, dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
 keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 morgan@kernel.org, paul@paul-moore.com, serge@hallyn.com, sergeh@kernel.org
Subject: Re: [PATCH v2 1/5] userns: record how far up CAP_SETFCAP reaches
In-Reply-To: <20261014-b4-setfcap-userns-v2-1-fac4d19281d7@toxicpanda.com>
Message-ID: <1ED6E2F4-211A-4E2A-8FC3-C06FB35D1A3A@mainlining.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 October 2026 21:47:46 BST, Josef Bacik <josef@toxicpanda.com> wrote:
>create_user_ns() records in ns->parent_could_setfcap whether the creator
>had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
>when a task in the new namespace maps the parent's uid 0.  A bool only
>describes the parent, though.  File capabilities belong to the kuid of a
>root user, and a namespace that maps the parent's uid 0 shares that kuid
>with the parent and possibly with ancestors further up, so what matters
>is how far up the creator's CAP_SETFCAP counted.
>
>Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
>namespace counts there and in its ancestors up to the one at that
>->level.  cap_setfcap_level() computes it from the creator's cred.  A
>creator that holds CAP_SETFCAP passes on the setfcap_level of its own
>namespace, one that doesn't gets the new namespace's own level, and the
>initial namespace has 0.
>
>verify_root_map() keeps checking the same condition: the bool was false
>exactly when the level is the namespace's own.
>
>No functional change.
>
>Assisted-by: LLM

Hi! I mean, I'm not a expert at this side of the kernel, but on the userns
side of things, it looks fine and *sane* enough to me (famous last words!
:d)

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>---
> include/linux/capability.h     |  3 +++
> include/linux/user_namespace.h |  7 ++++---
> kernel/user_namespace.c        |  4 ++--
> security/commoncap.c           | 26 ++++++++++++++++++++++++++
> 4 files changed, 35 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/capability.h b/include/linux/capability.h
>index 622137f66f09..026974a5111b 100644
>--- a/include/linux/capability.h
>+++ b/include/linux/capability.h
>@@ -34,6 +34,7 @@ struct cpu_vfs_cap_data {
> #define _USER_CAP_HEADER_SIZE  (sizeof(struct __user_cap_header_struct))
> #define _KERNEL_CAP_T_SIZE     (sizeof(kernel_cap_t))
> 
>+struct cred;
> struct file;
> struct inode;
> struct dentry;
>@@ -222,4 +223,6 @@ int get_vfs_caps_from_disk(const struct mnt_idmap *idmap,
> int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry
> *dentry,
> 		      const void **ivalue, size_t size);
> 
>+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
>+
> #endif /* !_LINUX_CAPABILITY_H */
>diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>index 91232053775d..f3753b6b6d29 100644
>--- a/include/linux/user_namespace.h
>+++ b/include/linux/user_namespace.h
>@@ -86,9 +86,10 @@ struct user_namespace {
> 	kgid_t			group;
> 	struct ns_common	ns;
> 	unsigned long		flags;
>-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
>-	 * in its effective capability set at the child ns creation time. */
>-	bool			parent_could_setfcap;
>+	/* setfcap_level: CAP_SETFCAP held in this ns counts here and in the
>+	 * ancestors up to the one at this ->level, see cap_setfcap_level().
>+	 */
>+	int			setfcap_level;
> 
> #ifdef CONFIG_KEYS
> 	/* List of joinable keyrings in this namespace.  Modification access of
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index 50c374ed4687..a5a94367600d 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -125,7 +125,7 @@ int create_user_ns(struct cred *new)
> 	if (!ns)
> 		goto fail_dec;
> 
>-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
>+	ns->setfcap_level = cap_setfcap_level(new, parent_ns);
> 
> 	ret = ns_common_init(ns);
> 	if (ret)
>@@ -921,7 +921,7 @@ static bool verify_root_map(const struct file *file,
> 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
> 		 * when it unshared.
> 		 * */
>-		if (!file_ns->parent_could_setfcap)
>+		if (file_ns->setfcap_level >= file_ns->level)
> 			return false;
> 	} else {
> 		/* Process p1 is writing to uid_map of p2, who is in a child
>diff --git a/security/commoncap.c b/security/commoncap.c
>index d47ab3022343..a51b9d51d96d 100644
>--- a/security/commoncap.c
>+++ b/security/commoncap.c
>@@ -131,6 +131,32 @@ int cap_capable(const struct cred *cred, struct user_namespace *target_ns,
> 	return ret;
> }
> 
>+/**
>+ * cap_setfcap_level - Determine how far up CAP_SETFCAP of a cred reaches
>+ * @cred: The credentials to use
>+ * @ns: The user namespace of @cred or one of its descendants
>+ *
>+ * File capabilities belong to the kuid of a namespace's root user, and the
>+ * same kuid can be the root user of ancestors of that namespace.  Every task
>+ * gets CAP_SETFCAP when it enters a user namespace, so having it there says
>+ * nothing about those ancestors.  user_ns->setfcap_level does: it is taken
>+ * from the creator when the namespace is created.
>+ *
>+ * Return: the ->level of the topmost namespace, from @ns upwards, for which
>+ * CAP_SETFCAP of @cred counts; @ns->level + 1 if it doesn't even over @ns.
>+ */
>+int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
>+{
>+	if (cap_capable(cred, ns, CAP_SETFCAP, CAP_OPT_NOAUDIT))
>+		return ns->level + 1;
>+
>+	if (cap_raised(cred->cap_effective, CAP_SETFCAP))
>+		return cred->user_ns->setfcap_level;
>+
>+	/* All we have is that we own a child of our namespace. */
>+	return cred->user_ns->level + 1;
>+}
>+
> /**
>  * cap_settime - Determine whether the current process may set the system clock
>  * @ts: The time to set
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
