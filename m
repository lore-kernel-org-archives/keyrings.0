From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 30 Jul 2019 12:35:40 +0000
Subject: [RFC v2 6/6] MAINTAINERS: Add entry for TEE based Trusted Keys
Message-Id: <1564489420-677-7-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>, corbet@lwn.net, jejb@linux.ibm.com, ard.biesheuvel@linaro.org, linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, casey@schaufler-ca.com, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce06877..0b61ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8930,6 +8930,15 @@ F:	include/keys/trusted-type.h
 F:	security/keys/trusted.c
 F:	security/keys/trusted.h
 
+KEYS-TEE-TRUSTED
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	Documentation/security/keys/tee-trusted.rst
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted-tee.c
+
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
 L:	keyrings@vger.kernel.org
-- 
2.7.4
