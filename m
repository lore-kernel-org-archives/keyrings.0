From: Coly Li <colyli@suse.de>
Date: Fri, 21 Aug 2020 13:53:56 +0000
Subject: [PATCH v4] docs: trusted-encrypted.rst: update parameters for command examples
Message-Id: <20200821135356.15737-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Coly Li <colyli@suse.de>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Stefan Berger <stefanb@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>

The parameters in command examples for tpm2_createprimary and
tpm2_evictcontrol are outdated, people (like me) are not able to create
trusted key by these command examples.

This patch updates the parameters of command example tpm2_createprimary
and tpm2_evictcontrol in trusted-encrypted.rst. With Linux kernel v5.8
and tpm2-tools-4.1, people can create a trusted key by following the
examples in this document.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
---
Changelog:
v4: update Reviewed-by list, and Cc linux-doc and linux-integrity
    maintainers.
v3: update commit log with review comments from Jarkko Sakkinen. 
v2: remove the change of trusted key related operation.
v1: initial version.

 Documentation/security/keys/trusted-encrypted.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9483a7425ad5..1da879a68640 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
 
 Or with the Intel TSS 2 stack::
 
-  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
+  #> tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
   [...]
-  handle: 0x800000FF
-  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
+  #> tpm2_evictcontrol -c key.ctxt 0x81000001
   persistentHandle: 0x81000001
 
 Usage::
-- 
2.26.2
