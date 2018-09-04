From: David Howells <dhowells@redhat.com>
Date: Tue, 04 Sep 2018 13:03:15 +0000
Subject: [RFC PATCH 2/2] request-key: Find best match rather than first match
Message-Id: <153606619508.5731.13384764940272893934.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

When an upcall happens currently, either a file by the name
"/etc/request-key.d/<type>.conf" is scanned or the default file
"/etc/request-key.conf" is scanned and then the first match (including
wildcards) is selected.

Change this to read all the files in the conf directory and then read the
default file.  The best rule is then chosen and executed.

"Best" is defined as the rule with the least number of characters that are
skipped by matching a wildcard (e.g. string "foo:bar" matches pattern
"foo:*" with the number of characters being skipped being 3).

Further, the operation, type, description and callout_info columns are
matched individually and in order, so that a skip of 1 in the operation
column, say, is less preferable than an exact match there and a skip of 2
in the type column.

For example, take:

	create  dns_resolver afsdb:*	*	/sbin/key.afsdb %k
	create  dns_resolver afsdb:*	hello*	/sbin/key.xxxx %k

if both lines match, the second one will be picked, but, on the other hand,
with:

	create  dns_resolver afsdb:*	*	/sbin/key.afsdb %k
	creat*  dns_resolver afsdb:*	hello*	/sbin/key.xxxx %k

the first will be picked.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 request-key.c |  365 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 217 insertions(+), 148 deletions(-)

diff --git a/request-key.c b/request-key.c
index f7697f3..b895518 100644
--- a/request-key.c
+++ b/request-key.c
@@ -24,6 +24,8 @@
 #include <signal.h>
 #include <syslog.h>
 #include <unistd.h>
+#include <dirent.h>
+#include <limits.h>
 #include <getopt.h>
 #include <fcntl.h>
 #include <errno.h>
@@ -33,44 +35,53 @@
 #include "keyutils.h"
 
 
+struct parameters {
+	key_serial_t	key_id;
+	char		*op;
+	char		*key_type;
+	char		*key_desc;
+	char		*callout_info;
+	char		*key;
+	char		*uid;
+	char		*gid;
+	char		*thread_keyring;
+	char		*process_keyring;
+	char		*session_keyring;
+	int		len;
+	int		oplen;
+	int		ktlen;
+	int		kdlen;
+	int		cilen;
+
+};
+
 static int xdebug;
 static int xnolog;
 static int xnoexec;
-static char *xkey;
-static char *xuid;
-static char *xgid;
-static char *xthread_keyring;
-static char *xprocess_keyring;
-static char *xsession_keyring;
-static char conffile[256];
+static char conffile[PATH_MAX + 1];
 static int confline;
 static int norecurse;
 
-static void lookup_action(char *op,
-			  key_serial_t key,
-			  char *ktype,
-			  char *kdesc,
-			  char *callout_info)
+static char cmd[4096 + 2], cmd_conffile[PATH_MAX + 1];
+static unsigned int cmd_wildness[4] = { UINT_MAX, UINT_MAX, UINT_MAX, UINT_MAX };
+static int cmd_len, cmd_confline;
+
+static void lookup_action(struct parameters *params)
 	__attribute__((noreturn));
+static void scan_conf_dir(struct parameters *params, const char *confdir);
+static void scan_conf_file(struct parameters *params, int dirfd, const char *conffile);
 
-static void execute_program(char *op,
-			    key_serial_t key,
-			    char *ktype,
-			    char *kdesc,
-			    char *callout_info,
+static void execute_program(struct parameters *params,
 			    char *cmdline)
 	__attribute__((noreturn));
 
-static void pipe_to_program(char *op,
-			    key_serial_t key,
-			    char *ktype,
-			    char *kdesc,
-			    char *callout_info,
+static void pipe_to_program(struct parameters *params,
 			    char *prog,
 			    char **argv)
 	__attribute__((noreturn));
 
-static int match(const char *pattern, int plen, const char *datum, int dlen);
+static int match(const char *pattern, int plen, const char *datum, int dlen,
+		 unsigned int *wildness);
 
 static void debug(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 static void debug(const char *fmt, ...)
@@ -132,8 +143,9 @@ static void oops(int x)
  */
 int main(int argc, char *argv[])
 {
-	key_serial_t key;
-	char *ktype, *kdesc, *buf, *callout_info;
+	struct parameters params;
+	char *test_desc = "user;0;0;1f0000;debug:1234";
+	char *buf;
 	int ret, ntype, dpos, n, fd, opt;
 
 	if (argc = 2 && strcmp(argv[1], "--version") = 0) {
@@ -146,9 +158,12 @@ int main(int argc, char *argv[])
 	signal(SIGBUS, oops);
 	signal(SIGPIPE, SIG_IGN);
 
-	while (opt = getopt(argc, argv, "dnx"),
+	while (opt = getopt(argc, argv, "D:dnx"),
 	       opt != -1) {
 		switch (opt) {
+		case 'D':
+			test_desc = optarg;
+			break;
 		case 'd':
 			xdebug++;
 			break;
@@ -182,32 +197,34 @@ int main(int argc, char *argv[])
 			error("dup failed: %m\n");
 	}
 
-	xkey = argv[1];
-	xuid = argv[2];
-	xgid = argv[3];
-	xthread_keyring = argv[4];
-	xprocess_keyring = argv[5];
-	xsession_keyring = argv[6];
+	params.op		= argv[0];
+	params.key		= argv[1];
+	params.uid		= argv[2];
+	params.gid		= argv[3];
+	params.thread_keyring	= argv[4];
+	params.process_keyring	= argv[5];
+	params.session_keyring	= argv[6];
+	params.callout_info	= argv[7];
 
-	key = atoi(xkey);
+	params.key_id = atoi(params.key);
 
 	/* assume authority over the key
 	 * - older kernel doesn't support this function
 	 */
 	if (!xnoexec) {
-		ret = keyctl_assume_authority(key);
+		ret = keyctl_assume_authority(params.key_id);
 		if (ret < 0 && !(argc = 8 || errno = EOPNOTSUPP))
-			error("Failed to assume authority over key %d (%m)\n", key);
+			error("Failed to assume authority over key %d (%m)\n",
+			      params.key_id);
 	}
 
 	/* ask the kernel to describe the key to us */
-	if (xdebug < 2) {
-		ret = keyctl_describe_alloc(key, &buf);
+	if (!xnoexec) {
+		ret = keyctl_describe_alloc(params.key_id, &buf);
 		if (ret < 0)
 			goto inaccessible;
-	}
-	else {
-		buf = strdup("user;0;0;1f0000;debug:1234");
+	} else {
+		buf = strdup(test_desc);
 	}
 
 	/* extract the type and description from the key */
@@ -219,37 +236,34 @@ int main(int argc, char *argv[])
 	if (n != 1)
 		error("Failed to parse key description\n");
 
-	ktype = buf;
-	ktype[ntype] = 0;
-	kdesc = buf + dpos;
+	params.key_type = buf;
+	params.key_type[ntype] = 0;
+	params.key_desc = buf + dpos;
 
-	debug("Key type: %s\n", ktype);
-	debug("Key desc: %s\n", kdesc);
+	debug("Key type: %s\n", params.key_type);
+	debug("Key desc: %s\n", params.key_desc);
 
 	/* get hold of the callout info */
-	callout_info = argv[7];
-
-	if (!callout_info) {
+	if (!params.callout_info) {
 		void *tmp;
 
 		if (keyctl_read_alloc(KEY_SPEC_REQKEY_AUTH_KEY, &tmp) < 0)
 			error("Failed to retrieve callout info (%m)\n");
 
-		callout_info = tmp;
+		params.callout_info = tmp;
 	}
 
-	debug("CALLOUT: '%s'\n", callout_info);
+	debug("CALLOUT: '%s'\n", params.callout_info);
 
 	/* determine the action to perform */
-	lookup_action(argv[0],		/* op */
-		      key,		/* ID of key under construction */
-		      ktype,		/* key type */
-		      kdesc,		/* key description */
-		      callout_info	/* call out information */
-		      );
+	params.oplen = strlen(params.op);
+	params.ktlen = strlen(params.key_type);
+	params.kdlen = strlen(params.key_desc);
+	params.cilen = strlen(params.callout_info);
+	lookup_action(&params);
 
 inaccessible:
-	error("Key %d is inaccessible (%m)\n", key);
+	error("Key %d is inaccessible (%m)\n", params.key_id);
 
 } /* end main() */
 
@@ -257,52 +271,88 @@ inaccessible:
 /*
  * determine the action to perform
  */
-static void lookup_action(char *op,
-			  key_serial_t key,
-			  char *ktype,
-			  char *kdesc,
-			  char *callout_info)
+static void lookup_action(struct parameters *params)
+{
+	if (!xnoexec) {
+		scan_conf_dir(params, "/etc/request-key.d");
+		scan_conf_file(params, AT_FDCWD, "/etc/request-key.conf");
+	} else {
+		scan_conf_dir(params, "request-key.d");
+		scan_conf_file(params, AT_FDCWD, "request-key.conf");
+	}
+
+	if (cmd_len > 0)
+		execute_program(params, cmd);
+
+	file_error("No matching action\n");
+}
+
+/*****************************************************************************/
+/*
+ * Scan the files in a configuration directory.
+ */
+static void scan_conf_dir(struct parameters *params, const char *confdir)
+{
+	struct dirent *d;
+	DIR *dir;
+	int l;
+
+	debug("__ SCAN %s __\n", confdir);
+
+	dir = opendir(confdir);
+	if (!dir) {
+		if (errno = ENOENT)
+			return;
+		error("Cannot open %s: %m\n", confdir);
+	}
+
+	while ((d = readdir(dir))) {
+		if (d->d_name[0] = '.')
+			continue;
+		if (d->d_type != DT_UNKNOWN && d->d_type != DT_REG)
+			continue;
+		l = strlen(d->d_name);
+		if (l < 5)
+			continue;
+		if (memcmp(d->d_name + l - 5, ".conf", 5) != 0)
+			continue;
+		scan_conf_file(params, dirfd(dir), d->d_name);
+	}
+
+	closedir(dir);
+}
+
+/*****************************************************************************/
+/*
+ * Scan the contents of a configuration file.
+ */
+static void scan_conf_file(struct parameters *params, int dirfd, const char *conffile)
 {
 	char buf[4096 + 2], *p, *q;
 	FILE *conf;
-	int len, oplen, ktlen, kdlen, cilen;
-
-	oplen = strlen(op);
-	ktlen = strlen(ktype);
-	kdlen = strlen(kdesc);
-	cilen = strlen(callout_info);
-
-	/* search the config file for a command to run */
-	if (strlen(ktype) <= sizeof(conffile) - 30) {
-		if (xdebug < 2)
-			snprintf(conffile, sizeof(conffile) - 1,
-				 "/etc/request-key.d/%s.conf", ktype);
-		else
-			snprintf(conffile, sizeof(conffile) - 1,
-				 "request-key.d/%s.conf", ktype);
-		conf = fopen(conffile, "r");
-		if (conf)
-			goto opened_conf_file;
-		if (errno != ENOENT)
-			error("Cannot open %s: %m\n", conffile);
+	int fd;
+
+	debug("__ read %s __\n", conffile);
+
+	fd = openat(dirfd, conffile, O_RDONLY);
+	if (fd < 0) {
+		if (errno = ENOENT)
+			return;
+		error("Cannot open %s: %m\n", conffile);
 	}
 
-	if (xdebug < 2)
-		snprintf(conffile, sizeof(conffile) - 1, "/etc/request-key.conf");
-	else
-		snprintf(conffile, sizeof(conffile) - 1, "request-key.conf");
-	conf = fopen(conffile, "r");
+	conf = fdopen(fd, "r");
 	if (!conf)
 		error("Cannot open %s: %m\n", conffile);
 
-opened_conf_file:
-	debug("Opened config file '%s'\n", conffile);
-
 	for (confline = 1;; confline++) {
+		unsigned int wildness[4] = {};
+		unsigned int len;
+
 		/* read the file line-by-line */
 		if (!fgets(buf, sizeof(buf), conf)) {
 			if (feof(conf))
-				error("Cannot find command to construct key %d\n", key);
+				break;
 			file_error("error %m\n");
 		}
 
@@ -324,7 +374,7 @@ opened_conf_file:
 			goto syntax_error;
 		*p = 0;
 
-		if (!match(q, p - q, op, oplen))
+		if (!match(q, p - q, params->op, params->oplen, &wildness[0]))
 			continue;
 
 		p++;
@@ -340,7 +390,7 @@ opened_conf_file:
 			goto syntax_error;
 		*p = 0;
 
-		if (!match(q, p - q, ktype, ktlen))
+		if (!match(q, p - q, params->key_type, params->ktlen, &wildness[1]))
 			continue;
 
 		p++;
@@ -356,7 +406,7 @@ opened_conf_file:
 			goto syntax_error;
 		*p = 0;
 
-		if (!match(q, p - q, kdesc, kdlen))
+		if (!match(q, p - q, params->key_desc, params->kdlen, &wildness[2]))
 			continue;
 
 		p++;
@@ -372,42 +422,64 @@ opened_conf_file:
 			goto syntax_error;
 		*p = 0;
 
-		if (!match(q, p - q, callout_info, cilen))
+		if (!match(q, p - q, params->callout_info, params->cilen, &wildness[3]))
 			continue;
 
 		p++;
 
-		debug("%s:%d: Line matches\n", conffile, confline);
-
-		/* we've got an action */
+		/* we've got a match */
 		while (isspace(*p)) p++;
 		if (!*p)
 			goto syntax_error;
 
-		fclose(conf);
-
-		execute_program(op, key, ktype, kdesc, callout_info, p);
+		debug("%s:%d: Line matches '%s' (%u,%u,%u,%u)\n",
+		      conffile, confline, p,
+		      wildness[0], wildness[1], wildness[2], wildness[3]);
+
+		if (wildness[0] < cmd_wildness[0] ||
+		    (wildness[0] = cmd_wildness[0] &&
+		     wildness[1] < cmd_wildness[1]) ||
+		    (wildness[0] = cmd_wildness[0] &&
+		     wildness[1] = cmd_wildness[1] &&
+		     wildness[2] < cmd_wildness[2]) ||
+		    (wildness[0] = cmd_wildness[0] &&
+		     wildness[1] = cmd_wildness[1] &&
+		     wildness[2] = cmd_wildness[2] &&
+		     wildness[3] < cmd_wildness[3])
+		    ) {
+			memcpy(cmd_wildness, wildness, sizeof(cmd_wildness));
+			cmd_len = len - (p - buf);
+			cmd_confline = confline;
+			debug("%s:%d: Prefer command (%u,%u,%u,%u)\n",
+			      conffile, confline,
+			      wildness[0], wildness[1], wildness[2], wildness[3]);
+			memcpy(cmd, p, cmd_len + 1);
+			strcpy(cmd_conffile, conffile);
+		}
 	}
 
-	file_error("No matching action\n");
+	fclose(conf);
+	return;
 
 syntax_error:
 	line_error("Syntax error\n");
-
-} /* end lookup_action() */
+}
 
 /*****************************************************************************/
 /*
  * attempt to match a datum to a pattern
  * - one asterisk is allowed anywhere in the pattern to indicate a wildcard
  * - returns true if matched, false if not
+ * - adds the total number of chars skipped by wildcard to *_wildness
  */
-static int match(const char *pattern, int plen, const char *datum, int dlen)
+static int match(const char *pattern, int plen, const char *datum, int dlen,
+		 unsigned int *_wildness)
 {
 	const char *asterisk;
 	int n;
 
-	debug("match(%*.*s,%*.*s)\n", plen, plen, pattern, dlen, dlen, datum);
+	if (xdebug >= 2)
+		debug("match(%*.*s,%*.*s)", plen, plen, pattern, dlen, dlen, datum);
 
 	asterisk = memchr(pattern, '*', plen);
 	if (!asterisk) {
@@ -426,12 +498,11 @@ static int match(const char *pattern, int plen, const char *datum, int dlen)
 		/* wildcard at beginning of pattern */
 		pattern++;
 		if (!*pattern)
-			goto yes; /* "*" matches everything */
+			goto yes_wildcard; /* "*" matches everything */
 
 		/* match the end of the datum */
-		plen--;
-		if (memcmp(pattern, datum + (dlen - plen), plen) = 0)
-			goto yes;
+		if (memcmp(pattern, datum + (dlen - (plen - 1)), plen - 1) = 0)
+			goto yes_wildcard;
 		goto no;
 	}
 
@@ -440,20 +511,28 @@ static int match(const char *pattern, int plen, const char *datum, int dlen)
 		goto no;
 
 	if (!asterisk[1])
-		goto yes; /* "abc*" matches */
+		goto yes_wildcard; /* "abc*" matches */
 
 	/* match the end of the datum */
 	asterisk++;
 	n = plen - n - 1;
 	if (memcmp(pattern, datum + (dlen - n), n) = 0)
-		goto yes;
+		goto yes_wildcard;
 
 no:
-	debug(" = no\n");
+	if (xdebug >= 2)
+		debug(" = no\n");
 	return 0;
 
 yes:
-	debug(" = yes\n");
+	if (xdebug >= 2)
+		debug(" = yes (w=0)\n");
+	return 1;
+
+yes_wildcard:
+	*_wildness += dlen - (plen - 1);
+	if (xdebug >= 2)
+		debug(" = yes (w=%u)\n", dlen - (plen - 1));
 	return 1;
 
 } /* end match() */
@@ -462,18 +541,13 @@ yes:
 /*
  * execute a program to deal with a key
  */
-static void execute_program(char *op,
-			    key_serial_t key,
-			    char *ktype,
-			    char *kdesc,
-			    char *callout_info,
-			    char *cmdline)
+static void execute_program(struct parameters *params, char *cmdline)
 {
 	char *argv[256];
 	char *prog, *p, *q;
 	int argc, pipeit;
 
-	debug("execute_program('%s','%s')\n", callout_info, cmdline);
+	debug("execute_program('%s','%s')\n", params->callout_info, cmdline);
 
 	/* if the commandline begins with a bar, then we pipe the callout data into it and read
 	 * back the payload data
@@ -532,16 +606,16 @@ static void execute_program(char *op,
 		/* single character macros */
 		if (!q[1]) {
 			switch (*q) {
-			case 'o': argv[argc] = op;			continue;
-			case 'k': argv[argc] = xkey;			continue;
-			case 't': argv[argc] = ktype;			continue;
-			case 'd': argv[argc] = kdesc;			continue;
-			case 'c': argv[argc] = callout_info;		continue;
-			case 'u': argv[argc] = xuid;			continue;
-			case 'g': argv[argc] = xgid;			continue;
-			case 'T': argv[argc] = xthread_keyring;		continue;
-			case 'P': argv[argc] = xprocess_keyring;	continue;
-			case 'S': argv[argc] = xsession_keyring;	continue;
+			case 'o': argv[argc] = params->op;		continue;
+			case 'k': argv[argc] = params->key;		continue;
+			case 't': argv[argc] = params->key_type;	continue;
+			case 'd': argv[argc] = params->key_desc;	continue;
+			case 'c': argv[argc] = params->callout_info;	continue;
+			case 'u': argv[argc] = params->uid;		continue;
+			case 'g': argv[argc] = params->gid;		continue;
+			case 'T': argv[argc] = params->thread_keyring;	continue;
+			case 'P': argv[argc] = params->process_keyring;	continue;
+			case 'S': argv[argc] = params->session_keyring;	continue;
 			default:
 				line_error("Unsupported macro\n");
 			}
@@ -624,7 +698,7 @@ static void execute_program(char *op,
 	}
 
 	if (pipeit)
-		pipe_to_program(op, key, ktype, kdesc, callout_info, prog, argv);
+		pipe_to_program(params, prog, argv);
 
 	/* attempt to execute the command */
 	execv(prog, argv);
@@ -635,22 +709,16 @@ static void execute_program(char *op,
 
 /*****************************************************************************/
 /*
- * pipe the callout information to the specified program and retrieve the payload data over another
- * pipe
+ * pipe the callout information to the specified program and retrieve the
+ * payload data over another pipe
  */
-static void pipe_to_program(char *op,
-			    key_serial_t key,
-			    char *ktype,
-			    char *kdesc,
-			    char *callout_info,
-			    char *prog,
-			    char **argv)
+static void pipe_to_program(struct parameters *params, char *prog, char **argv)
 {
 	char errbuf[512], payload[32768 + 1], *pp, *pc, *pe;
 	int ipi[2], opi[2], epi[2], childpid;
 	int ifl, ofl, efl, npay, ninfo, espace, tmp;
 
-	debug("pipe_to_program(%s -> %s)", callout_info, prog);
+	debug("pipe_to_program(%s -> %s)", params->callout_info, prog);
 
 	if (pipe(ipi) < 0 || pipe(opi) < 0 || pipe(epi) < 0)
 		error("pipe failed: %m");
@@ -700,8 +768,8 @@ static void pipe_to_program(char *op,
 	    fcntl(FROMSTDERR, F_SETFL, efl) < 0)
 		error("fcntl/F_SETFL failed: %m");
 
-	ninfo = strlen(callout_info);
-	pc = callout_info;
+	ninfo = params->cilen;
+	pc = params->callout_info;
 
 	npay = sizeof(payload);
 	pp = payload;
@@ -858,7 +926,8 @@ static void pipe_to_program(char *op,
 
 		norecurse = 1;
 		debug("child exited %d\n", WEXITSTATUS(tmp));
-		lookup_action("negate", key, ktype, kdesc, callout_info);
+		params->op = "negate";
+		lookup_action(params);
 	}
 
 	if (WIFSIGNALED(tmp)) {
@@ -866,14 +935,14 @@ static void pipe_to_program(char *op,
 			error("child died on signal %d\n", WTERMSIG(tmp));
 
 		norecurse = 1;
-		debug("child died on signal %d\n", WTERMSIG(tmp));
-		lookup_action("negate", key, ktype, kdesc, callout_info);
+		params->op = "negate";
+		lookup_action(params);
 	}
 
 	/* attempt to instantiate the key */
 	debug("instantiate with %td bytes\n", pp - payload);
 
-	if (keyctl_instantiate(key, payload, pp - payload, 0) < 0)
+	if (keyctl_instantiate(params->key_id, payload, pp - payload, 0) < 0)
 		error("instantiate key failed: %m\n");
 
 	debug("instantiation successful\n");
