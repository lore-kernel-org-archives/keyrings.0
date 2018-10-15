From: Robbie Harwood <rharwood@redhat.com>
Date: Mon, 15 Oct 2018 20:01:59 +0000
Subject: [PATCH] keyctl: Be more friendly about invocation errors
Message-Id: <jlgwoqj5688.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From 901cc5241e4a66168aed4998077d8fbe39efa866 Mon Sep 17 00:00:00 2001
From: Robbie Harwood <rharwood@redhat.com>
Date: Mon, 15 Oct 2018 15:57:51 -0400
Subject: [PATCH] keyctl: Be more friendly about invocation errors

When option parsing fails in main(), display usage information.

Also cleanly handle `keyctl --help`.

Signed-off-by: Robbie Harwood <rharwood@redhat.com>
---
 keyctl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/keyctl.c b/keyctl.c
index 61990b4..406f216 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -31,6 +31,7 @@ struct command {
 #define nr __attribute__((noreturn))
 
 static nr void act_keyctl___version(int argc, char *argv[]);
+static nr void act_keyctl___help(int argc, char *argv[]);
 static nr void act_keyctl_show(int argc, char *argv[]);
 static nr void act_keyctl_add(int argc, char *argv[]);
 static nr void act_keyctl_padd(int argc, char *argv[]);
@@ -74,6 +75,7 @@ static nr void act_keyctl_restrict_keyring(int argc, char *argv[]);
 
 const struct command commands[] = {
 	{ act_keyctl___version,	"--version",	"" },
+	{ act_keyctl___help,	"--help",	"" },
 	{ act_keyctl_add,	"add",		"<type> <desc> <data> <keyring>" },
 	{ act_keyctl_chgrp,	"chgrp",	"<key> <gid>" },
 	{ act_keyctl_chown,	"chown",	"<key> <uid>" },
@@ -178,7 +180,7 @@ int main(int argc, char *argv[])
 		/* partial match */
 		if (best) {
 			fprintf(stderr, "Ambiguous command\n");
-			exit(2);
+			format();
 		}
 
 		best = cmd;
@@ -186,7 +188,7 @@ int main(int argc, char *argv[])
 
 	if (!best) {
 		fprintf(stderr, "Unknown command\n");
-		exit(2);
+		format();
 	}
 
 	best->action(argc, argv);
@@ -235,6 +237,15 @@ static void act_keyctl___version(int argc, char *argv[])
 	exit(0);
 }
 
+/*****************************************************************************/
+/*
+ * Display help text (wrapper)
+ */
+static void act_keyctl___help(int argc, char *argv[])
+{
+	format();
+}
+
 /*****************************************************************************/
 /*
  * grab data from stdin
-- 
2.19.1
