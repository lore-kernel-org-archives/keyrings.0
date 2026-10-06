Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2932FDC20
	for <keyrings@vger.kernel.org>; Tue,  6 Oct 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301492; cv=none; b=Ci+yP+8njCqxamoTb7Ir6lx9Car12qrN7NMiLz9qIc+Rj0WxhvkylXBBwGGyPb6xqpViJQ1/sKtozVki8bAMArRq/JMkFPolkeN05fzeWZ8BEG8P78R+tde9nlfiSOBhqcCa10bWm44F48qLcX8oglNSeD0E0lyXGRMqVgWl+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301492; c=relaxed/simple;
	bh=AxdwV3jyCaz3acNcwVufe7ldBelGeRHhgWoXWQZiNGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQDMk8TlxeV1v74g2TXOHq5j0SittpTyalTtYMM2gItgK+JG4R8Yoxd80lbyaJoEmh0g2HbD0Mil1TLBXjpwzjam7ijiYS8ivbdHU7ECGqfjYweoO5E6Oq999n9ml+vUemAhM6TphDs6qNAHaepWUXT4XVXHoFL/Sbp/w8LjeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=dlDncMVu; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="dlDncMVu"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91054f537ccso9136746d6.1
        for <keyrings@vger.kernel.org>; Tue, 06 Oct 2026 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301488; x=1791906288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6fXKK9ddNXVDNgSu2OO+ZdNitAr8O+3Krqmr3ZLGjk4=;
        b=dlDncMVud+voktc9Oc/9Yg34Uf6mzglifxStOj1KPH0nJui51EzFxQAXBjZDMAUfkD
         jI0Y3SEB7lODLMfgdtWYK8jrwt/IDwZ5MagVeqzvNDkHd51hspDORmpv2BUColV8uUjg
         RWT7KsWl6xyG3z1YwKecvwbe+LvTIeF9KCmQ6wLPfH32O7L76LkLQMeqcr1rc2XGO+0P
         9vkMSgoTYhhRKNa7BD9b6k2xhaMe03Z3yKiIDouz/dAoHS6QW60mi2xxcfzkRT3JzPhV
         BVnI6U2WdIKz86Jgu4juylBbKom5aCop4fLQcvHaWF6C4rzQHa0Va1ErY8TlWq02z+rT
         C/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301488; x=1791906288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6fXKK9ddNXVDNgSu2OO+ZdNitAr8O+3Krqmr3ZLGjk4=;
        b=Nn0HIi0rr/b0G6SHVzexXY8E57HMCGM2IyVZD4thzduqIe4tSMFneXeeT73fqWNpNu
         zXNduH0w++B69pd0ULMTvzyUrdA/wQBE08KTX3CTD9kKSMs5h4uegbYN0jk4VJlEyE3f
         vjIhmrsU85nv/LTJUJb1ZmCvMGCcWLsZTyukx17BM27a6HOVNaStG5LZE5x3lVHBcI3e
         Ew1sP+gMkGp4BJM7adnqvrjeGgz4todz80JhQWl7F5c+YVxE056z75Lx+QFmH3uXBYOO
         APCacrO1i2qd+VkDMxTrbFwOMkaa7ShduxfsCQN5dcSL3l4+O9xfRGgJBTXXFn1bg5do
         H6IA==
X-Forwarded-Encrypted: i=1; AKwUvBz11QhncO/niD59PNMkclx3nvrYBSucilJfWXDxODbnquallO+xWk3XlxHSZF37fVY5RSdyuG8RCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kH3WgU/nSC0P8uDr87fzTIXDcqAVr61fDj/gdKxG51DJtHhX43
	Ozi70WVHEXzVgBzMKyMxE/zsA3bS2yldhsihnklVoPEq7A4CZmKIzfPAcdkSCzdeT3eZLKroYsF
	x821l
X-Gm-Gg: AYBFou1ZxmHiWQkpoJ+vHfVrL/tkEXM+iu6IeJ+3nEzgqTTOk5YoDY6lH90mHGDutme
	FcEQtjyYbS2dU2rEDyDZ/dsfz9KW4hkB/SRRVgetDjK81SXnurdkdXgxmxyepKeHpfd0/FohV0z
	m6CI/0iEzdET6fTP77iI6NNPYJpphwHNesayM4i2IS+CZdMkTV8vWeDlRoQajCcIFaHXGqwVbri
	kEjmcAb5eIw4Eki8V/NBUbeAh/OYKF10iPXRf12dTAadYBeY6UW3Ja1t97OO8g4R/OT5E4GL2h+
	4noZckojv57VebKNNKPYqYoF0JzYAZboEldUfxarx/feoZh9ddw6vvvff3KU8ryJX7ThzN8Uwu5
	min4jwQKMlqB/4hTSYn/7iUed5gtRptzDjl/ujBJqbxIe45DHO14UnODnlx8xrHPnR9WYzGiLSO
	BGfTA+VCucFnpvklhiDIvy97k7DSx/AOTeiFS+ItAxHn0nKEC18BILVoVGS5y2KttF54BHsymlY
	lYQZjL/LBfOENw=
X-Received: by 2002:a05:6214:ca2:b0:919:518f:3a92 with SMTP id 6a1803df08f44-9198b7b2e97mr40909216d6.17.1791301487948;
        Tue, 06 Oct 2026 08:44:47 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bc98fbsm115732516d6.29.2026.10.06.08.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:47 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 15:44:19 +0000
Subject: [PATCH 3/5] userns: check the writer too before mapping uid 0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-setfcap-userns-v1-3-f47e7ed66072@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301478; l=3855;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=AxdwV3jyCaz3acNcwVufe7ldBelGeRHhgWoXWQZiNGk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMY+oJ5hkLJYLy+wtpD0820OXDvDjzn/2W9uZiWzkpIndDjsoVu1mqh9U+PYTGYPqtnhE9LCKpf
 c5ivQuJCsBwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

verify_root_map() only looks at file->f_cred.  For every other privileged
id mapping new_idmap_permitted() wants the capability from the opener of
the map file and from the task that calls write(), but a map that consists
of the single line "0 0 1" takes the unprivileged branch, where only the
opener's euid counts.  So an open uid_map file is a token for mapping
uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  fd = open("/proc/<pid>/uid_map")
  B gets fd by inheritance
  or SCM_RIGHTS
                                    write(fd, "0 0 1")
                                      opener had CAP_SETFCAP -> allowed

B set up a mapping that it is not allowed to set up.

Apply to the writer what is applied to the opener: in the namespace that
is being mapped, its credentials must have come in with CAP_SETFCAP over
the parent; anywhere else it needs CAP_SETFCAP over the parent now.

This only affects maps that contain uid 0 of the parent namespace, and
only when the file was opened by a task with CAP_SETFCAP and is written to
by one without.  Those writes now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index bd5f9cea7430..421769e2d24f 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -891,8 +891,9 @@ EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
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
@@ -928,19 +929,28 @@ static bool verify_root_map(const struct file *file,
 		 * when it unshared, and that the opener, which may have come
 		 * in later with setns(), had it as well when it entered.
 		 */
-		if (!file_ns->parent_could_setfcap)
+		if (!file_ns->parent_could_setfcap ||
+		    file->f_cred->setfcap_level > level)
+			return false;
+	} else {
+		/* Process p1 is writing to uid_map of p2, who is in a child
+		 * user namespace to p1's.  Verify that the opener of the map
+		 * file has CAP_SETFCAP against the parent of the new map
+		 * namespace, and not just because it entered that.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    cap_setfcap_level(file->f_cred, map_ns->parent) > level)
 			return false;
-		return file->f_cred->setfcap_level <= level;
 	}
 
-	/* Process p1 is writing to uid_map of p2, who is in a child
-	 * user namespace to p1's.  Verify that the opener of the map
-	 * file has CAP_SETFCAP against the parent of the new map
-	 * namespace, and not just because it entered that.
+	/* The file may have been handed to someone else since it was opened,
+	 * so the same goes for the process that is doing the write.
 	 */
-	if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
-		return false;
-	return cap_setfcap_level(file->f_cred, map_ns->parent) <= level;
+	if (map_ns == current_user_ns())
+		return current_cred()->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cap_setfcap_level(current_cred(), map_ns->parent) <= level;
 }
 
 static ssize_t map_write(struct file *file, const char __user *buf,

-- 
2.55.0

