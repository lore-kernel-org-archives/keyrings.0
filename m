Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521326;
	b=Msl20FVWw5bMMN9cOSOEOyPZCCnCSCNgoCkpADyWhp4tb4BqwK8XIqaDQuUtwXjnUuW6
	 yDY2TEXrW0AzQunzZnJjqkkgQaOOtkJDKg5bIdhNIKNsJ1B0F3Fw414O7hRy/3GZkP71f
	 JAKyWtXQoKJazrvQo0KVlfBlTmW2a1IWWWMXpEGLqsM0sFDssKCg5/kYV7zt15CbtdgER
	 z/I56V+k31B1YZU2npyUHLt4WtwyVcpRMGzPg25eL8v1v91VH5JUXMfQiWn91iD/J29yr
	 s4USgfjQta5zs3GlkE8alB3TVKehPMDbaezfCLpU5rhk8kW62kLERdHhBYm95eqUjqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3yGL7Y7LsUqcUfOnBJgwpH86TQ2mSRVVzjodSWn8N7c=;
	b=YRQX3gVUPYxtRuzc2XK72HJv50Evv2nSDE0cbScW+gsOy6pMPYI7DVI8J3QVHUXU7RtU
	 7n4QKvVywdZvipfQYQycXauw7xgTOvYJkaJsymdO28QHQjeDPNej3uNX8To+DCWUG8h3R
	 CMa64wwkCX/qKRHcjzrfQiH7uJgdGlxQ2bbpH/Y/NTkghdWHpBbgiaJkR2SXsX4KaQ/Vh
	 Oyn/FJK4lhWF/wphXebeM2BaTYsTHBtfcIF88e23Rw9cAPDFf+C/nG1PNOht6pVc7P99n
	 OpAb330HlOxByxqXE0LYIGJia4E2V4x7vf0fBxD1lCHO5A8OMmj3TyV9L6F2P8hg9OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=IxBXjUyM;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA260A2600
	for <keyrings@vger.kernel.org>; Thu, 12 Nov 2026 22:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCA260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=IxBXjUyM
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-536717a4d83so3265661cf.2
        for <keyrings@vger.kernel.org>; Thu, 12 Nov 2026 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794521324; x=1795126124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3yGL7Y7LsUqcUfOnBJgwpH86TQ2mSRVVzjodSWn8N7c=;
        b=IxBXjUyMGcw+6TYkiEHuOOAuFQu3bafol7rYtPvlaIyuztkGMUszyOELiQjmmAvcZJ
         8/No6R6T2IKf/zN/2l10FFi3NnMie1NchpQDso2Oz7LIIuojB3JHdrAJn4DU9Cckwqgg
         YXmx5TTvi11M8BYR07S3BuD+yG+izH26eeh0cebsbNghpoW8/ZBXyYi+7Bj94Yxa4G4G
         KDSGZ+VkVbx02pHz3xVhh/1OgC7tlRjqLgHb+ts2rqPBxSwGV6K0al+AuR2zLvpQgSWT
         2eeGmXO0RA9RyGWHYC4ui7t7L0TF8AmtIT6I4rJSisN+eYHtm40bh9mE1SMXMJPvQmps
         oqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521324; x=1795126124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yGL7Y7LsUqcUfOnBJgwpH86TQ2mSRVVzjodSWn8N7c=;
        b=Aql0ZLCuminbMu0jumbkSALrPOutfAu6Sd5rzeao6JxXMQEUxKW+icWaCZSvH4VqLe
         qdFNKl/49m057rWOv8a4TIZUPwo+cfrFcSiKdAFr5WdGqZjOUyA8itZR9nRu2BtxfOOO
         p+yxgo4ehzeJb9BbA2OkJt2fwhytsNpbB9UTnuHncDnalE1qHFelX9ucnUdDqkrrbDaZ
         f2e47HPGERhHOKNWBnusDldZWYk8DJfounRKJxCl5ItUUaGbc2cHepSpK1tenNSBR2lW
         xDEEfMGi4DlBUDkgK4a48M9J6biddJHTuTS4Kz9cpvWCEjAe738cIBXZlz98Ak1+Exv+
         RCvw==
X-Forwarded-Encrypted: i=1; AL+hErHB44sA+zztXR8IFh60M+fo+8wcvwJnkxrARYjemDTOGhv7klLTzGm9Wez3RW1I+sfONGO5G9MZNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8O7LudlJ3+VXvIMP1UtZOcK7jFSp8uAG6hSSlByl2huzt1+lKJ
	CVDZEOKWsrIpxika2xZF0LT74CQNSKFXU+OYZNzp7AVn+CnVDYvugNPLQhngaBCiMms=
X-Gm-Gg: AYBFou2H+1bmuexMFBAjEjTBjwFupjn8ITMPfwZ/sye1kSHys1rE1mpPp6vLEY2vEXL
	3sNkNB9LarwB+QmmtW4imDhfu4X3IqB4WgjXb69oVR1qZuSt0K6UUZa57+xzr6GMjAhZhh8ATZk
	Bdh3e6PFApNeDJecFCUKihjK5hjXgFAJLaBIppbnqUYcTydKJmr5G1GPhfi0PHKm+JHpuozuGB0
	aXZNkIvIdRw9zm8lyL2/2f4jLHqsEZGRwFRJuoonkZFJ2mO6VgwUy6TUlzLfN5Faqwrh77d3VjE
	xX8rPA5nvIXWN3YjOr4nqnSjUef4Lh2Ji+G5d6fUhdz7zXjuD8qIJYwxSz5bIuF0PmnYeycV/s0
	U2Hz3aIE59bkYgPFzh3pvNT3T7OEF/nzhRVBEMtR2eiBKabioZW7TgI651GlrVvA+aak9+7d7Ks
	ioVw9KmCMZ8ypwcmgAuj+bXFp2LBXvwzFk3nbgzCt/Emc6XBCsXCqbDgriMRgnvMgU0CaByw8TN
	TNlb3NTlf2z3+oFCUYASU2LkiM48p68Nhx8j0+89pDNTYesNQeRoHLL68n3OMg3/UDDvjXm+unG
	3e8q01yx3O2m8lDSTQNAYHc6zTtvNZwKKLbHJKkrM49vwg==
X-Received: by 2002:a05:622a:1b1d:b0:536:cda:d3b0 with SMTP id d75a77b69052e-55aca0672c5mr11040441cf.75.1794521323635;
        Thu, 12 Nov 2026 14:08:43 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d5e579sm5876786d6.17.2026.11.12.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:08:43 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 12 Nov 2026 22:08:24 +0000
Subject: [PATCH v10 3/3] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
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
Message-Id: <20261112-b4-setfcap-userns-v10-3-84f6f7faa903@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1794521317; l=39698;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=J0awhMQldmwbshL3UZS7BWnltUPHhDq3XhypHkJa2oc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEhrxd9ii2/dEFzjpTetUSzAlHynwyedSK3nBwlY3dYEhdJhYXNnWHxQZef4nM1mTDpiOgUM+UY
 8M9I96NOBHQ4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add tests for whether a uid 0 task that gave up CAP_SETFCAP gets it back
by joining a user namespace whose tasks can write file capabilities for
its root user, or by attaching to such a task.

Each case runs as root in a private mount namespace with a tmpfs on
/tmp.  It sets up everything but the step it tests and fails if any of
that goes wrong, so a refusal comes from that step.

The ones that must be refused:

- setns() and PTRACE_ATTACH into namespaces that map host uid 0, at
  uid 0 or another uid, or that have no uid_map yet and whose tasks can
  still map it, and the same one level down among tasks of an
  unprivileged user
- setns() into a namespace without a uid_map under one that maps host
  uid 0 at uid 5, and setns() after moving the euid away from 0
- setns() and then writing file capabilities that uid 1000 runs with
  CAP_SYS_ADMIN, end to end
- pidfd_getfd(), PTRACE_ATTACH to targets that gave up CAP_SETFCAP but
  can get it back, and PTRACE_TRACEME towards a parent without
  CAP_SETFCAP
- joiners and tracers that kept CAP_SYS_PTRACE

The ones that must keep working are the mapping rule of commit
db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0") itself,
unprivileged users nesting namespaces, joiners and tracers with
CAP_SETFCAP, namespaces created without CAP_SETFCAP,
namespaces without a uid_map owned by another user, containers that
don't map host uid 0, idmapped mounts of a container's rootfs,
PTRACE_MODE_READ, and file capabilities written in a namespace of one's
own, after setns() with CAP_SETFCAP, by unprivileged users and through
an idmapped mount.

Everything skips when the test doesn't run as root with a full
capability set in the initial user namespace, root or uid 1000 can't
create user namespaces, or there is no tmpfs or no security.capability
on it.  The ptrace cases also skip when Yama forbids ptrace.  The
idmapped mount cases also skip when tmpfs can't be idmapped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tools/testing/selftests/namespaces/.gitignore     |    1 +
 tools/testing/selftests/namespaces/Makefile       |    3 +-
 tools/testing/selftests/namespaces/config         |    2 +
 tools/testing/selftests/namespaces/setfcap_test.c | 1505 +++++++++++++++++++++
 4 files changed, 1510 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 995b082357fa..f7d1867113e8 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -11,3 +11,4 @@ stress_test
 listns_pagination_bug
 regression_pidfd_setns_test
 uid_map_range_test
+setfcap_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 9b22d12708e1..0455b6544869 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -14,7 +14,8 @@ TEST_GEN_PROGS := nsid_test \
 		  stress_test \
 		  listns_pagination_bug \
 		  regression_pidfd_setns_test \
-		  uid_map_range_test
+		  uid_map_range_test \
+		  setfcap_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/namespaces/config b/tools/testing/selftests/namespaces/config
index d09836260262..2a1fa144398e 100644
--- a/tools/testing/selftests/namespaces/config
+++ b/tools/testing/selftests/namespaces/config
@@ -5,3 +5,5 @@ CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_CGROUPS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
diff --git a/tools/testing/selftests/namespaces/setfcap_test.c b/tools/testing/selftests/namespaces/setfcap_test.c
new file mode 100644
index 000000000000..8fb7286428ab
--- /dev/null
+++ b/tools/testing/selftests/namespaces/setfcap_test.c
@@ -0,0 +1,1505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A uid 0 task that gave up CAP_SETFCAP must not get it back by joining a
+ * user namespace whose tasks can write file capabilities for its root user,
+ * or by attaching to such a task.  Mapping and file capabilities in the
+ * namespaces involved have to keep working.
+ *
+ * "R" is a task with uid 0 and all capabilities in the initial namespace,
+ * "X" one with uid 0 that gave up CAP_SETFCAP and CAP_SYS_PTRACE in its
+ * permitted, effective and bounding sets, and "U" is uid 1000.
+ *
+ * Every test runs in a private mount namespace with a tmpfs on /tmp.
+ */
+#define _GNU_SOURCE
+#include <endian.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <linux/capability.h>
+#include <linux/mount.h>
+
+#include "kselftest_harness.h"
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#endif
+#ifndef __NR_pidfd_getfd
+#define __NR_pidfd_getfd 438
+#endif
+#ifndef __NR_open_tree
+#define __NR_open_tree 428
+#endif
+#ifndef __NR_move_mount
+#define __NR_move_mount 429
+#endif
+#ifndef __NR_mount_setattr
+#define __NR_mount_setattr 442
+#endif
+
+/* Exit codes of a copy of this program run with SETFCAP_TEST_CAPS set. */
+#define CAPS_HAS_SYS_ADMIN	42
+#define CAPS_NO_SYS_ADMIN	43
+
+/* A step that wasn't the one under test went wrong. */
+#define SETUP_ERROR		(-1000)
+
+static int capget_v3(struct __user_cap_data_struct d[2])
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+
+	return syscall(SYS_capget, &h, d);
+}
+
+__attribute__((constructor)) static void report_caps(void)
+{
+	struct __user_cap_data_struct d[2];
+
+	if (!getenv("SETFCAP_TEST_CAPS"))
+		return;
+	if (capget_v3(d))
+		_exit(1);
+	_exit(d[0].effective & (1u << CAP_SYS_ADMIN) ?
+	      CAPS_HAS_SYS_ADMIN : CAPS_NO_SYS_ADMIN);
+}
+
+/* X: uid 0 without CAP_SETFCAP and CAP_SYS_PTRACE */
+static void restrict_root(void)
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+	struct __user_cap_data_struct d[2];
+	unsigned int drop = (1u << CAP_SETFCAP) | (1u << CAP_SYS_PTRACE);
+
+	if (prctl(PR_CAPBSET_DROP, CAP_SETFCAP) ||
+	    prctl(PR_CAPBSET_DROP, CAP_SYS_PTRACE) || capget_v3(d))
+		_exit(99);
+	d[0].effective &= ~drop;
+	d[0].permitted &= ~drop;
+	if (syscall(SYS_capset, &h, d))
+		_exit(99);
+}
+
+/* Give up CAP_SETFCAP only in the permitted and effective set. */
+static void drop_setfcap_keep_bset(void)
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+	struct __user_cap_data_struct d[2];
+
+	if (capget_v3(d))
+		_exit(99);
+	d[0].effective &= ~(1u << CAP_SETFCAP);
+	d[0].permitted &= ~(1u << CAP_SETFCAP);
+	if (syscall(SYS_capset, &h, d))
+		_exit(99);
+}
+
+/* Keep CAP_SETFCAP only in the inheritable set. */
+static void keep_setfcap_inheritable(void)
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+	struct __user_cap_data_struct d[2];
+
+	if (capget_v3(d))
+		_exit(99);
+	d[0].inheritable |= 1u << CAP_SETFCAP;
+	if (syscall(SYS_capset, &h, d) || prctl(PR_CAPBSET_DROP, CAP_SETFCAP))
+		_exit(99);
+	d[0].effective &= ~(1u << CAP_SETFCAP);
+	d[0].permitted &= ~(1u << CAP_SETFCAP);
+	if (syscall(SYS_capset, &h, d))
+		_exit(99);
+}
+
+/* Give up CAP_SETFCAP only, keep CAP_SYS_PTRACE. */
+static void drop_setfcap(void)
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+	struct __user_cap_data_struct d[2];
+
+	if (prctl(PR_CAPBSET_DROP, CAP_SETFCAP) || capget_v3(d))
+		_exit(99);
+	d[0].effective &= ~(1u << CAP_SETFCAP);
+	d[0].permitted &= ~(1u << CAP_SETFCAP);
+	if (syscall(SYS_capset, &h, d))
+		_exit(99);
+}
+
+static void become_user(void)
+{
+	if (setresgid(1000, 1000, 1000) || setresuid(1000, 1000, 1000))
+		_exit(99);
+	prctl(PR_SET_DUMPABLE, 1);
+}
+
+static long wr(int fd, const char *s)
+{
+	long r = write(fd, s, strlen(s));
+
+	return r < 0 ? -errno : 0;
+}
+
+static long write_file(int pid, const char *name, const char *s)
+{
+	char path[64];
+	long r;
+	int fd;
+
+	if (pid)
+		snprintf(path, sizeof(path), "/proc/%d/%s", pid, name);
+	else
+		snprintf(path, sizeof(path), "/proc/self/%s", name);
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+	r = wr(fd, s);
+	close(fd);
+	return r;
+}
+
+static long write_map(int pid, const char *map)
+{
+	return write_file(pid, "uid_map", map);
+}
+
+/* both maps, as the setup for a test rather than its subject */
+static long map_both(int pid, const char *map)
+{
+	if (write_map(pid, map) || write_file(pid, "setgroups", "deny") ||
+	    write_file(pid, "gid_map", map))
+		return SETUP_ERROR;
+	return 0;
+}
+
+/* what an unprivileged user does after unshare(CLONE_NEWUSER) */
+static long map_user(void)
+{
+	return map_both(0, "0 1000 1\n");
+}
+
+static int userns_fd(int pid)
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	return open(path, O_RDONLY);
+}
+
+/* setns() into the user namespace fd refers to, and close it */
+static long join_fd(int fd)
+{
+	long r;
+
+	if (fd < 0)
+		return SETUP_ERROR;
+	r = setns(fd, CLONE_NEWUSER) ? -errno : 0;
+	close(fd);
+	return r;
+}
+
+static long join(int pid)
+{
+	return join_fd(userns_fd(pid));
+}
+
+/* security.capability with CAP_SYS_ADMIN in permitted and effective; v2 if rootid < 0 */
+static long set_fcap(const char *path, int rootid)
+{
+	struct vfs_ns_cap_data d;
+	int v3 = rootid >= 0;
+
+	memset(&d, 0, sizeof(d));
+	d.magic_etc = htole32((v3 ? VFS_CAP_REVISION_3 : VFS_CAP_REVISION_2) |
+			      VFS_CAP_FLAGS_EFFECTIVE);
+	d.data[0].permitted = htole32(1u << CAP_SYS_ADMIN);
+	d.rootid = htole32(rootid);
+	if (setxattr(path, "security.capability", &d,
+		     v3 ? XATTR_CAPS_SZ_3 : XATTR_CAPS_SZ_2, 0))
+		return -errno;
+	return 0;
+}
+
+/* a copy of this program, owned by uid */
+static int new_file(const char *path, int uid)
+{
+	char buf[65536];
+	int in, out, ret = -1;
+	ssize_t n;
+
+	unlink(path);
+	in = open("/proc/self/exe", O_RDONLY);
+	if (in < 0)
+		return -1;
+	out = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0755);
+	if (out < 0)
+		goto out_in;
+	while ((n = read(in, buf, sizeof(buf))) > 0)
+		if (write(out, buf, n) != n)
+			goto out;
+	if (!n && !fchown(out, uid, uid) && !fchmod(out, 0755))
+		ret = 0;
+out:
+	close(out);
+out_in:
+	close(in);
+	return ret;
+}
+
+/*
+ * Does U get CAP_SYS_ADMIN from the file capabilities of path?  1 if it
+ * does, 0 if not, -1 if the file didn't run.
+ */
+static int user_gets_sys_admin(const char *path)
+{
+	int pid, st;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+	if (!pid) {
+		become_user();
+		setenv("SETFCAP_TEST_CAPS", "1", 1);
+		execl(path, path, NULL);
+		_exit(1);
+	}
+	if (waitpid(pid, &st, 0) != pid || !WIFEXITED(st))
+		return -1;
+	if (WEXITSTATUS(st) == CAPS_HAS_SYS_ADMIN)
+		return 1;
+	return WEXITSTATUS(st) == CAPS_NO_SYS_ADMIN ? 0 : -1;
+}
+
+/* run fn in a child and return what it returns */
+static long in_child(long (*fn)(void *), void *arg)
+{
+	int p[2], pid;
+	long r = SETUP_ERROR;
+
+	if (pipe(p))
+		return SETUP_ERROR;
+	pid = fork();
+	if (!pid) {
+		close(p[0]);
+		r = fn(arg);
+		if (write(p[1], &r, sizeof(r)) != sizeof(r))
+			_exit(1);
+		_exit(0);
+	}
+	close(p[1]);
+	if (pid < 0 || read(p[0], &r, sizeof(r)) != sizeof(r))
+		r = SETUP_ERROR;
+	close(p[0]);
+	if (pid > 0)
+		waitpid(pid, NULL, 0);
+	return r;
+}
+
+/* A task that unshares a user namespace and waits. */
+struct holder {
+	int pid, go;
+};
+
+enum holder_kind {
+	HOLDER_ROOT,		/* R */
+	HOLDER_RESTRICTED,	/* X */
+	HOLDER_USER,		/* U, maps "0 1000 1" itself */
+};
+
+/*
+ * Fork a task that runs setup(arg), says it is ready and waits until it is
+ * reaped.  Its pid is -1 if any of that fails.
+ */
+static struct holder spawn(int (*setup)(const void *), const void *arg)
+{
+	struct holder h = { -1, -1 };
+	int ready[2], go[2];
+	char c;
+
+	if (pipe(ready))
+		return h;
+	if (pipe(go)) {
+		close(ready[0]);
+		close(ready[1]);
+		return h;
+	}
+	h.pid = fork();
+	if (!h.pid) {
+		close(ready[0]);
+		close(go[1]);
+		if (setup(arg) || write(ready[1], "r", 1) != 1)
+			_exit(1);
+		if (read(go[0], &c, 1) < 0)
+			_exit(1);
+		_exit(0);
+	}
+	close(ready[1]);
+	close(go[0]);
+	h.go = go[1];
+	if (h.pid > 0 && read(ready[0], &c, 1) != 1) {
+		kill(h.pid, SIGKILL);
+		waitpid(h.pid, NULL, 0);
+		h.pid = -1;
+	}
+	close(ready[0]);
+	if (h.pid <= 0) {
+		close(h.go);
+		h.go = -1;
+	}
+	return h;
+}
+
+struct holder_setup {
+	enum holder_kind kind;
+	int map_fd_at;
+};
+
+static int holder_setup(const void *a)
+{
+	const struct holder_setup *s = a;
+	int fd;
+
+	if (s->kind == HOLDER_RESTRICTED)
+		restrict_root();
+	if (s->kind == HOLDER_USER)
+		become_user();
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+	if (s->kind == HOLDER_USER && map_user())
+		return -1;
+	if (s->map_fd_at) {
+		fd = open("/proc/self/uid_map", O_WRONLY);
+		if (fd < 0 || dup2(fd, s->map_fd_at) != s->map_fd_at)
+			return -1;
+		close(fd);
+	}
+	return 0;
+}
+
+static struct holder spawn_holder(enum holder_kind kind, int map_fd_at)
+{
+	struct holder_setup s = { kind, map_fd_at };
+
+	return spawn(holder_setup, &s);
+}
+
+static void reap_holder(struct holder h)
+{
+	if (h.pid <= 0)
+		return;
+	close(h.go);
+	kill(h.pid, SIGKILL);
+	waitpid(h.pid, NULL, 0);
+}
+
+/* ... whose maps are written from the parent namespace by the caller */
+static struct holder spawn_mapped(enum holder_kind kind, const char *map)
+{
+	struct holder h = spawn_holder(kind, 0);
+
+	if (h.pid > 0 && map_both(h.pid, map)) {
+		reap_holder(h);
+		h.pid = -1;
+	}
+	return h;
+}
+
+/*
+ * ... that joins the user namespace of pid instead, runs prep there and, if
+ * new_ns is set, unshares another one
+ */
+struct joined_setup {
+	int pid;
+	void (*prep)(void);
+	int new_ns;
+};
+
+static int joined_setup(const void *a)
+{
+	const struct joined_setup *s = a;
+
+	if (join(s->pid))
+		return -1;
+	if (s->prep)
+		s->prep();
+	if (s->new_ns && unshare(CLONE_NEWUSER))
+		return -1;
+	return 0;
+}
+
+static struct holder spawn_joined(int pid, void (*prep)(void), int new_ns)
+{
+	struct joined_setup s = { pid, prep, new_ns };
+
+	return spawn(joined_setup, &s);
+}
+
+#define PID(a) (((struct holder *)(a))->pid)
+
+static long attach_only(int pid)
+{
+	if (ptrace(PTRACE_ATTACH, pid, 0, 0))
+		return -errno;
+	waitpid(pid, NULL, 0);
+	ptrace(PTRACE_DETACH, pid, 0, 0);
+	return 0;
+}
+
+/*
+ * /tmp idmapped with the user namespace of pid, at /tmp/mnt.  Returns 1 if
+ * tmpfs can't be idmapped, -1 if anything else goes wrong.
+ */
+static int idmap_tmp(int pid)
+{
+	struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP };
+	int tfd = -1, nsfd, ret = -1;
+	char path[64];
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	nsfd = open(path, O_RDONLY);
+	if (nsfd < 0)
+		return -1;
+	tfd = syscall(__NR_open_tree, AT_FDCWD, "/tmp",
+		      OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (tfd < 0) {
+		if (errno == ENOSYS)
+			ret = 1;
+		goto out;
+	}
+	attr.userns_fd = nsfd;
+	if (syscall(__NR_mount_setattr, tfd, "", AT_EMPTY_PATH, &attr,
+		    sizeof(attr))) {
+		if (errno == EINVAL || errno == EOPNOTSUPP || errno == ENOSYS)
+			ret = 1;
+		goto out;
+	}
+	if (syscall(__NR_move_mount, tfd, "", AT_FDCWD, "/tmp/mnt",
+		    MOVE_MOUNT_F_EMPTY_PATH))
+		goto out;
+	ret = 0;
+out:
+	if (tfd >= 0)
+		close(tfd);
+	close(nsfd);
+	return ret;
+}
+
+/* Each test: private mounts, a tmpfs on /tmp with copies of this program */
+static void prepare(struct __test_metadata *_metadata)
+{
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	ASSERT_EQ(mount("tmpfs", "/tmp", "tmpfs", 0, "mode=1777"), 0);
+	ASSERT_EQ(new_file("/tmp/x", 0), 0);
+	ASSERT_EQ(new_file("/tmp/u", 1000), 0);
+	ASSERT_EQ(mkdir("/tmp/mnt", 0755), 0);
+}
+
+/* What keeps the tests from running here, or NULL */
+static const char *missing(void)
+{
+	struct __user_cap_data_struct d[2];
+	unsigned long a, b, c;
+	int i, pid, st, last;
+	FILE *f;
+
+	if (geteuid())
+		return "needs root";
+	f = fopen("/proc/self/uid_map", "r");
+	if (!f)
+		return "no /proc/self/uid_map";
+	i = fscanf(f, "%lu %lu %lu", &a, &b, &c);
+	fclose(f);
+	if (i != 3 || a || b || c != 4294967295UL)
+		return "not in the initial user namespace";
+	f = fopen("/proc/sys/kernel/cap_last_cap", "r");
+	if (!f)
+		return "no /proc/sys/kernel/cap_last_cap";
+	i = fscanf(f, "%d", &last);
+	fclose(f);
+	if (i != 1 || capget_v3(d))
+		return "can't read the capability sets";
+	for (i = 0; i <= last; i++)
+		if (!(d[i / 32].effective & (1u << (i % 32))) ||
+		    prctl(PR_CAPBSET_READ, i) != 1)
+			return "needs a full capability set";
+	pid = fork();
+	if (!pid)
+		_exit(unshare(CLONE_NEWUSER) ? 1 : 0);
+	if (pid < 0 || waitpid(pid, &st, 0) != pid || !WIFEXITED(st))
+		return "fork() failed";
+	if (WEXITSTATUS(st))
+		return "can't create user namespaces";
+	pid = fork();
+	if (!pid) {
+		become_user();
+		_exit(unshare(CLONE_NEWUSER) ? 1 : 0);
+	}
+	if (pid < 0 || waitpid(pid, &st, 0) != pid || !WIFEXITED(st))
+		return "fork() failed";
+	if (WEXITSTATUS(st))
+		return "uid 1000 can't create user namespaces";
+	pid = fork();
+	if (!pid) {
+		if (unshare(CLONE_NEWNS) ||
+		    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
+		    mount("tmpfs", "/tmp", "tmpfs", 0, NULL))
+			_exit(2);
+		if (new_file("/tmp/x", 0))
+			_exit(3);
+		_exit(set_fcap("/tmp/x", -1) == -EOPNOTSUPP ? 4 : 0);
+	}
+	if (pid < 0 || waitpid(pid, &st, 0) != pid || !WIFEXITED(st))
+		return "fork() failed";
+	switch (WEXITSTATUS(st)) {
+	case 0:
+		break;
+	case 2:
+		return "can't mount a tmpfs on /tmp";
+	case 4:
+		return "no security.capability on tmpfs";
+	default:
+		return "can't copy the test program to tmpfs";
+	}
+	return NULL;
+}
+
+FIXTURE(setfcap) {};
+
+FIXTURE_SETUP(setfcap)
+{
+	const char *why = missing();
+
+	if (why)
+		SKIP(return, "%s", why);
+	prepare(_metadata);
+}
+
+FIXTURE_TEARDOWN(setfcap) {}
+
+/* ---------------------------------------------------------------------- */
+/* Mapping uid 0 of the parent                                           */
+
+static long x_maps_from_parent(void *a)
+{
+	restrict_root();
+	return write_map(PID(a), "0 0 1\n");
+}
+
+TEST_F(setfcap, map_from_parent_without_setfcap)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_maps_from_parent, &h), -EPERM);
+	reap_holder(h);
+}
+
+static long x_maps_own(void *a)
+{
+	restrict_root();
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	return write_map(0, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_own_without_setfcap)
+{
+	EXPECT_EQ(in_child(x_maps_own, NULL), -EPERM);
+}
+
+/* What has to keep working. */
+
+static long r_maps_own(void *a)
+{
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	return write_map(0, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_own)
+{
+	EXPECT_EQ(in_child(r_maps_own, NULL), 0);
+}
+
+static long r_maps_from_parent(void *a)
+{
+	return write_map(PID(a), "0 0 1000\n");
+}
+
+TEST_F(setfcap, map_from_parent)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_maps_from_parent, &h), 0);
+	reap_holder(h);
+}
+
+static long child_maps(void *a)
+{
+	return write_map(0, "0 0 1\n");
+}
+
+static long r_child_maps(void *a)
+{
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	return in_child(child_maps, NULL);
+}
+
+TEST_F(setfcap, map_by_child_of_creator)
+{
+	EXPECT_EQ(in_child(r_child_maps, NULL), 0);
+}
+
+static long r_joins_and_maps(void *a)
+{
+	long r = join(PID(a));
+
+	if (r)
+		return r;
+	return write_map(0, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_after_setns_with_setfcap)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_joins_and_maps, &h), 0);
+	reap_holder(h);
+}
+
+static long r_joins_writes_fd(void *a)
+{
+	void **v = a;
+	long r = join(PID(v[0]));
+
+	if (r)
+		return r;
+	return wr(*(int *)v[1], "0 0 1\n");
+}
+
+TEST_F(setfcap, map_opened_in_parent_written_inside)
+{
+	struct holder h;
+	char path[64];
+	void *v[2];
+	int fd;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	snprintf(path, sizeof(path), "/proc/%d/uid_map", h.pid);
+	fd = open(path, O_WRONLY);
+	ASSERT_GE(fd, 0);
+	v[0] = &h;
+	v[1] = &fd;
+	EXPECT_EQ(in_child(r_joins_writes_fd, v), 0);
+	close(fd);
+	reap_holder(h);
+}
+
+static long u_nested_maps_own(void *a)
+{
+	become_user();
+	if (unshare(CLONE_NEWUSER) || map_user())
+		return SETUP_ERROR;
+	return in_child(r_maps_own, NULL);
+}
+
+TEST_F(setfcap, map_unprivileged_nested)
+{
+	EXPECT_EQ(in_child(u_nested_maps_own, NULL), 0);
+}
+
+static long u_nested_maps_child(void *a)
+{
+	struct holder h;
+	long r;
+
+	become_user();
+	if (unshare(CLONE_NEWUSER) || map_user())
+		return SETUP_ERROR;
+	h = spawn_holder(HOLDER_ROOT, 0);
+	if (h.pid <= 0)
+		return SETUP_ERROR;
+	r = write_map(h.pid, "0 0 1\n");
+	reap_holder(h);
+	return r;
+}
+
+TEST_F(setfcap, map_unprivileged_nested_from_parent)
+{
+	EXPECT_EQ(in_child(u_nested_maps_child, NULL), 0);
+}
+
+/* ---------------------------------------------------------------------- */
+/* File capabilities                                                       */
+
+/* What has to keep working. */
+
+static long r_maps_sets_fcap(void *a)
+{
+	if (unshare(CLONE_NEWUSER) || map_both(0, "0 0 1\n"))
+		return SETUP_ERROR;
+	return set_fcap("/tmp/x", -1);
+}
+
+TEST_F(setfcap, fcap_own_ns)
+{
+	EXPECT_EQ(in_child(r_maps_sets_fcap, NULL), 0);
+	EXPECT_EQ(user_gets_sys_admin("/tmp/x"), 1);
+}
+
+static long r_joins_sets_fcap(void *a)
+{
+	long r = join(PID(a));
+
+	if (r)
+		return r;
+	return set_fcap("/tmp/x", -1);
+}
+
+TEST_F(setfcap, fcap_after_setns_with_setfcap)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_joins_sets_fcap, &h), 0);
+	reap_holder(h);
+}
+
+static long u_sets_fcap(void *a)
+{
+	become_user();
+	if (unshare(CLONE_NEWUSER) || map_user())
+		return SETUP_ERROR;
+	return set_fcap("/tmp/u", -1);
+}
+
+TEST_F(setfcap, fcap_unprivileged)
+{
+	EXPECT_EQ(in_child(u_sets_fcap, NULL), 0);
+}
+
+static long u_nested_sets_fcap_inner(void *a)
+{
+	if (unshare(CLONE_NEWUSER) || map_both(0, "0 0 1\n"))
+		return SETUP_ERROR;
+	return set_fcap("/tmp/u", -1);
+}
+
+static long u_nested_sets_fcap(void *a)
+{
+	become_user();
+	if (unshare(CLONE_NEWUSER) || map_user())
+		return SETUP_ERROR;
+	return in_child(u_nested_sets_fcap_inner, NULL);
+}
+
+TEST_F(setfcap, fcap_unprivileged_nested)
+{
+	EXPECT_EQ(in_child(u_nested_sets_fcap, NULL), 0);
+}
+
+static long u_joins_own_sets_fcap(void *a)
+{
+	long r;
+
+	become_user();
+	r = join(PID(a));
+	if (r)
+		return r;
+	return set_fcap("/tmp/u", -1);
+}
+
+TEST_F(setfcap, fcap_unprivileged_after_setns)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_USER, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(u_joins_own_sets_fcap, &h), 0);
+	reap_holder(h);
+}
+
+/* ---------------------------------------------------------------------- */
+/* Idmapped mounts: a container's rootfs can make its root host uid 0, so  */
+/* that file capabilities written through it are honoured on the host.    */
+/* That is up to whoever sets up the mount, so X may still join a         */
+/* container that doesn't map host uid 0 and write them.                  */
+
+struct idmap_case {
+	const char *ns_map, *idmap_map;
+	int file_uid, restricted;
+};
+
+struct idmap_join {
+	int pid, restricted;
+};
+
+/* join the namespace from a sibling of its holder and write the xattr */
+static long idmap_joins_sets_fcap(void *a)
+{
+	const struct idmap_join *j = a;
+
+	if (j->restricted)
+		restrict_root();
+	return join(j->pid) ? SETUP_ERROR : set_fcap("/tmp/mnt/x", 0);
+}
+
+/* returns 1 to skip: no idmapped mounts on tmpfs */
+static int idmap_case(const struct idmap_case *c, long *r)
+{
+	struct holder ns, im = { -1, -1 };
+	struct idmap_join j;
+	int ret = -1;
+
+	ns = spawn_mapped(HOLDER_ROOT, c->ns_map);
+	if (ns.pid <= 0)
+		return -1;
+	if (c->idmap_map) {
+		im = spawn_mapped(HOLDER_ROOT, c->idmap_map);
+		if (im.pid <= 0)
+			goto out;
+	}
+	if (new_file("/tmp/x", c->file_uid))
+		goto out;
+	ret = idmap_tmp(c->idmap_map ? im.pid : ns.pid);
+	if (ret)
+		goto out;
+	j.pid = ns.pid;
+	j.restricted = c->restricted;
+	*r = in_child(idmap_joins_sets_fcap, &j);
+	umount2("/tmp/mnt", MNT_DETACH);
+	ret = 0;
+out:
+	reap_holder(ns);
+	reap_holder(im);
+	return ret;
+}
+
+FIXTURE(idmap) {};
+
+FIXTURE_VARIANT(idmap) {
+	struct idmap_case c;
+	long expect;
+};
+
+/* R in its container writes through the container's own idmapped rootfs */
+FIXTURE_VARIANT_ADD(idmap, container_root) {
+	.c = { "0 100000 1000\n", NULL, 0, 0 },
+	.expect = 0,
+};
+
+/* left to the admin: the container doesn't map host uid 0 */
+FIXTURE_VARIANT_ADD(idmap, container_without_host_root) {
+	.c = { "0 100000 1000\n", NULL, 0, 1 },
+	.expect = 0,
+};
+
+FIXTURE_VARIANT_ADD(idmap, unrelated_idmap) {
+	.c = { "0 100000 1000\n", "200000 100000 1\n", 200000, 1 },
+	.expect = 0,
+};
+
+FIXTURE_SETUP(idmap)
+{
+	const char *why = missing();
+
+	if (why)
+		SKIP(return, "%s", why);
+	prepare(_metadata);
+}
+
+FIXTURE_TEARDOWN(idmap) {}
+
+TEST_F(idmap, fcap)
+{
+	long r = SETUP_ERROR;
+	int ret;
+
+	ret = idmap_case(&variant->c, &r);
+	ASSERT_GE(ret, 0);
+	if (ret == 1)
+		SKIP(return, "no idmapped mounts on tmpfs");
+	EXPECT_EQ(r, variant->expect);
+}
+
+/* ---------------------------------------------------------------------- */
+/* setns()                                                                 */
+/*                                                                         */
+/* A task that joins gets a full capability set in the namespace, so      */
+/* mapping uid 0 or writing file capabilities afterwards has no check of  */
+/* its own: setns() is the one.                                           */
+
+static long x_joins(void *a)
+{
+	restrict_root();
+	return join(PID(a));
+}
+
+static long r_joins(void *a)
+{
+	return join(PID(a));
+}
+
+TEST_F(setfcap, setns_ns_mapping_host_root)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins, &h), -EPERM);
+	reap_holder(h);
+}
+
+/* the root user can be mapped at any uid */
+TEST_F(setfcap, setns_ns_mapping_host_root_at_nonzero_uid)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "5 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins, &h), -EPERM);
+	reap_holder(h);
+}
+
+TEST_F(setfcap, setns_ns_without_map_yet)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins, &h), -EPERM);
+	reap_holder(h);
+}
+
+/* the same one level down, among tasks of an unprivileged user */
+static long u_nested_x(long (*step)(void *))
+{
+	struct holder h;
+	long r;
+
+	become_user();
+	if (unshare(CLONE_NEWUSER) || map_user())
+		return SETUP_ERROR;
+	/* R-like: full set in the user's namespace */
+	h = spawn_holder(HOLDER_ROOT, 0);
+	if (h.pid <= 0)
+		return SETUP_ERROR;
+	r = in_child(step, &h);
+	reap_holder(h);
+	return r;
+}
+
+static long u_nested_x_joins(void *a)
+{
+	return u_nested_x(x_joins);
+}
+
+TEST_F(setfcap, setns_nested_unprivileged)
+{
+	EXPECT_EQ(in_child(u_nested_x_joins, NULL), -EPERM);
+}
+
+/* host uid 0 is uid 5 of the parent, which the owner may map without it */
+static long x_joins_unmapped_under_nonzero_root(void *a)
+{
+	struct holder p, n;
+	long r;
+
+	p = spawn_mapped(HOLDER_ROOT, "5 0 1\n");
+	if (p.pid <= 0)
+		return SETUP_ERROR;
+	n = spawn_joined(p.pid, restrict_root, 1);
+	r = n.pid > 0 ? in_child(x_joins, &n) : SETUP_ERROR;
+	reap_holder(n);
+	reap_holder(p);
+	return r;
+}
+
+TEST_F(setfcap, setns_ns_without_map_yet_root_at_nonzero_uid)
+{
+	EXPECT_EQ(in_child(x_joins_unmapped_under_nonzero_root, NULL), -EPERM);
+}
+
+/* X moves its euid away from 0 and takes back its other capabilities */
+static long x_with_other_euid_joins(void *a)
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+	struct __user_cap_data_struct d[2];
+	int fd;
+
+	restrict_root();
+	fd = userns_fd(PID(a));
+	if (fd < 0 || setresuid(-1, 1000, -1) || capget_v3(d))
+		return SETUP_ERROR;
+	d[0].effective = d[0].permitted;
+	d[1].effective = d[1].permitted;
+	if (syscall(SYS_capset, &h, d))
+		return SETUP_ERROR;
+	return join_fd(fd);
+}
+
+TEST_F(setfcap, setns_with_other_euid)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_with_other_euid_joins, &h), -EPERM);
+	reap_holder(h);
+}
+
+/* ... and the end result: file capabilities that uid 1000 runs with */
+static long x_joins_sets_fcap(void *a)
+{
+	long r;
+
+	restrict_root();
+	r = join(PID(a));
+	return r ? r : set_fcap("/tmp/x", -1);
+}
+
+TEST_F(setfcap, setns_then_fcap_for_host_root)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins_sets_fcap, &h), -EPERM);
+	EXPECT_EQ(user_gets_sys_admin("/tmp/x"), 0);
+	reap_holder(h);
+}
+
+/* CAP_SYS_PTRACE doesn't stand in for CAP_SETFCAP */
+static long ptracer_joins(void *a)
+{
+	drop_setfcap();
+	return join(PID(a));
+}
+
+TEST_F(setfcap, setns_with_sys_ptrace)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(ptracer_joins, &h), -EPERM);
+	reap_holder(h);
+}
+
+/*
+ * Its creator is uid 1000 with CAP_SETFCAP, so tasks in there can only map
+ * uid 1000.  X keeps CAP_SYS_PTRACE to see a namespace of another user.
+ */
+static int capable_user_unshares(const void *a)
+{
+	struct __user_cap_header_struct h = { _LINUX_CAPABILITY_VERSION_3, 0 };
+	struct __user_cap_data_struct d[2];
+
+	if (prctl(PR_SET_KEEPCAPS, 1) || setresgid(1000, 1000, 1000) ||
+	    setresuid(1000, 1000, 1000) || capget_v3(d))
+		return -1;
+	d[0].effective = d[0].permitted;
+	d[1].effective = d[1].permitted;
+	if (syscall(SYS_capset, &h, d))
+		return -1;
+	return unshare(CLONE_NEWUSER) ? -1 : 0;
+}
+
+TEST_F(setfcap, setns_ns_without_map_yet_of_another_owner)
+{
+	struct holder h;
+
+	h = spawn(capable_user_unshares, NULL);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(ptracer_joins, &h), 0);
+	reap_holder(h);
+}
+
+/* its creator had no CAP_SETFCAP, so nobody in there can map uid 0 */
+TEST_F(setfcap, setns_ns_created_without_setfcap)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_RESTRICTED, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins, &h), 0);
+	reap_holder(h);
+}
+
+/* a container that doesn't map host uid 0 */
+TEST_F(setfcap, setns_container)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 100000 1000\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(setfcap, setns_unprivileged_ns)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_USER, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_joins, &h), 0);
+	reap_holder(h);
+}
+
+/* ---------------------------------------------------------------------- */
+/* ptrace                                                                  */
+
+FIXTURE(ptrace) {};
+
+FIXTURE_SETUP(ptrace)
+{
+	const char *why = missing();
+	FILE *f;
+	int scope;
+
+	if (why)
+		SKIP(return, "%s", why);
+	f = fopen("/proc/sys/kernel/yama/ptrace_scope", "r");
+	if (f) {
+		if (fscanf(f, "%d", &scope) == 1 && scope == 3) {
+			fclose(f);
+			SKIP(return, "Yama doesn't allow ptrace");
+		}
+		fclose(f);
+	}
+	prepare(_metadata);
+}
+
+FIXTURE_TEARDOWN(ptrace) {}
+
+static long x_attaches(void *a)
+{
+	restrict_root();
+	return attach_only(PID(a));
+}
+
+static long r_attaches(void *a)
+{
+	return attach_only(PID(a));
+}
+
+TEST_F(ptrace, into_ns_without_map_yet)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), -EPERM);
+	reap_holder(h);
+}
+
+static long x_takes_fd(void *a)
+{
+	int pfd, fd;
+
+	restrict_root();
+	pfd = syscall(__NR_pidfd_open, PID(a), 0);
+	if (pfd < 0)
+		return SETUP_ERROR;
+	fd = syscall(__NR_pidfd_getfd, pfd, 100, 0);
+	if (fd < 0)
+		return -errno;
+	close(fd);
+	return 0;
+}
+
+/* pidfd_getfd() checks for PTRACE_MODE_ATTACH */
+TEST_F(ptrace, pidfd_getfd)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 100);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_takes_fd, &h), -EPERM);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, into_ns_mapping_host_root)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), -EPERM);
+	reap_holder(h);
+}
+
+/* the root user can be mapped at any uid */
+TEST_F(ptrace, into_ns_mapping_host_root_at_nonzero_uid)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "5 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), -EPERM);
+	reap_holder(h);
+}
+
+static long u_nested_x_attaches(void *a)
+{
+	return u_nested_x(x_attaches);
+}
+
+TEST_F(ptrace, nested_unprivileged)
+{
+	EXPECT_EQ(in_child(u_nested_x_attaches, NULL), -EPERM);
+}
+
+/* X attaches to a task that joined the namespace and ran prep there */
+struct joined_target {
+	int pid;
+	void (*prep)(void);
+};
+
+static long x_attaches_joiner(void *a)
+{
+	const struct joined_target *j = a;
+	struct holder t;
+	long r;
+
+	t = spawn_joined(j->pid, j->prep, 0);
+	if (t.pid <= 0)
+		return SETUP_ERROR;
+	r = in_child(x_attaches, &t);
+	reap_holder(t);
+	return r;
+}
+
+/* an execve() as uid 0 gives the target CAP_SETFCAP back from its bset */
+TEST_F(ptrace, target_with_setfcap_in_bset)
+{
+	struct joined_target j = { 0, drop_setfcap_keep_bset };
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	j.pid = h.pid;
+	EXPECT_EQ(in_child(x_attaches_joiner, &j), -EPERM);
+	reap_holder(h);
+}
+
+/*
+ * The target's own capabilities don't matter: it gets CAP_SETFCAP back from
+ * its inheritable set on execve(), or takes it from another task of its
+ * namespace with CAP_SYS_PTRACE.
+ */
+TEST_F(ptrace, target_with_setfcap_inheritable)
+{
+	struct joined_target j = { 0, keep_setfcap_inheritable };
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	j.pid = h.pid;
+	EXPECT_EQ(in_child(x_attaches_joiner, &j), -EPERM);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, target_with_sys_ptrace)
+{
+	struct joined_target j = { 0, drop_setfcap };
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	j.pid = h.pid;
+	EXPECT_EQ(in_child(x_attaches_joiner, &j), -EPERM);
+	reap_holder(h);
+}
+
+/* ... or writes "0 0 1" while its namespace has no uid_map yet */
+TEST_F(ptrace, target_without_setfcap_ns_without_map_yet)
+{
+	struct joined_target j = { 0, restrict_root };
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	j.pid = h.pid;
+	EXPECT_EQ(in_child(x_attaches_joiner, &j), -EPERM);
+	reap_holder(h);
+}
+
+/*
+ * PTRACE_TRACEME from a child that joined a namespace mapping host uid 0,
+ * with a parent that gave up CAP_SETFCAP and CAP_SYS_PTRACE after the fork
+ */
+struct traceme {
+	int pid, restricted;
+};
+
+static long parent_of_traceme(void *a)
+{
+	const struct traceme *t = a;
+	int p[2], go[2], pid;
+	long r = SETUP_ERROR;
+	char c;
+
+	if (pipe(p) || pipe(go))
+		return SETUP_ERROR;
+	pid = fork();
+	if (!pid) {
+		close(p[0]);
+		close(go[1]);
+		if (read(go[0], &c, 1) != 1)
+			_exit(1);
+		if (join(t->pid))
+			r = SETUP_ERROR;
+		else
+			r = ptrace(PTRACE_TRACEME, 0, 0, 0) ? -errno : 0;
+		if (write(p[1], &r, sizeof(r)) != sizeof(r))
+			_exit(1);
+		_exit(0);
+	}
+	close(p[1]);
+	close(go[0]);
+	if (pid < 0) {
+		r = SETUP_ERROR;
+	} else {
+		if (t->restricted)
+			restrict_root();
+		if (write(go[1], "g", 1) != 1 ||
+		    read(p[0], &r, sizeof(r)) != sizeof(r))
+			r = SETUP_ERROR;
+	}
+	close(go[1]);
+	close(p[0]);
+	if (pid > 0) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+	}
+	return r;
+}
+
+TEST_F(ptrace, traceme_by_restricted_parent)
+{
+	struct traceme t = { 0, 1 };
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	t.pid = h.pid;
+	EXPECT_EQ(in_child(parent_of_traceme, &t), -EPERM);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, traceme_by_parent_with_setfcap)
+{
+	struct traceme t = { 0, 0 };
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	t.pid = h.pid;
+	EXPECT_EQ(in_child(parent_of_traceme, &t), 0);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, into_container)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 100000 1000\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, ns_mapping_only_user)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 1000 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, between_restricted)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_RESTRICTED, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(ptrace, with_setfcap)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_attaches, &h), 0);
+	reap_holder(h);
+}
+
+/* CAP_SYS_PTRACE doesn't stand in for CAP_SETFCAP */
+static long ptracer_attaches(void *a)
+{
+	drop_setfcap();
+	return attach_only(PID(a));
+}
+
+TEST_F(ptrace, with_sys_ptrace)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(ptracer_attaches, &h), -EPERM);
+	reap_holder(h);
+}
+
+static long x_reads_environ(void *a)
+{
+	char path[64];
+	int fd;
+
+	restrict_root();
+	snprintf(path, sizeof(path), "/proc/%d/environ", PID(a));
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+	close(fd);
+	return 0;
+}
+
+/* PTRACE_MODE_READ is unchanged */
+TEST_F(setfcap, ptrace_read_mode_unchanged)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_reads_environ, &h), 0);
+	reap_holder(h);
+}
+
+TEST_HARNESS_MAIN

-- 
2.55.0

