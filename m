From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 24 Oct 2017 16:06:03 +0000
Subject: TPM trusted keys code
Message-Id: <20171024160603.or2yflspzfrf3bfo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi David,

I have a proposal.

We are soon going to have the following tools for in-kernel consumers
of the TPM:

* tpm_send() that takes struct tpm_buf that gives easy tools to
  construct variable length commands. It has been already in use
  inside the TPM driver since 2015.
* tpm_find_and_get() and tpm_put() for locking the in-kernel API
  before use.
* All TPM constant values in include/linux/tpm.h

My main intention would be to refactor trusted keys code in the
following way:

1. Refactor TPM 1.x trusted keys code to use tpm_buf for constructing
   sealing messages and remove the custom stuff that you have currently.
2. Move TPM 2.x trusted keys code to security/keys/trusted

I originally implemeted TPM 2.x trusted keys code originally to the TPM
driver because the infrastructure was lacking.

My rationale here is that it is domain specific code used by only one
subsystem. For overall kernel arch it probably makes sense to have that
code located in that subsystems and have TPM driver only provide great
tools to implement that, right?

Just wanted to ask you before I start this effort. Thank you.

/Jarkko
