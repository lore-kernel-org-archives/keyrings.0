From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 17 Jun 2020 23:44:03 +0000
Subject: Re: [PATCH v10 6/8] security: keys: trusted: add PCR policy to TPM2 keys
Message-Id: <20200617234403.GK62794@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
 <20200616160229.8018-7-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200616160229.8018-7-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Tue, Jun 16, 2020 at 09:02:27AM -0700, James Bottomley wrote:
> This commit adds the ability to specify a PCR lock policy to TPM2
> keys.  There is a complexity in that the creator of the key must chose
> either to use a PCR lock policy or to use authentication.  At the
> current time they can't use both due to a complexity with the way
> authentication works when policy registers are in use.  The way to
> construct a pcrinfo statement for a key is simply to use the
> TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
> hash of all their values in order of ascending PCR number.
> 
> For simplicity, we require the policy name hash and the hash used for
> the PCRs to be the same.  Thus to construct a policy around the value
> of the resettable PCR 16 using the sha1 bank, first reset the pcr to
> zero giving a hash of all zeros as:
> 
> 6768033e216468247bd031a0a2d9876d79818f8f
> 
> Then the TPMS_PCR_SELECT value for PCR 16 is
> 
> 03000001
> 
> So create a new 32 byte key with a policy policy locking the key to
> this value of PCR 16 with a parent key of 81000001 would be:
> 
> keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo0000016768033e216468247bd031a0a2d9876d79818f8f" @u
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Policy stuff definitely should be a follow up and not part of the same
patch set. Too many decisions to make. 

/Jarkko
