From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 13 Dec 2018 00:19:56 +0000
Subject: Re: [PATCH v2 7/7] ima: Support platform keyring for kernel appraisal
Message-Id: <87y38ue0r7.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-8-nayna@linux.ibm.com>
In-Reply-To: <20181208202705.18673-8-nayna@linux.ibm.com>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, jforbes@redhat.com, seth.forshee@canonical.com, kexec@lists.infradead.org, keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, mpe@ellerman.id.au


Nayna Jain <nayna@linux.ibm.com> writes:

> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
>
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> ---
> Changelog:
>
> v2:
> - replace 'rc' with 'xattr_len' when calling integrity_digsig_verify()
> with INTEGRITY_KEYRING_IMA for readability
>
>  security/integrity/ima/ima_appraise.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

With the change to only access the platform keyring when it is enabled:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

--
Thiago Jung Bauermann
IBM Linux Technology Center
