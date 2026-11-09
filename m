Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253771;
	b=F4d+MIm4cdJt7io7ObsXUM0KqZg3m3skS61IM2o98pxEFFztrP9+jFEe98kulZZAAdsj
	 wYK0vh7JEvkhNXuC/Ws3iFPdds6HwJL894PGnfQ0N7L3AeMzgrlVZGwTRg173/Eq0aAEv
	 BAjrC2RWFq2FspqksdE3CwLVzAEXdVn8MOcq21d4Xbq3iFnS2CzQl9tNsvIJIq0cbYr2K
	 Oifdq391w5HbFIpHV7lylNI0MYv7uJAckdNR6T0OSTnIhExKJs/GhJJ6Du3Kv1SKB9vTq
	 4V+98GgzqfKGWD//mcOnzYFo11ToMBQVz07yexUAed4nFUFgefZCxhcCSzlXQ7vb1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uAhDYlvK2+3qASZfUSpUAqvVOjwzZmifCoWceYJJL+M=;
	b=BwypCxeKO3SNSkFNVGm8X7cNdbt4f3XVZ4UccQYMCKXfislQGytendGPlO/Dkpj4iguX
	 k4gsBMvnV5PK/FZFSKLFsWfwnYSrhTIn82aCeJyNoZyKABbJUTo4Pzk+zyRVqyuEvxU/f
	 a41AnWKYuRN2IHIae+cWQikKzE+gCfR4mexvvZrESlX3TLRxyf4yqj7ywOPfpCht/xbNa
	 DvH2vxPHDLQZBVUBVLtuMn0PE5t/UoHCvEyQ53yjQLLFxSGZuBnbim9tUFicCjGvwJdkp
	 kDleNlrHHTOi2ahEDVX8N46R1BojPHSYpd52zmhOUxrye3lLoUGKvwnTXrak1fMecyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kLJWX1rn;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5D60A2615
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 19:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD5D60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kLJWX1rn
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533861a59b8so15122041cf.1
        for <keyrings@vger.kernel.org>; Mon, 09 Nov 2026 11:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794253770; x=1794858570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAhDYlvK2+3qASZfUSpUAqvVOjwzZmifCoWceYJJL+M=;
        b=kLJWX1rnQ4huf6ru90hKR94H2MqoKMZQcLtp76N3m8CiAgzT9SoQmLSZFX3ANeltSP
         a0pC4kHpj+YUiKTTqalVcFKVjLdBTd5Yifmjld/3iG9UHYdkpkU6mr9sb1eRuSMxXcNU
         +VyF4Ofs0bWCTVxmC/OKXAweMbee8q1LPfgV4wcyP4HM8HJnW2B3HZInJDReW9bVKUZE
         Dpb/NUCKucpgfYwzJIr+8mc9APTETTGtZBQb0Zs8n7IHmHjK0lsE9HPKrXkiARRwHSF9
         GynzBH18Ec7hrszmXEtIMfJOvwIqivK/ZDqUrZxO85oEglZp0LKjEdJYfOZHyNUxdvti
         Zd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253770; x=1794858570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAhDYlvK2+3qASZfUSpUAqvVOjwzZmifCoWceYJJL+M=;
        b=u99VGipABV83KAiBjDOcdw9pnL2VvMUcycQX0bbzKbkRKsC4l5BaTtYfIIltyht5qq
         +mEZ1lK+5z7Co9BJY+2OtcRaWx5azce8MfR9vwxndbbC0Yy3HKx+ahoeCy/H71A50UT7
         +VoDYfeXR5R0w7IUj9W6sggiukzoZNmc0LABrMTHwgbTW0UwD9Cyot9t8wYjX97LFBXK
         /o3PqaJDsUfcPJ0PwF5sRbey60R22XIA11TeeBq/SiE4pcJXbCeMNm7SgUJvQMj4fR82
         NZd3uCPTiqbwEuILJy6o/w93QptqVaI9h+3dKRALZwIGDuADxYDRB2fOyxV4koAxxqhx
         NPYg==
X-Forwarded-Encrypted: i=1; AL+hErGPGAjUU2fd8gQGxM5mDRkCBWHtSXMiY8t0Ow+4+HFwXVHM4y29WjMLyOp4K8ZpP0508OCLOcddxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/xOZHPoZPQfpofNtdcensCv1GIRrfkL53n73cKeeRY9w2Qqn4T
	Nmm05f2f4xviP406IlXEZDF5g11ckUNJUn/aYw5K5hP+DHXLtvwTnbsmcN+RlAwVVfs=
X-Gm-Gg: AYBFou2M/rlZ0YbTbvB7pPOY+xdyHD31OFzIwBcdDuKlPj8CT4rlHFat/HlaCUM31LY
	zLOoNZiur5+iuGhWEcIQE3Ji7bwlkQNpQLdAun428JYoxAwpjq7LU1/zR7RFYiv89NzSzvwDU0w
	PIpn0U4nfM49q4YUofO8xvqvn1dz3Uz2l7LT0IwsHiP+wJw1CBeDYbpDlcE6B5escW3qZW6Cqh2
	nGWQ/4hziGqlB9Dxu06PDwBhe0bKB1+70BQ5pEJgOHdkyFuok3hsZfjlmPo02tAk7oWMIBqC62v
	yk3jgpBdl85UETNQqTFvqVl93dEGVRjsbzt7ZOJM4eKceWSInGkj7uL8SrvyHtTY0t7OUTBBoBj
	IgCgrcITT8K5NxsNSr2B0LSulxjoTic+Sn6jNxX2igLdEbWqdBPvbvoDQXl1JfxZVdEh9mAhPHg
	L0R0ygCG/iTGaR/SfsUc5skWpaImlUTj9sr0YS8rBq3zygSPRSLqhkhw3kfY1g3zFFXQbi8cf8w
	1WOUKLdpRNojw9GGfSkx7yZnA05eppXGz0mhTZMU6F+KLIm9je/N0GoYOVMruWBZ0HuBq+Z/+fa
	m26/3wUMItrm7i9uX3M1Qv00ljghjDvUmP9U4+vUHaBfAw==
X-Received: by 2002:a05:622a:299b:b0:535:70b5:806 with SMTP id d75a77b69052e-5552b15e49amr5380961cf.62.1794253770039;
        Mon, 09 Nov 2026 11:49:30 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555091eb7f5sm5387711cf.1.2026.11.09.11.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 09 Nov 2026 19:49:11 +0000
Subject: [PATCH v9 2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261109-b4-setfcap-userns-v9-2-0d3f00976ce2@toxicpanda.com>
References: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
In-Reply-To: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794253763; l=5442;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=lQ7qdUcZnQWLmwtfdxuLRnWVpPjrrhXHWgXwETwVEx0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGRzRC7SrJKU30VGPsSGvEfeY4y1dbq+wHdy6wOSjMoKv/0Mz2Vww/Nf+w56aBPHQqRQZSS0a6e
 AAvhgPwfF3gM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A uid 0 task that gave up CAP_SETFCAP and CAP_SYS_PTRACE can still
attach to a task in a user namespace that another root task created,
and have it write file capabilities for its root user.  For a target in
a child namespace cap_ptrace_access_check() asks for CAP_SYS_PTRACE over
that namespace, and cap_capable() grants every capability there to a
task whose euid owns it, whatever it gave up:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP,
  unshare(CLONE_NEWUSER)              no CAP_SYS_PTRACE
                                    ptrace(PTRACE_ATTACH, A)
                                      euid == ns->owner -> allowed
                                    make A write "0 0 1" to its uid_map,
                                    or set file capabilities

The same goes for /proc/<pid>/mem, process_vm_writev() and
pidfd_getfd().  setns() refuses B now, so ptrace is the way left into
the namespace.

PTRACE_MODE_READ, tracers with CAP_SYS_PTRACE, a tracer and target in
the same namespace, and targets in namespaces whose tasks can't write
file capabilities for the tracer's root user are not affected.

Fix by refusing PTRACE_MODE_ATTACH and PTRACE_TRACEME across user
namespaces when the tracer has neither CAP_SETFCAP nor CAP_SYS_PTRACE,
the target has CAP_SETFCAP or can get it back from its bounding set, and
setns() would refuse the tracer the target's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0ece141c68a6..d550a4e5d36a 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -176,14 +176,35 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * See cred_borrows_setfcap().  Within one namespace the usual rules apply: a
+ * tracer with CAP_SYS_PTRACE can take control of tasks with CAP_SETFCAP
+ * anyway.  A target that still has CAP_SETFCAP in its bounding set gets it
+ * back from an execve() the tracer can make it do.
+ */
+static bool cap_ptrace_borrows_setfcap(const struct cred *cred,
+				       const struct cred *child_cred)
+{
+	if (cred->user_ns == child_cred->user_ns)
+		return false;
+	if (!cap_raised(child_cred->cap_permitted, CAP_SETFCAP) &&
+	    !cap_raised(child_cred->cap_bset, CAP_SETFCAP))
+		return false;
+	return !cap_raised(cred->cap_permitted, CAP_SYS_PTRACE) &&
+	       cred_borrows_setfcap(cred, child_cred->user_ns);
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
+ * For PTRACE_MODE_ATTACH, if we have neither CAP_SETFCAP nor CAP_SYS_PTRACE
+ * and the target task is in another user_ns, where it can get CAP_SETFCAP
+ * over our root user, then ptrace access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -204,11 +225,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 		caller_caps = &cred->cap_effective;
 	else
 		caller_caps = &cred->cap_permitted;
+	if ((mode & PTRACE_MODE_ATTACH) &&
+	    cap_ptrace_borrows_setfcap(cred, child_cred))
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
@@ -219,8 +244,11 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If parent has neither CAP_SETFCAP nor CAP_SYS_PTRACE and current is in
+ * another user_ns, where it can get CAP_SETFCAP over parent's root user,
+ * then ptrace access is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -236,11 +264,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	rcu_read_lock();
 	cred = __task_cred(parent);
 	child_cred = current_cred();
+	if (cap_ptrace_borrows_setfcap(cred, child_cred))
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

