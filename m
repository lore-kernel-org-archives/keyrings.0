From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 06 May 2020 09:52:17 +0000
Subject: [PATCH v4 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Message-Id: <1588758017-30426-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
To: jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, jejb@linux.ibm.com
Cc: tee-dev@lists.linaro.org, daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>, op-tee@lists.trustedfirmware.org, corbet@lwn.net, janne.karhunen@gmail.com, linux-doc@vger.kernel.org, jmorris@namei.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Markus.Wamser@mixed-mode.de, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a45..fc8bf16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9403,6 +9403,14 @@ F:	include/keys/trusted-type.h
 F:	include/keys/trusted_tpm.h
 F:	security/keys/trusted-keys/
 
+KEYS-TRUSTED-TEE
+M:	Sumit Garg <sumit.garg@linaro.org>
+L:	linux-integrity@vger.kernel.org
+L:	keyrings@vger.kernel.org
+S:	Supported
+F:	include/keys/trusted_tee.h
+F:	security/keys/trusted-keys/trusted_tee.c
+
 KEYS/KEYRINGS
 M:	David Howells <dhowells@redhat.com>
 M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-- 
2.7.4
