From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:31 +0000
Subject: [PATCH v2 2/7] keyctl_dh_compute.3: mention /proc/crypto for hashnames
Message-Id: <20180927131436.23328-3-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The kernel does not have a set of known hashnames available. Instead,
/proc/crypto contains the information for the running system.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 man/keyctl_dh_compute.3 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man/keyctl_dh_compute.3 b/man/keyctl_dh_compute.3
index 837c481..bb1274c 100644
--- a/man/keyctl_dh_compute.3
+++ b/man/keyctl_dh_compute.3
@@ -86,7 +86,9 @@ function.
 The
 .I hashname
 specifies the Linux kernel crypto API name for a hash that shall be used
-for the key derivation function, such as sha256.
+for the key derivation function, such as sha256. See
+.I /proc/crypto
+for available hashes on the system.
 The
 .I hashname
 must be a NULL terminated string.
-- 
2.19.0.221.g150f307afc
