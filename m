From: Dan Williams <dan.j.williams@gmail.com>
Date: Wed, 27 Mar 2019 17:15:50 +0000
Subject: Re: [PATCH v3] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
Message-Id: <CAA9_cmfFpkBLz6TU0sLSV1JYE43sDtfi29Xw4R5Xt-RaWm8ZLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190326121158.13499-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190326121158.13499-1-jarkko.sakkinen@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linuxibm.com>, David Howells <dhowells@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Tue, Mar 26, 2019 at 5:13 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
> key type callbacks and exported functions to fail when a TPM is not
> available.
>
> Cc: James Morris <jmorris@namei.org>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> v3:
> - remove unnecessary check for chip in init_trusted()

v3 also tests ok here.
