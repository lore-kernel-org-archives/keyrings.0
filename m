Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6349F106
	for <keyrings@vger.kernel.org>; Tue,  6 Oct 2026 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301495; cv=none; b=tUMCWK8krshi8XQo8moKRtyS3QmjhJPXmuHVfE1hPM3Cuowsw8pUmtufhPeLEb/coazGRvUsJCshZj9b41W7rj6BW4jd+sMZ0JY1w8c1FggzQFSr/dxBQPC03UuTHNvaPxCUkOUfvcQ919TdbCSFaVteV3Qnj4qaaxEKFiUmClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301495; c=relaxed/simple;
	bh=E1rZootfw0BaVJgco43u4aUhbhbXqY00PRfewdfJt9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrAH/OPKPiEFSMqUMsR6ZaKUq3DcG/q58q8hQY04T0i3t3QBt3Y3lJqXRJpC61lFUSxDtbykTVZpMWHdnAbZZ7aCDRyIEHhxBkbfX0ZNuLwyjTbj2G6HPrKumak3JVB7H/kloEK91HGnJXh8kbSzMlwljYPomfMnimYBC2UgIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KQr8gLPB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KQr8gLPB"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533972e0cccso6259731cf.0
        for <keyrings@vger.kernel.org>; Tue, 06 Oct 2026 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301490; x=1791906290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kaO/BeZ1hBqRmUEbghNIWTLKJsn7PkodEnaWDOwIh8=;
        b=KQr8gLPB0kQ7qMRCQfgbqn+O620pr96nGegYxrOnz7N2gHFgXM3ZsGjjY792YjIM2Y
         o0wQnhywTHcIe+j9gk9Gn7EGdHHbGjgJ7K8pbKZIXgdPu0nd3U0UZ8YE5y3GvojQ/wlF
         u87G9uZ/1o6qAhfH29jIp/v54HB6J1dv5AuI+Mb5rJx6Gx2KOIiBeEOynGpShwCD+yd7
         5lO4QAK7v4QcuGgAyu1e6kHdahGwLzm7kdzk8E35Ruoz0nFLoMjFkw0ZjcO3NWUZUVJg
         0AvCx+nEwDnLGNk7nd29L8GS08Im1hskqpSQeVU2onuoieOZ73Rj6ksGvL5Iv/uKqYiD
         G9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301490; x=1791906290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/kaO/BeZ1hBqRmUEbghNIWTLKJsn7PkodEnaWDOwIh8=;
        b=aaNFSLgYwwRj3XckQ1CQjcg+F/jv2j+K8Uwuen6zBPulmpOrv4+DpAJIHk6w3IhJ6f
         GD2jgATsz879QSoor4sVFdvW0bIcUpaOR3gVGDYQjaN4dd6rRCcK7Vrbn+pFSEhhnXbq
         jkO7hjzdZWI/1/FxrJfaiNcqgOprljT+UoygfCA+sF++mQBPGZRCF5C5B7lsW0DJ/mAL
         h80eIkQwjleD8nJ6BiMDInPnuZbaze5u5WoiWTfplV9RJ8NG54zk+zANZcVeL4D+/NI4
         4olfszLS60JwYuSReFOKmWIh+cgJhvimCe8o4nOfIwU8u8MHVnomY4KdxaRm9kjqsVvh
         HXGA==
X-Forwarded-Encrypted: i=1; AKwUvBwEuKKR18GZyBe5oOujA6zHKmMANGHhVKRbkPeuqxRnxRNoZrLxeLF3K+2XuLmqmu3hSM8jJEI/SQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lOpS2WwzzAmuP0gXeq1BEoXkKmn8EbdXuhV41nBENaNpD6AahT
	+ts1EkD5dklAyj2D1KpuLOmg4L6bCVirUP43huENrg/rqF55mibrZ7i2yjwe4aWu+TEoGYm58WT
	naY87
X-Gm-Gg: AYBFou2efWZy6udKEnmPjyXf4dhqq1Zwvtq17Z44L1NEU67zpdkGG+4/aD4fRClHjfg
	OFUIQZ3n41zXOdUQQVeZBoF9ZzpWNW1GlikLCKdSxH+9reL5TRJLzpr99HD1IlqgtD44NXrtNx7
	pmr3LbBHoikF41otfHsoOab8Ms2sEv9/+oX/O01FEOZC0BGkbcFd+xRoMpKmdWoo3E974bKpPiE
	Vt/OYSIyFriOTcTLFeETehLv2QQ4+YLmPUEJEXnrnsm/snawlX1IQDXQJ2bne7itArf3GUT6ZdV
	9+fJonNH2cGuYrdMJ8DojyW4q4T5W1KV4WHObZTR6AUXWAYbbtxr77FbN7qgy5BDjCFtrDAIQQR
	FOOJL02b6jHgv/fCJ1g2a+C9itWxrI5jNyblni3Yn8GamfuNw4h7XfivWJFqJeSlhvJhp0//BE2
	lYDQ8UiQ7bHf6Drx9FTU3vpFG8/zy+tMXBM/JI+rCHVKfsXpxCQltHpGKaHOyrSEnpfPYwz/ixz
	e+NUhaOTFrxsSE=
X-Received: by 2002:a05:622a:1f0d:b0:535:1ab1:9046 with SMTP id d75a77b69052e-53566fba1cbmr33686651cf.61.1791301489859;
        Tue, 06 Oct 2026 08:44:49 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398d438ccsm123999661cf.30.2026.10.06.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 15:44:20 +0000
Subject: [PATCH 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-setfcap-userns-v1-4-f47e7ed66072@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301478; l=3137;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=E1rZootfw0BaVJgco43u4aUhbhbXqY00PRfewdfJt9k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ0asHQ8ANUUYwRFoQCZNpg1bUWHerEkstImIk5QC/dPWZ1mhKNyFNQGF7IKAcSNmZOC5eYTAi2
 CVMOoDyoxGws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that are
then honoured outside.  It does not have to create one, though.  Any
namespace will do that maps uid 0 and that it may enter, and it may enter
all those that were created by uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
  write "0 0 1" to uid_map, gid_map
                                    setns(A's user ns)
                                      full capability set
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
                                    (back in the initial namespace)
                                    execve(file)
                                      file capabilities apply

The map does not even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which cred->setfcap_level tells.

Tasks in the initial namespace, tasks that held CAP_SETFCAP when they
entered their namespace, and file capabilities for a root user that only
exists in namespaces the caller came into with CAP_SETFCAP or below are
not affected; that includes everything an unprivileged user does in his
own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index b406ede2fadc..26798d62e6b1 100644
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
+	    current_cred()->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < current_cred()->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

