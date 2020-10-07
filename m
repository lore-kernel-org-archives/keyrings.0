From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 07 Oct 2020 10:19:48 +0000
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Message-Id: <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
To: jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, jejb@linux.ibm.com
Cc: linux-security-module@vger.kernel.org, daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>, op-tee@lists.trustedfirmware.org, corbet@lwn.net, janne.karhunen@gmail.com, linux-doc@vger.kernel.org, jmorris@namei.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, lhinds@redhat.com, keyrings@vger.kernel.org, Markus.Wamser@mixed-mode.de, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, jens.wiklander@linaro.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

Add MAINTAINERS entry for TEE based Trusted Keys framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48aff80..eb3d889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9663,6 +9663,14 @@ F:	include/keys/trusted-type.h
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
