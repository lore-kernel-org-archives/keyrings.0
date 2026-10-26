Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048446;
	b=uGKh+aFOFUc2luBAz9/T11CTu958KUXiMS5bRk++kiH5sRDhrtn6itR9+iiJ71dTG1NR
	 rE1mSxVmMPmplz3vW37NT+H+SRaBnpgdbgU6vGqr+AuMAWWJRLE0DjAjG+e75Oy6kXCVy
	 QAfQYBUpBHY7Rg/fZd086flXo8pzQo08YvSSi0RzY5l/SC87faq7P0bqStL1Fjorh3Hbp
	 oNjJrZUoxqKeyfS9LnxRAtSZHnZr744KTHqtmaxjo/Kp7M3oxKeYFmhAE8gKnRHx5I6Fo
	 BsOTDQZZMy05zCqHj/RIxDqrzGGFAu4DxNgywjht3v1mlcJOH89dh70/G1lXCNYlk4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=SlE+GD6loY7SaEz5ltXlb5NxzrPftLvvYozFrshERGY=;
	b=1zF+mLxAVB78gxjQmkLTFGEJ5O1XSM4WWX4DdqwIGGkWwiRzkbcgFDl6BnqWTeAwabon
	 bhCH7TUcNxoHh2UYTLvDcCh9FBzubNihRIwu3pJcJy1xlinN7JHNv5gj4NfJuCkUJQWzD
	 /OXz1DqhC82681YjaNwm4R+hsriOMkzQdfQaxXkVzfw748xayOd9CbrT483hB1v2VS+NW
	 42SKN4Pj26J7QzZBn1nabwVrbIdUdfNZ626fGAM2qdkZ8AdkM2BloFqnAcprB6vcNFWYo
	 kINJE1pnhJrm/aaI1Num5U6MMeF75cIAMArGHaBBSPGPZIHOO9jKMLCrxMbyA/djYJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jHYdzlhf;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896960A2607
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 21:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7896960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jHYdzlhf
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53669f7b518so36091721cf.2
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 14:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048440; x=1793653240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlE+GD6loY7SaEz5ltXlb5NxzrPftLvvYozFrshERGY=;
        b=jHYdzlhfYYPEdR4vNyE+g9h3wo0O54pAOuVmlJZlckU3IL5ETxNoipPxDppOopxm3U
         Mh/UJVF0tJ2/zTZD5sHcGGOLRGYl2EZD8hspDVbg+vYGoPA5KIDvtNiNBS13CCQ658f8
         CWKUo+/b1iiV6UceUjNkhSSiOzPMO3nVm2C8PmwTibBb2AuMPDQsuF/Jn4ZYlYe1scXw
         HKngrfvViR2/p6FihmAbImV5Cwx2dqLvm3LDSmNc9z88bHVh8ANN+88FvdKeWHbFdhzY
         xGnzO/1EB1S/yEenC4uhWYxxQiJgJQt5uDHnqJl1y6b9c3rH6P11RdUTN+utcfwq6po3
         Nb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048440; x=1793653240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SlE+GD6loY7SaEz5ltXlb5NxzrPftLvvYozFrshERGY=;
        b=e+Z2lOhJrPTsovQFOEn0S05fykkNORVjh8q+U7tDi+KAjhieal+Yj3dw/EsFIITstC
         JznmXUE8TBUIDhY50sQ2I1gL2jD5wk9M+ldXgRdlFh96W51mV2Zuej/ZWfEhonhHqVQ2
         V0UdnbvEefed6SalktdqYhfSnnyASQhMCxtgSpiSRgztd3QXrh2jA0HDeGEjYEMa6IYS
         YNYxPbnf+W1CDol/AXBsEiay5ja5Z+H5hPmLOQaDPnEaFrjbf26PljGbwetjK/i2IpQl
         5CFGe5ysFqABGVLw4tDUsfrGmz4gGyakM+afN6B6O/pUZJptR+JXbwhfLVLIBcKvstGk
         qiaA==
X-Forwarded-Encrypted: i=1; AKwUvBzXmZvAyYNkOV4zgmN2kU6rQrjbXFP1O4R3PJWyA0rpXs7t/BhgRUBtgG8us8nNTu0XE8fHJcNLLw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLqw2c72Pet7gj/8hrNgsWLKP5ik/ZxsKCEA3f6g3viXjUU+5kr
	9owaWfik0LFIm52vNgGXcCo2HuSyURZb0Wd9yEzd4UMewajTff/qkL26fUhxCpNH4RFQpVmoArG
	6NNAaPtU=
X-Gm-Gg: AYBFou3H4s6hYqFoDQvl06th/k908VPcmYTimVPO+kY9NjVUJZPXbRM5tSmMOdSaX7v
	PObpXNHDP+g2GXVEV7BU9GVMdzgVgi6LkgSgD2mp67LSbfkMfPn5HkBlGMsYxdOf2vJQ/GEHyO4
	pJMzqtIp4gDZALpuBkKwPl5Eky1Y3a8XOS3iHc6hT0OCVZcDvI2xgyYF7drwZgAstRu2swhKDO8
	zObbG7vUk6sBgA0XqvdBCsNq9jVbby0uOTB9GNbLY8uWfS5ZKkIbuP8FrvT/nehLukgDx0o21Qk
	L6r+UzuW0HcraN41t3WiCZMlJQcl7yQ6p3vO6CXkaUr+BtIqenzWoByTRwRBG9cqSYM050+fupJ
	nkLVtAeZNfZ9cEX6YaTEpNrklhl0cP2mmvAIsoAy5h1LUmTVMyxcJLJdSYVVE0Qzyh77D/DB97g
	BWhjQFwllIyT3Ii6nvhlt5XEi/kmre1NQ7n7Rw6sAnBoUZtez+6JA8kDlHgm4wFlamit2pP+RiA
	S1rju7KbUKo6fa9tFcB46Rps45A2wG/olMV+anS1/tJb85Jd8xe45i2J/BzVMu1gqPn4ft5Es8S
	d0EW8Q5fkjpoSjbI4A==
X-Received: by 2002:a05:622a:44a:b0:533:8900:4eab with SMTP id d75a77b69052e-5383b4a973emr130240711cf.16.1793048440239;
        Mon, 26 Oct 2026 14:00:40 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4399fsm83319636d6.22.2026.10.26.14.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:22 +0000
Subject: [PATCH v7 4/6] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
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
Message-Id: <20261026-b4-setfcap-userns-v7-4-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=5703;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FDChG0bx+cXxkkBT6UYSsvtNifUZi0Mew1bpibNMRUo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCb0Jl+OxscNq+G5hjgGZclIM+7B63jlR0/vz8V+m/BDMIKKC5bAz9yM3XgwcSvpCZ+i1rmVoKI
 0HJmLTF//9Qs=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

A v2 xattr skips the conversion when the writer has CAP_SETFCAP over the
filesystem's namespace, and belongs to that namespace's root user.  It
gets the same check: if that root user is out of reach, the xattr goes
through the conversion instead, which names the root user of the
writer's namespace and refuses it when that one is out of reach too.
Otherwise a task that unshared without CAP_SETFCAP could mount a tmpfs
in its namespace, write a v2 xattr on it, and have it honoured through
an overlay mounted from the initial namespace.  If the filesystem's
namespace doesn't map uid 0 at all, the v2 xattr has no root user and
nobody could run the file with it, so it is refused with -EINVAL instead
of stored.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 8a9d998b1897..4e0b00b7b1a3 100644
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
+static int cap_root_level(kuid_t kuid, struct user_namespace *ns)
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
@@ -671,19 +694,46 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * There may be none, then nobody could ever run the file with these
+	 * capabilities.  Only write it unconverted if that root user is
+	 * within reach, the checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP)) {
+		kuid_t fsroot = make_kuid(fs_ns, 0);
+
+		if (!uid_valid(fsroot))
+			return -EINVAL;
+		if (cap_root_level(fsroot, task_ns) >= task_ns->setfcap_level)
 			/* user is privileged, just write the v2 */
 			return size;
+	}
 
 	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

