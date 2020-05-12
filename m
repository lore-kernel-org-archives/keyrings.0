From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 May 2020 09:32:42 +0000
Subject: Re: [PATCH v4 0/4] Introduce TEE based Trusted Keys support
Message-Id: <CAFA6WYNgBQDBY+670fG38Yrg8tMg6U74TW12WON=9dVvsT0t6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>, Janne Karhunen <janne.karhunen@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Markus Wamser <Markus.Wamser@mixed-mode.de>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Wed, 6 May 2020 at 15:10, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key. Also, this is
> an alternative in case platform doesn't possess a TPM device.
>
> This patch-set has been tested with OP-TEE based early TA which can be
> found here [1].
>
> [1] https://github.com/OP-TEE/optee_os/pull/3838

Fyi, this PR has been merged in OP-TEE OS as commit [1]. Looking
forward to any further comments/feedback on this patch-set.

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b

-Sumit

>
> Changes in v4:
> 1. Pushed independent TEE features separately:
>   - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
> 2. Updated trusted-encrypted doc with TEE as a new trust source.
> 3. Rebased onto latest tpmdd/master.
>
> Changes in v3:
> 1. Update patch #2 to support registration of multiple kernel pages.
> 2. Incoporate dependency patch #4 in this patch-set:
>    https://patchwork.kernel.org/patch/11091435/
>
> Changes in v2:
> 1. Add reviewed-by tags for patch #1 and #2.
> 2. Incorporate comments from Jens for patch #3.
> 3. Switch to use generic trusted keys framework.
>
> Sumit Garg (4):
>   KEYS: trusted: Add generic trusted keys framework
>   KEYS: trusted: Introduce TEE based Trusted Keys
>   doc: trusted-encrypted: updates with TEE as a new trust source
>   MAINTAINERS: Add entry for TEE based Trusted Keys
>
>  Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++---
>  MAINTAINERS                                       |   8 +
>  include/keys/trusted-type.h                       |  48 ++++
>  include/keys/trusted_tee.h                        |  66 +++++
>  include/keys/trusted_tpm.h                        |  15 -
>  security/keys/Kconfig                             |   3 +
>  security/keys/trusted-keys/Makefile               |   2 +
>  security/keys/trusted-keys/trusted_common.c       | 336 ++++++++++++++++++++++
>  security/keys/trusted-keys/trusted_tee.c          | 282 ++++++++++++++++++
>  security/keys/trusted-keys/trusted_tpm1.c         | 335 ++++-----------------
>  10 files changed, 974 insertions(+), 324 deletions(-)
>  create mode 100644 include/keys/trusted_tee.h
>  create mode 100644 security/keys/trusted-keys/trusted_common.c
>  create mode 100644 security/keys/trusted-keys/trusted_tee.c
>
> --
> 2.7.4
>
