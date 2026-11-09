Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253774;
	b=M7E1NGYr06N0ZmAA3lv6/v/29V7AcIxTOrEecyXNyBWsL8LZG8DAHYk7MwMWAmSJheRB
	 j8Nbmma1RvEaxmOdTPvhAH/gEUNjXJu+4jpztxeAkOdPTbjjUPM2LUuzq/hBedpgwO3sT
	 GUguflXdWjcVdDPzWsBznlgXVh8iayLAtf2BKJXUa3IZiCY3Af1oD4RupRw1aHpL5P/Ls
	 AHw4/FL5hv1GwWd+/502JYIBERXDBAFWsgi4oIoI7sLnC/wBlYvVHiFFCZK4GToYoxQCj
	 f/u0chfjjpbW03SCRz9NvPOk+IJpGfMA6PsymiaKOj+T75aHW/tMa1PeTXL9C1WVXqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0bAa5Ffh6mYikz3YLCCRnYN/vYu/i43dgFMtOnf8gLY=;
	b=DBMnABZBpW4ZOH6ZHHxj9AgH99pbGhOxA5qWmxq20zXYMTGqKnJs3tKQC0BRYgYyZGzi
	 nNi2faO4l+P0udqK30/NYkuq17SIK5aMI/6R184Q8qKpKs5nw/miBzzUG0ebzDUIIkVHA
	 Kgm27PabDigD6mJrhxuFpXy0Mm7iQm24h6YE6RFLDwPukovwpEZBWwjTrmEu95FV4polU
	 VxCjC24BbnoXeP8RiNyxhzVB9GL4uld+92NU6l+p4ia46U+ju4uGlc6dcOx/mGmkbyKLY
	 2gToycLMkliAzTGMuLDve0elv31OmzDghUG+xemtdYmAOfq1ghXoiyOatag3+tr/OTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gmxHR2n2;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A160A2616
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 19:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 955A160A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=gmxHR2n2
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f3c895a0eso105509385a.2
        for <keyrings@vger.kernel.org>; Mon, 09 Nov 2026 11:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794253771; x=1794858571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0bAa5Ffh6mYikz3YLCCRnYN/vYu/i43dgFMtOnf8gLY=;
        b=gmxHR2n2bdnTfJjex/NtM3hwUy+Pxd8odpPip2kE7Zx8R/A8FmAv2YC/8PXN2M+g9T
         FLJ/b7X6trmBZS22e2cBjV1Dykm69mq8lPedm0QgY5tw5xCpoiqR/vqZBbVA5O6i035o
         QmxcsKvo6bjuUcwteq59gx1KbRS/QEdZhXUXXu/mmRYv+vB4TMWQ0CYpEHWUP/gnIpmi
         HhUV0vtV+1ccibtQDQnMdv2xuubJVAileKPrkKqWvpO5ESr0qn0ec/tildCV8XjCt8Ku
         SDKZ6AMh2fx0Lxv3R2OjcjpCvIiIT6yHHitPiscxMpobwPNtR/DlCnAGWSkJ9PhGqsDu
         eGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253771; x=1794858571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bAa5Ffh6mYikz3YLCCRnYN/vYu/i43dgFMtOnf8gLY=;
        b=sffMs1ULcnLtceSQ4JsiVdAEQls2Z6I5aOMBYnVlFRs2ZUa0AkyS0FEcenhMs89m+g
         i064XmZ+yIEa8CjLecx9ucPWgiHW49WnI9mGw7F0J0PSsVfObPS2ikHVB9SfT3aVuHry
         X1ea23CZsD8dsbL4d5FVJ4gPT5MPTdYkmdpofBigZAK6SWS2+e4rwTqBY49rnFvSg8SS
         BcKKHnMQiy9SC8k4oOWkCz/6/TxOlSw6nwuMSXGF18Ex62xB58HZZQ7ix0zlDSequ/8d
         vR2YbDmkNZNjJmBQF9uy2P2A27mVZs5oIUI8ouMdic5F1gqdRb8vxctQYSWE6iyXxOIy
         t1pw==
X-Forwarded-Encrypted: i=1; AL+hErHUhSWh1dxx9FFXAXAxYtZlKaInuMbwMEL2eHd8xEmV0oKbeW07CEWMNS7E//CfPtRkfdf78DgWEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NQzv2LjBGrntbdlXywv/Wwjbh3SGoJjzYdneoHCkdJ97NwtGk
	GPOnfhiHBVCPani0qSf7Ac8bbZ7TMz92ob1p/JUxD9YJ+xAAa2D49vQzbz42h/8XIds=
X-Gm-Gg: AYBFou2chnetO+o5VS4x0IOPmzt0NNHLrmBuObXlD4v3ohuwT+JFRccORLbkMM3Ngf9
	9QzBDfzKAxOvus5Ko4xwWpm2+2phGN5QlUatXz6WUtm9GUj87GYF1Gjkbh2CVTsDKsyWPUzxCRb
	eexP7YAbVrM0ASmXnXiHFTmU4mjw5ST5fsDV8a9L9hSf3VWuEEi9NSwPNBGrrgHrkcDjaonUcrt
	bUeng1lRTYWBjZ/RMvc+j8yKNwUVcZ5iA1HhatX/wv4AvaCeNjTvNkhwawkmQguT5/XTHWvFfxF
	wf68e+nCtodu4iIMaOxwIZQTtR8mBw6NwCxXwcCxV7XB1e9BgDJahooUqGpw4vM0T2lRBjTZGEg
	1YZU8bkyznJjs6AC2CAblSZ0qPLkFNu1JMT3nSwY3vPCRD5qSbXdlPsaFhLEgUXFRHauGeYU7r7
	V515X9oWeMrpU5QDBb81uzIFnUnJAl+p+EWkr4XCgdVTXxAkt1nYjYiwmPBQVb3BJiIDLvG9nG/
	pCqrajeMEBPshx5rtxfOceNTv+/ekQo0UhjerfIlsxzV9kEHId3uWKaNlrBwmYM6Ij2Jq6niFu7
	EwFpb/KlDigymvN6ROzBjWa5oU2Do48EJ3+ESDka1xOsbg==
X-Received: by 2002:a05:620a:410f:b0:930:f337:ebeb with SMTP id af79cd13be357-9479f1d076amr88806785a.12.1794253771412;
        Mon, 09 Nov 2026 11:49:31 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7845fasm49712885a.18.2026.11.09.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:49:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 09 Nov 2026 19:49:12 +0000
Subject: [PATCH v9 3/3] selftests/namespaces: test the CAP_SETFCAP rule for
 user namespaces
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
Message-Id: <20261109-b4-setfcap-userns-v9-3-0d3f00976ce2@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1794253763; l=31312;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=DfLwiLz35iO+cuPJ3djxnNX03BbmYrEpmC64KRSacOE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKpTHBAGHnCdQrC/rR2E+ohZXo1ei/dODcr6D2uh6NQnfkIOE7cf7c79SfQ3W7Jp08zWzXbLtvN
 xnra+UoQSAwQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add tests for whether a uid 0 task that gave up CAP_SETFCAP gets it back
by joining a user namespace whose tasks can write file capabilities for
its root user, or by attaching to such a task.

Each case runs as root in a private mount namespace with a tmpfs on
/tmp.  It sets up everything but the step it tests and fails if any of
that goes wrong, so a refusal comes from that step.  The ones that must
be refused are setns() and PTRACE_ATTACH into namespaces that map host
uid 0, at uid 0 or another uid, or that have no uid_map yet and whose
tasks can still map it, the same one level down among tasks of an
unprivileged user, setns() after moving the euid away from 0,
pidfd_getfd(), PTRACE_ATTACH to a target that keeps CAP_SETFCAP only in
its bounding set, and PTRACE_TRACEME towards such a parent.  The ones
that must keep working are the mapping rule of commit db2e718a4798
("capabilities: require CAP_SETFCAP to map uid 0") itself, unprivileged
users nesting namespaces, joiners and tracers with CAP_SETFCAP or
CAP_SYS_PTRACE, namespaces created without CAP_SETFCAP, targets that
gave CAP_SETFCAP up for good, containers that don't map host uid 0,
idmapped mounts of a container's rootfs, PTRACE_MODE_READ, and file
capabilities in all of those.

The idmapped mount cases skip when tmpfs can't be idmapped.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tools/testing/selftests/namespaces/Makefile       |    3 +-
 tools/testing/selftests/namespaces/config         |    2 +
 tools/testing/selftests/namespaces/setfcap_test.c | 1210 +++++++++++++++++++++
 3 files changed, 1214 insertions(+), 1 deletion(-)

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
index 000000000000..aee0b1d6f329
--- /dev/null
+++ b/tools/testing/selftests/namespaces/setfcap_test.c
@@ -0,0 +1,1210 @@
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
+static long join(int pid)
+{
+	char path[64];
+	int fd, r;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return SETUP_ERROR;
+	r = setns(fd, CLONE_NEWUSER);
+	close(fd);
+	return r ? -errno : 0;
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
+	int in, out;
+	ssize_t n;
+
+	unlink(path);
+	in = open("/proc/self/exe", O_RDONLY);
+	out = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0755);
+	if (in < 0 || out < 0)
+		return -1;
+	while ((n = read(in, buf, sizeof(buf))) > 0)
+		if (write(out, buf, n) != n)
+			return -1;
+	if (fchown(out, uid, uid) || fchmod(out, 0755))
+		return -1;
+	close(in);
+	close(out);
+	return 0;
+}
+
+/* Does U get CAP_SYS_ADMIN from the file capabilities of path? */
+static int user_gets_sys_admin(const char *path)
+{
+	int pid, st;
+
+	pid = fork();
+	if (pid < 0)
+		return 0;
+	if (!pid) {
+		become_user();
+		setenv("SETFCAP_TEST_CAPS", "1", 1);
+		execl(path, path, NULL);
+		_exit(1);
+	}
+	if (waitpid(pid, &st, 0) != pid)
+		return 0;
+	return WIFEXITED(st) && WEXITSTATUS(st) == CAPS_HAS_SYS_ADMIN;
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
+static struct holder spawn_holder(enum holder_kind kind, int map_fd_at)
+{
+	struct holder h = { -1, -1 };
+	int ready[2], go[2];
+	char c;
+
+	if (pipe(ready) || pipe(go))
+		return h;
+	h.pid = fork();
+	if (!h.pid) {
+		close(ready[0]);
+		close(go[1]);
+		if (kind == HOLDER_RESTRICTED)
+			restrict_root();
+		if (kind == HOLDER_USER)
+			become_user();
+		if (unshare(CLONE_NEWUSER))
+			_exit(1);
+		if (kind == HOLDER_USER && map_user())
+			_exit(1);
+		if (map_fd_at)
+			dup2(open("/proc/self/uid_map", O_WRONLY), map_fd_at);
+		if (write(ready[1], "r", 1) != 1)
+			_exit(1);
+		if (read(go[0], &c, 1) < 0)
+			_exit(1);
+		_exit(0);
+	}
+	close(ready[1]);
+	close(go[0]);
+	if (read(ready[0], &c, 1) != 1)
+		h.pid = -1;
+	close(ready[0]);
+	h.go = go[1];
+	return h;
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
+static struct holder spawn_joined(int pid, void (*prep)(void), int new_ns)
+{
+	struct holder h = { -1, -1 };
+	int ready[2], go[2];
+	char c;
+
+	if (pipe(ready) || pipe(go))
+		return h;
+	h.pid = fork();
+	if (!h.pid) {
+		close(ready[0]);
+		close(go[1]);
+		if (join(pid))
+			_exit(1);
+		if (prep)
+			prep();
+		if (new_ns && unshare(CLONE_NEWUSER))
+			_exit(1);
+		if (write(ready[1], "r", 1) != 1)
+			_exit(1);
+		if (read(go[0], &c, 1) < 0)
+			_exit(1);
+		_exit(0);
+	}
+	close(ready[1]);
+	close(go[0]);
+	if (h.pid > 0 && read(ready[0], &c, 1) != 1) {
+		kill(h.pid, SIGKILL);
+		waitpid(h.pid, NULL, 0);
+		h.pid = -1;
+	}
+	close(ready[0]);
+	h.go = go[1];
+	return h;
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
+/* /tmp idmapped with the user namespace of pid, at /mnt */
+static int idmap_tmp(int pid)
+{
+	struct mount_attr attr = { .attr_set = MOUNT_ATTR_IDMAP };
+	char path[64];
+	int tfd, nsfd;
+
+	mkdir("/mnt", 0755);
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	nsfd = open(path, O_RDONLY);
+	tfd = syscall(__NR_open_tree, AT_FDCWD, "/tmp",
+		      OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	if (nsfd < 0 || tfd < 0)
+		return -1;
+	attr.userns_fd = nsfd;
+	if (syscall(__NR_mount_setattr, tfd, "", AT_EMPTY_PATH, &attr,
+		    sizeof(attr)))
+		return -1;
+	if (syscall(__NR_move_mount, tfd, "", AT_FDCWD, "/mnt",
+		    MOVE_MOUNT_F_EMPTY_PATH))
+		return -1;
+	close(tfd);
+	close(nsfd);
+	return 0;
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
+	mkdir("/mnt", 0755);
+}
+
+FIXTURE(setfcap) {};
+
+FIXTURE_SETUP(setfcap)
+{
+	if (geteuid())
+		SKIP(return, "needs root");
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
+	EXPECT_TRUE(user_gets_sys_admin("/tmp/x"));
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
+/* Idmapped mounts: a container's rootfs can make its root host uid 0.     */
+/* That is up to whoever sets up the mount, so X may still join.           */
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
+	return join(j->pid) ? SETUP_ERROR : set_fcap("/mnt/x", 0);
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
+	if (idmap_tmp(c->idmap_map ? im.pid : ns.pid)) {
+		ret = 1;
+		goto out;
+	}
+	j.pid = ns.pid;
+	j.restricted = c->restricted;
+	*r = in_child(idmap_joins_sets_fcap, &j);
+	umount2("/mnt", MNT_DETACH);
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
+	if (geteuid())
+		SKIP(return, "needs root");
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
+static long u_nested_x_joins(void *a)
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
+	r = in_child(x_joins, &h);
+	reap_holder(h);
+	return r;
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
+	char path[64];
+	int fd, r;
+
+	restrict_root();
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", PID(a));
+	fd = open(path, O_RDONLY);
+	if (fd < 0 || setresuid(-1, 1000, -1) || capget_v3(d))
+		return SETUP_ERROR;
+	d[0].effective = d[0].permitted;
+	d[1].effective = d[1].permitted;
+	if (syscall(SYS_capset, &h, d))
+		return SETUP_ERROR;
+	r = setns(fd, CLONE_NEWUSER);
+	close(fd);
+	return r ? -errno : 0;
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
+TEST_F(setfcap, ptrace_into_ns_without_map_yet)
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
+TEST_F(setfcap, ptrace_pidfd_getfd)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 100);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_takes_fd, &h), -EPERM);
+	reap_holder(h);
+}
+
+TEST_F(setfcap, ptrace_into_ns_mapping_host_root)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), -EPERM);
+	reap_holder(h);
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
+TEST_F(setfcap, ptrace_target_with_setfcap_in_bset)
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
+/* a target that gave CAP_SETFCAP up for good */
+TEST_F(setfcap, ptrace_target_without_setfcap)
+{
+	struct joined_target j = { 0, restrict_root };
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	j.pid = h.pid;
+	EXPECT_EQ(in_child(x_attaches_joiner, &j), 0);
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
+TEST_F(setfcap, ptrace_traceme_by_restricted_parent)
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
+TEST_F(setfcap, ptrace_traceme_by_parent_with_setfcap)
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
+TEST_F(setfcap, ptrace_into_container)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 100000 1000\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(setfcap, ptrace_ns_mapping_only_user)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 1000 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(setfcap, ptrace_between_restricted)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_RESTRICTED, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_attaches, &h), 0);
+	reap_holder(h);
+}
+
+TEST_F(setfcap, ptrace_with_setfcap)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_attaches, &h), 0);
+	reap_holder(h);
+}
+
+/* CAP_SYS_PTRACE gives control of tasks with CAP_SETFCAP anyway */
+static long ptracer_attaches(void *a)
+{
+	drop_setfcap();
+	return attach_only(PID(a));
+}
+
+TEST_F(setfcap, ptrace_with_sys_ptrace)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(ptracer_attaches, &h), 0);
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

