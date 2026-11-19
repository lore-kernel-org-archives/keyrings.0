Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084974;
	b=bEP59C9aM85sR4r/c+yR8CNid+QXQE8A7sec4cmIz1rTo+JO7cXOEKwO0n0GNCDm0H3F
	 MMazqzwG8aGAJaKvJSZu3Ifql7pc/MVB+4LJEOPzjQq5Yq37pZmthiZOYVUpar8ktNuN5
	 QcO9JknpVfNpEtLtRj664xGNo7TYg7WJm2bemndvQW0S97w6S00oz4WF1Q0qIWqEPbeY0
	 CehS8OdlyMo+z6Bb3g48NuHfBImNyKx5ffVyT1s39E6vOqwGBbuP1vIRb9CUoEM4/vtgU
	 XA3l+SdmZ4k4zYYRKTOsxGQQjbUnocyLDDvb5EpfQFytBT79pV84Q4pgL4C3cwG/FxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=K0VpW7YvMhl0iK0xeqDJ+A8D6OVh/Im/AWHWGl8sSUs=;
	b=sJ8nOJpOnozLAhpV7YEecqRjQBWP6j+l41ezTUzd4eHtIDpKR7a+JrvFJUm28x3Xx/4o
	 c+6bo/EEkjGTYNFOpIBq/rvmZpRpX6ToskVH6bJz7OqG/+UEl2eRGGercuYiFDnRjSqT4
	 m6zKlMqKPiim0OksDdqopR4/RT8vKT9LfR6nfpVfvLvGxa/X6puNT+cF3heq7HZ2cyJQM
	 iVBvep8fvpjUFX+Jh8Syeew6OhECFJpWhI0AhgbTZtfF4OuJYh8tj48zeUMvsDfSUJ5QA
	 zPaTSU8jIUKzJjQyKQrNzR5vKCaoQcmgv5f7j2couQa2/oOE1Dl8TCEHgf8RyQXMXHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dYYJaJLY;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4060A2611
	for <keyrings@vger.kernel.org>; Thu, 19 Nov 2026 10:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FE4060A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dYYJaJLY
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a615ab0c06so2610573a12.2
        for <keyrings@vger.kernel.org>; Thu, 19 Nov 2026 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795084972; x=1795689772; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0VpW7YvMhl0iK0xeqDJ+A8D6OVh/Im/AWHWGl8sSUs=;
        b=dYYJaJLYMnEy4RHfL1CMb2r8JwhR8Fj05tJ5NNGuIVCdKhXdZJxcZh0i9PI4QL5XN2
         pX2zoZMJBYFwTVHH92MwlpzaaH/gNBWrCtjMftVfCzEBCAdXVhVZx27dt2YfyaoiaPls
         +rc55ASA21ddeIQf6fCsdB+Gc89M0UK079O4SVd+CyEqaQtcdDRgshmU9sW1Xo6rC/4N
         JSF8BcFF/A9NCp8sA1fZyVWzRkXRFobcHIJTYRvZS3FOXKdhNiOQFfe3pVHVPjpfYalT
         M9uL8yqgrgumxmIEE+ZtZfMMd9pGyIQzxQ52pEwVY4asW/QsZI16y9dGpYiHSaXJhMI8
         6SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084972; x=1795689772;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0VpW7YvMhl0iK0xeqDJ+A8D6OVh/Im/AWHWGl8sSUs=;
        b=A5h7VhrqSVZCSczcYO61ioBRdd9z3p0cet4IVNLbYcMuCRz+i/ky44orhwgtZVpzo0
         xRksTMxhPug3l0dFBhlXtVGjnBAD+t5aRRIDoWPqDCmhLnDMmnOd1ouPhSwKMXdpelOs
         v83XnIaYZ97SMZryHjvxK7PvL670wckg94iWsG+jO2LMFKCmPlmV9llruvp5B7nZpbJZ
         p7TAz8SeLl3JUzwDGxl9mQS8x3aq1WeCGTR1+3o5rGTJ1uDEt3UoBtgE9CrlnAc6xfAL
         AdDd9HJbEQ73DMnRIN4F82zb8y1s6bsBrJN4/UATPURL207sg00fqftsRj8UPMeJ9uRV
         Tzag==
X-Forwarded-Encrypted: i=1; AL+hErEYUTI66piIHPnI7Jnj2VXUTddLoPc2pzVfwhc77mK+p6eCg8qRx5337eE9fcEcHeUnzG6I8g3auA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+sqJFovxHxcR1Tadg1oqHdKuoOKwQn1AJLjfqVE/zh0qKWV3s5
	ZxX+HnX42nYkYsAt5xE/q0Ew69UOIbvvc+UKWzCrkgIxA1c4EFgUM2PNdskRHa+rqH3nHHAK/w=
	=
X-Received: from edev9-n1.prod.google.com ([2002:a05:6402:a2c9:10b0:6b7:77b0:4135])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:d411:0:b0:6b8:ac39:bb96
 with SMTP id 4fb4d7f45d1cf-6b8ac39c472mr2401311a12.12.1795084971484; Thu, 19
 Nov 2026 02:42:51 -0800 (PST)
Date: Thu, 19 Nov 2026 10:42:06 +0000
In-Reply-To: <20261119104208.782900-1-halg@google.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119104208.782900-3-halg@google.com>
Subject: [PATCH v2 2/4] capability: bound ptrace and cred subset checks by
 userns ceilings
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Hallgrimur H. Gunnarsson" <halg@google.com>
Content-Type: text/plain; charset="UTF-8"

Same-namespace ptrace checks only compare cap_permitted (or
cap_effective), ignoring the userns capability ceiling. As a result, a
task with a lowered ceiling could trace a less-restricted same-UID task
in the same user namespace and use it to create a wider child user
namespace.

Require the tracee's cred_userns_bset() to be a subset of the tracer's
in the same-namespace check in cap_ptrace_access_check() and
cap_ptrace_traceme(). Cross-namespace implicit CAP_SYS_PTRACE via user
namespace ownership is already bounded by cap_capable_helper(), while
tracers holding explicit CAP_SYS_PTRACE retain access.

Also update cred_cap_issubset() so commit_creds() resets mm->dumpable
and pdeath_signal whenever a credential transition widens the effective
userns capability ceiling.

Suggested-by: Christian Brauner <brauner@kernel.org>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>
---
 kernel/cred.c        | 13 +++++++++----
 security/commoncap.c | 12 ++++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index d01df40a9a38..968122cdbf07 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -335,17 +335,22 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
 	 * the capabilities of subset are a subset of set.
 	 */
 	if (set_ns == subset_ns)
-		return cap_issubset(subset->cap_permitted, set->cap_permitted);
+		return cap_issubset(subset->cap_permitted,
+				    set->cap_permitted) &&
+			cap_issubset(cred_userns_bset(subset),
+				     cred_userns_bset(set));
 
 	/* The credentials are in a different user namespaces
 	 * therefore one is a subset of the other only if a set is an
 	 * ancestor of subset and set->euid is owner of subset or one
-	 * of subsets ancestors.
+	 * of subsets ancestors, and set's userns capability ceiling
+	 * covers subset's capabilities.
 	 */
 	for (;subset_ns != &init_user_ns; subset_ns = subset_ns->parent) {
-		if ((set_ns == subset_ns->parent)  &&
+		if (set_ns == subset_ns->parent &&
 		    uid_eq(subset_ns->owner, set->euid))
-			return true;
+			return cap_issubset(subset_ns->cap_bset,
+					    cred_userns_bset(set));
 	}
 
 	return false;
diff --git a/security/commoncap.c b/security/commoncap.c
index ddac8e917680..786f99eb6838 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -157,7 +157,8 @@ int cap_settime(const struct timespec64 *ts, const struct timezone *tz)
  * @mode: The mode of attachment.
  *
  * If we are in the same or an ancestor user_ns and have all the target
- * task's capabilities, then ptrace access is allowed.
+ * task's capabilities (including its userns capability ceiling), then
+ * ptrace access is allowed.
  * If we have the ptrace capability to the target user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -179,7 +180,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
 	else
 		caller_caps = &cred->cap_permitted;
 	if (cred->user_ns == child_cred->user_ns &&
-	    cap_issubset(child_cred->cap_permitted, *caller_caps))
+	    cap_issubset(child_cred->cap_permitted, *caller_caps) &&
+	    cap_issubset(cred_userns_bset(child_cred), cred_userns_bset(cred)))
 		goto out;
 	if (ns_capable(child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
@@ -194,7 +196,8 @@ int cap_ptrace_access_check(struct task_struct *child, unsigned int mode)
  * @parent: The task proposed to be the tracer
  *
  * If parent is in the same or an ancestor user_ns and has all current's
- * capabilities, then ptrace access is allowed.
+ * capabilities (including its userns capability ceiling), then ptrace
+ * access is allowed.
  * If parent has the ptrace capability to current's user_ns, then ptrace
  * access is allowed.
  * Else denied.
@@ -211,7 +214,8 @@ int cap_ptrace_traceme(struct task_struct *parent)
 	cred = __task_cred(parent);
 	child_cred = current_cred();
 	if (cred->user_ns == child_cred->user_ns &&
-	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted))
+	    cap_issubset(child_cred->cap_permitted, cred->cap_permitted) &&
+	    cap_issubset(cred_userns_bset(child_cred), cred_userns_bset(cred)))
 		goto out;
 	if (has_ns_capability(parent, child_cred->user_ns, CAP_SYS_PTRACE))
 		goto out;
-- 
2.56.1.708.g77570a6a1d-goog

