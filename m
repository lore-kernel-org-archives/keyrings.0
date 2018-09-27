From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:35 +0000
Subject: [PATCH v2 6/7] keyctl_set_reqkey_keyring.3: mention KEY_REQKEY_DEFL_USER_SESSION_KEYRING
Message-Id: <20180927131436.23328-7-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 man/keyctl_set_reqkey_keyring.3 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/man/keyctl_set_reqkey_keyring.3 b/man/keyctl_set_reqkey_keyring.3
index 00da586..18d520c 100644
--- a/man/keyctl_set_reqkey_keyring.3
+++ b/man/keyctl_set_reqkey_keyring.3
@@ -51,6 +51,9 @@ This makes the UID-specific keyring the default destination.
 .B KEY_REQKEY_DEFL_USER_SESSION_KEYRING
 This makes the UID-specific session keyring the default destination.
 .TP
+.B KEY_REQKEY_DEFL_GROUP_KEYRING
+This makes the GID-specific session keyring the default destination.
+.TP
 .B KEY_REQKEY_DEFL_DEFAULT
 This selects the default behaviour which is to use the thread-specific keyring
 if there is one, otherwise the process-specific keyring if there is one,
-- 
2.19.0.221.g150f307afc
