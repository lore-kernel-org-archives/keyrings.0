From: Ben Boeckel <me@benboeckel.net>
Date: Wed, 13 May 2020 22:23:06 +0000
Subject: [PATCH 1/1] man: clarify that keyctl_set_reqkey_keyring(3) returns the old default
Message-Id: <20200513222306.870160-2-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200513222306.870160-1-list.lkml.keyrings@me.benboeckel.net>
In-Reply-To: <20200513222306.870160-1-list.lkml.keyrings@me.benboeckel.net>
To: keyrings@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, dhowells@redhat.com

From: Ben Boeckel <mathstuf@gmail.com>

The prose mentions this, but the return value section gave conflicting
information.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 man/keyctl_set_reqkey_keyring.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/keyctl_set_reqkey_keyring.3 b/man/keyctl_set_reqkey_keyring.3
index 00da586..6e6725e 100644
--- a/man/keyctl_set_reqkey_keyring.3
+++ b/man/keyctl_set_reqkey_keyring.3
@@ -66,8 +66,8 @@ and
 .SH RETURN VALUE
 On success
 .BR keyctl_set_reqkey_keyring ()
-returns
-.BR 0 .
+returns the serial number of the keyring which was the previous default for the
+current thread.
 On error, the value
 .B -1
 will be returned and
-- 
2.25.4
