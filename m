Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75ED4AA570
	for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010897; cv=none; b=OANMEeBvhh1jWSwOH1iECgHW07f8RwaFFI0TpKuaTpEr03EuSgbEL0fDeNYqASY3L0oGWV1CfIWH7TXdmPNXlvcdMa73XWrCP4Qz2G1GfjgyQVw2VR73G2chd1SPdH2tGzNliOOItlyCPenGm7KOiPZiouw0JMwvYBGDNb1gRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010897; c=relaxed/simple;
	bh=SURLLXVKbdJe4oh+rQN5mZZp8FsoWoJcWswVlOyrRPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGmZ2bNcsykFPeQDWppeRAQYNB8RWGP69YRb3AhRDzEpyYnNL03CwM5KFDnnNghuZcUtoydmpIy9bn/0TN0nEJPUtc6Wqp5GsizDPrWG/iNKQ31j4REeFrF9mu9QPdQboNgrB5juHo0ku/Wmrd8AprOjJs6/9LdNOVw25xEXUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=WdnCVCEP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="WdnCVCEP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f079a63b8so74807985a.3
        for <keyrings@vger.kernel.org>; Wed, 14 Oct 2026 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792010892; x=1792615692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6ZEVCcL2437a6X5ybbau3kMmqg+eTdm9EgDz7SIcRM=;
        b=WdnCVCEPeqZW2Sa9urGXg2u5AgBM6snzqtBrgzpZfZO3axleDkqEUX/fmSYU+IqKBP
         gTM08/X6eu/wtbLDFL+3JEEMAPz4WHgOEh6kVy8H4GVV60sxP89A8+2JaIKZwBA22rUK
         fkhqNINojrdTNGQ99N2wSm9yxqdJ6o1NMYQNr8cY7NGet51Plenm9anzcBv0yDG/4lAQ
         2juXqCtZInGZaMvrXHyvaqFfSSAhZWq5vR/N1iPTiBN+3D7Os184B5Fku7FYJkvlxZdC
         jEw/QgwRxEJ4M1BWqxW5kzdNcI3XhOobXmcQhgwQqCzplCLzEmA5QimUrF1dLridAzmE
         KktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010892; x=1792615692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6ZEVCcL2437a6X5ybbau3kMmqg+eTdm9EgDz7SIcRM=;
        b=evzZMxVer7s485Z5f6vu3BcTE4MnK7YJ4PN8EvTCzH1a3/3BhS4L9GRyb4W4W6Ol+j
         9nrRslsOoaOCzzm9TGHJYl/eMy2RLGnSyJrXjRHvi+zNjpfZ3q1dxMGQlwjZRVVCXNaE
         ZQaabd9MKd6AIkboqJwQ6vI2UmMMgPQIOp1GKPV8sty1t+l77H7yAPZTJnxGllw4Pq81
         PtyNF6axnSVsyKvGvvArkF5uWpYJDNJbJizlb5OWiDK3zb5vHVxdN86yYMHtbEePpdGw
         5/NYqCjarUTLZUJE4Vt/gwiK5ZNJRjmoscPn08a1v+Pfz9fnC5L2haft9vQSh1JVoLOT
         ykDw==
X-Forwarded-Encrypted: i=1; AKwUvBxjs8ac8lkWN2sij8vfMLNfaW8vfX9M0Rk/1HRlm+WfonesG7hCgc3d3+vs/JtIaDcQXq4bp1ix8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0eJYGsHBQZPZI6b1ZS5j+jpA0vBqQOVVo6gZ7oqcbt6xzaYmS
	TmktOlZoTiGXHPiCBacyw3VQ3ooR0WKECMzEG2Oeqt94L0shRjWF2TWQZJLndi+E5RI=
X-Gm-Gg: AYBFou2bc7a1waQF5Ir+yTiyFgNS9d01jKeMP8PkxMfqcaWqyHCVxCWktkSoqxeeNsv
	1LP87NQEwX6qUurAhxqs38INDU3iREEOQKnmbpBRpeWCL7gDG1HXMq+zJqWFNHT/uXU6AbbL0cx
	4W/AlRLbYZH/xS75ipIG7lzf2oCqGGoGDGBDKjwgBiuVGq4sOXsgxT3bRokGqVygRaeZbEu8rAM
	cH3+9UR1ndzfdmYe25FLMTUj2srgixwJQX6C6mZbPx2j3O892fxV1cPBR3ThoLaduhw5pJGcJUt
	kNOERXsPcIhp44sA7uq/7sMCYFDe2sGwDd9nprGyKyL2uJ/ollrj4WNDE48jzvIQYZyO4/h5GIC
	cWKewfpGLgtIR0nKGWzCieP/zg3p6dcAjb5Qws36QQChoL7N4/SOZPbPO2NFSFgKN42YzQyModZ
	3l/oQApKAI5ze1CWKw+OvcUBcsJWXIHam8xppXRhoeQbMmnSqYnt2xvxYgeukVQcn+Kjxjvi+hy
	tcEK8QuOCWehcqL1MsvUksLMJk=
X-Received: by 2002:a05:620a:171e:b0:93b:d7a3:45d0 with SMTP id af79cd13be357-93ebd293de6mr2563371285a.57.1792010892437;
        Wed, 14 Oct 2026 13:48:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5028051sm582408385a.18.2026.10.14.13.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:48:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 14 Oct 2026 20:47:47 +0000
Subject: [PATCH v2 2/5] userns: don't let setns() lend CAP_SETFCAP
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792010880; l=2699;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=SURLLXVKbdJe4oh+rQN5mZZp8FsoWoJcWswVlOyrRPg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCAe4dSbXbzqRr9RUIjQ/O/Vty7mTOCY6bKiZblvqs4grh9LSM730NY/0mu92ENvCx96B/KrSLf
 2BGxLu2NhaQg=
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

Refuse setns() into a user namespace unless the joiner's CAP_SETFCAP
reaches at least as far up as the namespace's setfcap_level.  Then every
task in a namespace is entitled to what its setfcap_level says, and the
checks on the way to file capabilities can go by the namespace.  This
has to apply to every user namespace, also to those that don't map the
parent's uid 0: through an idmapped mount, a root user that only exists
in the namespace can be stored as the parent's.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace created by a task that
had it, such as a root-created container.  Tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces, are not affected.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..330085a7d7d4 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,13 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Everybody in the namespace gets CAP_SETFCAP that reaches as far up
+	 * as its setfcap_level, so only let in tasks whose own reaches as far.
+	 */
+	if (cap_setfcap_level(current_cred(), user_ns->parent) >
+	    user_ns->setfcap_level)
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;

-- 
2.55.0

