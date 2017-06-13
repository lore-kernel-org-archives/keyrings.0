From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 13 Jun 2017 21:50:05 +0000
Subject: [PATCH keyutils v2 1/6] keyctl: Add xpadd command for hexadecimal data
Message-Id: <20170613215010.14390-2-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The unit tests for 'keyctl dh_compute' and KDF variants involve binary
user key payloads hundreds of bytes in length, which are cumbersome to
represent on the command line and in scripts. The 'keyctl xpadd' command
provides a way to populate keys with binary values without relying on
backslash escapes.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 keyctl.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/keyctl.c b/keyctl.c
index 61990b4..b8bec93 100644
--- a/keyctl.c
+++ b/keyctl.c
@@ -34,6 +34,7 @@ static nr void act_keyctl___version(int argc, char *argv[]);
 static nr void act_keyctl_show(int argc, char *argv[]);
 static nr void act_keyctl_add(int argc, char *argv[]);
 static nr void act_keyctl_padd(int argc, char *argv[]);
+static nr void act_keyctl_xpadd(int argc, char *argv[]);
 static nr void act_keyctl_request(int argc, char *argv[]);
 static nr void act_keyctl_request2(int argc, char *argv[]);
 static nr void act_keyctl_prequest2(int argc, char *argv[]);
@@ -118,6 +119,7 @@ const struct command commands[] = {
 	{ act_keyctl_timeout,	"timeout",	"<key> <timeout>" },
 	{ act_keyctl_unlink,	"unlink",	"<key> [<keyring>]" },
 	{ act_keyctl_update,	"update",	"<key> <data>" },
+	{ act_keyctl_xpadd,	"xpadd",	"<type> <desc> <keyring>" },
 	{ NULL,			NULL,		NULL }
 };
 
@@ -426,6 +428,71 @@ static void act_keyctl_padd(int argc, char *argv[])
 
 /*****************************************************************************/
 /*
+ * add a key, reading ASCII hexadecimal from a pipe and converting to binary
+ */
+static void act_keyctl_xpadd(int argc, char *argv[])
+{
+	key_serial_t dest;
+	size_t hexdatalen;
+	char *hexdata;
+	size_t datalen = 0;
+	char *data;
+	int ret;
+
+	if (argc != 4)
+		format();
+
+	dest = get_key_id(argv[3]);
+
+	hexdata = grab_stdin(&hexdatalen);
+
+	data = malloc(hexdatalen/2);
+	if (!data)
+		error("xpadd: cannot allocate memory");
+
+	while (hexdatalen > 1) {
+		if (isspace(hexdata[0])) {
+			hexdatalen--;
+			hexdata++;
+			continue;
+		}
+
+		if (!isxdigit(hexdata[1]) && isxdigit(hexdata[0])) {
+			fprintf(stderr, "xpadd: odd number of contiguous "
+					"hexadecimal digits\n");
+			exit(2);
+		}
+
+		ret = sscanf(hexdata, "%02hhx", &data[datalen]);
+		if (ret != 1) {
+			fprintf(stderr, "xpadd: non-hexadecimal input data\n");
+			exit(2);
+		}
+
+		hexdatalen -= 2;
+		hexdata += 2;
+		datalen++;
+	}
+
+	if (hexdatalen = 1 && !isspace(hexdata[0])) {
+		fprintf(stderr,	"xpadd: invalid trailing byte\n");
+		exit(2);
+	}
+
+	ret = add_key(argv[1], argv[2], data, datalen, dest);
+	free(data);
+
+	if (ret < 0)
+		error("add_key");
+
+	/* print the resulting key ID */
+	printf("%d\n", ret);
+	exit(0);
+
+} /* end act_keyctl_xpadd() */
+
+/*****************************************************************************/
+/*
  * request a key
  */
 static void act_keyctl_request(int argc, char *argv[])
-- 
2.13.1

