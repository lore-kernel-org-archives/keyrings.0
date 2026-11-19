Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084976;
	b=Suuo+KdWhCpYQnzqhVM9Jp3XTv3WIoYF9eIvutmpp26tIE0HHRi9Pluf2IHmkrYwybFw
	 lP2uH9RoXM/ANht+q5fpVRNXC6iuScuzPDOm7N2M5RqhZ4OjthwZbla1sDIdxL5Yo5i0S
	 qiAxirZRyf1z8qdD/8qf++QxIrzMesJKUoEB8BrvvVXkBODtSuChKbmoHLg61yzY7p6ze
	 G/4gVNI+a5WNUPcYXS4UMgmyaHiswhJzze4fzGjaA2cIitNSj48BIqH0Bds89Ju5gusC/
	 hj2+CUVAVS0iOW576xcS9eDVcgYUBWGPyc3r3izIzy8M5TFuu5Zbh3CtlKzeiCpaKoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=vMWbbWSOkcM/Z7Vh8kox11muEBd1XkiAo3xwlvt0N24=;
	b=X+CRko1J4/frtjJx6PRA32G71teaw5WYrjdQ492OSWWIs5r0hnpbNmHGrr8WeWepQSAo
	 4K0C3XhZC9246zM/QaydyS3mv3jg00LUBdWJa1YxzhDOAc/g2NwLI4Rr0ijt7FV2HqxS1
	 s2Af7Qeq1P9bZGPwG+eW98h525vJ/gXB3tXvqyQiHVQnTquxJ+oy0jlNaqVemN2wQDQJm
	 TNe9eXmlnUxD9drb/+peV/pHjOLoTkYwf86fnOaDeCdatoMoFkDUmppFBzEl5ecf3y7vT
	 K1R/FgbLvgL/0Y/WML5GCIPmnytjr4Wf2LLYkRWiwOy+azTQUECflMPWx/SwbuHYhRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oW11fiAh;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02F606A33E
	for <keyrings@vger.kernel.org>; Thu, 19 Nov 2026 10:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F02F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oW11fiAh
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c50b0de2139so158914366b.3
        for <keyrings@vger.kernel.org>; Thu, 19 Nov 2026 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795084970; x=1795689770; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMWbbWSOkcM/Z7Vh8kox11muEBd1XkiAo3xwlvt0N24=;
        b=oW11fiAh1fVsy6xgq5IQLkJN98zWoYddIagqZkzDkpueCJDM5RIhtOWVt2Ibp+QeE4
         vLVz/VN3IfukbMIEgIcSxtqVOJdjFTy1kTkm+xYeScSIN0agEKjQzNIglCtubHhdZahM
         gW2PO3wR6vduTj/PsGUzsQ16G6wt3LnAgQJ0PlyesozFr9xxEvViV95OZVtK6h8LF1uW
         qlrnxlMEFynQwmpWIygxK29xxqFPiAzMQbI3oAVcqzzu7lhaDtqAqhBqv4kQ6GXBoYCy
         WseF3F/odDo7mOODaKXMCIpmLHus2gdb4ou41qfyP4iiaDg+6kgjD2md05OsgrD+rxPp
         LRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795084970; x=1795689770;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMWbbWSOkcM/Z7Vh8kox11muEBd1XkiAo3xwlvt0N24=;
        b=B5T7ynx68eOIKBq/rzpS3jVhmr+V0EKbclKDYMeBRA2/kWdlMCAH3HRPNLYns4Aazv
         BN5dFq9jEBkc+0cVQWD4i2AxRVZe7mA/V8BTxNPjC4Yr0L1ztjyVioDu3f+F5i4GJDuL
         rV6ZTL+z/s5HnrmiMM/sF7bOQsJNtiLrB0GY8YEJA0B2m9RZfaD7FwttZpTzF5kjTNGx
         SIqhBfCt2H4l74OoHx0W67HEZ7IPo2YX4K7HKkONCwLE3Ezs/Grxr/k7pbNugoz/YBeG
         Cxip1v1omXhOcu87ezt1G8TsyH2OMLG1/puFcAVtNIwCRAlmVPenVtKZR34gBc+GS2hp
         calQ==
X-Forwarded-Encrypted: i=1; AL+hErHbQ7OT6Tv+EGK6W0vZebXvkhlw3S4BH+HkocXmDi/iJIV7peWhuS+8JD38ySKzuqV7FV99OnyVrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZTctaIkHomVTS8/zRikKPqyr8kEkBR6Jh3opr/SvyEEh/w3u+
	mS768+uix6ee4lNs3g9XBsPDpzG2xbzwMWFEWXgsg0O5ICSpkpPOeGeeTd3IyLRAbCxaS7I9zw=
	=
X-Received: from ejak1.prod.google.com ([2002:a17:906:541:b0:c3f:7129:4c10])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:9f8a:b0:c41:61b9:6ef6
 with SMTP id a640c23a62f3a-c510e376c7dmr532576166b.27.1795084969312; Thu, 19
 Nov 2026 02:42:49 -0800 (PST)
Date: Thu, 19 Nov 2026 10:42:04 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119104208.782900-1-halg@google.com>
Subject: [PATCH v2 0/4] userns: per-namespace capability bounding set
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

When an unprivileged process creates a new user namespace, it is granted
a full set of capabilities (CAP_FULL_SET) scoped to that namespace.
While isolated to the namespace, these capabilities allow unprivileged
local users to reach deep kernel subsystems (most notably networking
configuration and raw sockets via CAP_NET_ADMIN and CAP_NET_RAW) that
historically assumed a trusted caller and have accounted for a large
share of local privilege escalation vulnerabilities.

Many sandboxes and workloads use unprivileged user namespaces strictly
for UID/GID, mount, PID, or network isolation and never need high-risk
capabilities like CAP_NET_ADMIN. Likewise, system administrators,
service managers, and container runtimes often want to enforce a
capability ceiling across descendant user namespaces while still
permitting exceptions for authorized workloads.

Prior work by Jonathan Calmels [1, 2] proposed a per-thread userns
capability set (cap_userns), while v1 of this series [3] proposed a
capability bounding set (cap_bset) in struct user_namespace configured
via a global sysctl and clone3().

During v1 review, both Christian Brauner and Andy Lutomirski had
reservations about the sysctl and clone3() approach, and Andy pointed
out the need to cover the single-deep container case. Christian then
proposed combining per-cred cap_userns with the per-namespace cap_bset
ceiling [4].

This series implements that combined approach:

1. Per-namespace cap_bset and per-cred cap_userns (Patch 1)
   Introduce user_namespace->cap_bset and cred->cap_userns, controlled
   via prctl(PR_CAP_USERNS) and SECBIT_CAP_USERNS_STRICT (named _STRICT
   rather than SECURE_NO_USERNS_CAP_RAISE as it also disables the
   default cap_permitted exemption). Clamp namespace creation,
   set_cred_user_ns(), and parent-owner checks in cap_capable_helper()
   against these ceilings.

   One refinement over the v1 review sketch: set_cred_user_ns() also
   intersects cred->cap_userns with user_ns->cap_bset on namespace
   entry. Since userns transitions only move downward in the hierarchy,
   excluded bits are permanently inert anyway. Clearing them keeps
   CapUns and PR_CAP_USERNS_IS_SET accurate after setns() and gives all
   six task capability masks a uniform user_ns->cap_bset subset
   invariant.

2. Ptrace and dumpability bounding (Patch 2)
   Require the tracee's cred_userns_bset() to be a subset of the
   tracer's in the same-namespace ptrace check (complementing the
   cross-userns owner check in cap_capable_helper()), and update
   cred_cap_issubset() so widening the effective userns ceiling resets
   mm->dumpable and pdeath_signal.

3. Introspection via /proc/<pid>/status (Patch 3)
   Expose cred->cap_userns as CapUns in /proc/<pid>/status. Leave
   AUDIT_CAPSET unchanged, as capset() never modifies cap_userns
   (matching cap_bset, where prctl() changes are covered by syscall
   auditing).

4. Selftests (Patch 4)
   Add kselftests covering PR_CAP_USERNS, CapUns, nested monotonicity,
   creator capability retention, SECBIT_CAP_USERNS_STRICT, setns()
   clamping, parent-owner bounding, ptrace restrictions, and dumpability
   resets.

Changes in v2:
- Replace the global sysctl, CLONE_NEWUSER_BSET / struct clone_args
  extension, and NS_USER_GET_INFO ioctl with per-cred cap_userns,
  prctl(PR_CAP_USERNS), SECBIT_CAP_USERNS_STRICT, and CapUns in
  /proc/<pid>/status.
- Drop CLONE_NEWNET_LOOPBACK and UNSHARE_NEWNET_LOOPBACK to handle in a
  separate series.
- Clamp set_cred_user_ns() (including cred->cap_userns) against
  user_ns->cap_bset and cred_userns_bset(cred).
- In cap_capable_helper(), bound implicit parent-owner capabilities
  by the owned namespace's cap_bset, and grant them only when that
  cap_bset is a subset of cred_userns_bset(cred).
- Bound same-namespace ptrace checks in cap_ptrace_access_check() and
  cap_ptrace_traceme() and credential subset checks in
  cred_cap_issubset() by userns capability ceilings.
- Rebase onto v7.4-rc1, preserving SECURE_ALL_UNPRIVILEGED handling in
  set_cred_user_ns().
- Link to v1: https://lore.kernel.org/r/20261028221705.3915340-1-halg@google.com

[1] https://lore.kernel.org/all/20240609104355.442002-1-jcalmels@3xx0.net/
[2] https://lwn.net/Articles/978846/
[3] https://lore.kernel.org/all/20261028221705.3915340-1-halg@google.com/
[4] https://lore.kernel.org/all/20261111-behagen-faktisch-entgegen-e2e714373895@brauner/

Hallgrimur H. Gunnarsson (4):
  userns: introduce capability bounding set for user namespaces
  capability: bound ptrace and cred subset checks by userns ceilings
  proc: expose userns capability mask as CapUns in /proc/<pid>/status
  selftests/capabilities: add userns capability bounding set tests

 Documentation/filesystems/proc.rst            |    2 +
 Documentation/security/credentials.rst        |   12 +-
 fs/proc/array.c                               |    4 +-
 include/linux/cred.h                          |   22 +
 include/linux/user_namespace.h                |   12 +
 include/uapi/linux/prctl.h                    |    7 +
 include/uapi/linux/securebits.h               |   16 +-
 init/init_task.c                              |    1 +
 kernel/cred.c                                 |   13 +-
 kernel/user.c                                 |    1 +
 kernel/user_namespace.c                       |   33 +-
 security/commoncap.c                          |   80 +-
 security/keys/process_keys.c                  |    1 +
 .../testing/selftests/capabilities/.gitignore |    1 +
 tools/testing/selftests/capabilities/Makefile |    2 +-
 .../capabilities/userns_bounding_set_test.c   | 1064 +++++++++++++++++
 16 files changed, 1246 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/capabilities/userns_bounding_set_test.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.708.g77570a6a1d-goog

