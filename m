From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 18 Mar 2020 17:22:48 +0000
Subject: [RFC] IMA: Use Trusted Execution Environment to protect IMA keys and operations
Message-Id: <f175c12e-24d8-745e-394d-6c850e01cf6c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, linux-integrity@vger.kernel.org
Cc: sashal@kernel.org, keyrings@vger.kernel.org, James Morris <jamorris@linuxonhyperv.com>, balajib@microsoft.com, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>

Linux kernel stores keys, secrets, and other such sensitive and high 
value entities in memory. An attacker can exploit a kernel vulnerability 
to modify existing entities or inject new ones to gain access to 
privileged operations.

IMA uses asymmetric keys stored in keyrings such as .ima, .evm to 
validate digital signature of system files, kernel modules, etc. An 
attacker can utilize a kernel exploit to modify or inject keys into 
these system keyrings and hijack integrity operations performed by the 
IMA subsystem.

We can tackle this issue by storing such sensitive kernel data in
a secure environment where they cannot be easily tampered with and
performing the integrity operations in this environment.

For instance, ARM platform supports TrustZone (TZ) and Trusted Execution 
Environment (TEE), Intel provides Software Guard Extensions (SGX), which 
can be leveraged for this purpose.

Proposal
--------

  Loading IMA Keyrings
   => IMA keyrings and the keys in those keyrings will be maintained
      inside TZ.
   => These keyrings will be created and keys populated in the TZ when
      the machine initializes TZ.
   => Write access to these keyrings\keys will be blocked once they
      are initialized.

  Digital Signature Appraisal
   Digital signature stored in security.ima, security.evm, or appended to
   the module are verified by functions integrity_digsig_verify() or
   integrity_modsig_verify().

  The move to TZ\TEE can be done in phases:

   Phase #1:
    Maintain the keyrings\keys in TZ. Integrity functions execute in
    the "Normal World" (Untrusted environment). They query the key
    from TZ and validate signature.

   Phase #2:
    The integrity functions and their dependencies that validate
    signature are executed in TEE.

   Phase #3:
    Integrity measurement, appraisal, and logging are executed in TEE.

  Key Queries
   KEYS subsystem need to be updated to route the calls to TZ
   for queries for IMA keyrings such that callers (such as, user mode
   utilities such as KEYCTL, EVMCTL, etc.) work seamlessly.

Please provide comments\feedback on the proposal.

Thanks,
  -lakshmi
