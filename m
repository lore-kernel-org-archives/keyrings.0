From: colyli@suse.de
Date: Sat, 15 Aug 2020 12:46:14 +0000
Subject: [PATCH RESEND] docs: update trusted-encrypted.rst
Message-Id: <20200815124614.115201-1-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200815075143.47082-1-colyli@suse.de>
In-Reply-To: <20200815075143.47082-1-colyli@suse.de>
To: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Coly Li <colyli@suse.de>, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Coly Li <colyli@suse.de>

The parameters in tmp2 commands are outdated, people are not able to
create trusted key by the example commands.

This patch updates the paramerters of tpm2 commands, they are verified
by tpm2-tools-4.1 with Linux v5.8 kernel.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 9483a7425ad5..442a2775156e 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -39,10 +39,9 @@ With the IBM TSS 2 stack::
 
 Or with the Intel TSS 2 stack::
 
-  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
+  #> tpm2_createprimary --hierarchy o -G rsa2048 key.ctxt
   [...]
-  handle: 0x800000FF
-  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
+  #> tpm2_evictcontrol -c key.ctxt 0x81000001
   persistentHandle: 0x81000001
 
 Usage::
@@ -115,7 +114,7 @@ append 'keyhandle=0x81000001' to statements between quotes, such as
 
 ::
 
-    $ keyctl add trusted kmk "new 32" @u
+    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
     440502848
 
     $ keyctl show
@@ -138,7 +137,7 @@ append 'keyhandle=0x81000001' to statements between quotes, such as
 
 Load a trusted key from the saved blob::
 
-    $ keyctl add trusted kmk "load `cat kmk.blob`" @u
+    $ keyctl add trusted kmk "load `cat kmk.blob` keyhandle=0x81000001" @u
     268728824
 
     $ keyctl print 268728824
-- 
2.26.2
