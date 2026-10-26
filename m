Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029314;
	b=5BWg49akwiqWRychX+Yj4tgdCrRUL9F07kVKi3aNDFQfimMmQHojY34iwwjRO9Ll1vOk
	 Fc1kH1r1Cp7q9TUq6+O5jH8VHT3ELBywOL8NcVgNHKiad8B74k/4hPoHns2ByzH+jt2iN
	 R2oHxJh6ayRmoeo5f2AGqMYe4dXShkvhcdYc6HM5hFXpcy3PFgQSDwAZGb5wIsEhqJ9d7
	 mvtK9E+Z0ZuqOz9/81G5PTHFOcFYEFBtdO5AdFpK8sgI/uRz5h5RDlEbbrdPScgSU337G
	 w21KHldV/XC89p0DQ2qXtvLY/8TLukj4Go22qSpyd8di+1+DCuy/LhoMQtty6ND836A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
	b=Vq87QeaI7Du0FfOaKGaqnWnG1Rn0J6Tk+85obYtVDvWZzSR+aTrJEOxuLk3w+H+MRTA8
	 PW3uu1CDOTwWJPsf+3W9QF3Q2qBBEGPiIMW5VRpuZy1nD7zKImmAcst5ohlzmvWLKQXRh
	 RaMIomg+eCWtIxPKAWcYaGYDZ/qbZ0FS0DLxNGKkVXtWZqPPUd8BwsBQJfhhibe3lZINa
	 lGqMu2dQk68GdMPr/wgVP9G+YoCIvJ08ezNyTQJQrib4H4oJztC/fr9Idj6unQGH/JFXc
	 Fu3RpY8f0+87y6elkTb0NontvBE8uaEw8BmBLEpHbrPo8d3QiJHNczkPKAGUw5ggUJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CYj6O+YP;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517560A2604
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 15:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3517560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CYj6O+YP
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ab43af5e97so237367b3.1
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029313; x=1793634113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=CYj6O+YPPqVN/NThuARpJ4glDPKJXXwRCkZ4XDkFYkLb1aWNH6l14wUeUEXiwu6j4Y
         aJ8b8atBy6juKw8fOdHlamAAQO9IdrWiVayomuMiJ/n0v+An4iyePBOXrYydFmJHF8AH
         ofg3vSCej1Vopgl2ON2ysgzk02M5NqqNX+sMfjxqtIIVEXyNU0PbZgCfMMfwozwN2knn
         y4tLGGezXDIHbx0kPzQvgzKOEFQv1apl6bkQX8Vd0af2U4vpXA/tKjrfDtYEKVL7a4T9
         dAVbqDbG77mL5Q1HVQmnWU3Rug+j+u5bsnKr0nBCSBFEVvuKePH4z/K70HMYnb0uBVX9
         oNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029313; x=1793634113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=VRQ6bAyf+G/bn5dtSxPa/fC+hbrP6Os7JJpqn0EsSeJcESNOBWiNU1FeTxs4MGH/Oc
         co+FjnzUGLJqn2071LMUKfSmpwaY/4DGBBiAoFq4uCtgl3rPar8IBHdIC9s7V+DFh3M7
         5KHMWJVlCzAYe5ZFA70W42SEwgLdQMKsJoLXPAKIzYBtMIFCcwsuBHFNLD8WlX26dFH7
         lM70qnkV5e9Ey8QNoRjk92F+n4SZAz+XNiygMZRao7OqSnkGLIEMsPtCXaqgPSsVZCoD
         J9+DdTbGrIJjBVctPCIOT7+z6rU5AppnQS8n9lTflJt/t66hceWapILIU128g7YPsQD/
         Bu9A==
X-Forwarded-Encrypted: i=1; AKwUvBxJVac2cPbW6nQbSEQumCxJPZhqU6+fuZtL3unYhCeleCwJNnhLSZ6//nFQGtPHkZXaIto5ROkcJw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJdDK8PNcpxvDHa8N3BucESm9IQy1cX0shNRwSD4sDoND+4WK+l
	4ifUiQBlYiLKWJ6o0anRVYaR5HTecrs4PwFrNV5M+sF/VanpB14OgU+wc+E5wCLGLNI=
X-Gm-Gg: AYBFou35+hua6CQTxUEQjlww3CDrA17FKRG8W572Fdre/QKzOqqGHVWte32YOemwlqC
	rKUXjEunjmOgSSprq40j1i7ZpNvbLtbILU/W6IynUsfdl2MU2f06/nWBELCv6ECsnYYgW2GlgF+
	oznp9/1AbR8WSjaEqTj7d5UEhQG40ZPO0xeHIYx6WsHBFKFVN5gN2XPAhusvsW5tOBU78OSEuGB
	udQalUxle6CENRlp5S0jd8zpIgc6fN1wTHy25X37LPDIeKb9YAsVLL8I6hSD3vX0dKQ9Se3pbj0
	y/Ak2/VYqhnzbURv7u/DD2mQpAb3HoaXjLSKrAgdr0uQtIFJ3ef7kwy+JLc2zMw7ufbzCn6SsV4
	2U5U1uLkopGJDd2ME76PtdQS+FLU4UOO8KF4EswLFQQlzx1JXVC+Hi12EA5NdOJFt35b+GhTyry
	RYBbyalu2+tNBjgeV2j2eJbIEq/xdSBSvP3SgkCCw9mPl9wXEb4y1M3SIRoTdNUDqmgtozKroLV
	Yt+jpAv16bJnaTWVTRXdICjCJpEE5heVO8b/BCuk2K4LZ6fZx31zB9A0eC3I+u50kYz7E+s
X-Received: by 2002:a05:690c:698b:b0:8b0:e13c:2852 with SMTP id 00721157ae682-8b19c9c4694mr214787b3.7.1793029313228;
        Mon, 26 Oct 2026 08:41:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e10d50sm33046137b3.21.2026.10.26.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:39 +0000
Subject: [PATCH v6 3/6] userns: check the opener and the writer before
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
Message-Id: <20261026-b4-setfcap-userns-v6-3-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
In-Reply-To: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029305; l=6694;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tq4QC700hpQ0XsVb6nesQjcXMRFBl8Nnhz0SoKNdw/Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIHWuNeC+fFqpHEHcTDItz3zq3ggZ98aAqBYR+ptz1N/S3xRGyqaUX/sgV9U0ICWu2ng2kkFmLD
 k0bQzwL2stQw=
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
reach the topmost of them.  A task outside the namespace that is being
mapped needs CAP_SETFCAP over the parent, reaching that far by
cap_setfcap_level().  A task inside it needs CAP_SETFCAP there, and
ns->setfcap_level has to reach that far: a task in the namespace that
gave up CAP_SETFCAP would otherwise map uid 0 and get it back from
execve().

This only affects maps that contain the root user of the parent or of
one of its ancestors.  A write by a task without CAP_SETFCAP to a file
opened by one with it, and a map by a task whose CAP_SETFCAP stops short
of the root user it passes on, now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 87 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7bd3692c2f3e..db078dd6406a 100644
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
@@ -897,42 +937,43 @@ static bool verify_root_map(const struct file *file,
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
-		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
+		 * the new namespace.  Verify that it still has CAP_SETFCAP
+		 * there, and that the parent had it when it unshared, as far up
+		 * as those root users go.
 		 * */
-		if (file_ns->setfcap_level >= file_ns->level)
+		if (!file_ns_capable(file, map_ns, CAP_SETFCAP) ||
+		    file_ns->setfcap_level > level)
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
+		return ns_capable(map_ns, CAP_SETFCAP) &&
+		       map_ns->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
 }
 
 /*

-- 
2.55.0

