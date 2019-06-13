From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 13 Jun 2019 10:42:33 +0000
Subject: [RFC 7/7] MAINTAINERS: Add entry for TEE based Trusted Keys
Message-Id: <1560421833-27414-8-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: jens.wiklander@linaro.org, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, ard.biesheuvel@linaro.org, daniel.thompson@linaro.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, Sumit Garg <sumit.garg@linaro.org>

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496c..db84fc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8728,6 +8728,15 @@ F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	security/keys/trusted.h
 
+KEYS-TEE-TRUSTED
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	Documentation/security/keys/tee-trusted.rst
+F:	include/keys/tee_trusted.h
+F:	security/keys/tee_trusted.c
+
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 L:	keyrings@vger.kernel.org
-- 
2.7.4
