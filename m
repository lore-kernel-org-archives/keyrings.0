From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 13 Jun 2017 21:50:07 +0000
Subject: [PATCH keyutils v2 3/6] Doc: Add 'keyctl xpadd' information
Message-Id: <20170613215010.14390-4-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 man/keyctl.1 | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/man/keyctl.1 b/man/keyctl.1
index 0360bf0..6ee8776 100644
--- a/man/keyctl.1
+++ b/man/keyctl.1
@@ -19,6 +19,8 @@ keyctl \- key management facility control
 .br
 \fBkeyctl\fR padd <type> <desc> <keyring>
 .br
+\fBkeyctl\fR xpadd <type> <desc> <keyring>
+.br
 \fBkeyctl\fR request <type> <desc> [<dest_keyring>]
 .br
 \fBkeyctl\fR request2 <type> <desc> <info> [<dest_keyring>]
@@ -176,6 +178,8 @@ IDs will be dumped in hex instead of decimal.
 \fBkeyctl add\fR <type> <desc> <data> <keyring>
 .br
 \fBkeyctl padd\fR <type> <desc> <keyring>
+.br
+\fBkeyctl xpadd\fR <type> <desc> <keyring>
 
 This command creates a key of the specified type and description; instantiates
 it with the given data and attaches it to the specified keyring. It then prints
@@ -192,11 +196,24 @@ The \fBpadd\fR variant of the command reads the data from stdin rather than
 taking it from the command line:
 
 .RS
-.fi
+.nf
 $ echo \-n stuff | keyctl padd user mykey @u
 26
 .fi
 .RE
+
+The \fBxpadd\fR variant of the command reads hexadecimal text from stdin and
+converts it to binary data before instantiating the key:
+
+.RS
+.nf
+$ echo \-n "11223344 ccddeeff" | keyctl xpadd user mykey @u
+26
+.fi
+.RE
+
+Each hexadecimal data byte must be represented by two adjacent hexadecimal
+digits. Whitespace is ignored before and after each hexadecimal data byte.
 .SS Request a key
 \fBkeyctl request\fR <type> <desc> [<dest_keyring>]
 .br
-- 
2.13.1

