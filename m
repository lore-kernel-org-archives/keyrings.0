From: Ben Boeckel <me@benboeckel.net>
Date: Sat, 16 May 2020 00:23:34 +0000
Subject: [PATCH 1/1] man: the info strings are actually space or tab separated
Message-Id: <20200516002334.2025760-2-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200516002334.2025760-1-list.lkml.keyrings@me.benboeckel.net>
In-Reply-To: <20200516002334.2025760-1-list.lkml.keyrings@me.benboeckel.net>
To: keyrings@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, dhowells@redhat.com

From: Ben Boeckel <mathstuf@gmail.com>

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 man/keyctl_pkey_encrypt.3 | 4 ++--
 man/keyctl_pkey_query.3   | 2 +-
 man/keyctl_pkey_sign.3    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/man/keyctl_pkey_encrypt.3 b/man/keyctl_pkey_encrypt.3
index 44c640e..5a5b71b 100644
--- a/man/keyctl_pkey_encrypt.3
+++ b/man/keyctl_pkey_encrypt.3
@@ -40,8 +40,8 @@ When invoking the function,
 .I key
 indicates the key that will provide the cryptographic material and
 .I info
-points to a comma-separated string of "key[=value]" parameters that indicate
-things like encoding forms and passwords to unlock the key; see
+points to a space- or tab-separated string of "key[=value]" parameters that
+indicate things like encoding forms and passwords to unlock the key; see
 asymmetric-key(7) for more information.
 .PP
 .IR data " and " datalen
diff --git a/man/keyctl_pkey_query.3 b/man/keyctl_pkey_query.3
index dbeb0fd..e70665f 100644
--- a/man/keyctl_pkey_query.3
+++ b/man/keyctl_pkey_query.3
@@ -32,7 +32,7 @@ When invoking the function,
 .I key
 indicates the key to be queried,
 .I info
-points to a comma-separated string of "key[=value]" parameters and
+points to a space- or tab-separated string of "key[=value]" parameters and
 .I result
 points to a buffer in which the result will be placed.
 .PP
diff --git a/man/keyctl_pkey_sign.3 b/man/keyctl_pkey_sign.3
index 2f17e73..4fb6a14 100644
--- a/man/keyctl_pkey_sign.3
+++ b/man/keyctl_pkey_sign.3
@@ -44,8 +44,8 @@ When invoking the function,
 .I key
 indicates the key that will provide the cryptographic material and
 .I info
-points to a comma-separated string of "key[=value]" parameters that indicate
-things like encoding forms and passwords to unlock the key; see
+points to a space- or tab-separated string of "key[=value]" parameters that
+indicate things like encoding forms and passwords to unlock the key; see
 asymmetric-key(7) for more information.
 .PP
 .IR data " and " datalen
-- 
2.25.4
