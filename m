From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:47 +0000
Subject: [PATCH 2/5] docs: clarify `keyctl ... trusted` commands
Message-Id: <20180927131450.23458-3-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Values to be provided by the user are wrapped in `<>` to indicate such.
Hex values also do not have a literal leading `0x` on them.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 .../security/keys/trusted-encrypted.rst       | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 3bb24e09a332..5f3f1f4038e5 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -24,19 +24,19 @@ trouser's utility: "tpm_takeownership -u -z".
 
 Usage::
 
-    keyctl add trusted name "new keylen [options]" ring
-    keyctl add trusted name "load hex_blob [pcrlock=pcrnum]" ring
+    keyctl add trusted name "new <keylen> [options]" ring
+    keyctl add trusted name "load <hex_blob> [pcrlock=pcrnum]" ring
     keyctl update key "update [options]"
     keyctl print keyid
 
     options:
-       keyhandle=    ascii hex value of sealing key default 0x40000000 (SRK)
-       keyauth=	     ascii hex auth for sealing key default 0x00...i
+       keyhandle=    ascii hex value of sealing key; default 40000000 (SRK)
+       keyauth=      ascii hex auth for sealing key; default 00...
                      (40 ascii zeros)
-       blobauth=     ascii hex auth for sealed data default 0x00...
+       blobauth=     ascii hex auth for sealed data; default 00...
                      (40 ascii zeros)
-       pcrinfo=	     ascii hex of PCR_INFO or PCR_INFO_LONG (no default)
-       pcrlock=	     pcr number to be extended to "lock" blob
+       pcrinfo=      ascii hex of PCR_INFO or PCR_INFO_LONG (no default)
+       pcrlock=      pcr number to be extended to "lock" blob
        migratable=   0|1 indicating permission to reseal to new PCR values,
                      default 1 (resealing allowed)
        hash=         hash algorithm name as a string. For TPM 1.x the only
@@ -69,10 +69,10 @@ application specific, which is identified by 'format'.
 
 Usage::
 
-    keyctl add encrypted name "new [format] key-type:master-key-name keylen"
+    keyctl add encrypted name "new [format] <key-type>:<master-key-name> <keylen>"
         ring
-    keyctl add encrypted name "load hex_blob" ring
-    keyctl update keyid "update key-type:master-key-name"
+    keyctl add encrypted name "load <hex_blob>" ring
+    keyctl update keyid "update <key-type>:<master-key-name>"
 
 Where::
 
-- 
2.17.1
