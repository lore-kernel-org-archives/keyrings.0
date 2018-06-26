From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 26 Jun 2018 19:30:38 +0000
Subject: [PATCH 0/2] Convert trusted keys to find and use the default TPM chip
Message-Id: <20180626193040.2509798-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com, zohar@linux.vnet.ibm.com, jejb@linux.vnet.ibm.com
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

The following patches build on top of the series of patches that
convert IMA to find and use the system's default TPM chip.

I have done some successful testing with trusted keys using publicly
available examples.

   Stefan

Stefan Berger (2):
  tpm: Implement public tpm_put_chip() to release reference to chip
  KEYS: trusted: Find tpm_chip and use it until module shutdown

 drivers/char/tpm/tpm-chip.c | 10 +++++++++
 include/linux/tpm.h         |  4 ++++
 security/keys/trusted.c     | 41 +++++++++++++++++++++++++------------
 3 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

