From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sat, 02 Sep 2017 04:40:32 +0000
Subject: [PATCH v2 6/6] keyctl.2: mention ENOMEM in ERRORS
Message-Id: <20170902044032.GA7817@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This one is not very specific, as memory allocations are scattered across
the code, so let's put some generic description here.
---
 man2/keyctl.2 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/man2/keyctl.2 b/man2/keyctl.2
index bbd85ce..fe17b1e 100644
--- a/man2/keyctl.2
+++ b/man2/keyctl.2
@@ -1866,6 +1866,10 @@ did not exist, and
 .I arg3
 was zero (meaning don't create the key if it didn't exist).
 .TP
+.B ENOMEM
+One of kernel memory allocation routines failed during the execution of the
+syscall.
+.TP
 .B ENOTDIR
 A key of keyring type was expected but the ID of a key with
 a different type was provided.
-- 
2.1.4

