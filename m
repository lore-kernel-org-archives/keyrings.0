From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 13 Nov 2019 15:46:18 +0000
Subject: Re: One question about trusted key of keyring in Linux kernel.
Message-Id: <1573659978.17949.83.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
To: "Zhao, Shirley" <shirley.zhao@intel.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>

On Wed, 2019-11-13 at 01:22 +0000, Zhao, Shirley wrote:
> Hi, all,
> 
> This is Shirley from Intel. I have one question about trusted key of
> keyring in kernel. Please help.
> 
> According the to description in https://github.com/torvalds/linux/bl
> ob/master/Documentation/security/keys/trusted-encrypted.rst.
> Trusted key will be saved in TPM with PCR policy protected.

"Trusted Keys use a TPM both to generate and to seal the keys. Keys
are sealed under a 2048 bit RSA key in the TPM, ..."

Trusted keys are not TPM keys.  They are not stored in the TPM.

> 
> Then, I running the following command to create a trusted key.
> keyctl add trusted test_trusted "new 32 keyhandle=0x81000001" @u
> 
> I also tried the following command, it can add one trusted key, too.
> keyctl add trusted test_trusted "new 32 keyhandle=0x81000001
> pcrinfo=`cat pcr7.blob`" @u
> 
> But after reboot, this key will be removed.
> I need to re-added during boot.

Right, they need to be re-loaded on boot.  Refer to the dracut
module /modules.d/97masterkey for loading a trusted key during boot.

> 
> Then the question is since this key is saved in TPM, how to get it
> back from TPM?

Trusted keys are not stored in the TPM.  Refer to the ima-evm-utils
README for examples of creating a trusted key (kmk) and an encrypted
key (evm-key).

> 
> From the document, I need to use "keyctl pipe" to save the key into
> a blob, then load it.
> But the blob contend key text, and this is a file on hard disk, it
> is not safe to protect the key.
> 
> So what can TPM do here?

The hex ascii encoded trusted key is sealed under the TPM SRK.

Mimi
