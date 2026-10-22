Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694205;
	b=eSX1Xb2qYcQHwXYJjjS+ffYro1sjqkIACijYx3cWPxLaSRx2ckHr8vtCsiarr3BdJSRM
	 MESP58YikzE8gIJy7TedkLI1OlOKysFKsB5X3FelFRZcWLH4fLKsed45QvVbmi5LEP2nX
	 kKL0hK5jaVcV979H/pU3EA9oPozenuvBkVvqGaHkClaL09g6wejJhreC2OKi+Fd4g4NQd
	 Xv3+bNwhpT0Iy9hzQXWvTNV5DFTEbXkbWoUayEu0WBAnbet4Luwq86ji+JSfmNjK6JPop
	 dWXw/Cbgewjl5ZiNpHD66ghe0kSxxaCIjAGn7GetnFhz3jXasc8+pJf/vTQSbK0vbBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
	b=KAgmAVPH+wP0pv9uuRkwSVs+pD5Wccbn0MyDUnXfhO6gJQ+OB0cjdUaEBKDL7eAycRot
	 bDJZBmDDdgwHZxAx4r+dIg0uFn+9o1LO0jD1NWXzCBb8arFMX64o2Zr9NlsfuDSmUHiBN
	 cbLtDPknnfU+ZuFmiSuvcH27W0uYvmSkJeQUvAzJP+WimXW1Q5Piz3SBfrWnZD0/hYVLa
	 lBvkgs/NCGfJ32jyf1ixUh+afgowtP1bse/UG8BxzwSVBD5lPdbgv+jX/DbTL4vONAqvY
	 GLyPkVIbFG3gTPbtJoo6xhjO6lO1s6l0Xq6ZFbMqC4S3pE0ArsxRanjVD8DLdBh8LwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F7z5QRbE;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCB9606A339
	for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 18:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCB9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=F7z5QRbE
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93cbc3ab2fdso3354785a.3
        for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694204; x=1793299004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
        b=F7z5QRbEHW8hNFtC9lVdaa1zTXyrbim1jVDneirl+zVZZRajgDmg3t4LLo6I8nDu8a
         RKIieFupHq+p9BNDrZlca1+DcUMUtlXzaY+uz3/nZCQyn6374BYmXT9UJ7qlIwEokWzF
         DPa0l4+FdMdpqUOlHQNSVyu1bULSLFht9Vp+xtYPi1ZNtqTvHpbwjZENIKQXBkBcy8pA
         FWTf6Z7cIVzuGPE2oatiP1e6+P4evADSipde4L5A/2eRrlYCTSxaQYmn1PyAmC8rrEcq
         Y4dO34r2xxWrgV3C/rruNnuW2dg4UQuMR7qTu/Hs0Bz9hs5NpzYPf8gN4UYgXwEOmWCv
         nPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694204; x=1793299004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TljB+llJAtEltt0X5GuRdQ8uO9LKBKu9svl/N9f3acU=;
        b=MMI2+BHMayJDAB4TSgcsIWvB5pY9TRjHrtgiSa7G0s7+kWY26NUwj+gm7LeVh24urd
         zXhScAoiijOEkQavUbdkSAEcq3J6lFebiLxkSnZw8lir0vTSUAHEL2mrhOXU5xTVh8jY
         HXVSZWghNz8nbJbn47YTzh5viFj0EhwEpdNCCWpni2txM2BxxWmtXaGFQsL0amEzGUsz
         K+RRqr3RKiEO7UxyhxMitHbmQDC7vynnl78o2QBUJITKWB7BG525dmqFkXt1+NZ/d1G+
         VcpUd8S1TpD+SmbP5l2eZZHgY0Ha530g79xcCgZXOfUDriyfZNx/Y6kbb+8Ks0Pngx3B
         UiEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwG3NGtcBiOQUptITD3MYkKUFMEhy3T4UgCLC9vYT+t2AoKNfIzUYc+iTzVnMm2fEzRHwIti8bamQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4xU41RtA7S2xTdZKs8mT6auUSSWXhJj5tBWzZxuIQEGcihOLd
	yY28vYPuITGSE/Vkp51C982f0FPhhksdZwNf+FRXcg10rjRF8sAiUWCtHaHUIwibGVk=
X-Gm-Gg: AYBFou3SgMnS60/rSygGonQMDj1cAxwVwW7bMUlbAEl6rFJLp/niqFfb2yLZoSqat+5
	FmNlGNEOu73GmgqNSruNyHKf3hixCPmRAIFoGGY/eogWN5rqGX70Oo1xiulpxDDB4ocj1BNOlp8
	60HWBoT1nTZCXaX/Zt4x6lFSzl9VSv1T2uHSRBbSLLxcWXaddtRtaM8bDLKQRIs7uFrlnSLLSx8
	iSk4dZOsXs5u6sUKgrF+TF9Xe7jffTFYOHKt/WgK8PsIqWht16IDByJmRqlPqF55CajJWBcY9GK
	lGU7wePu9HAO830MkXeujnLxUXdEdQthm4fTlBsRSb+fl0yXm/xq3Vq9b2qa5P3I6LJMoG8maXw
	u8lOWmKY8Kz9qMpgL8BxGBmi2afRqmgARhi6gKfyS7pwv1dFik3S+/PUeKpwXXsCaNvDZtkZoNP
	39PX+ujLu7lX7sXs9iwnlBbdUSrPntzqgUsKMq0gGXG9ojrKBKHb2mQvrQnQmi0UAwZTmSSSugp
	o8d8Kccvl9RSacvGzFLMgV6LGV3r+/DS150QRjxSSdtenLY05NVjuRZKw8HCIYUTfVDSuZJ
X-Received: by 2002:a05:620a:2b97:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-93f6f941cb5mr51504685a.31.1792694204079;
        Thu, 22 Oct 2026 11:36:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fa79976sm20911585a.1.2026.10.22.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 22 Oct 2026 18:36:22 +0000
Subject: [PATCH v4 4/5] capabilities: limit fscaps to where CAP_SETFCAP
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
Message-Id: <20261022-b4-setfcap-userns-v4-4-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
In-Reply-To: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694192; l=4387;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aZfwbbad7JbWE1sbfyYkODripimDq3vAr36rblWADSA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF3MVCsE+gzeGnl2Q+YtC/TsNj0oxCQUnKW3Si0zQrjO0OC244dOuQ90gD49mg97mO9JhJiHqi1
 k3NoNWYpR6As=
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
through the conversion instead, and is refused there.  Otherwise a task
that unshared without CAP_SETFCAP could mount a tmpfs in its namespace,
write a v2 xattr on it, and have it honoured through an overlay mounted
from the initial namespace.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index b06914223039..655e822c8e76 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -694,19 +694,41 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
-		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
-			/* user is privileged, just write the v2 */
-			return size;
+	/*
+	 * A v2 xattr belongs to the root user of the filesystem's namespace,
+	 * which may be the root user of ancestors of our namespace as well.
+	 * Only write it unconverted if that root user is within reach, the
+	 * checks below handle everything else.
+	 */
+	if (size == XATTR_CAPS_SZ_2 && idmap == &nop_mnt_idmap &&
+	    ns_capable(fs_ns, CAP_SETFCAP) &&
+	    cap_root_level(make_kuid(fs_ns, 0), task_ns) >=
+	    task_ns->setfcap_level)
+		/* user is privileged, just write the v2 */
+		return size;
 
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

