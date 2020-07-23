From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Thu, 23 Jul 2020 18:53:15 +0000
Subject: [PATCH v2] encrypted-keys: Replace HTTP links with HTTPS ones
Message-Id: <20200723185315.71039-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200723020114.GG45081@linux.intel.com>
In-Reply-To: <20200723020114.GG45081@linux.intel.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 v2: Shortened commit message.

 Oh, and it wasn't my intention to address the slow deprecation of plain HTTP.

 include/keys/encrypted-type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/keys/encrypted-type.h b/include/keys/encrypted-type.h
index 38afb341c3f2..abfcbe02001a 100644
--- a/include/keys/encrypted-type.h
+++ b/include/keys/encrypted-type.h
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2010 IBM Corporation
  * Copyright (C) 2010 Politecnico di Torino, Italy
- *                    TORSEC group -- http://security.polito.it
+ *                    TORSEC group -- https://security.polito.it
  *
  * Authors:
  * Mimi Zohar <zohar@us.ibm.com>
-- 
2.27.0
