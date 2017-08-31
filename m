From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 31 Aug 2017 15:58:27 +0000
Subject: [RFC PATCH 2/5] keyctl.2: update kernel documentation path reference
Message-Id: <20170831155827.GA4931@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It has been changed in b68101a1e8f0263dbc7b8375d2a7c57c6216fb76.
---
 man2/keyctl.2 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/man2/keyctl.2 b/man2/keyctl.2
index 3469947..e4b4bc9 100644
--- a/man2/keyctl.2
+++ b/man2/keyctl.2
@@ -1992,7 +1992,5 @@ main(int argc, char *argv[])
 .BR user\-session\-keyring (7),
 .BR request\-key (8)
 .PP
-The kernel source files
-.IR Documentation/security/keys.txt
-and
-.IR Documentation/security/keys\-request\-key.txt .
+The kernel source files under
+.IR Documentation/security/keys/ .
-- 
2.1.4

