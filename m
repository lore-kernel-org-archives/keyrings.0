From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 05 Mar 2018 16:56:09 +0000
Subject: [PATCH v3 0/5] Migrate all TPM 2.0 commands to use struct tpm_buf
Message-Id: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, open list <linux-kernel@vger.kernel.org>

In order to make struct tpm_buf the first class object for constructing TPM
commands, this patch set migrates all TPM 2.0 commands to use it. The next
step after this is to migrate TPM 1.2 commands in a subsequent patch set.
Finally, tpm_transmit_cmd() can take simply struct tpm_buf as its argument
and this interface can be exported to be used by the kernel keyring.

The ultimate goal of this work is to make constructing TPM commands inside
the kernel simple and robust.

v3:
* Fixed error handling in tpm2_get_random()

v2:
* Fixed author information in the commit that fixes the self-test issue,
  removed '\n' from the log message and added the missing tested-by.
  (James: sincere apologies about this)
* Removed the redundant "out of memory" log message from tpm2_shutdown().
* tpm_buf_destroy() was called before using the response data in
  tpm2_probe().
* Added missing tpm_buf_destroy() to tpm2_get_random().

James Bottomley (1):
  tpm: fix intermittent failure with self tests

Jarkko Sakkinen (4):
  tpm: migrate tpm2_shutdown() to use struct tpm_buf
  tpm: migrate tpm2_probe() to use struct tpm_buf
  tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
  tpm: migrate tpm2_get_random() to use struct tpm_buf

 drivers/char/tpm/tpm-interface.c |  20 ++-
 drivers/char/tpm/tpm.h           |  20 +--
 drivers/char/tpm/tpm2-cmd.c      | 286 ++++++++++++++-------------------------
 3 files changed, 132 insertions(+), 194 deletions(-)

-- 
2.15.1

