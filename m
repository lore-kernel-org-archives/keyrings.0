Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189454C10D7
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010902; cv=none; b=H31N9c/B/N9XZNuh/bJHKFrH978jC8Q5eWLJH4hUcU0Gg+kfNySLSeq0WxyDWbeF79PscMp5WsOKi60vNAMEtcvrdrx2PC4GnAi7SBtBOlTBzcLNBoRvYCQFARiv2qyQiAyyn0x52/GAuZYDxlERpS56RhAXkGYmqEfQ0dehYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010902; c=relaxed/simple;
	bh=JxNh2ZjX4icAlvNneZTo89JakH8InNfiSrOt6oIkwl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfKMGzR9WWdHV6Q2RyobPn6Z3uIwTK9g3q899JMCWIzN5F1HJd6/CChfEPpS64tzNwlrxyU1Un4l1y15oQDye8xUXDCc8aMHAiMLQSRZBlxdfpx0LEwkoSSXKcTONoY2k43oEFvIZLzuu+Gdypo2tacVA0CRaOOoBpNJZaZghCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Ki9EmMGg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Ki9EmMGg"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917a64f28d0so85928396d6.0
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010899; x=1792615699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVOOTjqsEAexejDaS34RRaZCsLjQoE9QZWSztQhKcEY=;
        b=Ki9EmMGgOHeJzFoCZtrU+J97n0ldQcNVhFDKHuc5dBfjFylCtqDZJOYC/WUq/9Qn6k
         a2TlnpFN88u+ddwVTyHwQx8/G9/a23Z0Kz+fQomrrA3voaC6RVg/TzhUjQ88Gxz3TI5q
         eXy/c2/EqbJbeipowayhAcVQIlnxFG/FsHoA4kS3lKP87v47jVqXilx4JGt6G81vcXxb
         3Bw24PE8ZW3faEq9fu7jkGtoK32M6FMsTRfuEBndq/oIXaMAHxgfnyS1ClkSdJKik9lB
         w/BbYBMdCXUrbeG9p2DPpGWFHYpQDd5TOH7zjT3ZT93qPWswlhNE4MYcbBLREj/gf3GD
         lzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010899; x=1792615699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fVOOTjqsEAexejDaS34RRaZCsLjQoE9QZWSztQhKcEY=;
        b=p/khHsDAXTHPukt2gi3wfnf8+N8a3Q/VdwrXIqN845VdSVi/7Wz5GsSeDq1uK1I5Lx
         nCYQu8giCo82Ud0x4br+6y4sYwCbZj1XOFg9UrOQridpgP3QBlXCtWERJWOJrdigdM2X
         zh1i4GNq+sw8iUfmZ3/DXEHzLqbm1GcjaY+MVnI8MHaSPJVa064Eb16QDUynPss8kiJL
         Ej7sYQnml+18Uo+6m7gX+wHXQMazN+4MZsMoASmM7MGIabEq27KZ5vSYNkrRf/I7/LvH
         SSrQkiTefU/DKB3DSKgdHeE2vHqAzE97DIENlyJqEZez7fUOldXBVqDuuJLCMuyep1t6
         fk/w==
X-Forwarded-Encrypted: i=1; AKwUvBwWzxjB5nVPgzulQ8FVOj8K6gVcoeu3Z1lA+XFDxzcd9EuhU77vEkEceoWXDVjJC1YOaUUNhpwfKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK7qv3Qx2EwH3BwAdkYExRygT88X2P9m/lbbeGn2bpBkmtljXNp
	O2PFhPJICGbzjc34eORD4hE/ncox1SFCPCK8dPhf+jOxVEiFe8dXEzBW0ZLdeLhAF7k=
X-Gm-Gg: AYBFou0x+jiQ866IfAfA6Ao5URDgsUdizCKCzZ4MpxkVHWFb7dZuk7y7Fzb5x4w6ysS
	5NpjXcj6LUOcll9CvVhBTKlLT8Gppx+b73VIup0ZcGJI8d7mFidAeKVf+wnDECKb+70pjJb8pnL
	o0s4h7U4lfcOGucRpUmrgBn4WIUKMb7se8eZjSkp/kWjmHGZfvVTSmAmrRZfzXUkR5UKBRLcqzW
	fRB+95hBfWOjdqRfMNQM+xepgObtCMo9A9N2Sc12UJC1x/izwayQKAuevqN1YhFTplD/y5vS3Do
	my+HmK9NlUdPVYxHav+/K/4Oe3oqBrrpAT/OZFZlf5skaFQLVVDB7ZAxWpvxm36vHe7GljCk8Zo
	WNJKeJVDptqD/DXqKhCetafOSk/m16J2enLEQdme/cDRSSCnlBctSt0lu5DpSsaSOTaPPNrLvBV
	rucjXz8r+ACVZrkZ7uCfXNKbCURMZNuetKl5NQkpktEjxARBGkiPLZsKRRSibNwmrrRC3F89wPv
	xoqFFaLG2f1lMaY
X-Received: by 2002:a05:6214:808b:b0:91b:80ca:76dc with SMTP id 6a1803df08f44-91bb46d8e7emr26763046d6.6.1792010898952;
        Wed, 14 Oct 2026 13:48:18 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ba3d63c70sm42906276d6.43.2026.10.14.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:50 +0000
Subject: [PATCH v2 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-5-fac4d19281d7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=6264;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=JxNh2ZjX4icAlvNneZTo89JakH8InNfiSrOt6oIkwl4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKA9QkVT7IXAtcSIHZtMS/kvt0PL3EQLWnajEYduVEA3ULMH7lNRl8Ad5cqAc4AMwRJiZpuBOH+
 lsomgepoHJgA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
0 of the parent and write file capabilities that are honoured there.
That is the one privilege they keep outside of their namespace.  setns()
no longer lets anybody in who doesn't have it, but the ptrace checks
don't know about it: for a target in another user namespace
cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
target's namespace, which the owner rule hands to any task with the
right euid.

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    ptrace(PTRACE_ATTACH, A)
                                      uids match, euid == ns->owner
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities
                                      A is entitled -> allowed

The same goes for /proc/<pid>/mem, process_vm_writev() and pidfd_getfd().

Require for PTRACE_MODE_ATTACH and PTRACE_TRACEME what setns() requires
to get into the target's namespace: CAP_SETFCAP of the tracer has to
reach as far up as the namespace's setfcap_level, or the tracer has
CAP_SYS_PTRACE over the ancestor at that level, which gives control of
tasks there that have CAP_SETFCAP anyway.  Whether the namespace maps
the root user of that ancestor doesn't matter, for the same reason as in
setns(): through an idmapped mount its tasks can store file capabilities
for it all the same.  A tracer in the target's namespace got in with as
much and always passes.

Targets in the initial namespace and in namespaces created without
CAP_SETFCAP (what unprivileged users create) are not affected.  What
remains is a tracer that gave up CAP_SETFCAP and CAP_SYS_PTRACE and a
target in a namespace created by a task that didn't, such as a
root-created container, which the tracer can't setns() into either.
PTRACE_MODE_READ is unchanged.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 2cae4354aeae..83cb5c9c3a25 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -195,14 +195,48 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * Tasks in a user namespace have CAP_SETFCAP that can count in ancestors of
+ * the namespace, see cap_setfcap_level().  That is a privilege outside of the
+ * namespace, so capabilities over the namespace are not enough to take
+ * control of such a task.
+ */
+static bool cap_covers_setfcap(const struct cred *cred,
+			       const struct cred *child_cred)
+{
+	struct user_namespace *ns = child_cred->user_ns, *top;
+
+	if (ns->setfcap_level >= ns->level)
+		return true;
+
+	/* setns() only lets in tasks whose CAP_SETFCAP reaches as far. */
+	if (cred->user_ns == ns)
+		return true;
+
+	/*
+	 * Whether the namespace maps the root user of an ancestor doesn't
+	 * matter: through an idmapped mount its tasks can store file
+	 * capabilities for it anyway.  So ask for as much as setns() does.
+	 */
+	for (top = ns->parent; top->level > ns->setfcap_level; top = top->parent)
+		;
+
+	/* CAP_SYS_PTRACE up there gives control of tasks with CAP_SETFCAP. */
+	return cap_setfcap_level(cred, ns->parent) <= ns->setfcap_level ||
+	       !cap_capable(cred, top, CAP_SYS_PTRACE, CAP_OPT_NOAUDIT);
+}
+
 /**
  * cap_ptrace_access_check - Determine whether the current process may access
  *			   another
  * @child: The process to be accessed
  * @mode: The mode of attachment.
  *
- * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * For PTRACE_MODE_ATTACH, if the target task may make use of CAP_SETFCAP in
+ * an ancestor of its user_ns that our CAP_SETFCAP or CAP_SYS_PTRACE doesn't
+ * reach, then ptrace access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -223,11 +257,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    !cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, *caller_caps))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();
@@ -238,8 +276,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If current may make use of CAP_SETFCAP in an ancestor of its user_ns that
+ * parent's CAP_SETFCAP or CAP_SYS_PTRACE doesn't reach, then ptrace access
+ * is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -255,11 +296,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (!cap_covers_setfcap(cred, child_cred))
+		goto deny;
 	if (cred->user_ns == child_cred->user_ns &&
 	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
+deny:
 	ret = -EPERM;
 out:
 	rcu_read_unlock();

-- 
2.55.0

