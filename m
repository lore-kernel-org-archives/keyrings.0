Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029323;
	b=UAvbXChNfNFr6qBP6WTD0r8+V4LeLARXn5bnl+wxHWkVUrCn3LbMFSIAP4HldAutn+/C
	 feuynPib2RmIMj6/xkZrlDEikiGe6vwqYQR1PSKbHphqjxzQNkgayR+Q1X7Vtlynz1E8a
	 MxxDPmmXkvtD47J89XnwIP61Kqxl2Sqcfrwbq3EpLS6uG/zRtdiCVezO9libdNW8F1bm9
	 gpRs5HVDAlgYvTqDP7J6kLGpROkwxYCNPGCX5a/GSTcYV1AwtDVs86UuGwPVMSdinQEEw
	 ZqHVr00ZxKlZWiqRT+ecod8jPB+FL9lXKVFmLwdssJjA7TcYhkWp5626Ipu0ch6BFxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=/QAf07cAiyxBwSWgq7Tjim9fLXjZh7SPBHX/IjDGa5I=;
	b=xrzX6ZWV04j/FIMssphB9+1InK5BMTrTcO5iLcCxsnquNAuTGZJEDsNaNoA/gW9Fh21E
	 EnhOavsLt6E9Wj1rNBBY4V93UamOTmF3EuD8/FAWgWWh2ewzKy1rAAQbTnLpqZynaTOBl
	 t8B7l84hq6g1n/h0nCuT9XLtLOkC7psIR2ykD8iPFyoxS82Q9uwgrcPmDKc78mxEh6wSm
	 cvGtHlyKTrVi2N4LOFDMZ6pjbMryByDbgUZC0JOFlEY3Wp9ppsmDgZoIZxqynhFWMolQD
	 t5OSsq4RCAq9qlIj6tMS2514iJQliWng/ZQq87OnYCRPEP3inPmuUddNoXIMk/Yl/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="h/e0QK/g";
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE13606A32A
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 15:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE13606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=h/e0QK/g
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93ead211f14so1640085a.1
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029317; x=1793634117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/QAf07cAiyxBwSWgq7Tjim9fLXjZh7SPBHX/IjDGa5I=;
        b=h/e0QK/gxSlRUxrl/XozDgzLPPvgqcgVUjLSWebwE5yW0lG879yRTMMeM/Zv2I32gA
         +6+1LplHZ43LSDFZMrm6YDmG86vAYSEYIMMY2rb9pv0sDceVo3T9X5hfnWKE6arngWt7
         YKzNPPeW3nosxrplTC7MkWCyDARSGXOycgCJjI3BAcq+6dlJsQ93g8wsmkBCBCD1MI5z
         vg3wxurCnWkuevAlRHhn47bDNWohcLcxLyPRLUoi45NIK186dqSolXUD+VWQ/yuojdzU
         Xt5xjC28t3+TdCiw3yJ4xZ4lRpgFcEIpsAnetKq2og0h36G+RegMk3p/rCCN02doGZEL
         kYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029317; x=1793634117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QAf07cAiyxBwSWgq7Tjim9fLXjZh7SPBHX/IjDGa5I=;
        b=TRu/VSyAx1ifJhFv3bg25qNHW+Cd3xgcy8majwDKnb0kJ6sVGTKzpIDQNFBL9NNGr8
         zyPboJUcfvhZaCy4PJDeqYl1qZhMnfjzvqYwSBhJJO+jWL0u9B6o/kEEqNrTVvu4e4BC
         5ieelBXGK0VEakqZ4GuwppjCaId3DFr687EL/PBNkcaQU/yY01PyO3Zn8X2VQwEhrtQ2
         BAQedRhIn1YIK+MiuG+4T8V+8GxLuODo+UpNWA5vf9d9/POzttcvWWu3zkkiDk13nGIq
         1xrQp6uoMPzNtebv0R5S26aMQ3QfJtsKg1PZKinIF/8+VCvUybWOIXIs4L0mYhJV95H5
         ENHg==
X-Forwarded-Encrypted: i=1; AKwUvBzL3Rf7Lz5EPj1/EvbJPKMoGQKM4ypcO3S9Q3EO6SumgE7KdCpKNXO5WYwnG8NLMp8+CfsFhxPDjA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIqIDPG/9wMIUvaFDrFg4bXV2D+b64XyQTqa23cVBmfAwEhXXAI
	kJKuivzJoLm9HQ2OFmrIgn0P4BeIBs8N8qKfbLOa4GUUhCt1d1ISm9+RrJPq06gH8Q8=
X-Gm-Gg: AYBFou2pJIcDg7txkfYsxJlIP+TA1Mt98a2lVSDc7Z3X2jn0nmKsFk2zW/QJvKMLUJi
	aWlrvSECp8KxEsguZMeT2Wvp0nEXGAWQhlRS2DYhKOFro2VQ2TNzREbiLVLi5ab6qHIJkrcgxQt
	11L4RMw6v7Zg77ryTKanvU/9CO3k5ZTTeJjJWmUi9Cl5MLkL0C0OZvBg0GvJb0Ck6xpiqnjVX3q
	xRBUD79WwCv5lKIJcFWJlLqf8a9fxz91heWWhMy9klMoKTF6durUGHywf9MjBGkTHx3+nxPO/cm
	gMctRUllq9R+f00nys7NvEliLJK8po3uvgNzjySGyLT3lEKiMlkMEwKmb7Zi799oVfAtnEB2U51
	ZHxFsT0K8XJS0fDi0H9WMGSWRKxlpAVCGWEI/hy43/AaP0SkzsgtOoYp4gfTeiK8+sHlcMH6Fd1
	BsKBwEoEzl+l3MnRfetGVT6bN4zgb2BR+6yJiaOhbbFc8ILijRDxkQTM7MRMRNj6S5fyX0p4k5P
	wsG1PW02k8dH5kwBgSKqKPdt8FaKUAXuhfgJ8irXrOPAYUtK9FGwwxKcvR6CnfgcZE2JBZW
X-Received: by 2002:a05:620a:d8c:b0:93f:2571:c317 with SMTP id af79cd13be357-943f4bc5d77mr2682685a.28.1793029317058;
        Mon, 26 Oct 2026 08:41:57 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47cb85f3sm75112816d6.36.2026.10.26.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:41 +0000
Subject: [PATCH v6 5/6] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261026-b4-setfcap-userns-v6-5-25f10b7ca497@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029305; l=5986;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=sZPBiHwnYa3YycPMYlN3oxrwhjCY5GQuMbx5FDiasfw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAOy2GGiePgKQcYEt41jyZFpxZWhl5CSTt7eOc7pi3b7QRX9tPSazsl0Fhaupv0QLEf91zBxu/s
 vJ+EZOkrSEgU=
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
reach the root users of ancestors that tasks in the namespace can write
file capabilities for, or the tracer has CAP_SYS_PTRACE over the topmost
of those ancestors, which gives control of tasks there that have
CAP_SETFCAP anyway.  As in setns(), root users stored through an
idmapped mount are not considered.  A tracer in the target's namespace
got in with as much and always passes.

Targets in the initial namespace, in namespaces created without
CAP_SETFCAP (what unprivileged users create) and in namespaces that
don't map the root user of an ancestor (the usual container) are not
affected.  What remains is a tracer that gave up CAP_SETFCAP and
CAP_SYS_PTRACE and a target in a namespace that maps the root user of
an ancestor and was created by a task that didn't give it up, which the
tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 4e0b00b7b1a3..91ed4a5f4b25 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -254,14 +254,41 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
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
+	/* setns() only lets in tasks whose CAP_SETFCAP reaches as far. */
+	if (cred->user_ns == ns)
+		return true;
+
+	top = setfcap_top(ns);
+	if (!top)
+		return true;
+
+	/* CAP_SYS_PTRACE up there gives control of tasks with CAP_SETFCAP. */
+	return cred_setfcap_reaches(cred, ns->parent, top->level) ||
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
@@ -282,11 +309,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -297,8 +328,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -314,11 +348,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
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

