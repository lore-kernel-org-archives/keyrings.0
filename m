Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521323;
	b=zWz+mbkNPa5EC7Oys2PR/Zh24M1k62VY76c40/QCAKxkG74QupAyDT8OfZq3yyFWnMvh
	 uwbTOk/bWieAdcrF7MKOdgiKLpzm7CueuCRgbwlwQuSB0pO74/BUBcqZxyXj04wYV4dMm
	 ZrFCYzFgi+rksgqYaHkoiMf5l0ip8Gr9O9QtGu9AzKWq9T3yusG6z3DOzXKIiJt//hIHr
	 fxfgjzxen2ZBVX6TsD5ZlNcN/3xyTw2v8r1A6GJaHBfVoe72TasDHKbZRGo1p5xK852ts
	 L+RXCP2dYChiBOV0M5wYfhZGBHP6nfxKVTSw7wnVRWr+R7rEmFLKvW1lX0nXy+ySFZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=EGz6t+nadkIYsChXWmYseOA5mfkYKT15SuVuIDD9+dU=;
	b=YMxjQFKBpxwETiYkxF4Ef79+rf2n7wmEFegKWmt0TjEJJLscmxzztvOmzdZyI8l+9cix
	 wma4CoDuVGBv81nDSGWcC39CdTwGtx7vEZScBWd56WViwCCd0HcBiKbUS332RP93LcgGZ
	 S4GbTan47rZH32PMnvBcrmfeF/Wg7wRe5Bs2luIVBEriGCpsxJRIjfObDHa1qtLAhoqwT
	 TOC/Smkcrk1+i3zN0biujCRCNAnJzGmL2Q5qUxtkUfJGVNhrs0p7jNrOzWC91SLiuVl4s
	 GOhvRM4yLr/qBssQh10GyMpArVtUDZRUwwBigjx2hOw5ZN7mnfSMSlm7pUtqsqfM2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FOEkVr0W;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9B606A32E
	for <keyrings@vger.kernel.org>; Thu, 12 Nov 2026 22:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC9B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FOEkVr0W
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91f0ab17747so5248236d6.1
        for <keyrings@vger.kernel.org>; Thu, 12 Nov 2026 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794521322; x=1795126122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGz6t+nadkIYsChXWmYseOA5mfkYKT15SuVuIDD9+dU=;
        b=FOEkVr0WbYBthIcM9gohDEiRWLPmqrVx8j/mybaA2Lnd9dVdwESHthVXTLRcRHgLMa
         Mi2menhOhNlhQsX4CSSXE4MzcojD7W6iFEnsYknkWi68V+kGeVEcX5mq2APJmGmL2q7I
         J4vO7NJIcYE1Yp1OHwSqwG4RKsui5qbbdRR6LjNJGVmhs7Q8Wbou4SLYnt2/CARZvkJO
         arKryryHW1I73Z3CzPCqkr1b54XxAbq0dMpNLqnAdY39na6U8KxZIwrNvYKfhaFwf2eS
         9krFaTGm+1wX3+lZ8XQe/WxsFbL8F7ZwpsFKCzZ7VqpLzzPOz82h01BebnQqyXR9JV13
         YyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521322; x=1795126122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGz6t+nadkIYsChXWmYseOA5mfkYKT15SuVuIDD9+dU=;
        b=kA1ofVV+ma19Y5eyXcfQp+L0zvGZ4AIAMgdgrdHeIfnSCjZEL+IZB/a/ISM/Zhciqp
         d+bykSvnVWK0LCsAiZXcButebfWx8rOBQeex4QWOUG08ASxWmglXEojmP6se4xcc8bDw
         4XXrsNo7n0g1pw5NI7SpOgXhzl+X+MWR9kHzfP5CyT3sjInHXpgYrNpWZkWqOvrQHdQU
         7PCDQrReyGezZ3X3KrFAYvTIDdO++xhr5L1z79afIYUMKvWYLqV0llMV9e34rhdU5IVp
         f40HOIFBa+fcVuT7bXMpjEWoSdN6QuQlFx6P171pNpcb7u9G8EPNcr2F27BLCwzBBscg
         50qQ==
X-Forwarded-Encrypted: i=1; AL+hErEt5gW1HBvwY1BBeyMXWH4EOgfwedhxgR2lsIcuS5JiEtJmF8tFu3sTFzFEfXrVsFZDL1WSlspJEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+BwZR39ME6farZCwutoNntFbKbADjQfcU8vLIOs/VOHKwWRL1S
	9k7LWUpxIk8JePFwyODZ0sVq05lHqPFPD7wcmCxZ0zedzXIzQ+GBftSw+4BlSN2oO18=
X-Gm-Gg: AYBFou1bxkuaJbv01Wozq5JWiMvZBPQFhV9VmA2/wTuPBud4w6PbBz9AnrZqOBmKd3K
	qoInoln6dbb5l1C491XBwVh7DW3ZXHvodiEh8xLJz33vVTp9MMjGn3Ac0uO7Mg9LMcVhRxhcp9o
	9sj8LGXCFkOn694gYlorrm8b41fyg9PLPT1RxJ/ojGywPw5TsSh6c4QJz3uD76M6kQfmOAotY69
	+7XhIdxYNbGjxnmV1mm0xycLht7WdI2co92RoAr3s9plgz8PCtS5VpnhJ5/1EYPCrzk7+uFNph7
	r9cf3Gcz5dr4EuWTI5daLLDxTuuVaZHIfdgWBkbyhizpWhNz9oz/gt5cDRPS6GvneALjasJKQJ2
	c8am2CrgIcMmDyKvyMlDs/MLvmCfNmeE12NgYPXvQCDPhhh+j4oWOd/oQ1nsE/yK/ZWO7F58lZG
	PtJ23KKx6pGBX/SeuZYPiv28AtlTvbzUPIGDBd28UG/NLPjvseB3/wGBHq52IE/j5A9He40Okke
	JM1+lPKms9uHRa9OgvHzYuXLMeVDTg3WGx9oQyGblanxBFDJeZY6mLtjbNzjdRtUFPbA9nFQYco
	DwHmFVQxOHkuP3Y6kjlGWAsrdsDhFVcSVAEASmVW9ehrKA==
X-Received: by 2002:a05:620a:439e:b0:93c:7e9c:3bba with SMTP id af79cd13be357-9494bbf688emr136728885a.41.1794521322104;
        Thu, 12 Nov 2026 14:08:42 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836156sm38473785a.19.2026.11.12.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:08:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 12 Nov 2026 22:08:23 +0000
Subject: [PATCH v10 2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
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
Message-Id: <20261112-b4-setfcap-userns-v10-2-84f6f7faa903@toxicpanda.com>
References: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
In-Reply-To: <20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1794521317; l=5767;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=pN+dVl/hfA+qMnI14kUgrGQzM5lAeve6StDgdvCYdTE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKTLy8hC6+/9/deEqTY5K0cP+1keUNCXeQBITpMeOW+PE7b+QuRTRFd7xZf5j5QvGBZGs4eC2hj
 jo372E3RVKAw=
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
index 99a77fe459e9..c43abf4f148b 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -184,14 +184,31 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
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
@@ -212,11 +229,15 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -227,8 +248,10 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
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
@@ -244,11 +267,14 @@ int cap_ptrace_traceme(struct task_struct *parent)
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

