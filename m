From: Adam Sampson <ats@offog.org>
Date: Fri, 16 Nov 2018 00:39:11 +0000
Subject: [PATCH] keyutils: fix keyctl_pkey_verify(3) include
Message-Id: <20181116003911.GI8744@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

keyctl_pkey_verify.3 includes itself; it should include
keyctl_pkey_sign.3 where this function is described.

Signed-off-by: Adam Sampson <ats@offog.org>

--- a/man/keyctl_pkey_verify.3
+++ b/man/keyctl_pkey_verify.3
@@ -1 +1 @@
-.so keyctl_pkey_verify.3
+.so keyctl_pkey_sign.3

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
