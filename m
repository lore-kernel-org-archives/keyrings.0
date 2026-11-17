Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945284;
	b=gZD0mzSfZavcIXoNoM4BAe3WwUGYbdwg1XVRbYUfvdhDsSforr8ELAEDXK8om2Gr6jIL
	 GWh4jhfJ0xRzSwJkumsGkBftKq2mrxk/+CM0dCiKXjFxh571KwkJ/SUfw3yBthe2lapKh
	 +1KY3fKSJf6Ikdvjp8mV/1DZTLpxIbNixH7ZL9tAUGN4dmB7sKJe9xew+nfz9V4iLjxTz
	 WvoKwKm1XZoYVYv6GAlhnyZxz+EmQRPqJ1X83tZWPl2lLq5hcFJOufiIvuFf1HZnVQv6u
	 oyLSXRa4Ux+PDERaK1jt7ig3Uls3EcWPTPZJE719miIVx8azd7o2aJS0mqWzwXvZF0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=IRbkQNPp6ntUJQd2Szokx2Vqksl74hRyEGUsWCtzMq0=;
	b=qsneVJ06k8RkOSU1V8I/WsOXE2vLBID6HHztoYRhRkhRjuUMx8vKHjBRSlqnYeM+zR+5
	 L5MMJDCQXjhGj55XBFhf68+4ZuNWgh0fPnfLNGKq9LENUOwrpPfPUBhFsj7jV3m0xtt18
	 xSUHJtwud0PXqpD4Yz6Bvt50AXH1sGqnYM7P+ZRFV9MmkS9i+mDY6EgO2zVJAKg0U2Sa5
	 pj3mih6iQi9mHNt1qfMKsU/wLfTlqc2qz8Ne8jMLsiSOVzwmDntMgXMM8OH7eK8mWKjbb
	 0YG/GT3SJbnC6bykmCEO5YMTLxix5Qg4I2rtSr8CnAUyJjOrANlyfed9htyIoPabSxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=G4oxusNa;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9248606A882
	for <keyrings@vger.kernel.org>; Tue, 17 Nov 2026 19:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9248606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=G4oxusNa
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ea0c05c92so1035556d6.0
        for <keyrings@vger.kernel.org>; Tue, 17 Nov 2026 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794945283; x=1795550083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRbkQNPp6ntUJQd2Szokx2Vqksl74hRyEGUsWCtzMq0=;
        b=G4oxusNab08YLPFjGW1AQXB7wskmOghIX+kykyozMCd0ezw0zDhxw3YlKz0rwjJtcg
         prHhOceF/hahgLIveceOFGpV/zbTRIcmxbYb9XKApWt4kIcYFtz+XuBa4Q+mKlPQRHxN
         SPRwi0HdHLmHfaCRq0rMrhgdb7pq4s9O/LvHEO4DYPYgx/rgqJly/aJD6HO1IVJ0pdaY
         hqYrXfoOxMrIjt7YRfY5X8r49vxP7Kl3CnlZv2f77e7xe/veJL6g+V9f/v3VExiX0jhd
         Q/TdSaAr5DrQXQH0oi96Blfq/sgZEJDulU5Av2RXW1eJNDsyQ5mTOMsWK5CmArn3WPHk
         YsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945283; x=1795550083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRbkQNPp6ntUJQd2Szokx2Vqksl74hRyEGUsWCtzMq0=;
        b=HhitNmdw3dcBqKoqygvgQnR2h2ENb/plIdL8eCC2EW7B0M8fDjw4D1IHx3mMRMszc8
         lw/WwsB/MKO2TCLl04zpwA9khJMjPMPRcqJP1KBLSEKwxBf+u7Z4tgyecj2xRqcH3Cn0
         gOAy6UXfvM4i1BJcZtnO90B11H1/wTQ5IE2P7ZQX+XD74Jl0GOU8wUh7Snqbt6B56YVS
         NU4UgOsv5w5O7uI4TW46q46LCo4tEM5ZxekaJiUeU6VnWGAU5Q63roiZsZAxSHqhaQHM
         oPXqSu80uMwxC+BhopAILG8ubel7vH2FlwFOQKA27Q50fwMAFbscOva2a/D/fgNiGcjU
         07Cw==
X-Forwarded-Encrypted: i=1; AL+hErEMejdaZCaWGmxGZUnI5HIfhbB5WUpsR/7NIRudRhRbh079vMcjFnGvdMuCWveklz/5LTWvIWZEAA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9j/ikCnnMdoXH08G74vlaaBUoq9XMPc45aIfesFaZwBGoeYOlR
	3Zr4BQ14esKC8+9A1a5aFgH/+zVTGiLqUOHM3exduX6XOuAUuknkMmBdKKyRkiIdQ8o=
X-Gm-Gg: AZFdTZcy01xYyZFces0sEIXa87ePyv9QKA84u0RU/+wRhGcJ0Py7KlXs7q2ZidzDzVb
	mZHZIK84Mn+TlONmiVd/EXcPfYiAp4B+5KVI2Jiqo+/KoFe4+RHIL7NELNRY8pKf/33Qg8+GL47
	3xC/jqRXj6CfjZmGm4VeUC+USuGXrI3YlO+fm4ZMYL906z8XHS96WQeqTZn11sY9prJr0BLaHT9
	sgHS5JZdBd6SbqkAXLlfO13MdY4gVQHmriikvelYisRzOkEvg5TVuu7rHViOt+FdgSnR8Ixxxc1
	eEKGxNd6lga3DUj7uRM9omm3fxbmKdVqt1pKlwQjQ5BLfJvLxp7Pty8bKs4kteqaP5Vm/3tqj+e
	PFMkgzTwXw9oi+SzWDsrv0qm0+6sXCuJhOHB5IfqFk6SXnjdBakBb3XZ73QpfZUzbqFPfGytK/I
	rBQoE9vlUBo4M00jFwpT/V4k1XmpXyeuZawVIPFy/865pynb3Q2xs3+LU4+a2NTlDTAOr5vYmII
	WlMA5KC7nAF4UOTAtuvjCCOSgWGoL+kdVj54LsIp/qs0X8zp/4Gz6b3BRehUT6ioSLFsD6MvsoZ
	BvzqplFOYOPZhaocP5iK+rxCTn/IWXR5UBa3PtvVoNOlEg==
X-Received: by 2002:ad4:5e8b:0:b0:91b:90a2:df1f with SMTP id 6a1803df08f44-92114e6fdeamr3745716d6.49.1794945282921;
        Tue, 17 Nov 2026 11:54:42 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d4f6f5sm2004996d6.22.2026.11.17.11.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:54:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 17 Nov 2026 19:54:25 +0000
Subject: [PATCH v11 2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261117-b4-setfcap-userns-v11-2-2be11a2c32f4@toxicpanda.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
In-Reply-To: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1794945277; l=5767;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=F125fGDs7ydTeCQ/ehR0JMC5GA3SzY2kn8ha8b8bbz0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAjHM8JRRaZWP2g13rjrJAmny75aaAO5JZA1jABaojOz9vbXK1SAOoOT0fgD7dj8g4W+gvv3oiS
 O+DeAygMvFg8=
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

The target's own capabilities are no guide.  A target that gave up
CAP_SETFCAP can still get it back from its inheritable set on execve(),
take it from another task of its namespace if it kept CAP_SYS_PTRACE, or
write "0 0 1" to its namespace's uid_map while there is none yet.

Every PTRACE_MODE_ATTACH check is refused, so reading /proc/<pid>/mem,
/proc/<pid>/stack and process_vm_readv() of such a target go too.
PTRACE_MODE_READ, a tracer and target in the same namespace, and targets
in namespaces that setns() lets the tracer into are not affected.
Within one namespace the usual rules apply, as for every other
capability.  A tracer with CAP_SYS_PTRACE but not CAP_SETFCAP is refused
as well: whether CAP_SYS_PTRACE lets it take CAP_SETFCAP from a task of
its own namespace depends on LSMs such as Yama.

Fix by refusing PTRACE_MODE_ATTACH and PTRACE_TRACEME across user
namespaces when the tracer doesn't have CAP_SETFCAP and setns() would
refuse it the target's namespace.

Suggested-by: Serge Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 96ac039fddad..4a78939d149b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -195,14 +195,31 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
 	return 0;
 }
 
+/*
+ * A tracer that setns() keeps out of a namespace mustn't take control of a
+ * task there either, whatever that task holds itself: it can get CAP_SETFCAP
+ * back on execve(), from another task of its namespace it traces, or by
+ * writing the uid_map of a namespace that doesn't have one yet.  Within one
+ * namespace the usual rules apply, as for every other capability.
+ */
+static bool cap_ptrace_borrows_setfcap(const struct cred *cred,
+				       const struct cred *child_cred)
+{
+	return cred->user_ns != child_cred->user_ns &&
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
+ * For PTRACE_MODE_ATTACH, if we don't have CAP_SETFCAP and the target task
+ * is in another user_ns that setns() would keep us out of, then ptrace
+ * access is denied.
+ * Otherwise, if we are in the same or an ancestor user_ns and have all the
+ * target task's capabilities, then ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -223,11 +240,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -238,8 +259,10 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * cap_ptrace_traceme - Determine whether another process may trace the current
  * @parent: The task proposed to be the tracer
  *
- * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * If parent doesn't have CAP_SETFCAP and current is in another user_ns
+ * that setns() would keep parent out of, then ptrace access is denied.
+ * Otherwise, if parent is in the same or an ancestor user_ns and has all
+ * current's capabilities, then ptrace access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -255,11 +278,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
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

