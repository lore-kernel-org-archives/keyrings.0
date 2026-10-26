Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029324;
	b=3KY5dfqbIJokg22G29U9QuMcmvEcibVRAN9JBBE20jk8L1kklimxu21gazOBPyH/KQfj
	 hJDM7NOedNRuNO2a+eZdf3nEgIfoBWmgM4dJqroiePoUU+RIWJayiDLFTfNmz18qkAvU0
	 cwG+whSekRtf97Ge5N7YRbwxmZMB5uRFJSb3uueCZK8SEEA9f/j4+EEagI/t4yfSYu/11
	 49rBUkycvoyK9X21x5iAAevJI0EBBu3H06rtF9VQYzRW9pC8te1ZVVEZgbC14ye652p6K
	 tzeb3m/t0QmTHMCULjJu18St0Rtu7p+6h112E7sAmzC9MBiEMuDyeH3v05sF1a7gqig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hDmpA/YPl0rzE90ujxNkOBbK7OlTUI8aL/f1Edc2GrE=;
	b=UeVRzfmI8mSNLsebKCdyyPR0J6gUSN6vO5wsgED///We05+sN0aCj5JwTQDX7lIyH6DP
	 G8v7MbgciJ6TTzVTrbb/WVSU3SSlUR0A0KVlUnOOnEA1dS9roLGnqksagEKXIlOra2XMN
	 cb8JAdaz/xDazlpHWx3onDgbDKkX9bVpQyX2ZRSRipC4PnIlmgV21aoHzPtmS0pi6s1Ja
	 bTRivU4j/zbInm0kvrDOK15dEQ79EiKMx/L38hG/YwpifeHQzvOoSSSTWitVSPBZcMEy2
	 7ieFSfhl+k9+jBJJA7OHjRcg0S1PZ9ZYIfG6GouFW9UhKCb7lIHOWPD3G+YsQ6RadjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TLXAhbgN;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFD60A261E
	for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 15:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EFD60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TLXAhbgN
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f2ed2541aso2321385a.0
        for <keyrings@vger.kernel.org>; Mon, 26 Oct 2026 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793029319; x=1793634119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDmpA/YPl0rzE90ujxNkOBbK7OlTUI8aL/f1Edc2GrE=;
        b=TLXAhbgNcKx6gRp9iVx3XbW0lULw1PLeKYQoVjtQF/JVKFcBg+DUsjvL24s8KB7E6r
         kHr4bgfi82cllKiYgZ4vmndJFtT6sgxNhqBpG9Zqd9jMztThmQhu+Mfq4/EEC2Yt+6bT
         ybcJ7T4Y4Eio18gqC+wy1VCP47hVJjt++zI4KtxiGuuYeFqgNrqa5v0XZee4jKS5Lwmp
         nxLH1PW0tdSM6VOUiJlbHSX0mq15ceV3M2Pr4VCGL+3hr8Y09aRuVvSKZvZbtp01V0yu
         YdACeZbmd/dP4ln0D7AEzThXEGt/VlkvPFLkSUDpx14x697LZAC9U7N5TjRoElzRnbew
         1v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029319; x=1793634119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDmpA/YPl0rzE90ujxNkOBbK7OlTUI8aL/f1Edc2GrE=;
        b=SE2pkM10cwKPqd6YOQg78hBmhloZw7duk3HAIFQtnmwk5eNoLdLjHZwep/47WUIikd
         d1ETKGCAbWX5vzSj8EdpXgOYQvDSttjxb98IwRjrYEBRp33ArWqagqV9AnfE8LqkVPtU
         8ybkEkuPgPzL750FRRzucwZPpkLhH0xEvXcEpgrw2Z5FZMRAWNmatpa9LhFO21BvV9hd
         YOrhSt7ez4dGncRI1EehEwnIW+txV8BHB1EG4zy92Tw/gM5Z9HzTV8s3T6f6RmWJevYk
         i10HLqjw4ICUOlRIxERDs955XkjXg2cVZR75UjRYDB/zyX8wMQqElWyOSIJYnq0Ijtp2
         jR1w==
X-Forwarded-Encrypted: i=1; AKwUvBw+7EC9AgRbiWOIXpzxN7GBu4jyUgA1lcD4hUTdbjRklauEB4sgTuTZjBCxeFIkNJy0aPKtXRCK/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLKThe1gH8hUIY8Ju4NBPUvr/AgQ4tByhHE97D/08+DZho0xA70
	v6WvnrJPy1jHf8i84xV3hs7yYijHuIjYie3ax267dcTDHbfdw3rJT2fD5w0EanLT9+8=
X-Gm-Gg: AYBFou04pa6TNIo0UrdmkVkcP0fNk+/h/kCk5R3QSk1yDfwxVYFRX86WP+WCzvGbjG6
	k0KdayQLZR7RDDpZinWRfP2AkuMHlPxRu9yLB8JC8EBRcIRE8NzKt2wDpp4t7rUxlCkD5UP3kkF
	jarlZ4rYKIGG7fLatvKnBTABOkfMSm+I1m0brueowwz6ZgHmriP1v81H+G4a4YD/EhUdlqNU4Tx
	1GOM6MXKp1st3U1M3T2IYlJNbhDh6Z/YKF/vEWev7eIgMqjApL0/95vcYOkw6O1WBXmGQin2L9d
	D62rWrEZcJzvd0NFZLBdEVMYJoS2cZ83H20Pcwfikkx1WmUL2z1XUcCWubQfX4u5pdCqfSqei69
	RhNkbInXdZKh1PiKd4bJqfkPphZT9KO2IWAb6NXGMGBvyaunrzJWJhaIjhO6vQnF3mFRnazDUpb
	R1yacSuUf4Z0Nbp888WODgnZdB7D/KkViVA1wZ79J3AYja1QI2jEvBWZBuQ2bWwnOPoSufZcM2+
	zpxr9NWNU1S01cl0gN9v5cnfmpQkSeXRYoyVl+lktp6iiOnvbi7whAwv8iBbEx5JNZEGrnP
X-Received: by 2002:a05:620a:288e:b0:93f:3193:ac09 with SMTP id af79cd13be357-943f4b42489mr5767285a.15.1793029318741;
        Mon, 26 Oct 2026 08:41:58 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0788550sm717560485a.26.2026.10.26.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:41:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 26 Oct 2026 15:41:42 +0000
Subject: [PATCH v6 6/6] selftests/namespaces: test the CAP_SETFCAP rule for
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
Message-Id: <20261026-b4-setfcap-userns-v6-6-25f10b7ca497@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793029305; l=35447;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=x1SQg8IjmzgLoD6JRWaGWk8Tenol7HkV3gwR2Dukj2c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOyjA1FkBSHmif8/1xstyMpYd501kUDVLUxcHUMRUFoFM1NT0/3oNfrMyyvN2X8qGV45TOcv0bB
 RqXDj6IKkpg4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add tests for who may map the root user of an ancestor user namespace,
write file capabilities that are honoured in an ancestor, join a
namespace whose tasks may do so, or attach to such a task.

Each case runs as root in a private mount namespace with a tmpfs on
/tmp.  The ones that must be refused are the ways around the rule that
the preceding patches close: setns() into a namespace created with
CAP_SETFCAP, a uid_map fd opened by somebody else, pidfd_getfd(), a
writer inside the namespace that gave up CAP_SETFCAP, the root user of
an ancestor mapped at a non-zero uid, v2 and v3 xattrs written after a
privileged task mapped uid 0 for a namespace created without
CAP_SETFCAP, a joiner of such a namespace, and PTRACE_ATTACH.  The ones
that must keep working are a task mapping its own namespace, a
privileged task mapping it from the parent, unprivileged users nesting
namespaces, joiners that have CAP_SETFCAP, file capabilities in all of
those, containers that don't map host uid 0, and idmapped mounts of a
container's rootfs.  Where file capabilities are written the test also
checks whether uid 1000 gets CAP_SYS_ADMIN from them, by running a copy
of itself.

The idmapped mount cases skip when tmpfs can't be idmapped.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tools/testing/selftests/namespaces/Makefile       |    3 +-
 tools/testing/selftests/namespaces/config         |    3 +
 tools/testing/selftests/namespaces/setfcap_test.c | 1362 +++++++++++++++++++++
 3 files changed, 1367 insertions(+), 1 deletion(-)

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
index d09836260262..dfbabc35cd8a 100644
--- a/tools/testing/selftests/namespaces/config
+++ b/tools/testing/selftests/namespaces/config
@@ -5,3 +5,6 @@ CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
 CONFIG_CGROUPS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_KEYS=y
diff --git a/tools/testing/selftests/namespaces/setfcap_test.c b/tools/testing/selftests/namespaces/setfcap_test.c
new file mode 100644
index 000000000000..0a82b239b368
--- /dev/null
+++ b/tools/testing/selftests/namespaces/setfcap_test.c
@@ -0,0 +1,1362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Who may map the root user of an ancestor user namespace, write file
+ * capabilities that are honoured in an ancestor, join a namespace whose
+ * tasks may do so, or take control of such a task.
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
+#include <linux/keyctl.h>
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
+	if (!pid) {
+		become_user();
+		setenv("SETFCAP_TEST_CAPS", "1", 1);
+		execl(path, path, NULL);
+		_exit(1);
+	}
+	waitpid(pid, &st, 0);
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
+		r = fn(arg);
+		if (write(p[1], &r, sizeof(r)) != sizeof(r))
+			_exit(1);
+		_exit(0);
+	}
+	close(p[1]);
+	if (read(p[0], &r, sizeof(r)) != sizeof(r))
+		r = SETUP_ERROR;
+	close(p[0]);
+	waitpid(pid, NULL, 0);
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
+/* ... whose maps are written from the parent namespace by the caller */
+static struct holder spawn_mapped(enum holder_kind kind, const char *map)
+{
+	struct holder h = spawn_holder(kind, 0);
+
+	if (h.pid > 0 && map_both(h.pid, map))
+		h.pid = -1;
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
+/* Mapping uid 0 of the parent, or the root user of an ancestor at any uid */
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
+static long x_joins_and_maps(void *a)
+{
+	long r;
+
+	restrict_root();
+	r = join(PID(a));
+	if (r)
+		return r;
+	return write_map(0, "0 0 1\n");
+}
+
+/* X can't get into R's namespace to map uid 0 from inside */
+TEST_F(setfcap, map_after_setns)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins_and_maps, &h), -EPERM);
+	reap_holder(h);
+}
+
+static long x_writes_fd(void *a)
+{
+	restrict_root();
+	return wr(*(int *)a, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_through_borrowed_fd)
+{
+	struct holder h;
+	char path[64];
+	int fd;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	snprintf(path, sizeof(path), "/proc/%d/uid_map", h.pid);
+	fd = open(path, O_WRONLY);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(in_child(x_writes_fd, &fd), -EPERM);
+	close(fd);
+	reap_holder(h);
+}
+
+static long x_steals_fd(void *a)
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
+	return wr(fd, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_through_pidfd_getfd)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 100);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_steals_fd, &h), -EPERM);
+	reap_holder(h);
+}
+
+/* the same one level down, among tasks of an unprivileged user */
+static long u_nested(void *a)
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
+	r = in_child(x_joins_and_maps, &h);
+	reap_holder(h);
+	return r;
+}
+
+TEST_F(setfcap, map_after_setns_nested_unprivileged)
+{
+	EXPECT_EQ(in_child(u_nested, NULL), -EPERM);
+}
+
+static long x_joins_unshares_maps(void *a)
+{
+	long r;
+
+	restrict_root();
+	r = join(PID(a));
+	if (r)
+		return r;
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	return write_map(0, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_after_setns_and_unshare)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins_unshares_maps, &h), -EPERM);
+	reap_holder(h);
+}
+
+/* the writer opened the map, then went into an unrelated namespace */
+static long r_opens_then_leaves(void *a)
+{
+	char path[64];
+	int fd;
+
+	snprintf(path, sizeof(path), "/proc/%d/uid_map", PID(a));
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return SETUP_ERROR;
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	return wr(fd, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_writer_left_for_other_ns)
+{
+	struct holder h;
+
+	h = spawn_holder(HOLDER_ROOT, 0);
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(r_opens_then_leaves, &h), -EPERM);
+	reap_holder(h);
+}
+
+/*
+ * R maps host uid 0 as uid 1000 of X's namespace.  X maps "0 1000 1" one
+ * level down: host uid 0 is uid 0 there without any extent at uid 0.
+ */
+static long x_nonzero_root(void *a)
+{
+	int s1[2], s2[2], res[2], pid;
+	long r = SETUP_ERROR;
+	char c;
+
+	if (pipe(s1) || pipe(s2) || pipe(res))
+		return SETUP_ERROR;
+	pid = fork();
+	if (!pid) {
+		restrict_root();
+		if (unshare(CLONE_NEWUSER) || write(s1[1], "u", 1) != 1 ||
+		    read(s2[0], &c, 1) != 1)
+			_exit(1);
+		if (unshare(CLONE_NEWUSER))
+			r = SETUP_ERROR;
+		else
+			r = write_map(0, "0 1000 1\n");
+		if (write(res[1], &r, sizeof(r)) != sizeof(r))
+			_exit(1);
+		_exit(0);
+	}
+	if (read(s1[0], &c, 1) != 1 || map_both(pid, "1000 0 1\n") ||
+	    write(s2[1], "g", 1) != 1 || read(res[0], &r, sizeof(r)) != sizeof(r))
+		r = SETUP_ERROR;
+	waitpid(pid, NULL, 0);
+	return r;
+}
+
+TEST_F(setfcap, map_ancestor_root_at_nonzero_uid)
+{
+	EXPECT_EQ(in_child(x_nonzero_root, NULL), -EPERM);
+}
+
+/*
+ * R's namespace has no map yet.  R opens its uid_map and hands the fd to a
+ * task of the same namespace that gave up CAP_SETFCAP (but kept it in the
+ * bounding set, so it would get it back from execve() as uid 0).
+ */
+static long dropped_writes_inherited_fd(void *a)
+{
+	int fd, pid, st;
+	long r = SETUP_ERROR;
+	int p[2];
+
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	fd = open("/proc/self/uid_map", O_WRONLY);
+	if (fd < 0 || pipe(p))
+		return SETUP_ERROR;
+	pid = fork();
+	if (!pid) {
+		drop_setfcap_keep_bset();
+		r = wr(fd, "0 0 1\n");
+		if (write(p[1], &r, sizeof(r)) != sizeof(r))
+			_exit(1);
+		_exit(0);
+	}
+	if (read(p[0], &r, sizeof(r)) != sizeof(r))
+		r = SETUP_ERROR;
+	waitpid(pid, &st, 0);
+	return r;
+}
+
+TEST_F(setfcap, map_in_ns_writer_without_setfcap)
+{
+	EXPECT_EQ(in_child(dropped_writes_inherited_fd, NULL), -EPERM);
+}
+
+/* ... and the same task opening its own map */
+static long dropped_opens_and_writes(void *a)
+{
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	drop_setfcap_keep_bset();
+	return write_map(0, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_in_ns_opener_without_setfcap)
+{
+	EXPECT_EQ(in_child(dropped_opens_and_writes, NULL), -EPERM);
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
+static long session_to_parent(void *a)
+{
+	if (syscall(SYS_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL) < 0 ||
+	    syscall(SYS_keyctl, KEYCTL_SESSION_TO_PARENT) < 0)
+		return SETUP_ERROR;
+	return 0;
+}
+
+/* a cred replaced by key_change_session_keyring() keeps what it had */
+static long r_new_session_keyring_maps(void *a)
+{
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	if (in_child(session_to_parent, NULL))
+		return SETUP_ERROR;
+	return write_map(0, "0 0 1\n");
+}
+
+TEST_F(setfcap, map_after_session_to_parent)
+{
+	EXPECT_EQ(in_child(r_new_session_keyring_maps, NULL), 0);
+}
+
+/* ---------------------------------------------------------------------- */
+/* File capabilities that are honoured in an ancestor                      */
+
+static long x_joins_sets_fcap(void *a)
+{
+	long r;
+
+	restrict_root();
+	r = join(PID(a));
+	if (r)
+		return r;
+	return set_fcap("/tmp/x", -1);
+}
+
+TEST_F(setfcap, fcap_after_setns)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "0 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins_sets_fcap, &h), -EPERM);
+	reap_holder(h);
+	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
+}
+
+static long x_joins_sets_fcap_rootid5(void *a)
+{
+	long r;
+
+	restrict_root();
+	r = join(PID(a));
+	if (r)
+		return r;
+	return set_fcap("/tmp/x", 5);
+}
+
+/* a v3 xattr can name the root user by any uid it has in the namespace */
+TEST_F(setfcap, fcap_after_setns_v3_rootid)
+{
+	struct holder h;
+
+	h = spawn_mapped(HOLDER_ROOT, "5 0 1\n");
+	ASSERT_GT(h.pid, 0);
+	EXPECT_EQ(in_child(x_joins_sets_fcap_rootid5, &h), -EPERM);
+	reap_holder(h);
+	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
+}
+
+/* X unshares and R maps "0 0 1" for it from the parent */
+static long x_unshares_r_maps(void *a)
+{
+	int version = *(int *)a;
+	int s1[2], s2[2], res[2], pid;
+	long r = SETUP_ERROR;
+	char c;
+
+	if (pipe(s1) || pipe(s2) || pipe(res))
+		return SETUP_ERROR;
+	pid = fork();
+	if (!pid) {
+		restrict_root();
+		if (unshare(CLONE_NEWUSER) || write(s1[1], "u", 1) != 1 ||
+		    read(s2[0], &c, 1) != 1)
+			_exit(1);
+		if (version == 2) {
+			/* a v2 xattr on a tmpfs of its own */
+			if (unshare(CLONE_NEWNS) ||
+			    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
+			    mount("tmpfs", "/mnt", "tmpfs", 0, NULL) ||
+			    new_file("/mnt/f", 0))
+				r = SETUP_ERROR;
+			else
+				r = set_fcap("/mnt/f", -1);
+		} else {
+			r = set_fcap("/tmp/x", -1);
+		}
+		if (write(res[1], &r, sizeof(r)) != sizeof(r))
+			_exit(1);
+		_exit(0);
+	}
+	if (read(s1[0], &c, 1) != 1 || map_both(pid, "0 0 1\n") ||
+	    write(s2[1], "g", 1) != 1 || read(res[0], &r, sizeof(r)) != sizeof(r))
+		r = SETUP_ERROR;
+	waitpid(pid, NULL, 0);
+	return r;
+}
+
+TEST_F(setfcap, fcap_creator_without_setfcap_parent_mapped)
+{
+	int version = 3;
+
+	EXPECT_EQ(in_child(x_unshares_r_maps, &version), -EPERM);
+	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
+}
+
+/* the v2 fast path of cap_convert_nscap() */
+TEST_F(setfcap, fcap_v2_creator_without_setfcap_parent_mapped)
+{
+	int version = 2;
+
+	EXPECT_EQ(in_child(x_unshares_r_maps, &version), -EPERM);
+}
+
+/* R maps "5 0 1", gives up CAP_SETFCAP, unshares again */
+static long r_drops_then_nests(void *a)
+{
+	if (unshare(CLONE_NEWUSER) || map_both(0, "5 0 1\n"))
+		return SETUP_ERROR;
+	restrict_root();
+	if (set_fcap("/tmp/x", 5) != -EPERM)
+		return SETUP_ERROR;
+	if (unshare(CLONE_NEWUSER))
+		return SETUP_ERROR;
+	if (write_map(0, "5 5 1\n"))
+		return -EPERM;
+	write_file(0, "setgroups", "deny");
+	write_file(0, "gid_map", "5 5 1\n");
+	return set_fcap("/tmp/x", 5);
+}
+
+TEST_F(setfcap, fcap_after_dropping_setfcap_and_nesting)
+{
+	EXPECT_EQ(in_child(r_drops_then_nests, NULL), -EPERM);
+	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
+}
+
+/* X unshares, R maps "0 0 1" for it, and another R joins it */
+static long joiner_takes_ns_reach(void *a)
+{
+	struct holder h;
+	long r;
+
+	h = spawn_mapped(HOLDER_RESTRICTED, "0 0 1\n");
+	if (h.pid <= 0)
+		return SETUP_ERROR;
+	r = join(h.pid);
+	if (!r)
+		r = set_fcap("/tmp/x", -1);
+	reap_holder(h);
+	return r;
+}
+
+TEST_F(setfcap, fcap_joiner_takes_namespace_reach)
+{
+	EXPECT_EQ(in_child(joiner_takes_ns_reach, NULL), -EPERM);
+	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
+}
+
+/*
+ * A v2 xattr on a filesystem whose namespace has no uid 0 has no root user
+ * and is honoured nowhere: refuse it rather than storing it unconverted.
+ */
+static long r_v2_without_uid0(void *a)
+{
+	if (unshare(CLONE_NEWUSER) || map_both(0, "1000 0 1\n"))
+		return SETUP_ERROR;
+	/* host uid 0, our uid, is uid 1000 here */
+	if (unshare(CLONE_NEWNS) ||
+	    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
+	    mount("tmpfs", "/mnt", "tmpfs", 0, NULL) || new_file("/mnt/f", 1000))
+		return SETUP_ERROR;
+	return set_fcap("/mnt/f", -1);
+}
+
+TEST_F(setfcap, fcap_v2_without_uid0_in_fs_ns)
+{
+	EXPECT_EQ(in_child(r_v2_without_uid0, NULL), -EINVAL);
+}
+
+/* ... and from the parent namespace, where the writer does have a root user */
+static long r_v2_without_uid0_from_parent(void *a)
+{
+	struct holder *h = a;
+	char path[64];
+
+	snprintf(path, sizeof(path), "/proc/%d/root/mnt/f", h->pid);
+	return set_fcap(path, -1);
+}
+
+TEST_F(setfcap, fcap_v2_without_uid0_from_parent)
+{
+	int ready[2], go[2], mapped[2], pid;
+	struct holder h;
+	char c;
+
+	ASSERT_EQ(pipe(ready), 0);
+	ASSERT_EQ(pipe(go), 0);
+	ASSERT_EQ(pipe(mapped), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		/* host uid 0 is uid 1000 in here, nobody is uid 0 */
+		if (unshare(CLONE_NEWUSER) || write(ready[1], "u", 1) != 1 ||
+		    read(mapped[0], &c, 1) != 1 || unshare(CLONE_NEWNS) ||
+		    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
+		    mount("tmpfs", "/mnt", "tmpfs", 0, NULL) ||
+		    new_file("/mnt/f", 1000) || write(ready[1], "m", 1) != 1)
+			_exit(1);
+		if (read(go[0], &c, 1) < 0)
+			_exit(1);
+		_exit(0);
+	}
+	h.pid = pid;
+	h.go = go[1];
+	ASSERT_EQ(read(ready[0], &c, 1), 1);
+	ASSERT_EQ(map_both(pid, "1000 0 1\n"), 0);
+	ASSERT_EQ(write(mapped[1], "g", 1), 1);
+	ASSERT_EQ(read(ready[0], &c, 1), 1);
+	EXPECT_EQ(in_child(r_v2_without_uid0_from_parent, &h), -EINVAL);
+	reap_holder(h);
+}
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
+static long r_v2_own_fs(void *a)
+{
+	if (unshare(CLONE_NEWUSER) || map_both(0, "0 0 1\n"))
+		return SETUP_ERROR;
+	if (unshare(CLONE_NEWNS) ||
+	    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
+	    mount("tmpfs", "/mnt", "tmpfs", 0, NULL) || new_file("/mnt/f", 0))
+		return SETUP_ERROR;
+	return set_fcap("/mnt/f", -1);
+}
+
+TEST_F(setfcap, fcap_v2_own_ns)
+{
+	EXPECT_EQ(in_child(r_v2_own_fs, NULL), 0);
+}
+
+/* ---------------------------------------------------------------------- */
+/* Idmapped mounts: the root user is both the one seen through the mount   */
+/* and the one stored.  Mounts that make a container's root host uid 0 are  */
+/* up to whoever sets them up.                                             */
+
+struct idmap_case {
+	const char *ns_map, *idmap_map;
+	int file_uid, restricted;
+};
+
+/* returns 1 to skip: no idmapped mounts on tmpfs */
+static int idmap_case(const struct idmap_case *c, long *r)
+{
+	struct holder ns, im;
+	int pid, p[2], st;
+
+	ns = spawn_mapped(HOLDER_ROOT, c->ns_map);
+	if (ns.pid <= 0)
+		return -1;
+	im = c->idmap_map ? spawn_mapped(HOLDER_ROOT, c->idmap_map) : ns;
+	if (im.pid <= 0 || new_file("/tmp/x", c->file_uid))
+		return -1;
+	if (idmap_tmp(im.pid)) {
+		reap_holder(ns);
+		if (c->idmap_map)
+			reap_holder(im);
+		return 1;
+	}
+	if (pipe(p))
+		return -1;
+	/* join from a child of the namespace's holder's sibling: pass the pid */
+	pid = fork();
+	if (!pid) {
+		long res;
+
+		if (c->restricted)
+			restrict_root();
+		res = join(ns.pid);
+		if (!res)
+			res = set_fcap("/mnt/x", 0);
+		if (write(p[1], &res, sizeof(res)) != sizeof(res))
+			_exit(1);
+		_exit(0);
+	}
+	if (read(p[0], r, sizeof(*r)) != sizeof(*r))
+		*r = SETUP_ERROR;
+	waitpid(pid, &st, 0);
+	umount2("/mnt", MNT_DETACH);
+	reap_holder(ns);
+	if (c->idmap_map)
+		reap_holder(im);
+	return 0;
+}
+
+FIXTURE(idmap) {};
+
+FIXTURE_VARIANT(idmap) {
+	struct idmap_case c;
+	long expect;
+};
+
+/* X can't join a namespace that maps host uid 0 to get at the mount */
+FIXTURE_VARIANT_ADD(idmap, reverse_mapping) {
+	.c = { "0 0 1\n", "100000 0 1\n", 100000, 1 },
+	.expect = -EPERM,
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
+	long r;
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

