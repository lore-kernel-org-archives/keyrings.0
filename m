From: David Howells <dhowells@redhat.com>
Date: Wed, 27 Sep 2017 16:10:04 +0000
Subject: [RFC][PATCH] keyutils: Add key/keyring ACL support
Message-Id: <24395.1506528604@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <10635.1506467135@warthog.procyon.org.uk>
In-Reply-To: <10635.1506467135@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Here's a patch to make keyutils support ACLs on keys.

[root@andromeda ~]# LD_LIBRARY_PATH=~/keyutils ~/keyutils/keyctl setacl $k all:all u.4:r pos:0x37f root:I net:c
[root@andromeda ~]# LD_LIBRARY_PATH=~/keyutils ~/keyutils/keyctl getacl $k
IDENTITY  ID         PERMS
===== ===== =========all       -          0fffffff cjSRIlswrv
uid                4 00000002 --------r-
possessor -          0000037f cj-RIlswrv
root      -          00000020 ----I-----
net       -          00000200 c---------


David
---
diff --git a/keyctl.c b/keyctl.c
index 61990b4..c8b6f6f 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -71,6 +71,9 @@ static nr void act_keyctl_dh_compute(int argc, char *argv[]);
 static nr void act_keyctl_dh_compute_kdf(int argc, char *argv[]);
 static nr void act_keyctl_dh_compute_kdf_oi(int argc, char *argv[]);
 static nr void act_keyctl_restrict_keyring(int argc, char *argv[]);
+static nr void act_keyctl_getacl(int argc, char *argv[]);
+static nr void act_keyctl_rgetacl(int argc, char *argv[]);
+static nr void act_keyctl_setacl(int argc, char *argv[]);
 
 const struct command commands[] = {
 	{ act_keyctl___version,	"--version",	"" },
@@ -82,9 +85,10 @@ const struct command commands[] = {
 	{ act_keyctl_dh_compute, "dh_compute",	"<private> <prime> <base>" },
 	{ act_keyctl_dh_compute_kdf, "dh_compute_kdf", "<private> <prime> <base> <len> <hash_name>" },
 	{ act_keyctl_dh_compute_kdf_oi, "dh_compute_kdf_oi", "<private> <prime> <base> <len> <hash_name>" },
+	{ act_keyctl_getacl,	"getacl",	"<key>" },
+	{ act_keyctl_get_persistent, "get_persistent", "<keyring> [<uid>]" },
 	{ act_keyctl_instantiate, "instantiate","<key> <data> <keyring>" },
 	{ act_keyctl_invalidate,"invalidate",	"<key>" },
-	{ act_keyctl_get_persistent, "get_persistent", "<keyring> [<uid>]" },
 	{ act_keyctl_link,	"link",		"<key> <keyring>" },
 	{ act_keyctl_list,	"list",		"<keyring>" },
 	{ act_keyctl_negate,	"negate",	"<key> <timeout> <keyring>" },
@@ -107,12 +111,14 @@ const struct command commands[] = {
 	{ act_keyctl_request2,	"request2",	"<type> <desc> <info> [<dest_keyring>]" },
 	{ act_keyctl_restrict_keyring, "restrict_keyring", "<keyring> [<type> [<restriction>]]" },
 	{ act_keyctl_revoke,	"revoke",	"<key>" },
+	{ act_keyctl_rgetacl,	"rgetacl",	"<key>" },
 	{ act_keyctl_rlist,	"rlist",	"<keyring>" },
 	{ act_keyctl_search,	"search",	"<keyring> <type> <desc> [<dest_keyring>]" },
 	{ act_keyctl_security,	"security",	"<key>" },
 	{ act_keyctl_session,	"session",	"" },
 	{ NULL,			"session",	"- [<prog> <arg1> <arg2> ...]" },
 	{ NULL,			"session",	"<name> [<prog> <arg1> <arg2> ...]" },
+	{ act_keyctl_setacl,	"setacl",	"<key> [<ace> <ace> ...]" },
 	{ act_keyctl_setperm,	"setperm",	"<key> <mask>" },
 	{ act_keyctl_show,	"show",		"[-x] [<keyring>]" },
 	{ act_keyctl_timeout,	"timeout",	"<key> <timeout>" },
@@ -1841,6 +1847,226 @@ static void act_keyctl_restrict_keyring(int argc, char *argv[])
 	exit(0);
 }
 
+static const char *special_ace_ids[] = {
+	[0]			= "?0",
+	[KEY_ACE_EVERYONE]	= "all",
+	[KEY_ACE_GROUP]		= "group",
+	[KEY_ACE_OWNER]		= "owner",
+	[KEY_ACE_POSSESSOR]	= "possessor",
+	[KEY_ACE_ROOT]		= "root",
+	[KEY_ACE_SYS_ADMIN]	= "sys",
+	[KEY_ACE_NET_ADMIN]	= "net",
+};
+
+/*
+ * Display ACL.
+ */
+static void display_acl(const struct key_ace *acl, int nr_ace)
+{
+	int i;
+
+	printf("IDENTITY  ID         PERMS\n");
+	printf("===== ===== ==========\n");
+
+	for (i = 0; i < nr_ace; i++) {
+		const struct key_ace *ace = &acl[i];
+
+		switch (ace->mask & KEY_ACE__IDENTITY) {
+		case KEY_ACE_SPECIAL:
+			if (ace->special_id <= KEY_ACE_NET_ADMIN)
+				printf("%-9.9s -         ", special_ace_ids[ace->special_id]);
+			else
+				printf("?special  %10u", ace->special_id);
+			break;
+		case KEY_ACE_UID:
+			printf("uid       %10u", ace->uid);
+			break;
+		case KEY_ACE_GID:
+			printf("gid       %10u", ace->gid);
+			break;
+		default:
+			printf("?%x        %10u",
+			       (ace->mask & KEY_ACE__IDENTITY) >> 28,
+			       ace->special_id);
+			break;
+		}
+
+		printf(" %08x ", ace->mask & KEY_ACE__PERMS);
+		printf("%c%c%c%c%c%c%c%c%c%c\n",
+		       ace->mask & KEY_ACE_CLEAR	? 'c' : '-',
+		       ace->mask & KEY_ACE_JOIN		? 'j' : '-',
+		       ace->mask & KEY_ACE_SET_SECURITY	? 'S' : '-',
+		       ace->mask & KEY_ACE_REVOKE	? 'R' : '-',
+		       ace->mask & KEY_ACE_INVAL	? 'I' : '-',
+		       ace->mask & KEY_ACE_LINK		? 'l' : '-',
+		       ace->mask & KEY_ACE_SEARCH	? 's' : '-',
+		       ace->mask & KEY_ACE_WRITE	? 'w' : '-',
+		       ace->mask & KEY_ACE_READ		? 'r' : '-',
+		       ace->mask & KEY_ACE_VIEW		? 'v' : '-');
+	}
+}
+
+/*
+ * Get a key's ACL.
+ */
+static void act_keyctl_getacl(int argc, char *argv[])
+{
+	struct key_ace *acl;
+	key_serial_t key;
+	int ret, nr_ace;
+
+	if (argc != 2)
+		format();
+
+	key = get_key_id(argv[1]);
+
+	ret = keyctl_get_acl_alloc(key, &acl);
+	if (ret < 0)
+		error("keyctl_get_acl_alloc");
+	nr_ace = ret / sizeof(*acl);
+
+	display_acl(acl, nr_ace);
+	exit(0);
+}
+
+/*
+ * Get a key's ACL in raw hex form.
+ */
+static void act_keyctl_rgetacl(int argc, char *argv[])
+{
+	struct key_ace *acl;
+	key_serial_t key;
+	int ret, nr_ace, i;
+
+	if (argc != 2)
+		format();
+
+	key = get_key_id(argv[1]);
+
+	ret = keyctl_get_acl_alloc(key, &acl);
+	if (ret < 0)
+		error("keyctl_get_acl_alloc");
+	nr_ace = ret / sizeof(*acl);
+
+	for (i = 0; i < nr_ace; i++) {
+		if (i != 0)
+			putchar(';');
+		printf("%x:%x", acl[i].mask, acl[i].special_id);
+	}
+
+	putchar('\n');
+	exit(0);
+}
+
+/*
+ * Set a key's ACL.
+ */
+static void act_keyctl_setacl(int argc, char *argv[])
+{
+	struct key_ace *acl = NULL, *ace;
+	key_serial_t key;
+	unsigned ltmp;
+	unsigned tmp, len;
+	char *id, *colon, *perm, *p;
+	int nr_ace, i;
+
+	if (argc < 2)
+		format();
+
+	key = get_key_id(argv[1]);
+	nr_ace = argc - 2;
+
+	if (nr_ace > 0) {
+		acl = alloca(sizeof(*acl) * nr_ace);
+		memset(acl, 0, sizeof(*acl) * nr_ace);
+
+		for (i = 0; i < nr_ace; i++) {
+			ace = &acl[i];
+			id = argv[i + 2];
+			colon = strchr(id, ':');
+			if (!colon || colon = id)
+				goto invalid_ace;
+
+			*colon = 0;
+			if (strcmp(id, "all") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_EVERYONE;
+			} else if (strcmp(id, "grp") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_GROUP;
+			} else if (strcmp(id, "own") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_OWNER;
+			} else if (strcmp(id, "pos") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_POSSESSOR;
+			} else if (strcmp(id, "root") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_ROOT;
+			} else if (strcmp(id, "sys") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_SYS_ADMIN;
+			} else if (strcmp(id, "net") = 0) {
+				ace->mask = KEY_ACE_SPECIAL;
+				ace->special_id = KEY_ACE_NET_ADMIN;
+			} else if (strncmp(id, "u.", 2) = 0) {
+				ace->mask = KEY_ACE_UID;
+				if (sscanf(id + 2, "%u%n", &tmp, &len) != 1)
+					goto invalid_ace_colon;
+				if (id + 2 + len != colon)
+					goto invalid_ace_colon;
+				ace->uid = tmp;
+			} else if (strncmp(id, "g.", 2) = 0) {
+				ace->mask = KEY_ACE_GID;
+				if (sscanf(id + 2, "%u%n", &tmp, &len) != 1)
+					goto invalid_ace_colon;
+				if (id + 2 + len != colon)
+					goto invalid_ace_colon;
+				ace->gid = tmp;
+			} else {
+				goto invalid_ace_colon;
+			}
+
+			perm = colon + 1;
+			if (isdigit(*perm)) {
+				ltmp = strtoul(perm, &p, 0);
+				if (ltmp & ~(unsigned long)KEY_ACE__PERMS)
+					goto invalid_ace_colon;
+				ace->mask |= ltmp;
+			} else if (strcmp(perm, "all") = 0) {
+				ace->mask |= KEY_ACE__PERMS;
+			} else {
+				for (; *perm; perm++) {
+					switch (*perm) {
+					case 'v': ace->mask |= KEY_ACE_VIEW;	break;
+					case 'r': ace->mask |= KEY_ACE_READ;	break;
+					case 'w': ace->mask |= KEY_ACE_WRITE;	break;
+					case 's': ace->mask |= KEY_ACE_SEARCH;	break;
+					case 'l': ace->mask |= KEY_ACE_LINK;	break;
+					case 'I': ace->mask |= KEY_ACE_INVAL;	break;
+					case 'R': ace->mask |= KEY_ACE_REVOKE;	break;
+					case 'S': ace->mask |= KEY_ACE_SET_SECURITY; break;
+					case 'j': ace->mask |= KEY_ACE_JOIN;	break;
+					case 'c': ace->mask |= KEY_ACE_CLEAR;	break;
+					default: goto invalid_ace_colon;
+					}
+				}
+			}
+		}
+	}
+
+	if (keyctl_set_acl(key, acl, nr_ace * sizeof(*acl)) < 0)
+		error("keyctl_set_acl");
+
+	exit(0);
+
+invalid_ace_colon:
+	*colon = ':';
+invalid_ace:
+	fprintf(stderr, "Invalid ACE: '%s'\n", id);
+	exit(2);
+}
+
 /*****************************************************************************/
 /*
  * parse a key identifier
diff --git a/keyutils.c b/keyutils.c
index d2bb34c..a37acbc 100644
--- a/keyutils.c
+++ b/keyutils.c
@@ -264,6 +264,16 @@ long keyctl_restrict_keyring(key_serial_t keyring, const char *type,
 	return keyctl(KEYCTL_RESTRICT_KEYRING, keyring, type, restriction);
 }
 
+long keyctl_get_acl(key_serial_t id, struct key_ace *acl, size_t max_acl_size)
+{
+	return keyctl(KEYCTL_GET_ACL, id, acl, max_acl_size);
+}
+
+long keyctl_set_acl(key_serial_t id, const struct key_ace *acl, size_t acl_size)
+{
+	return keyctl(KEYCTL_SET_ACL, id, acl, acl_size);
+}
+
 /*****************************************************************************/
 /*
  * fetch key description into an allocated buffer
@@ -405,6 +415,41 @@ int keyctl_dh_compute_alloc(key_serial_t priv, key_serial_t prime,
 	return ret;
 }
 
+/*****************************************************************************/
+/*
+ * Fetch key ACL into an allocated buffer
+ * - Returns size of ACL in bytes.
+ */
+int keyctl_get_acl_alloc(key_serial_t id, struct key_ace **_acl)
+{
+	struct key_ace *acl;
+	long acl_size, ret;
+
+	ret = keyctl_get_acl(id, NULL, 0);
+	if (ret < 0)
+		return -1;
+
+	for (;;) {
+		acl_size = ret;
+		acl = malloc(acl_size);
+		if (!acl)
+			return -1;
+
+		ret = keyctl_get_acl(id, acl, acl_size);
+		if (ret < 0) {
+			free(acl);
+			return -1;
+		}
+
+		if (acl_size >= ret)
+			break;
+		free(acl);
+	}
+
+	*_acl = acl;
+	return ret;
+}
+
 /*
  * Depth-first recursively apply a function over a keyring tree
  */
diff --git a/keyutils.h b/keyutils.h
index 89c5b08..de1b0b4 100644
--- a/keyutils.h
+++ b/keyutils.h
@@ -101,6 +101,8 @@ typedef uint32_t key_perm_t;
 #define KEYCTL_GET_PERSISTENT		22	/* get a user's persistent keyring */
 #define KEYCTL_DH_COMPUTE		23	/* Compute Diffie-Hellman values */
 #define KEYCTL_RESTRICT_KEYRING		29	/* Restrict keys allowed to link to a keyring */
+#define KEYCTL_GET_ACL			30	/* Get a key's ACL */
+#define KEYCTL_SET_ACL			31	/* Set a key's ACL */
 
 /* keyctl structures */
 struct keyctl_dh_params {
@@ -117,6 +119,42 @@ struct keyctl_kdf_params {
 };
 
 /*
+ * Key ACL definitions.
+ */
+struct key_ace {
+	unsigned int		mask;
+#define KEY_ACE_VIEW		0x00000001 /* Can describe the key */
+#define KEY_ACE_READ		0x00000002 /* Can read the key content */
+#define KEY_ACE_WRITE		0x00000004 /* Can update/modify the key content */
+#define KEY_ACE_SEARCH		0x00000008 /* Can find the key by search */
+#define KEY_ACE_LINK		0x00000010 /* Can make a link to the key */
+#define KEY_ACE_INVAL		0x00000020 /* Can invalidate the key */
+#define KEY_ACE_REVOKE		0x00000040 /* Can revoke the key */
+#define KEY_ACE_SET_SECURITY	0x00000080 /* Can set owner, group, ACL */
+#define KEY_ACE_JOIN		0x00000100 /* Can join keyring */
+#define KEY_ACE_CLEAR		0x00000200 /* Can clear keyring */
+#define KEY_ACE__ORDINARY	0x0000001f /* Ordinary permissions */
+#define KEY_ACE__PERMS		0x0fffffff
+#define KEY_ACE_SPECIAL		0x10000000 /* A specific subject */
+#define KEY_ACE_UID		0x20000000 /* A nominated UID */
+#define KEY_ACE_GID		0x30000000 /* A nominated GID */
+#define KEY_ACE__IDENTITY	0xf0000000
+
+	union {
+		uid_t		uid;
+		gid_t		gid;
+		unsigned int	special_id;
+#define KEY_ACE_EVERYONE	1	/* Everyone, including owner and group */
+#define KEY_ACE_GROUP		2	/* The key's group */
+#define KEY_ACE_OWNER		3	/* The owner of the key */
+#define KEY_ACE_POSSESSOR	4	/* Any process that possesses of the key */
+#define KEY_ACE_ROOT		5	/* The user namespace root user */
+#define KEY_ACE_SYS_ADMIN	6	/* Anyone with CAP_SYS_ADMIN */
+#define KEY_ACE_NET_ADMIN	7	/* Anyone with CAP_NET_ADMIN */
+	};
+};
+
+/*
  * syscall wrappers
  */
 extern key_serial_t add_key(const char *type,
@@ -177,6 +215,8 @@ extern long keyctl_dh_compute_kdf(key_serial_t private, key_serial_t prime,
 				  char *buffer, size_t buflen);
 extern long keyctl_restrict_keyring(key_serial_t keyring, const char *type,
 				    const char *restriction);
+extern long keyctl_get_acl(key_serial_t id, struct key_ace *acl, size_t max_acl_size);
+extern long keyctl_set_acl(key_serial_t id, const struct key_ace *acl, size_t max_acl_size);
 
 /*
  * utilities
@@ -186,6 +226,7 @@ extern int keyctl_read_alloc(key_serial_t id, void **_buffer);
 extern int keyctl_get_security_alloc(key_serial_t id, char **_buffer);
 extern int keyctl_dh_compute_alloc(key_serial_t priv, key_serial_t prime,
 				   key_serial_t base, void **_buffer);
+extern int keyctl_get_acl_alloc(key_serial_t id, struct key_ace **_acl);
 
 typedef int (*recursive_key_scanner_t)(key_serial_t parent, key_serial_t key,
 				       char *desc, int desc_len, void *data);
diff --git a/tests/keyctl/dh_compute/bad-args/runtest.sh b/tests/keyctl/dh_compute/bad-args/runtest.sh
index 7e8828b..f58a44c 100644
--- a/tests/keyctl/dh_compute/bad-args/runtest.sh
+++ b/tests/keyctl/dh_compute/bad-args/runtest.sh
@@ -72,7 +72,7 @@ expect_keyid logonid
 
 marker "CHECK WRONG KEY TYPE"
 dh_compute --fail $privateid $primeid $logonid
-expect_error ENOKEY
+expect_error EOPNOTSUPP
 dh_compute --fail $privateid $primeid @s
 expect_error EOPNOTSUPP
 
diff --git a/tests/keyctl/permitting/valid/runtest.sh b/tests/keyctl/permitting/valid/runtest.sh
index 70600e7..0b3d55f 100644
--- a/tests/keyctl/permitting/valid/runtest.sh
+++ b/tests/keyctl/permitting/valid/runtest.sh
@@ -72,12 +72,11 @@ set_key_perm $keyid 0x00201f00
 describe_key --fail $keyid
 expect_error EACCES
 
-# check that we can't use other perms instead of user perms to view the key
-# (our UID matches that of the key)
-marker "VIEW OTHER PERMISSIONS"
+# check that permissions for everyone allow the user to view the key,
+# even if our user perms don't.
+marker "VIEW EVERYONE PERMISSIONS"
 set_key_perm $keyid 0x0020001f
-describe_key --fail $keyid
-expect_error EACCES
+describe_key $keyid
 
 # check that taking away setattr permission renders the key immune to setperm
 marker "REMOVE SETATTR"
