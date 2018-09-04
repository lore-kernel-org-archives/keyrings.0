From: David Howells <dhowells@redhat.com>
Date: Tue, 04 Sep 2018 13:03:08 +0000
Subject: [RFC PATCH 1/2] request-key: Provide a command line option to suppress execution
Message-Id: <153606618827.5731.15114650218923495769.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Allow "-x" to be passed on the command line to the request-key program to
suppress side effects and target execution.  This makes it easier to debug
the program and its configuration by allowing it to be driven from the
command line.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 request-key.c |   58 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/request-key.c b/request-key.c
index 3762e9a..f7697f3 100644
--- a/request-key.c
+++ b/request-key.c
@@ -24,6 +24,7 @@
 #include <signal.h>
 #include <syslog.h>
 #include <unistd.h>
+#include <getopt.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <ctype.h>
@@ -34,6 +35,7 @@
 
 static int xdebug;
 static int xnolog;
+static int xnoexec;
 static char *xkey;
 static char *xuid;
 static char *xgid;
@@ -132,7 +134,7 @@ int main(int argc, char *argv[])
 {
 	key_serial_t key;
 	char *ktype, *kdesc, *buf, *callout_info;
-	int ret, ntype, dpos, n, fd;
+	int ret, ntype, dpos, n, fd, opt;
 
 	if (argc = 2 && strcmp(argv[1], "--version") = 0) {
 		printf("request-key from %s (Built %s)\n",
@@ -144,22 +146,25 @@ int main(int argc, char *argv[])
 	signal(SIGBUS, oops);
 	signal(SIGPIPE, SIG_IGN);
 
-	for (;;) {
-		if (argc > 1 && strcmp(argv[1], "-d") = 0) {
+	while (opt = getopt(argc, argv, "dnx"),
+	       opt != -1) {
+		switch (opt) {
+		case 'd':
 			xdebug++;
-			argv++;
-			argc--;
-		}
-		else if (argc > 1 && strcmp(argv[1], "-n") = 0) {
+			break;
+		case 'n':
 			xnolog = 1;
-			argv++;
-			argc--;
-		}
-		else
 			break;
+		case 'x':
+			xnoexec = 1;
+			break;
+		}
 	}
 
-	if (argc != 8 && argc != 9)
+	argc -= optind;
+	argv += optind;
+
+	if (argc != 7 && argc != 8)
 		error("Unexpected argument count: %d\n", argc);
 
 	fd = open("/dev/null", O_RDWR);
@@ -177,21 +182,23 @@ int main(int argc, char *argv[])
 			error("dup failed: %m\n");
 	}
 
-	xkey = argv[2];
-	xuid = argv[3];
-	xgid = argv[4];
-	xthread_keyring = argv[5];
-	xprocess_keyring = argv[6];
-	xsession_keyring = argv[7];
+	xkey = argv[1];
+	xuid = argv[2];
+	xgid = argv[3];
+	xthread_keyring = argv[4];
+	xprocess_keyring = argv[5];
+	xsession_keyring = argv[6];
 
 	key = atoi(xkey);
 
 	/* assume authority over the key
 	 * - older kernel doesn't support this function
 	 */
-	ret = keyctl_assume_authority(key);
-	if (ret < 0 && !(argc = 9 || errno = EOPNOTSUPP))
-		error("Failed to assume authority over key %d (%m)\n", key);
+	if (!xnoexec) {
+		ret = keyctl_assume_authority(key);
+		if (ret < 0 && !(argc = 8 || errno = EOPNOTSUPP))
+			error("Failed to assume authority over key %d (%m)\n", key);
+	}
 
 	/* ask the kernel to describe the key to us */
 	if (xdebug < 2) {
@@ -220,7 +227,7 @@ int main(int argc, char *argv[])
 	debug("Key desc: %s\n", kdesc);
 
 	/* get hold of the callout info */
-	callout_info = argv[8];
+	callout_info = argv[7];
 
 	if (!callout_info) {
 		void *tmp;
@@ -234,7 +241,7 @@ int main(int argc, char *argv[])
 	debug("CALLOUT: '%s'\n", callout_info);
 
 	/* determine the action to perform */
-	lookup_action(argv[1],		/* op */
+	lookup_action(argv[0],		/* op */
 		      key,		/* ID of key under construction */
 		      ktype,		/* key type */
 		      kdesc,		/* key description */
@@ -611,6 +618,11 @@ static void execute_program(char *op,
 	/* if the last argument is a single bar, we spawn off the program dangling on the end of
 	 * three pipes and read the key material from the program, otherwise we just exec
 	 */
+	if (xnoexec) {
+		printf("-- exec disabled --\n");
+		exit(0);
+	}
+
 	if (pipeit)
 		pipe_to_program(op, key, ktype, kdesc, callout_info, prog, argv);
 
