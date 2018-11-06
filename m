From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Tue, 06 Nov 2018 16:00:58 +0000
Subject: Re: [PATCH] docs: Extend trusted keys documentation for TPM 2.0
Message-Id: <20181106160058.5ov7yhzq6mbrg6yn@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181019101758.1569-1-stefanb@linux.ibm.com>
 <20181105204215.hw6vme5epxcc3nch@cantor>
In-Reply-To: <20181105204215.hw6vme5epxcc3nch@cantor>
To: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, zohar@linux.ibm.com, jejb@linux.ibm.com, Alexander.Levin@microsoft.com, jmorris@namei.org, linux-kernel@vger.kernel.org
Cc: William Roberts <william.c.roberts@intel.com>

On Mon Nov 05 18, Jerry Snitselaar wrote:
>On Fri Oct 19 18, Stefan Berger wrote:
>>Extend the documentation for trusted keys with documentation for how to
>>set up a key for a TPM 2.0 so it can be used with a TPM 2.0 as well.
>>
>>Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>---
>>.../security/keys/trusted-encrypted.rst       | 31 ++++++++++++++++++-
>>1 file changed, 30 insertions(+), 1 deletion(-)
>>
>>diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
>>index 3bb24e09a332..6ec6bb2ac497 100644
>>--- a/Documentation/security/keys/trusted-encrypted.rst
>>+++ b/Documentation/security/keys/trusted-encrypted.rst
>>@@ -18,10 +18,33 @@ integrity verifications match.  A loaded Trusted Key can be updated with new
>>when the kernel and initramfs are updated.  The same key can have many saved
>>blobs under different PCR values, so multiple boots are easily supported.
>>
>>+TPM 1.2
>>+-------
>>+
>>By default, trusted keys are sealed under the SRK, which has the default
>>authorization value (20 zeros).  This can be set at takeownership time with the
>>trouser's utility: "tpm_takeownership -u -z".
>>
>>+TPM 2.0
>>+-------
>>+
>>+The user must first create a storage key and make it persistent, so the key is
>>+available after reboot. This can be done using the following commands.
>>+
>>+With the IBM TSS 2 stack::
>>+
>>+  #> tsscreateprimary -hi o -st
>>+  Handle 80000000
>>+  #> tssevictcontrol -hi o -ho 80000000 -hp 81000001
>>+
>>+Or with the Intel TSS 2 stack::
>>+
>>+  #> tpm2_createprimary --hierarchy o -G rsa2048 -o key.ctxt
>>+  [...]
>>+  handle: 0x800000FF
>>+  #> tpm2_evictcontrol -c key.ctxt -p 0x81000001
>>+  persistentHandle: 0x81000001
>>+
>
>Is that the correct option for tpm2_evictcontrol? What I'm seeing
>in the versions I have is -S or -persistent= for specifying the persistent handle.
>
>Other than that looks good to me.

William, is the above correct?

>
>>Usage::
>>
>>    keyctl add trusted name "new keylen [options]" ring
>>@@ -30,7 +53,9 @@ Usage::
>>    keyctl print keyid
>>
>>    options:
>>-       keyhandle=    ascii hex value of sealing key default 0x40000000 (SRK)
>>+       keyhandle=    ascii hex value of sealing key
>>+                       TPM 1.2: default 0x40000000 (SRK)
>>+                       TPM 2.0: no default; must be passed every time
>>       keyauth=	     ascii hex auth for sealing key default 0x00...i
>>                     (40 ascii zeros)
>>       blobauth=     ascii hex auth for sealed data default 0x00...
>>@@ -84,6 +109,10 @@ Examples of trusted and encrypted key usage:
>>
>>Create and save a trusted key named "kmk" of length 32 bytes::
>>
>>+Note: When using a TPM 2.0 with a persistent key with handle 0x81000001,
>>+append 'keyhandle=0x81000001' to statements between quotes, such as
>>+"new 32 keyhandle=0x81000001".
>>+
>>    $ keyctl add trusted kmk "new 32" @u
>>    440502848
>>
>>-- 
>>2.17.2
>>
