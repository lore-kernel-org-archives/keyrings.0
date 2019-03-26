From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 26 Mar 2019 11:52:49 +0000
Subject: Re: [PATCH] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
Message-Id: <20190326115249.GC10898@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linuxibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Mar 25, 2019 at 04:47:35PM +0200, Jarkko Sakkinen wrote:
> Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
> key type callbacks and exported functions to fail when a TPM is not
> available.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Will send a revised version: since now the key type is not registered,
none of the callbacks needs the check for the chip instance. Only the
exported functions should have it.

/Jarkko
