Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048440;
	b=U7H2kWnB99mqwaW6S0x0yfFY1PQrysjEh2aqb+EJ7Ad1Opx2Z+mfU6fgGSE9lxttnWW0
	 c4bu0mppJKObU1IQsps/+MPjhU9dsxPVfoj9qZTf7NBnNLtP9rGyL8OpqYgYD+Zs06GYy
	 IU3cxOlbtg/z92RZH4BMLPvJqrKnEwqLylBFS4xS6JX0yWksUgMdbGaumkavmziEUT+9j
	 IAQW4PSdqEiRcXT7gk/guK5zOXtMDOqg3+7a6NJOmipEs+K6ePkfk+sUgUh3Ufbr06Baz
	 wxVQUEJK90uUpH8y10G2vnOfZF2cmNzgN6aJ69tkYZhraKXvEFCEy1huUgZz/N10VNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
	b=I1rtXYPvrU6EyqKB7BqKsjTk+zebDvYthmk+MEC3fD6C7kpxCW4KiQZjRMgzCL9EmGFI
	 VqH4S6kjY1lRH+5MLx7jwADw/APgEO1BnbvzX1diw2JKfwG3xayJh7uszzzB08h8ARvzS
	 +M0dvSCtStxJTNH3Xc3oc+S8FMXK6Fu6J5VKAzPCOimc7Ut6ixhsldeLLUdPa5ZMhZ03R
	 X5+b/fYlVcM+g7cd3WvPtiYYvJeb1npw5nMhqjOS0TKyJOhSWGXs5vsX6/r0KllOTPuzO
	 XeVK63HTYvUO26stTldm7H/p3XAl3LK4wcCJqajDAPoqJJH630SLT4IkucvxBChWf0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TzI1kkl2;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A849606A33B
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 21:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A849606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TzI1kkl2
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363316fa0cso53507461cf.3
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048438; x=1793653238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=TzI1kkl2mSfQ85YGENYPjutjEUP4Qv8DAFPCYXLDw3acvuc7Yif+TIOnqtHKvf1Cwj
         Ei5aFdW5PntrNNsTu4iWxmh2Z+zZgwfdQoxOKem7ctRp5/KlmH4qA+6tfc9iDdcg85Qw
         Z1i98M5rPLaGj12czaqrzKeNu2d/xmiIsq3hDFoym2VQMz9s7XswkzmKaX1njPEeUgoQ
         BEYv4eSNujQL63kJJdAtSCNN1s65+zwR+IXHFqWv9vxtzB0ljnOfe9JYuJXNlRvUO/lf
         CrvqK34ZBYkfedtyAc1hqwTDexKJUllWpVbYCaRZfprqHaZdiH6Tg1PDUdhnWcy/my/T
         XJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048438; x=1793653238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=FAHoCD97B5SJslHcn+yxLCX0t4tKmJHke5npzHFppMpcYQeiQqhRnOPg2SCmCB5eoZ
         RSE6G16IxrbeE4ui5l0rR9dBmwc5Y07cMmdz5C63ZZDP+du3ODKg7SxlSOF4vZJdGFL6
         DDFEibphvSbXWFqieou0ZBvdi9cxqdxQXH4ibYS4A5oFP+nj6pFeChf4aUtfOUMWkIPM
         VZpRO1QgZBKYHZ0jhWWLdlxyMOIYRBBn1qSzMZm1yp9gQSI4jNs88M0l5mDQHIljlnwM
         nP0PAVvzh7mF3gDNUkM/TFs2ZfT5+1eCXqv8Pzdo2nlvSCan6NZvHCCRDTJ138jT/3Ay
         V96w==
X-Forwarded-Encrypted: i=1; AKwUvBwWz2FnQ0xkGAobjwyBZCkrVo9bmr+ICdUN6soIHpt4hxjxPxiCUFNqdttP/CkBPHB7xr9SZB53HQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbRCFC4iaMZcIkgBYFiw49uI/n65GtuNqZ1bmvoN1f6jNtg6Y8
	Jz1TNZshWkRnYUdbfDx7IVoqoRfwmXG8mRKVYTumEBfuOwYvX8nvILvm0cavvkzui5XlZeSVHvI
	vLnNcWAk=
X-Gm-Gg: AYBFou1xXMp3SAxMmrZ0r8cvcEWgW4TnJjlj1IgEMjTjrl2uJjdsLmg+Ovp0MjGwOig
	AG1r9YyCUzaH3vtnBRHbKIT30P01LOBpLOonCQ1IsoM00BVHGcWT4Da2PngtaKvkMROJhqjZIlY
	E+4y8RCtaQOWn8+eiS5n1vQxoV13ImM6d3mHsO9rhBdbnHM2efspr4toBVhd0HfGvWkuWdZUYI/
	itxRCTmYE40mG4Wbmck3YVxBW/ds8sQHUBIxllRehpi1ihMWP9LxaZefw4T5Vfo2dpWt+AcyjXF
	h2XxNhyJFxPROcb6TBdwza7oW1MX7ijDmVwSUgfDpMMSYJ7LiKWhZVqqrJrM+0Mhe5cEhi44Ej5
	j+uDOT1UepCSozyv1WU7SrM4iiYTdW6GW7811d23gbcAP6yeUs62ZjwFyF/Pz+qGV0hMss4vgnB
	aLxZv4lv5MAD6WzEmSC3cgLNKbPkpV8si7ldK/Q8xcuqRgPf+yg8j+3S4YYHDQjRHyU5kLFc+0W
	GvbJAevf0nubTGgMf3M3Nfe6vTmWq2KJgholxOxAgNFe3r3cwCiT7h6GIFf2YT5kKZaoyks
X-Received: by 2002:a05:622a:5594:b0:535:cd9e:bfc8 with SMTP id d75a77b69052e-5383b6e775fmr128967861cf.77.1793048437994;
        Mon, 26 Oct 2026 14:00:37 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383973f314sm63147121cf.24.2026.10.26.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:21 +0000
Subject: [PATCH v7 3/6] userns: check the opener and the writer before
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
Message-Id: <20261026-b4-setfcap-userns-v7-3-bf8a576f7259@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=6694;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tq4QC700hpQ0XsVb6nesQjcXMRFBl8Nnhz0SoKNdw/Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM9aieuT++ilR+Qz7gxmzZu8MAed36/c5amF8PT3lZXNvhnW0pB2ZVMa2WNXF9bqnonpkcmUG7V
 pCusIkYSsVAo=
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

