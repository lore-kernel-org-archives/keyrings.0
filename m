From: janne.karhunen@gmail.com
Date: Mon, 11 Feb 2019 17:30:33 +0000
Subject: [PATCH] RFC: user-mode extensible trusted key support
Message-Id: <20190211173033.2493-1-Janne.Karhunen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com
Cc: Janne Karhunen <Janne.Karhunen@gmail.com>

From: Janne Karhunen <Janne.Karhunen@gmail.com>

Current kernel key subsystem only supports tpm to implement
trusted keys. This is fine, but the tpm is poorly supported
in the embedded world that primarily use custom trust roots,
TEEs or even white box crypto. Problem with these setups is
that they are extremely diverse, complex, proprietary and
in some cases for valid reasons (white box).

This patch provides trial plumbing to enable declaration
of new trust sources via tiny user mode helpers baked as
part of the kernel image. If the hardware based trust source
is available, the provided um helper can read the given
device node and act as a translator for the kernel key
requests and the actual device node can be kept out of the
'regular' userland. In the case of white box crypto, the
um helper is free to perform any sort of software magic
required to mangle the keys within the kernel keyring.

The kernel built-in usermode helper key operations are made
available via new key type named 'ext-trusted' that is
compatible with the existing userland utilities:
keyctl add ext-trusted foo "new_umh 32" @u
keyctl pipe `keyctl search @u ext-trusted foo` > foo.key
keyctl add ext-trusted bar "load `cat foo.key`" @u
...

Signed-off-by: Janne Karhunen <Janne.Karhunen@gmail.com>
Reviewed-by: Pekka Honkanen <Pekka.Honkanen@aalto.fi>
---
 include/keys/ext-keyprotocol.h   |  22 ++
 security/keys/Kconfig            |  13 +
 security/keys/Makefile           |   1 +
 security/keys/Makefile.um        |  12 +
 security/keys/trusted-ext.blob.S |   7 +
 security/keys/trusted-ext.c      | 580 +++++++++++++++++++++++++++++++
 security/keys/umhelper.c         | 114 ++++++
 7 files changed, 749 insertions(+)
 create mode 100644 include/keys/ext-keyprotocol.h
 create mode 100644 security/keys/Makefile.um
 create mode 100644 security/keys/trusted-ext.blob.S
 create mode 100644 security/keys/trusted-ext.c
 create mode 100644 security/keys/umhelper.c

diff --git a/include/keys/ext-keyprotocol.h b/include/keys/ext-keyprotocol.h
new file mode 100644
index 000000000000..3dfe2fd37af0
--- /dev/null
+++ b/include/keys/ext-keyprotocol.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __KERNEL__
+#include <errno.h>
+#endif
+
+#define UM_MESSAGE_SIZE 4096
+
+#define UM_NOMSG        0x00000000
+#define UM_ECHO         0x00000001
+#define UM_AUTH         0x00000002
+#define UM_CREATE_KEY   0x00010001
+#define UM_SEAL_KEY     0x00010002
+#define UM_UNSEAL_KEY   0x00010003
+
+struct keyreq {
+	uint32_t request;
+	int32_t  reply;
+	uint32_t keytype;
+	uint32_t keyhandle;
+	uint32_t datalen;
+};
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 6462e6654ccf..a4c4380f1360 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -71,6 +71,19 @@ config TRUSTED_KEYS
 
 	  If you are unsure as to whether this is required, answer N.
 
+config TRUSTED_EXT_KEYS
+	tristate "TRUSTED EXTERNAL KEYS"
+	depends on KEYS
+	select CRYPTO
+	help
+	  This option provides support for creating, sealing, and unsealing
+	  keys via a registered userspace helper that is able to talk to a
+	  external trust source (hardware or software). Note that if you
+	  turn the option on, prebuilt keyhelper must be present as
+	  security/keys/keyhelper_umh as static elf executable.
+
+	  If you are unsure as to whether this is required, answer N.
+
 config ENCRYPTED_KEYS
 	tristate "ENCRYPTED KEYS"
 	depends on KEYS
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef54064f60..23cfd2408541 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 obj-$(CONFIG_BIG_KEYS) += big_key.o
 obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
+obj-$(CONFIG_TRUSTED_EXT_KEYS) += trusted-ext.o trusted-ext.blob.o
diff --git a/security/keys/Makefile.um b/security/keys/Makefile.um
new file mode 100644
index 000000000000..dd5899b61f2a
--- /dev/null
+++ b/security/keys/Makefile.um
@@ -0,0 +1,12 @@
+CC = $(CROSS_COMPILE)gcc
+OBJDUMP = $(CROSS_COMPILE)objdump
+OBJCOPY = $(CROSS_COMPILE)objcopy
+UMEXEC = keyhelper_umh
+
+$(UMEXEC): umhelper.c
+	$(CC) -Wl,--strip-all -Os -Wall -I../../include/keys -static $< -o $@
+
+all: $(UMEXEC)
+
+clean:
+	rm -f $(UMEXEC)
diff --git a/security/keys/trusted-ext.blob.S b/security/keys/trusted-ext.blob.S
new file mode 100644
index 000000000000..e6682f6b7156
--- /dev/null
+++ b/security/keys/trusted-ext.blob.S
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+	.section .init.rodata, "a"
+	.global keyhelper_umh_start
+keyhelper_umh_start:
+	.incbin "security/keys/keyhelper_umh"
+	.global keyhelper_umh_end
+keyhelper_umh_end:
diff --git a/security/keys/trusted-ext.c b/security/keys/trusted-ext.c
new file mode 100644
index 000000000000..7572e9cd9d2f
--- /dev/null
+++ b/security/keys/trusted-ext.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/random.h>
+#include <linux/parser.h>
+#include <linux/umh.h>
+#include <linux/key-type.h>
+
+#include <keys/trusted-type.h>
+#include <keys/user-type.h>
+#include <keys/ext-keyprotocol.h>
+
+#include <crypto/sha.h>
+
+#define USER_TRUSTED_DEBUG 0
+
+extern char keyhelper_umh_start;
+extern char keyhelper_umh_end;
+
+enum {
+	Opt_err, Opt_new, Opt_load, Opt_update, Opt_keyhandle,
+	Opt_keyauth, Opt_blobauth, Opt_migratable, Opt_new_umh
+};
+
+static struct umh_info um_info;
+static DEFINE_MUTEX(keyreq_lock);
+
+static const match_table_t key_tokens = {
+	{ Opt_new, "new" },
+	{ Opt_load, "load" },
+	{ Opt_update, "update" },
+	{ Opt_keyhandle, "keyhandle=%s" },
+	{ Opt_keyauth, "keyauth=%s" },
+	{ Opt_blobauth, "blobauth=%s" },
+	{ Opt_migratable, "migratable=%s" },
+	{ Opt_new_umh, "new_umh" },
+	{ Opt_err, NULL }
+};
+
+#if USER_TRUSTED_DEBUG
+static inline void dump_options(struct trusted_key_options *o)
+{
+	pr_info("ext_trusted_key: sealing key type %d\n", o->keytype);
+	pr_info("ext_trusted_key: sealing key handle %0X\n", o->keyhandle);
+}
+
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+	pr_info("ext_trusted_key: key_len %d\n", p->key_len);
+	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
+		       16, 1, p->key, p->key_len, 0);
+	pr_info("ext_trusted_key: bloblen %d\n", p->blob_len);
+	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
+		       16, 1, p->blob, p->blob_len, 0);
+	pr_info("ext_trusted_key: migratable %d\n", p->migratable);
+}
+#endif
+
+static void stop_umh(struct umh_info *info)
+{
+	struct task_struct *tsk;
+
+	if (!info->pid)
+		return;
+
+	tsk = get_pid_task(find_vpid(info->pid), PIDTYPE_PID);
+	if (tsk) {
+		force_sig(SIGKILL, tsk);
+		put_task_struct(tsk);
+	}
+	fput(info->pipe_to_umh);
+	fput(info->pipe_from_umh);
+	info->pid = 0;
+}
+
+static struct trusted_key_options *trusted_options_alloc(void)
+{
+	struct trusted_key_options *options;
+
+	options = kzalloc(sizeof(*options), GFP_KERNEL);
+	if (options) {
+		options->keytype = 0;
+		options->keyhandle = 0;
+	}
+	return options;
+}
+
+static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
+{
+	struct trusted_key_payload *p = NULL;
+	int ret;
+
+	ret = key_payload_reserve(key, sizeof(*p));
+	if (ret < 0)
+		return p;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p)
+		p->migratable = 1; /* migratable by default */
+	return p;
+}
+
+static int getoptions(char *c, struct trusted_key_payload *pay,
+		      struct trusted_key_options *opt)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *p = c;
+	int token;
+	int res;
+	unsigned long handle;
+	unsigned long token_mask = 0;
+
+	while ((p = strsep(&c, " \t"))) {
+		if (*p = '\0' || *p = ' ' || *p = '\t')
+			continue;
+		token = match_token(p, key_tokens, args);
+		if (test_and_set_bit(token, &token_mask))
+			return -EINVAL;
+
+		switch (token) {
+		case Opt_keyhandle:
+			res = kstrtoul(args[0].from, 16, &handle);
+			if (res < 0)
+				return -EINVAL;
+			opt->keytype = 0;
+			opt->keyhandle = handle;
+			break;
+		case Opt_keyauth:
+			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
+				return -EINVAL;
+			res = hex2bin(opt->keyauth, args[0].from,
+				      SHA1_DIGEST_SIZE);
+			if (res < 0)
+				return -EINVAL;
+			break;
+		case Opt_blobauth:
+			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
+				return -EINVAL;
+			res = hex2bin(opt->blobauth, args[0].from,
+				      SHA1_DIGEST_SIZE);
+			if (res < 0)
+				return -EINVAL;
+			break;
+		case Opt_migratable:
+			if (*args[0].from = '0')
+				pay->migratable = 0;
+			else
+				pay->migratable = 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int datablob_parse(char *datablob, struct trusted_key_payload *p,
+			  struct trusted_key_options *o)
+{
+	substring_t args[MAX_OPT_ARGS];
+	long keylen;
+	int ret = -EINVAL;
+	int key_cmd;
+	char *c;
+
+	/* main command */
+	c = strsep(&datablob, " \t");
+	if (!c)
+		return -EINVAL;
+	key_cmd = match_token(c, key_tokens, args);
+	switch (key_cmd) {
+	case Opt_new:
+		/* first argument is key size */
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		ret = kstrtol(c, 10, &keylen);
+		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
+			return -EINVAL;
+		p->key_len = keylen;
+		ret = getoptions(datablob, p, o);
+		if (ret < 0)
+			return ret;
+		ret = Opt_new;
+		break;
+	case Opt_new_umh:
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		ret = kstrtol(c, 10, &keylen);
+		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
+			return -EINVAL;
+		p->key_len = keylen;
+		ret = getoptions(datablob, p, o);
+		if (ret < 0)
+			return ret;
+		ret = Opt_new_umh;
+		break;
+	case Opt_load:
+		/* first argument is sealed blob */
+		c = strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		p->blob_len = strlen(c) / 2;
+		if (p->blob_len > MAX_BLOB_SIZE)
+			return -EINVAL;
+		ret = hex2bin(p->blob, c, p->blob_len);
+		if (ret < 0)
+			return -EINVAL;
+		ret = getoptions(datablob, p, o);
+		if (ret < 0)
+			return ret;
+		ret = Opt_load;
+		break;
+	case Opt_err:
+		break;
+	}
+	return ret;
+}
+
+static int um_seal(struct trusted_key_payload *payload,
+		   struct trusted_key_options *options)
+{
+	struct keyreq *request = NULL;
+	struct keyreq *reply = NULL;
+	ssize_t reqlen, n;
+	int ret = -EFAULT;
+	loff_t pos;
+
+	if (payload->key_len > UM_MESSAGE_SIZE - sizeof(*request))
+		return -ENOSPC;
+
+	reqlen = sizeof(*request) + payload->key_len;
+	request = kmalloc(reqlen, GFP_KERNEL);
+	reply = kmalloc(UM_MESSAGE_SIZE, GFP_KERNEL);
+	if (!request || !reply) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(request, 0, reqlen);
+
+	request->request = UM_SEAL_KEY;
+	request->datalen = payload->key_len;
+	request->keyhandle = options->keyhandle;
+	memcpy(request + 1, payload->key, payload->key_len);
+
+	mutex_lock(&keyreq_lock);
+	n = __kernel_write(um_info.pipe_to_umh, request, reqlen,
+			   &pos);
+	if (n != reqlen) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	pos = 0;
+	n = kernel_read(um_info.pipe_from_umh, reply,
+			UM_MESSAGE_SIZE, &pos);
+	if (n < sizeof(*reply)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if ((reply->reply = 0) &&
+	    (reply->datalen > 0) &&
+	    (reply->datalen <= UM_MESSAGE_SIZE - sizeof(*reply)) &&
+	    (n >= sizeof(*reply) + reply->datalen)) {
+		memcpy(payload->blob, reply + 1, reply->datalen);
+		payload->blob_len = reply->datalen;
+	} else {
+		ret = -EIO;
+		goto out;
+	}
+	ret = reply->reply;
+
+out:
+	mutex_unlock(&keyreq_lock);
+	kzfree(request);
+	kzfree(reply);
+	return ret;
+}
+
+static int um_unseal(struct trusted_key_payload *payload,
+		     struct trusted_key_options *options)
+{
+	struct keyreq *request = NULL;
+	struct keyreq *reply = NULL;
+	ssize_t reqlen, n;
+	int ret = -EFAULT;
+	loff_t pos;
+
+	if (payload->blob_len > UM_MESSAGE_SIZE - sizeof(*request))
+		return -ENOSPC;
+
+	reqlen = sizeof(*request) + payload->blob_len;
+	request = kmalloc(reqlen, GFP_KERNEL);
+	reply = kmalloc(UM_MESSAGE_SIZE, GFP_KERNEL);
+	if (!request || !reply) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(request, 0, reqlen);
+
+	request->request = UM_UNSEAL_KEY;
+	request->datalen = payload->blob_len;
+	request->keyhandle = options->keyhandle;
+	memcpy(request + 1, payload->blob, payload->blob_len);
+
+	mutex_lock(&keyreq_lock);
+	n = __kernel_write(um_info.pipe_to_umh, request, reqlen,
+			   &pos);
+	if (n != reqlen) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	pos = 0;
+	n = kernel_read(um_info.pipe_from_umh, reply,
+			UM_MESSAGE_SIZE, &pos);
+	if (n < sizeof(*reply)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if ((reply->reply = 0) &&
+	    (reply->datalen > 0) &&
+	    (reply->datalen <= (UM_MESSAGE_SIZE - sizeof(*reply))) &&
+	    (n >= sizeof(*reply) + reply->datalen)) {
+		memcpy(payload->key, reply + 1, reply->datalen);
+		payload->key_len = reply->datalen;
+	} else {
+		ret = -EIO;
+		goto out;
+	}
+	ret = reply->reply;
+
+out:
+	mutex_unlock(&keyreq_lock);
+	kzfree(request);
+	kzfree(reply);
+	return ret;
+}
+
+static int um_create(struct trusted_key_payload *payload,
+		     struct trusted_key_options *options)
+{
+	struct keyreq *request = NULL;
+	struct keyreq *reply = NULL;
+	ssize_t reqlen, n;
+	int ret = -EFAULT;
+	loff_t pos;
+
+	if (payload->key_len > UM_MESSAGE_SIZE - sizeof(*request))
+		return -ENOSPC;
+
+	reqlen = sizeof(*request);
+	request = kmalloc(reqlen, GFP_KERNEL);
+	reply = kmalloc(UM_MESSAGE_SIZE, GFP_KERNEL);
+	if (!request || !reply) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(request, 0, reqlen);
+
+	request->request = UM_CREATE_KEY;
+	request->datalen = payload->key_len;
+	request->keyhandle = options->keyhandle;
+
+	mutex_lock(&keyreq_lock);
+	n = __kernel_write(um_info.pipe_to_umh, request, reqlen,
+			   &pos);
+	if (n != reqlen) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	pos = 0;
+	n = kernel_read(um_info.pipe_from_umh, reply,
+			UM_MESSAGE_SIZE, &pos);
+	if (n < sizeof(*reply)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if ((reply->reply = 0) &&
+	    (reply->datalen > 0) &&
+	    (reply->datalen <= (UM_MESSAGE_SIZE - sizeof(*reply))) &&
+	    (n >= sizeof(*reply) + reply->datalen)) {
+		memcpy(payload->key, reply + 1, reply->datalen);
+		payload->key_len = reply->datalen;
+	} else {
+		ret = -EIO;
+		goto out;
+	}
+	ret = reply->reply;
+
+out:
+	mutex_unlock(&keyreq_lock);
+	kzfree(request);
+	kzfree(reply);
+	return ret;
+}
+
+static int ext_trusted_instantiate(struct key *key,
+				   struct key_preparsed_payload *prep)
+{
+	struct trusted_key_payload *payload = NULL;
+	struct trusted_key_options *options = NULL;
+	struct keyreq req;
+	uint8_t *data;
+	int ret, key_cmd;
+
+	req.datalen = prep->datalen;
+
+	if (req.datalen <= 0 || req.datalen > 32767 ||
+		!prep->data || um_info.pid = 0)
+		return -EINVAL;
+
+	data = kmalloc(req.datalen + 1, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(data, prep->data, req.datalen);
+	data[req.datalen] = '\0';
+
+	options = trusted_options_alloc();
+	if (!options) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	payload = trusted_payload_alloc(key);
+	if (!payload) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key_cmd = datablob_parse(data, payload, options);
+	if (key_cmd < 0) {
+		ret = key_cmd;
+		goto out;
+	}
+
+#if USER_TRUSTED_DEBUG
+	dump_payload(payload);
+	dump_options(options);
+#endif
+
+	switch (key_cmd) {
+	case Opt_load:
+		ret = um_unseal(payload, options);
+		if (ret)
+			pr_err("trusted_key: um_unseal failed (%d)\n", ret);
+		break;
+	case Opt_new:
+		if (rng_is_initialized() = false) {
+			ret = -EAGAIN;
+			break;
+		}
+		/* Generate a key ..*/
+		get_random_bytes(payload->key, payload->key_len);
+		/* .. and the handle */
+		get_random_bytes(&options->keyhandle, sizeof(uint32_t));
+
+		ret = um_seal(payload, options);
+		if (ret)
+			pr_err("trusted_key: um_seal failed (%d)\n", ret);
+		break;
+	case Opt_new_umh:
+		ret = um_create(payload, options);
+		if (ret) {
+			pr_err("trusted_key: um_create failed (%d)\n", ret);
+			break;
+		}
+		ret = um_seal(payload, options);
+		if (ret)
+			pr_err("trusted_key: um_seal failed (%d)\n", ret);
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	kzfree(data);
+	kzfree(options);
+	if (!ret)
+		rcu_assign_keypointer(key, payload);
+	else
+		kzfree(payload);
+
+	return ret;
+}
+
+static int ext_trusted_update(struct key *key,
+			      struct key_preparsed_payload *prep)
+{
+	return -EPERM;
+}
+
+static long ext_trusted_read(const struct key *key,
+			     char __user *buffer, size_t buflen)
+{
+	const struct trusted_key_payload *p;
+	char *ascii_buf;
+	char *bufp;
+	int i;
+
+	p = dereference_key_locked(key);
+	if (!p)
+		return -EINVAL;
+
+	if (buffer && buflen >= 2 * p->blob_len) {
+		ascii_buf = kmalloc_array(2, p->blob_len, GFP_KERNEL);
+		if (!ascii_buf)
+			return -ENOMEM;
+
+		bufp = ascii_buf;
+		for (i = 0; i < p->blob_len; i++)
+			bufp = hex_byte_pack(bufp, p->blob[i]);
+		if (copy_to_user(buffer, ascii_buf, 2 * p->blob_len) != 0) {
+			kzfree(ascii_buf);
+			return -EFAULT;
+		}
+		kzfree(ascii_buf);
+	}
+	return 2 * p->blob_len;
+}
+
+static void ext_trusted_destroy(struct key *key)
+{
+	kzfree(key->payload.data[0]);
+}
+
+struct key_type key_type_ext_trusted_ops = {
+	.name = "ext-trusted",
+	.instantiate = ext_trusted_instantiate,
+	.update = ext_trusted_update,
+	.destroy = ext_trusted_destroy,
+	.describe = user_describe,
+	.read = ext_trusted_read,
+};
+EXPORT_SYMBOL_GPL(key_type_ext_trusted_ops);
+
+static int __init init_ext_trusted(void)
+{
+	int ret;
+
+	um_info.cmdline = "umkeyhelper";
+	ret = fork_usermode_blob(&keyhelper_umh_start,
+				 &keyhelper_umh_end - &keyhelper_umh_start,
+				 &um_info);
+	if (ret)
+		return ret;
+
+	pr_info("Loaded keyhelper with pid %d\n", um_info.pid);
+
+	return register_key_type(&key_type_ext_trusted_ops);
+}
+
+static void __exit cleanup_ext_trusted(void)
+{
+	stop_umh(&um_info);
+	unregister_key_type(&key_type_ext_trusted_ops);
+}
+
+late_initcall(init_ext_trusted);
+module_exit(cleanup_ext_trusted);
+
+MODULE_LICENSE("GPL");
diff --git a/security/keys/umhelper.c b/security/keys/umhelper.c
new file mode 100644
index 000000000000..a53bbac4d94e
--- /dev/null
+++ b/security/keys/umhelper.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#include "ext-keyprotocol.h"
+
+#define _kregalign __attribute__((aligned(__alignof__(struct keyreq))))
+
+static uint8_t buffer[UM_MESSAGE_SIZE] _kregalign;
+static int dfd;
+
+static void hexdump(char *token, uint8_t *data, int len)
+{
+	dprintf(dfd, "%s: ", token);
+	for (int i = 0; i < len; i++)
+		dprintf(dfd, "%02hhx:", data[i]);
+	dprintf(dfd, "\n");
+}
+
+static int frob(uint8_t *data, size_t datalen)
+{
+	memfrob(data, datalen);
+	return 0;
+}
+
+static int genkey(uint8_t *data, size_t datalen)
+{
+	ssize_t len;
+	int fd;
+
+	if (datalen <= 0)
+		return -EINVAL;
+
+	mknod("/dev/urandom", S_IFCHR|0666, makedev(1, 9));
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd = -1) {
+		dprintf(dfd, "Open failed\n");
+		return -EFAULT;
+	}
+	len = read(fd, data, datalen);
+	close(fd);
+	if (len != datalen) {
+		dprintf(dfd, "Read failed, %lu expected %lu\n", len,
+			datalen);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+int main(int a, char **b)
+{
+	struct keyreq *req = (struct keyreq *)buffer;
+	size_t bytesin, bytesout;
+	uint8_t *dp;
+
+	dfd = open("/dev/console", O_WRONLY);
+	dprintf(dfd, "Started keyhelper\n");
+
+	while (1) {
+		bytesin = read(0, buffer, UM_MESSAGE_SIZE);
+
+		if (bytesin < sizeof(*req))
+			continue;
+
+		dp = buffer + sizeof(*req);
+		hexdump("datain", dp, req->datalen);
+
+		switch (req->request) {
+		case UM_CREATE_KEY:
+			dprintf(dfd, "%u byte key generation request\n",
+				req->datalen);
+			req->reply = genkey(dp, req->datalen);
+			if (!req->reply)
+				bytesin = req->datalen + sizeof(*req);
+			break;
+		case UM_SEAL_KEY:
+			dprintf(dfd, "%u byte seal request\n",
+				req->datalen);
+			req->reply = frob(dp, req->datalen);
+			break;
+		case UM_UNSEAL_KEY:
+			dprintf(dfd, "%u byte unseal request\n",
+				req->datalen);
+			req->reply = frob(dp, req->datalen);
+			break;
+		default:
+			dprintf(dfd, "Unknown %lu byte message\n",
+				bytesin);
+			req->reply = -EINVAL;
+			break;
+		}
+
+		hexdump("dataout", dp, req->datalen);
+
+		bytesout = write(1, buffer, bytesin);
+		if (bytesin < bytesout)
+			dprintf(dfd, "Error writing reply\n");
+
+		memset(buffer, 0, UM_MESSAGE_SIZE);
+	}
+	close(dfd);
+	return 0;
+}
-- 
2.17.1
