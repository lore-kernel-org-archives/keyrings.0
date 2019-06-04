From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Tue, 04 Jun 2019 14:17:48 +0000
Subject: [PATCH v2 14/22] docs: security: trusted-encrypted.rst: fix code-block tag
Message-Id: <3f540bedea5771489750cbcba540e9b27b21225b.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, James Morris <jamorris@linux.microsoft.com>

The code-block tag is at the wrong place, causing those
warnings:

    Documentation/security/keys/trusted-encrypted.rst:112: WARNING: Literal block expected; none found.
    Documentation/security/keys/trusted-encrypted.rst:121: WARNING: Unexpected indentation.
    Documentation/security/keys/trusted-encrypted.rst:122: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/security/keys/trusted-encrypted.rst:123: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 7b35fcb58933..50ac8bcd6970 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -107,12 +107,14 @@ Where::
 
 Examples of trusted and encrypted key usage:
 
-Create and save a trusted key named "kmk" of length 32 bytes::
+Create and save a trusted key named "kmk" of length 32 bytes.
 
 Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
 append 'keyhandle=0x81000001' to statements between quotes, such as
 "new 32 keyhandle=0x81000001".
 
+::
+
     $ keyctl add trusted kmk "new 32" @u
     440502848
 
-- 
2.21.0
