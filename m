From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 25 Sep 2017 06:12:01 +0000
Subject: Re: [PATCH v5 0/4] Certificate insertion support for x86 bzImages
Message-Id: <20170925061159.GA6934@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
In-Reply-To: <1494440456-28671-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org

Hi,

> These patches add support for modifying the reserved space for extra
> certificates in a compressed bzImage in x86. This allows separating the
> system keyring certificate from the kernel build process. After the kernel
> image is distributed, the insert-sys-cert script can be used to insert the
> certificate for x86.

I know it's been a while since these patches were posted and they seem to
fail between the cracks ...
Is there anything that prevents merging them?
 
> Changes:
> 
> v5:
> * Added CRC fixing (3/4)
> 
> v4:
> * Applied checkpatch.pl suggestions (2/4, 3/4)
> * Cleaned up the commit messages (1/4, 2/4)
> * Added the build file to .gitignore (1/4)
> 
> v3:
> * Rewrote 1/4 to insert incompressible bytes are at build time. Previous
> solution required changes to <arch>/boot/Makefile's for modifying the
> vmlinux file after linking, and did not work well with cross compilation.
> * Added 2/4 for ELF class-independent processing of vmlinux file, in case
> the script was compiled for 64-bit and the kernel was compiled for 32-bit.
> * Reordered 3/4, added x86 bzImage boot version (>=2.08) verification.
> 
> v2:
> * Rebased arch/boot/x86/Makefile patch (removed in v3)
> 
> Mehmet Kayaalp (4):
>   KEYS: Insert incompressible bytes to reserve space in bzImage
>   KEYS: Add ELF class-independent certificate insertion support
>   KEYS: Support for inserting a certificate into x86 bzImage
>   KEYS: Print insert-sys-cert information to stdout instead of stderr
> 
>  certs/.gitignore            |   1 +
>  certs/Makefile              |  21 +-
>  certs/system_certificates.S |   2 +-
>  scripts/Makefile            |   1 +
>  scripts/insert-sys-cert.c   | 473 +++++++++++++++++++++++++++++++++-----------
>  5 files changed, 381 insertions(+), 117 deletions(-)

-- 
Sincerely yours,
Mike.

