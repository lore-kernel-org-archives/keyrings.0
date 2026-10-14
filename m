Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550F4BE45E
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010899; cv=none; b=MpHpBWoR9yEWstGS13kPRm/ik3Osa8PJChQHYW004GesgO3ZNYCt3ordAtzj1rHH8s+j8tz3b1uQyqDbCna39BqSKO0RkJFrGAMDXDuaEljcprE4LB27+2ikizraUBpjoxzGnx24a/QhRHqOrarUHMm0BxtGVsQ9Ff4n7ZK2MDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010899; c=relaxed/simple;
	bh=yz/ljsX0zsmZtZUSzyzVMVFxg8xWAZZITJvfwDjnZoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrDb/dGSIUtfXqUnJR7nPUPcSCfwK7QGWz0eoXxGcQzB5t0ejHMFN1OriLJYU7EVUOJzgtYBOnrCMej8lThoGXZUOIbzFdUhAsjefKxxZK7sL8P8ARTFOoSvGE/fdohLZfOG+sNPVooRcFq5jSr6kw5HnFcZRBbdnB6mlGmrlY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=I2cAzsDJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="I2cAzsDJ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93cb1c0e851so355203485a.0
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010897; x=1792615697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O6PJ6Vsu/6xTVjkvaAXTBm2OKjtFf/wfZcImncZuPSs=;
        b=I2cAzsDJpEiJeka7tG7Ps8mxGceI9GPSrOxZSiqBQQhM2mq7Lzs1LH573HWDBOcD8G
         ZFd0WExaCcp3URILazR/uIl54BOJsBIyr0Z8lW1L6VTc5Lza0IOBFHC5lfHjPtkkDK33
         B5COJYucPOHnsedIKado0RLkCp7BWq3EWFNpnXNykkmb0PR7SyMp7jxgKLky5k0efNxj
         FrPCVw+LnQpunHDu6XEqzy8cTWW2BDDxV8DSiLfC36/Fael2vOUkJR84VhGr/yWxSXDH
         jZi8+P3BiKdTztuuJLe0ORfBqfg0pVSrSKROSZnIgVBh+3nrDNg7NP6gLi59mFbkPKkt
         Godw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010897; x=1792615697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6PJ6Vsu/6xTVjkvaAXTBm2OKjtFf/wfZcImncZuPSs=;
        b=jZVFWAR1gUuI+fIbY8+oCyc8W+KSUdXHftlWJB1pMffTOd/9eSw+aNJ7esWhN8gAoe
         K0/YVG+tjrgjF/WT/Kx5E93SZyIxCBqg2Zv1U1tiwJJtxs414OgeeD8xdMn0SVkDMf8G
         xwKOgtO4Jla1BGM1N5FVljvO5G3516jlJIUHT2u9FVbde130Hy/nSKFYWoyYMTV/0r4m
         I3UdQOfn3wJQ+V8w3dEhr9xD0e+lDe4S9BDWvYLuJxeuzHKayFjUW1PiODBin9jUQqEJ
         Ft0tOFtIReod7+HyBJnCWD4gkvuQ9P9Jl4SAObtaTbu7egDI5bs5nRNy8/8hs6atWuAh
         yJTA==
X-Forwarded-Encrypted: i=1; AKwUvBw1ueQMt9qYw3JVo9oXVzME0+siJW+ul8udH+ydEoXWsvTlTUIpE9MFPI9HEnr1DggCzitW6gGn/A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJD1t/f/qlJLk34X6YQ3ZIIO7XmyTXP6TOCfmJ1FNVQCZQ0ORkO
	11TGt+1m0lB4tbs0fxme12KtCGsZpacpa0p83rbfBditjxflj/Ga/+Wdeo5eI0N+UMY=
X-Gm-Gg: AYBFou08AwPXW+cteE7ZHnskfbb38IikIHRa/LF1FKDnIeK7QrOBi7wbj7MyGkdRWfR
	twZNmz9Tji+0b/UYXqMyLgI4lBQ7T1Dc8RaIXjyRLVRQkB+8P+G4YR5svD2iyO4MrgHiOVSaVth
	zPNHiqs+yehd1vKBChIu08NdwTLXMTAPXEPNRTPr+IpRtuEd7b7UYalkJVK/rOZ4dgWhvpuEoxx
	Axg9hecMDJup9hlXNzXNKHZw7iEeJd1/r6WmjWoQhpoRdgqphEdhntflqtCEfCqXCOkDrzL7HN5
	OvMcoD5TugpXYdndxq4/2kH7mpp7Y7v/cwj0godEOlDEE9X1lW+BB+rNvZyjv/jB9gmXN0HiSTC
	t2J6+p+DiIzrZxlVcmkvRnkLLOPC4o7O5cQhcyAqHp4rCQJGNMzzgK34PHT3jCS2GGLGoi/QXPS
	Ts1h2yy10k58IeGz1soDI+3clEclrJ8AZbwxgRiC7Tk/UwmVj4rAPIiIF1goZUhZHbzd+S4U+Op
	3zG1eZ4ucrqjPw=
X-Received: by 2002:a05:620a:a7dd:10b0:93e:f0b9:505a with SMTP id af79cd13be357-93ef0b95671mr867809385a.58.1792010896728;
        Wed, 14 Oct 2026 13:48:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50080aasm588523985a.14.2026.10.14.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:49 +0000
Subject: [PATCH v2 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-4-fac4d19281d7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=3016;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=yz/ljsX0zsmZtZUSzyzVMVFxg8xWAZZITJvfwDjnZoA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QItvq5f13UpqrDRjEY0E2EsO4PlV1hqDHH2LfE8qTXjZ/Prj/Fa55wgA+40Z7Y6Ksz5LPam3uTB
 1mNaPRQBY1A4=
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

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index f52f1c7a87be..2cae4354aeae 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -644,10 +644,24 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
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

