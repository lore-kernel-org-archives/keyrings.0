From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sat, 02 Sep 2017 04:40:14 +0000
Subject: [PATCH v2 3/6] keyrings.7: add pointers to kernel's documentation
Message-Id: <20170902044014.GA7493@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Mostly because of assymmetric-keys.txt, which is outside security/keys
for some reason.
---
 man7/keyrings.7 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man7/keyrings.7 b/man7/keyrings.7
index ba980da..0cb1190 100644
--- a/man7/keyrings.7
+++ b/man7/keyrings.7
@@ -866,3 +866,8 @@ scripts can use them.
 .BR user\-session\-keyring (7),
 .BR pam_keyinit (8),
 .BR request-key (8)
+.PP
+The kernel source files
+.IR Documentation/crypto/asymmetric-keys.txt
+and under
+.IR Documentation/security/keys .
-- 
2.1.4

