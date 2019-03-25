From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 25 Mar 2019 21:33:38 +0000
Subject: Re: [PATCH] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
Message-Id: <CAPcyv4gCvqkAUSb2sC1+hoHF=bu5X8AXvJuRoqcEt4OQGvWk5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, stable <stable@vger.kernel.org>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linuxibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Mar 25, 2019 at 7:48 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
> key type callbacks and exported functions to fail when a TPM is not
> available.
>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reported-and-tested-by: Dan Williams <dan.j.williams@intel.com>

Thanks Jarkko!
