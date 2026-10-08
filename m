Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B14D09F5;
	Thu,  8 Oct 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471477; cv=none; b=tWLPKc6nxxHAraoOe1b/Mm+cdZL3t2e+uRJFj/gi9IvjlYl/gRxWC7sL+gW9s5fsgt4ePhwJ9yiB1JnIA76LFJ00/8eBBOZtU0Y7vo6JEr80zsbvrQFhORgZdR4CK/vw7f+IEKBg02jCDeSd9v2W3zR5iUAwIjVu4ufUslNSY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471477; c=relaxed/simple;
	bh=dFyDlFylCGBedwblTNmCGRDAA9Qq0CQZ4HD6Q8uJaG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1UZcJym9XYZ4vv11AkRpHz1UnKMJXO7gJsp6dw+xup84RVgrh5miC5Wy1Qejojxaa+ly+xEECaoeAznhvTSDtJrSSbBT362adl+iki0OJFB7i+hPRdm4MZQeYE1MDaBGZVWQPaJCuwHJlVXsGOClESmT567S7JtLfCwWBCEjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2eoCYQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2eoCYQD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 141E11F000FF;
	Thu,  8 Oct 2026 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791471463;
	bh=Wh5tQGvwWbPkZbskfNrB5zOk8u7eEUeQg7AHnvaIuR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g2eoCYQDLF/ul9J+VXkCUEVxgAb5bxyLa4lGjVvWTvOp6GlMiamjszoOnqPz68PeS
	 YQonnD86QwUYd2tBRe+eQ8ssGV+aEjMr98ooR8aP0vZ5syNTZSDouXZ+9r1g8PevBt
	 lLiRv9z0RCEbaHBDV0PUPxTLiqp209TQcygs2PPR/Bb3Mm7jslmJ8gEY76woqdQKlX
	 yCwM++lUGpon9h2qx1M8s938ZPX77707z2UYhSEdDIfqfYYIJ1gATOB66KDuJXPhQd
	 7Xe8FcUbVSwbi7hjW6a1MWwxMUQaumE879KIurA2pT94aNA5P+bxr59iDDHaSHna9D
	 eBqcZN/XxO2eA==
Date: Thu, 8 Oct 2026 17:57:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, dhowells@redhat.com,
	keyrings@vger.kernel.org
Subject: Re: [PATCH] selftests/keys: Add persistent keyring expiry regression
 test
Message-ID: <asevZLJWiIjSqLD9@kernel.org>
References: <20261006173902.78344-1-sahaj123.sc@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006173902.78344-1-sahaj123.sc@gmail.com>

On Tue, Oct 06, 2026 at 11:09:02PM +0530, Sahaj Chaudhari wrote:
> KEYCTL_GET_PERSISTENT creates and registers a persistent keyring before
> linking it into the caller's destination keyring. If the destination is
> restricted, the link returns -EPERM. Verify that the keyring's configured
> expiry is still applied after the failed link.
> 
> Register the test in kselftest and document direct and QEMU/GDB execution.
> The failure case is intended for a disposable VM: an unexpired persistent
> keyring may remain registered until its user namespace is torn down.
> 
> Tested:
> 
>   make -C tools/testing/selftests/keys
> 
>   QEMU guest with fixed kernel: TAP pass 1/1
> 
> Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>

I don't think we want this. This is a specialized reproducer.

> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/keys/.gitignore       |   2 +
>  tools/testing/selftests/keys/Makefile         |   6 +
>  tools/testing/selftests/keys/README           |  50 +++
>  .../testing/selftests/keys/initramfs-init.sh  |  10 +
>  .../keys/persistent_keyring_expiry.c          | 367 ++++++++++++++++++
>  tools/testing/selftests/keys/run_qemu.sh      |  64 +++
>  7 files changed, 500 insertions(+)
>  create mode 100644 tools/testing/selftests/keys/.gitignore
>  create mode 100644 tools/testing/selftests/keys/Makefile
>  create mode 100644 tools/testing/selftests/keys/README
>  create mode 100755 tools/testing/selftests/keys/initramfs-init.sh
>  create mode 100644 tools/testing/selftests/keys/persistent_keyring_expiry.c
>  create mode 100755 tools/testing/selftests/keys/run_qemu.sh
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 273853937c25..d74ad9370bd1 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -62,6 +62,7 @@ TARGETS += ipc
>  TARGETS += ir
>  TARGETS += kcmp
>  TARGETS += kexec
> +TARGETS += keys
>  TARGETS += kselftest_harness
>  TARGETS += kvm
>  TARGETS += landlock
> diff --git a/tools/testing/selftests/keys/.gitignore b/tools/testing/selftests/keys/.gitignore
> new file mode 100644
> index 000000000000..48c2900d780e
> --- /dev/null
> +++ b/tools/testing/selftests/keys/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +persistent_keyring_expiry
> diff --git a/tools/testing/selftests/keys/Makefile b/tools/testing/selftests/keys/Makefile
> new file mode 100644
> index 000000000000..33984d1eceb3
> --- /dev/null
> +++ b/tools/testing/selftests/keys/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -g -Wall $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := persistent_keyring_expiry
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/keys/README b/tools/testing/selftests/keys/README
> new file mode 100644
> index 000000000000..dd92abc1ddfe
> --- /dev/null
> +++ b/tools/testing/selftests/keys/README
> @@ -0,0 +1,50 @@
> +The persistent_keyring_expiry selftest verifies that a failed link from
> +KEYCTL_GET_PERSISTENT still gives a newly created persistent keyring its
> +configured expiry. It requires CONFIG_KEYS, CONFIG_PERSISTENT_KEYRINGS,
> +CONFIG_PROC_FS, procfs, and root privileges. The test temporarily changes
> +/proc/sys/kernel/keys/persistent_keyring_expiry and restores its original value.
> +
> +Build and run it against a kernel containing the fix with:
> +
> +    make -C tools/testing/selftests/keys
> +    sudo tools/testing/selftests/keys/persistent_keyring_expiry
> +
> +The QEMU/GDB instructions assume a configured Linux source tree with an
> +existing `.config` and the standard kernel build toolchain. The QEMU runner
> +requires `cpio`, `qemu-system-x86_64`, `busybox`, and `ldd`; GDB is required
> +for the interactive debugging steps.
> +
> +For a QEMU/GDB run, build an x86 kernel with debug symbols and
> +CONFIG_PERSISTENT_KEYRINGS=y. Starting from an existing `.config`, enable
> +the required options and build `bzImage` and `vmlinux`:
> +
> +    scripts/config --enable KEYS --enable PERSISTENT_KEYRINGS \
> +        --enable PROC_FS --enable DEVTMPFS --enable DEVTMPFS_MOUNT \
> +        --disable DEBUG_INFO_NONE --enable DEBUG_INFO \
> +        --enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> +        --enable GDB_SCRIPTS --enable FRAME_POINTER
> +    make olddefconfig
> +    make -j2 bzImage
> +
> +Then run:
> +
> +    tools/testing/selftests/keys/run_qemu.sh path/to/bzImage path/to/vmlinux
> +
> +In another terminal, attach GDB and continue the paused guest:
> +
> +    gdb path/to/vmlinux
> +    (gdb) target remote localhost:1234
> +    (gdb) break key_get_persistent
> +    (gdb) break key_set_timeout
> +    (gdb) continue
> +
> +At `key_get_persistent`, inspect `uid` with `info args`. Continue until
> +`key_set_timeout` is hit, check `timeout` with `print timeout` (300 seconds),
> +then continue to let the test finish. The result is printed on the QEMU serial
> +console.
> +
> +To reproduce the bug, run this test against a kernel built from the parent of
> +commit 25bf14f81716. It reports a permanent ("perm") expiry. With the fix, the
> +restricted link returns -EPERM and the new keyring has a finite expiry.
> +The pre-fix bug can leave a permanent keyring in the test's user namespace
> +until that namespace is torn down, so run this reproduction in a disposable VM.

We would expect this to run without this documentatio existing at all.

> diff --git a/tools/testing/selftests/keys/initramfs-init.sh b/tools/testing/selftests/keys/initramfs-init.sh
> new file mode 100755
> index 000000000000..47cbfcb68d64
> --- /dev/null
> +++ b/tools/testing/selftests/keys/initramfs-init.sh
> @@ -0,0 +1,10 @@
> +#!/bin/busybox sh
> +# SPDX-License-Identifier: GPL-2.0
> +# shellcheck shell=dash
> +
> +/bin/busybox mount -t proc procfs /proc
> +/keys/persistent_keyring_expiry
> +status=$?
> +/bin/busybox echo "keyring expiry selftest exit status: $status"
> +/bin/busybox poweroff -f
> +exit "$status"
> diff --git a/tools/testing/selftests/keys/persistent_keyring_expiry.c b/tools/testing/selftests/keys/persistent_keyring_expiry.c
> new file mode 100644
> index 000000000000..55dbd8ce74ec
> --- /dev/null
> +++ b/tools/testing/selftests/keys/persistent_keyring_expiry.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/keyctl.h>
> +#include <limits.h>
> +#include <stdarg.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "../kselftest.h"
> +
> +#define EXPIRY_PATH "/proc/sys/kernel/keys/persistent_keyring_expiry"
> +#define TEST_EXPIRY 300
> +
> +static int read_expiry(unsigned int *expiry)
> +{
> +	char buf[32];
> +	char *end;
> +	unsigned long value;
> +	ssize_t len;
> +	int fd;
> +
> +	fd = open(EXPIRY_PATH, O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	len = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (len <= 0)
> +		return -1;
> +
> +	buf[len] = '\0';
> +	errno = 0;
> +	value = strtoul(buf, &end, 10);
> +	if (errno || end == buf || (*end != '\n' && *end != '\0') ||
> +	    value > UINT_MAX) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	*expiry = value;
> +	return 0;
> +}
> +
> +static int write_expiry(unsigned int expiry)
> +{
> +	char buf[32];
> +	size_t len;
> +	ssize_t written;
> +	int fd;
> +
> +	len = snprintf(buf, sizeof(buf), "%u\n", expiry);
> +	fd = open(EXPIRY_PATH, O_WRONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	written = write(fd, buf, len);
> +	if (written != len) {
> +		int saved_errno = errno;
> +
> +		close(fd);
> +		errno = written >= 0 ? EIO : saved_errno;
> +		return -1;
> +	}
> +	if (close(fd) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static long add_keyring(const char *description)
> +{
> +	return syscall(SYS_add_key, "keyring", description, NULL, 0,
> +		       KEY_SPEC_SESSION_KEYRING);
> +}
> +
> +static int unlink_key(int key, int keyring)
> +{
> +	return syscall(SYS_keyctl, KEYCTL_UNLINK, key, keyring, 0, 0);
> +}
> +
> +static int find_persistent_expiry(uid_t uid, char *expiry, size_t expiry_len)
> +{
> +	char description[32];
> +	char *line = NULL;
> +	size_t line_len = 0;
> +	ssize_t len;
> +	FILE *keys;
> +	int found = 0;
> +
> +	snprintf(description, sizeof(description), "_persistent.%u", uid);
> +	keys = fopen("/proc/keys", "r");
> +	if (!keys)
> +		return -1;
> +
> +	while ((len = getline(&line, &line_len, keys)) >= 0) {
> +		char *fields[9];
> +		char *saveptr;
> +		char *field;
> +		unsigned int n = 0;
> +		size_t description_len = strlen(description);
> +
> +		for (field = strtok_r(line, " \t\n", &saveptr);
> +		     field && n < ARRAY_SIZE(fields);
> +		     field = strtok_r(NULL, " \t\n", &saveptr))
> +			fields[n++] = field;
> +
> +		if (n == ARRAY_SIZE(fields) &&
> +		    strncmp(fields[8], description, description_len) == 0 &&
> +		    (fields[8][description_len] == '\0' ||
> +		     fields[8][description_len] == ':')) {
> +			snprintf(expiry, expiry_len, "%s", fields[3]);
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	free(line);
> +	fclose(keys);
> +	return found;
> +}
> +
> +static void dump_persistent_keys(void)
> +{
> +	char *line = NULL;
> +	size_t line_len = 0;
> +	FILE *keys = fopen("/proc/keys", "r");
> +
> +	if (!keys)
> +		return;
> +
> +	while (getline(&line, &line_len, keys) >= 0) {
> +		if (strstr(line, "_persistent."))
> +			ksft_print_msg("visible key: %s", line);
> +	}
> +
> +	free(line);
> +	fclose(keys);
> +}
> +
> +static void set_failure(char *reason, size_t reason_len, const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vsnprintf(reason, reason_len, fmt, args);
> +	va_end(args);
> +}
> +
> +static void report_skip(const char *reason)
> +{
> +	ksft_test_result_skip("%s\n", reason);
> +	ksft_finished();
> +}
> +
> +int main(void)
> +{
> +	char expiry[32] = {};
> +	char reason[256] = {};
> +	unsigned int saved_expiry;
> +	uid_t test_uid = getuid();
> +	int destination = -1;
> +	int cleanup_destination = -1;
> +	int linked_persistent = -1;
> +	int cleanup_persistent = -1;
> +	long ret;
> +	bool restore_expiry = false;
> +	bool passed = false;
> +	bool skipped = false;
> +	int get_persistent_errno;
> +	int attempt;
> +	int found;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	if (geteuid() != 0)
> +		report_skip("requires root to set persistent_keyring_expiry");
> +
> +	if (read_expiry(&saved_expiry) < 0)
> +		report_skip("CONFIG_PERSISTENT_KEYRINGS or procfs is unavailable");
> +
> +	found = find_persistent_expiry(test_uid, expiry, sizeof(expiry));
> +	if (found < 0)
> +		report_skip("/proc/keys is unavailable");
> +	if (found) {
> +		test_uid = 50000 + (getpid() % 10000);
> +		for (attempt = 0; attempt < 128; attempt++) {
> +			found = find_persistent_expiry(test_uid, expiry,
> +						       sizeof(expiry));
> +			if (found < 0)
> +				report_skip("cannot read /proc/keys");
> +			if (!found)
> +				break;
> +			test_uid++;
> +		}
> +		if (attempt == 128)
> +			report_skip("could not find an unused persistent keyring UID");
> +	}
> +
> +	/* The inherited session keyring may have been revoked. */
> +	ret = syscall(SYS_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL, 0, 0, 0);
> +	if (ret < 0) {
> +		set_failure(reason, sizeof(reason),
> +			    "KEYCTL_JOIN_SESSION_KEYRING failed: %s",
> +			    strerror(errno));
> +		goto out;
> +	}
> +
> +	if (write_expiry(TEST_EXPIRY) < 0) {
> +		if (write_expiry(saved_expiry) < 0)
> +			ksft_exit_fail_msg("failed to restore persistent keyring expiry: %s\n",
> +					   strerror(errno));
> +		report_skip("cannot change persistent_keyring_expiry");
> +	}
> +	restore_expiry = true;
> +
> +	{
> +		char description[64];
> +
> +		snprintf(description, sizeof(description), "keyring-expiry-test-%d",
> +			 getpid());
> +		ret = add_keyring(description);
> +	}
> +	if (ret < 0) {
> +		set_failure(reason, sizeof(reason), "add_key(keyring) failed: %s",
> +			    strerror(errno));
> +		goto out;
> +	}
> +	destination = ret;
> +
> +	ret = syscall(SYS_keyctl, KEYCTL_RESTRICT_KEYRING, destination,
> +		      0, 0, 0);
> +	if (ret < 0) {
> +		set_failure(reason, sizeof(reason),
> +			    "KEYCTL_RESTRICT_KEYRING failed: %s", strerror(errno));
> +		goto out;
> +	}
> +
> +	ret = syscall(SYS_keyctl, KEYCTL_GET_PERSISTENT, test_uid,
> +		      destination, 0, 0);
> +	get_persistent_errno = errno;
> +	ksft_print_msg("GET_PERSISTENT returned %ld (%s)\n", ret,
> +		       ret < 0 ? strerror(get_persistent_errno) : "success");
> +	if (ret >= 0) {
> +		linked_persistent = ret;
> +		set_failure(reason, sizeof(reason),
> +			    "GET_PERSISTENT unexpectedly linked key %ld", ret);
> +		goto out;
> +	}
> +	if (get_persistent_errno != EPERM) {
> +		set_failure(reason, sizeof(reason),
> +			    "GET_PERSISTENT failed with %s instead of EPERM",
> +			    strerror(get_persistent_errno));
> +		goto out;
> +	}
> +
> +	ret = find_persistent_expiry(test_uid, expiry, sizeof(expiry));
> +	if (ret < 0) {
> +		set_failure(reason, sizeof(reason), "cannot read /proc/keys");
> +		goto out;
> +	}
> +	if (!ret) {
> +		dump_persistent_keys();
> +		set_failure(reason, sizeof(reason),
> +			    "GET_PERSISTENT did not create the requested keyring");
> +		skipped = true;
> +		goto out;
> +	}
> +	if (!strcmp(expiry, "perm") || !strcmp(expiry, "expd")) {
> +		set_failure(reason, sizeof(reason),
> +			    "failed link left _persistent.%u with expiry %s",
> +			    test_uid, expiry);
> +		{
> +			char description[64];
> +
> +			snprintf(description, sizeof(description),
> +				 "keyring-expiry-cleanup-%d", getpid());
> +			ret = add_keyring(description);
> +		}
> +		if (ret >= 0) {
> +			cleanup_destination = ret;
> +			ret = syscall(SYS_keyctl, KEYCTL_GET_PERSISTENT, test_uid,
> +				      cleanup_destination, 0, 0);
> +			if (ret >= 0) {
> +				cleanup_persistent = ret;
> +				if (unlink_key(cleanup_persistent,
> +					       cleanup_destination) < 0) {
> +					ksft_print_msg("warning: unlink temporary key: %s\n",
> +						       strerror(errno));
> +				} else {
> +					cleanup_persistent = -1;
> +				}
> +			} else {
> +				ksft_print_msg("warning: expiry cleanup failed: %s\n",
> +					       strerror(errno));
> +			}
> +		} else {
> +			ksft_print_msg("warning: unable to create cleanup keyring: %s\n",
> +				       strerror(errno));
> +		}
> +		goto out;
> +	}
> +
> +	passed = true;
> +
> +out:
> +	if (linked_persistent > 0 &&
> +	    unlink_key(linked_persistent, destination) < 0) {
> +		ksft_print_msg("warning: unable to unlink persistent key from test keyring: %s\n",
> +			       strerror(errno));
> +		if (passed)
> +			set_failure(reason, sizeof(reason),
> +				    "unable to clean up linked persistent key: %s",
> +				    strerror(errno));
> +		passed = false;
> +	}
> +	if (cleanup_persistent > 0 && cleanup_destination > 0 &&
> +	    unlink_key(cleanup_persistent, cleanup_destination) < 0) {
> +		ksft_print_msg("warning: unable to unlink temporary persistent key: %s\n",
> +			       strerror(errno));
> +	}
> +	if (cleanup_destination > 0 &&
> +	    unlink_key(cleanup_destination, KEY_SPEC_SESSION_KEYRING) < 0) {
> +		ksft_print_msg("warning: unable to unlink cleanup keyring: %s\n",
> +			       strerror(errno));
> +		if (passed)
> +			set_failure(reason, sizeof(reason),
> +				    "unable to clean up temporary keyring: %s",
> +				    strerror(errno));
> +		passed = false;
> +	}
> +	if (destination > 0 &&
> +	    unlink_key(destination, KEY_SPEC_SESSION_KEYRING) < 0) {
> +		ksft_print_msg("warning: unable to unlink test keyring: %s\n",
> +			       strerror(errno));
> +		if (passed)
> +			set_failure(reason, sizeof(reason),
> +				    "unable to clean up test keyring: %s",
> +				    strerror(errno));
> +		passed = false;
> +	}
> +	if (restore_expiry && write_expiry(saved_expiry) < 0) {
> +		set_failure(reason, sizeof(reason),
> +			    "failed to restore persistent_keyring_expiry: %s",
> +			    strerror(errno));
> +		passed = false;
> +	}
> +
> +	if (passed) {
> +		ksft_print_msg("restricted link returned EPERM; _persistent.%u expires in %s\n",
> +			       test_uid, expiry);
> +		ksft_test_result_pass("failed link still applies persistent keyring expiry\n");
> +	} else if (skipped) {
> +		ksft_test_result_skip("%s\n", reason);
> +	} else {
> +		ksft_test_result_fail("%s\n", reason);
> +	}
> +	ksft_finished();
> +}
> diff --git a/tools/testing/selftests/keys/run_qemu.sh b/tools/testing/selftests/keys/run_qemu.sh
> new file mode 100755
> index 000000000000..522cc8495ca2
> --- /dev/null
> +++ b/tools/testing/selftests/keys/run_qemu.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +set -eu
> +
> +script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
> +repo_root=$(CDPATH='' cd -- "$script_dir/../../../.." && pwd)
> +kernel_image=${1:-"$repo_root/arch/x86/boot/bzImage"}
> +vmlinux=${2:-"$repo_root/vmlinux"}
> +test_binary="$script_dir/persistent_keyring_expiry"
> +
> +for tool in cpio qemu-system-x86_64 busybox ldd; do
> +	if ! command -v "$tool" >/dev/null 2>&1; then
> +		echo "required tool not found: $tool" >&2
> +		exit 1
> +	fi
> +done
> +
> +make -C "$script_dir"
> +if [ ! -r "$kernel_image" ] || [ ! -r "$vmlinux" ]; then
> +	echo "usage: $0 [bzImage] [vmlinux]" >&2
> +	exit 1
> +fi
> +
> +tmpdir=$(mktemp -d)
> +trap 'rm -rf "$tmpdir"' EXIT HUP INT TERM
> +rootfs="$tmpdir/rootfs"
> +initrd="$tmpdir/initramfs.cpio"
> +mkdir -p "$rootfs/bin" "$rootfs/dev" "$rootfs/proc" "$rootfs/keys"
> +
> +copy_binary()
> +{
> +	source=$1
> +	destination=$2
> +	install -D "$source" "$rootfs$destination"
> +
> +	ldd "$source" 2>/dev/null |
> +		awk '$2 == "=>" && $3 ~ /^\// { print $3 }
> +		     $1 ~ /^\// { print $1 }' |
> +		sort -u |
> +		while IFS= read -r library; do
> +			[ -f "$library" ] || continue
> +			cp -L --parents "$library" "$rootfs"
> +		done
> +}
> +
> +copy_binary "$(command -v busybox)" /bin/busybox
> +copy_binary "$test_binary" /keys/persistent_keyring_expiry
> +install -m 755 "$script_dir/initramfs-init.sh" "$rootfs/init"
> +
> +(
> +	cd "$rootfs"
> +	find . -print0 | cpio --null -o --format=newc
> +) > "$initrd"
> +
> +echo "QEMU is paused at startup; attach GDB to localhost:1234 and continue."
> +qemu-system-x86_64 \
> +	-kernel "$kernel_image" \
> +	-initrd "$initrd" \
> +	-append "console=ttyS0 nokaslr rdinit=/init" \
> +	-display none \
> +	-serial stdio \
> +	-monitor none \
> +	-gdb tcp::1234 \
> +	-S

Normally you should not do this as the kselftest runs in the test target
in the first place.

> -- 
> 2.43.0
> 

Br, Jarkko
