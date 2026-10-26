Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048439;
	b=qKfT3wZxXtH8o8LOlLTQZpn1OmSpUzguLdyObv/+QBnW+SpN5vwlI9S39KFWzR1UL5mK
	 gANneHFRLDxk/S4ak/7TH3cIumf2AbUW7FHGCvqc/KJowj1l48iA/zuTjuAnYfsP+svGk
	 QVTH3izk6GOhjMJtirNKaT2E0kJePT/hX34OhMVbOhMaS7FGKNVYHBXFkN7XcOYdeFpcA
	 Nr4FYY96ww0XO4pJz3r9KP8w+J/VudC1m0FcETf+6nqGbtc0waDctamGHN3YsYykzlIm1
	 2dVOD/uxV6vDz0E0QDjLKi6OcgFk/bDmdTApSaP8zXZkPYHx1YVUXFHFrSsYOg4u6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=4m2YKKVD1UCA84JjmB4tdM4GpI9YGoRh1V41OODWAV//W4z/dSrlhYSO6RFsYpFv08Cz
	 5bS2scfTtvU2r4aEMa0xTMiw9WaRnN+jy0xhK5tu3PQxVZxrx13KM0daHJofD554OKLEE
	 7PFI+qiFluG7SZxXb4tpGEIGOgTCfLhltlN6E1Eq11+FI6hJ4O4Hk4Ism/GlBHJDWeVRr
	 wsdjFtgHc8j4eN4TRDwsyqg2yP3EEJfEil7Qe+iHOKSh4dnrLyEwy3irKw1E4Sa8UJPd4
	 LVUqNHVVPkgr3aqadCz25VtmaDGLKgQ53e3LSpQ0zL9lNi8udz0BuIno8QY5NHxBcSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=BLwKQn6F;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8C60A2602
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 21:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE8C60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=BLwKQn6F
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917c04630c2so38267496d6.3
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793048435; x=1793653235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=BLwKQn6Fi5H8ZbNI2H+RkZ+vtrmfkK10wJfH2YotYolD3P5zkZC3dpJCYhVG+yQkkU
         gzEHqfsnYt9XIvRLmAmzlWl9usdArchsDaEoKilvn+8SiGMMZq1/Tl6kyR++mInvc1Yt
         gc71x3LmV7nwBV8WVEXKU0Ct2RSn4EbLqln9jvCMDUV5v3szTXev9NysLHxFBKpSwNud
         ZMup73VzAooVoTzafh7y5/dDaRrX4d71IDmIpePvKC6ndbxyc083TRla7ytJvbP2KDRg
         j+YpBK2OurtSgIyO+4X701KGgtp37/+F7f4C3BCRMSWGRkuvLA2bQeeoF6z2DvZKcyEe
         ZVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048435; x=1793653235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=A+3H57xDKPP8J7PPuFGIUqU0wUTv9mG4AxaDrmQNIRbn7elFPUsesPIi/ffcz7PI0n
         Wjf4goZQHpdMJue35p+YGJMvcx6duU3Tdq7XmbP36PjckxJsO1TT2iRvWNsmDZ2Rvyg5
         df5HpTgu8tApFs9DbeEUhK2ZB1UbL46eEd5wUfn4Dru/0EXTNKxAFNR3AhP90KS+dvH0
         RHZCeow1B799kq7apeNvdVuIVmVF6I8lacsIyXs5N+5OgKvVgKRU5yEMJ2EZnZiGH0pd
         Gw7gJL/CHDRMAgq9Cet68dOJvkfMABtOKag4XMORDtIYHifW3n/h+H23U0pwpsYp/aND
         nqew==
X-Forwarded-Encrypted: i=1; AKwUvByyav5KxZHm8WfuFX78YEvR/FV7dT0YPs43CBqpw+K55AUAAUM/Geu+44/RJRuISs3j9ZrpN79jIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbQlSPGY4MTPsPZXkPK4gBYRtE1jLMEKvq+8jFsxEkHEwQQTTk
	BIru922pxwyrEv10N48FoRT9sSsXDM6JxTw0iW9FLlekmO3a1LqbdDnNrX85nei1cZTmD/Hy5An
	ms+Wjyxg=
X-Gm-Gg: AYBFou2FWFHWRGARtcPsuYO7FxUFyG17AQNZerRXgGI5T8Y63k1n03iwW54lnQgEmgY
	ZbAI1dpTCEOaFARpxqaAUJEWgSS6HWZ35Zr7LKpSFxc6TB39L6uaryRn77K7bYAtXemcZIE3pd6
	yOda5XywBDB8ea3P1GDYNpWhgNtKfV5XKgRs4uZLV8dP4rA6apOZAg0UiUQSo3NZUovh/uoKptI
	wpbId/gfMINzETYhjmo1WxITiQfAy4ygSMD47tyYD1bl0ngAveN5sGvmZVQEyL7oPtYLjJK3e8v
	hoaRrI2bxHMMfCJ7oH2q06Va0J7NQXW73fA3Rf9xpE6H9wWZYf7hn/ZBnkvM1Hx9IYlSnCRLmES
	9yccv0gJvV8MujJ5K+KZkoFAXXXmIGcP2043hdDKVGaqPEvAU1MCAAWV2beGteH85jGXcppTB7O
	ofp4QrisaMNwQCyOJ9WBqkKclvn/Lendx2aMlk7gKoaIUPZly6HcooNkB6LGBKkJKfemBZwUy0S
	Adgr9QsrCNlfsD7ry7AXRjTQ/3L4e617ROKCR5WCell5Mwy7EsiLFyZifDbPGkmZI9YizrFQr87
	Fuu68ISqTaF7g53lRw==
X-Received: by 2002:a05:6214:21e4:b0:91b:8fc9:417d with SMTP id 6a1803df08f44-91c48e7fca1mr138560226d6.35.1793048435019;
        Mon, 26 Oct 2026 14:00:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c96375sm82875786d6.33.2026.10.26.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:00:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 21:00:20 +0000
Subject: [PATCH v7 2/6] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261026-b4-setfcap-userns-v7-2-bf8a576f7259@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793048427; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKRP9p7Y4tKjH9ZoGRozJ4Df14LwNX7qnG5PhuVi/E2OgFp6a281oSYOheOdJtkwSplfOhyguvX
 7Rlr9blxsvwY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  A task that is already in the namespace has a
full capability set there and can't be asked any more, so
verify_root_map() goes by what the creator had, now ns->setfcap_level.

But setns() lets other tasks in, and they get the full set as well:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      ns->setfcap_level is A's -> allowed

or, if A's namespace maps uid 0 already, B sets security.capability on a
file.  Either way B ends up with file capabilities that are honoured in
the initial namespace, which it could not have written there, nor in a
namespace it created itself.

Refuse setns() into a user namespace whose tasks can write file
capabilities for the root user of an ancestor that the joiner's
CAP_SETFCAP doesn't reach.  That is the case when the namespace maps
such a root user, or has no uid map yet and its parent maps one.
cred_may_setfcap_userns() checks it, and cred_setfcap_reaches() is the
comparison it and the later checks use.  Then every task in such a
namespace is entitled to what its setfcap_level says, and the checks on
the way to file capabilities can go by the namespace.

An idmapped mount can store a root user that the namespace doesn't map,
for example a "0 100000" container whose rootfs maps 100000 to host uid
0.  That is a deliberate setup and up to whoever creates the mount, so
it is not considered here.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace that maps the root user
of an ancestor, and was created by a task whose CAP_SETFCAP reached that
far.  Containers that don't map host uid 0, tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces are not affected.

Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undurchdringlichen-35666eb62cff@brauner/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  6 +++++
 security/commoncap.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 026974a5111b..e4199b03668b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -224,5 +224,8 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level);
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..7bd3692c2f3e 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,12 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Tasks in the namespace may have CAP_SETFCAP that counts outside of
+	 * it, so only let in tasks whose own counts as far.
+	 */
+	if (!cred_may_setfcap_userns(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index 4f49dba65426..8a9d998b1897 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -158,6 +158,64 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
 	return cred->user_ns->level + 1;
 }
 
+/**
+ * cred_setfcap_reaches - Check how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ * @level: The ->level of the ancestor of @ns it has to count in
+ *
+ * Return: true if CAP_SETFCAP of @cred counts in @ns and in its ancestors
+ * up to the one at @level.
+ */
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level)
+{
+	return cap_setfcap_level(cred, ns) <= level;
+}
+
+/*
+ * The topmost ancestor of @ns whose root user tasks in @ns can write file
+ * capabilities for: within @ns->setfcap_level, and mapped into @ns, or into
+ * its parent while @ns has no uid_map yet.  NULL if there is none.  An
+ * idmapped mount can store other root users, but that is up to whoever sets
+ * up the mount.
+ */
+static struct user_namespace *setfcap_top(struct user_namespace *ns)
+{
+	struct user_namespace *seen, *p, *top = NULL;
+
+	if (ns->setfcap_level >= ns->level)
+		return NULL;
+
+	seen = READ_ONCE(ns->uid_map.nr_extents) ? ns : ns->parent;
+	for (p = ns->parent; p; p = p->parent) {
+		if (p->level < ns->setfcap_level)
+			break;
+		if (kuid_has_mapping(seen, make_kuid(p, 0)))
+			top = p;
+	}
+
+	return top;
+}
+
+/**
+ * cred_may_setfcap_userns - Check whether a cred covers what a userns can do
+ * @cred: The credentials to use
+ * @ns: The user namespace
+ *
+ * Tasks in @ns can have CAP_SETFCAP that counts in ancestors of @ns, see
+ * cap_setfcap_level().  Check that CAP_SETFCAP of @cred reaches as far up as
+ * tasks in @ns can make use of theirs.
+ *
+ * Return: true if it does.
+ */
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
+{
+	struct user_namespace *top = setfcap_top(ns);
+
+	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

