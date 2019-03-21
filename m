From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 21 Mar 2019 13:54:51 +0000
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
Message-Id: <20190321135451.GD4603@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, James Bottomley <jejb@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Mon, Mar 18, 2019 at 04:45:13PM -0700, Dan Williams wrote:
> Rather than fail initialization of the trusted.ko module, arrange for
> the module to load, but rely on trusted_instantiate() to fail
> trusted-key operations.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

It should check for chip in each function that uses TPM now that
the code does not rely on default chip. Otherwise, the semantics
are kind of inconsistent.

/Jarkko
