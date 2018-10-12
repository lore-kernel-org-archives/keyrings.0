From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 12 Oct 2018 18:08:13 +0000
Subject: [PATCH 2/2] conf: add upcall line for nvdimm in request-key.conf
Message-Id: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Add support for nvdimm key management.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 request-key.conf |    1 +
 1 file changed, 1 insertion(+)

diff --git a/request-key.conf b/request-key.conf
index ff16a95..b76c414 100644
--- a/request-key.conf
+++ b/request-key.conf
@@ -39,3 +39,4 @@ create  user    debug:*         revoked         /bin/keyctl reject %k 30 %c %S
 create	user	debug:loop:*	*		|/bin/cat
 create	user	debug:*		*		/usr/share/keyutils/request-key-debug.sh %k %d %c %S
 negate	*	*		*		/bin/keyctl negate %k 30 %S
+create  logon   nvdimm*         *               /usr/sbin/nvdimm-upcall %k
