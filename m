Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773045;
	b=AKgoE5gTmj//eeSKY5Lfv/N0PhaSAhqpOpWTYpFLGDNYJCLFWKZcwLJuQf1jloBIngW1
	 abvU02him96ZAiHkGSdbJ2xFBuj9XhiTIy3F7++Lik+TANakOIYkx5KRG+joE2nGTM63A
	 yDC57Y2YpngWgKAV3kcVXGXGfsYfIw9zppI+hGKgRYV3dCUSRlm5d7xgH2PasQreebQ8E
	 1avhaihiIICPkJvFFxAoacouAlpxsooG1YNgnwm0hQnyh5C9XkevtAQlIirHKrW2q7zKJ
	 Xtgv+dEyeLAIc6ErChG6ARHChk7liRKmh9T/+f9VQLahNds7VezRhBsrhL1rWenk8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=io5/MpSeIQWp3vBhDjdx3L11KeuWUQPvRmdm96EA+Fs=;
	b=kUkVguFtXxDGrYRa/JP9ZIWrdo9sSZTpGYT0BgMQcgBXfd+/8ET87r9k8B8VvIfLOEf7
	 38EejeyAKWls6VdGjAPxb4wRfGkngFxYqYO9htLg6c2KtYUmD2NQR4ON8LzE6IMz4vnvY
	 9YfJyIrGuk/OnNlVQY068UF0SEfjOcBIgrF/hpG2MgnjTAyhzRbcxKg7D3sdHdpHF5no0
	 hUJrSmGRdfR97+1EqcgxJfZrgx1ZzQNO7zlg/bBKst5JFhgNFjgof0DuLe8sKps/IrUKF
	 di7tdwDVXqW1U42W5zqPVCFANL7tSZqqCLBEtyu2k4KCqxt6/4XxKuVJOa8K1ONREnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GMw6NVZV;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913760A260F
	for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 16:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1913760A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=GMw6NVZV
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5366ae57896so10620121cf.3
        for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773033; x=1793377833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io5/MpSeIQWp3vBhDjdx3L11KeuWUQPvRmdm96EA+Fs=;
        b=GMw6NVZV1jEvYMKDtyiB9Dqfmm5UQjoD7fvwclYPC0s8FEyTRWaAb65XcARn7laXS7
         jDJ9nGQ3ygxxCqrb89ssUvISb6XAkGRgEhzcoOfimGNpzTnaz4ZiiRnj9YrhW9sTMzfO
         mYUHBPKk863T9V5vFSfFItBWQBmfrbHpLPdyysIeoFzdZ4w1Wf8ObJ56SJ2TWKM7MYf8
         YxfRpaLnB5+7aWLotK2Wc/Q5xh68mlR4zwDvbtMmP9mXKFLRVBKlGeGPVEM4Bd6JavWa
         fgGxEvhJcVvlq7PMXi2EtxykgHPIOlBnInU6YOngu2PWN8tnzkTb+nysxJCmi6uIW2mE
         i0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773033; x=1793377833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=io5/MpSeIQWp3vBhDjdx3L11KeuWUQPvRmdm96EA+Fs=;
        b=pCJYShp0gbe/nVxRpPIU8GjNzOiHNYLGLgG7rLPionoYlf8PYXSZMtDJ9/OGsqMJgn
         uVmAHLo5DHWkOCgtmdxXt4f3Q1rgG+D12a4TIaqK6WNnMiFgWoq7Dtpst7LGLBh4ROWQ
         sDFvVcOBa++jT3de5sjwrl9z3LojVkesL3HfuucpfuyjQu5ARUevo20HjUQEmj2WtkE4
         nzUj/C+T4dRic4+evqb5ogAVgSnC+RabnKU77Wq6roBMQAMqBAoWBvY0KakZNO1mwqgp
         +1K7GHB/7ZYm6iZEm2z+jGs/xrm37MbTLuuPJWO/snj6gvRTLaM2DCeBF9Cy4EeIP4Ik
         cUUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEFtW58WBYCnnTEpucITtBvUZtVFa1b6hSs+Mjd1mXdEL4VxdTMVhqn4L1C8wqbxzOrLcjHA8YWg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK4um6M/AQcwm74GCGeEA0m7Yo2i1rP4o+8m3paIfhPdFC7cT50
	zvfOiS3eaxtL0oAmhc3ycdy2u+XTww2vyQ51/QTW0Rn8JCjdE3EKL+Q15hfk3hbJb/Q=
X-Gm-Gg: AYBFou3DpspoMN5te0WyPm0N7RyYC7TpxgCEh6saWqRz/QVCw2UHnq0FckziK+KKFr/
	cBg2vFYw+8uFRY+Zz5oRXtJmNv3lLL/GgXYDD0wAZnTsiABzrVXelc5hkv+EQc90FE6E3cudPoy
	Syl6brUDleyqaw0kBEExP0L2USYmPD38QnIlePsgcOjx/YALGURqJ5nYhPCA0sh5b+dqwrSfvJf
	vDD6sUY6aYuyRO4BJeHNub/HYRe/3m9dicj8zBDQKsZDLxl1mnXxuNOpHpuMmUpzJqoJJnlVTfn
	4j7zdhcIw25s64zs1zn/lTneyw4XiR+jPMCX3HN3hnlHp7t8KDWoMwsqnxRYznFUzuAsQe2eUID
	a/2aYXFzzc+nh3zJgi4Vt+yzodSIDk3JWbgSQtHkH93miMuXa8zmluyj8gEeFpObw4HtqR8Nn9e
	hujmzBR0QBv3elyGdAm8cyrifyWOZRzeV294Q3ysDI5wZKU4ny6wyDYqqqvryh6D28gLHVm9L+x
	SECdAA5Qd4zjXTSGd0Icd5NhBoV3mixEDy5ZBhlFQtPN0ChrZ1nsoxZEZV/l3+4pwiXA6tN
X-Received: by 2002:ac8:5f8e:0:b0:536:4df9:d95a with SMTP id d75a77b69052e-536c282a097mr40039391cf.40.1792773032900;
        Fri, 23 Oct 2026 09:30:32 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836be8911sm1353151cf.12.2026.10.23.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:09 +0000
Subject: [PATCH v5 3/5] userns: check the opener and the writer before
 mapping uid 0
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
Message-Id: <20261023-b4-setfcap-userns-v5-3-0620223be951@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=6277;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=z1TAiwfnapZ/x0sqAr9rh9ujCv3xiyTNvGaSS3SmRFk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCFJmsKFxA5Ijzs1WUPi4w5JR38DWU8OR4iMmttn3RB122Ir81G+53f+nqbZ9TIwub0+YqhEb95
 Gzv1Plzevag4=
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

And the check only happens for a map with an extent that starts at the
parent's uid 0, and only asks for CAP_SETFCAP over the parent.  But the
root user of an ancestor can be mapped into the parent at any uid, and
the parent's own root user can be the root user of ancestors further up.
A task without CAP_SETFCAP that unshared a namespace, which a privileged
task then mapped "1000 0 1" for, can unshare again and map "0 1000 1":
host uid 0 is uid 0 of the new namespace, and nothing was checked.

Find every ancestor whose root user the new map contains, at whatever uid
it has in the parent, and require that the opener and the writer both
reach the topmost of them: by ns->setfcap_level for a task in the
namespace that is being mapped, by cap_setfcap_level() for one outside
it.

This only affects maps that contain the root user of the parent or of
one of its ancestors.  A write by a task without CAP_SETFCAP to a file
opened by one with it, and a map by a task whose CAP_SETFCAP stops short
of the root user it passes on, now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 82 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7bd3692c2f3e..661d7e9b72d5 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -881,15 +881,55 @@ VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
 }
 EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
 
+static bool map_has_id(struct uid_gid_map *map, u32 id)
+{
+	struct uid_gid_extent *extent;
+	int idx;
+
+	for (idx = 0; idx < map->nr_extents; idx++) {
+		if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			extent = &map->extent[idx];
+		else
+			extent = &map->forward[idx];
+		if (id >= extent->lower_first &&
+		    id - extent->lower_first < extent->count)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * The lowest ->level among @parent and its ancestors whose root user @new_map
+ * maps, whatever uid that root user has in @parent; INT_MAX if there is none.
+ */
+static int map_root_level(struct user_namespace *parent,
+			  struct uid_gid_map *new_map)
+{
+	struct user_namespace *p;
+	int level = INT_MAX;
+	uid_t id;
+
+	for (p = parent; p; p = p->parent) {
+		id = from_kuid(parent, make_kuid(p, 0));
+		if (id != (uid_t)-1 && map_has_id(new_map, id))
+			level = p->level;
+	}
+
+	return level;
+}
+
 /**
  * verify_root_map() - check the uid 0 mapping
  * @file: idmapping file
  * @map_ns: user namespace of the target process
  * @new_map: requested idmap
  *
- * If a process requests mapping parent uid 0 into the new ns, verify that the
- * process writing the map had the CAP_SETFCAP capability as the target process
- * will be able to write fscaps that are valid in ancestor user namespaces.
+ * If a process requests mapping the root user of the parent ns, or of one of
+ * its ancestors, into the new ns, verify that the process that opened the map
+ * file and the process writing the map had the CAP_SETFCAP capability as the
+ * target process will be able to write fscaps that are valid in ancestor user
+ * namespaces.
  *
  * Return: true if the mapping is allowed, false if not.
  */
@@ -897,42 +937,40 @@ static bool verify_root_map(const struct file *file,
 			    struct user_namespace *map_ns,
 			    struct uid_gid_map *new_map)
 {
-	int idx;
 	const struct user_namespace *file_ns = file->f_cred->user_ns;
-	struct uid_gid_extent *extent0 = NULL;
-
-	for (idx = 0; idx < new_map->nr_extents; idx++) {
-		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
-			extent0 = &new_map->extent[idx];
-		else
-			extent0 = &new_map->forward[idx];
-		if (extent0->lower_first == 0)
-			break;
-
-		extent0 = NULL;
-	}
+	int level;
 
-	if (!extent0)
+	level = map_root_level(map_ns->parent, new_map);
+	if (level == INT_MAX)
 		return true;
 
 	if (map_ns == file_ns) {
 		/* The process unshared its ns and is writing to its own
 		 * /proc/self/uid_map.  User already has full capabilites in
 		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
+		 * when it unshared, as far up as those root users go.
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
+		 * namespace, and as far up as those root users go.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    !cred_setfcap_reaches(file->f_cred, map_ns->parent, level))
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
+	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
 }
 
 /*

-- 
2.55.0

