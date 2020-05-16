From: Ben Boeckel <me@benboeckel.net>
Date: Sat, 16 May 2020 00:39:17 +0000
Subject: [PATCH 1/1] Documentation: security: core.rst: add missing argument
Message-Id: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
In-Reply-To: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
To: keyrings@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

This argument was just never documented in the first place.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/security/keys/core.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index d9b0b859018b..c26b9e7d47c2 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -920,10 +920,14 @@ The keyctl syscall functions are:
 
 	long keyctl(KEYCTL_PKEY_QUERY,
 		    key_serial_t key_id, unsigned long reserved,
+		    const char* params,
 		    struct keyctl_pkey_query *info);
 
-     Get information about an asymmetric key.  The information is returned in
-     the keyctl_pkey_query struct::
+     Get information about an asymmetric key.  Specific algorithms and
+     encodings may be queried by using the ``params`` argument.  This is a
+     string containing a space- or tab-separated string of key-value pairs.
+     Currently supported keys include ``enc`` and ``hash``.  The information
+     is returned in the keyctl_pkey_query struct::
 
 	__u32	supported_ops;
 	__u32	key_size;
-- 
2.25.4
