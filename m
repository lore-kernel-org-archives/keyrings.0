From: Robert Holmes <robeholmes@gmail.com>
Date: Wed, 24 Apr 2019 17:36:56 +0000
Subject: Re: [PATCH v2] KEYS: Make use of platform keyring for module signature verify
Message-Id: <CAD_KW27rN-GefFqegdBTYNf4393cF5Kc+jP=au45GfSvmTSn9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1556116431-7129-1-git-send-email-robeholmes@gmail.com> <20190424160609.EE5ED21901@mail.kernel.org>
In-Reply-To: <20190424160609.EE5ED21901@mail.kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: jeyu@kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, stable@vger.kernel.org

In the v5.0.9 stable tree we also require also cherry-picking commits

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=219a3e8676f3132d27b530c7d2d6bcab89536b57
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278311e417be60f7caef6fcb12bda4da2711ceff

which, arguably, should be on stable anyway, since it has already picked up

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.0.y&id=9dc92c45177ab70e20ae94baa2f2e558da63a9c7
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.0.y&id=60740accf78494e166ec76bdc39b7d75fc2fe1c7

Robert.

On Wed, Apr 24, 2019 at 5:06 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.0.9, v4.19.36, v4.14.113, v4.9.170, v4.4.178, v3.18.138.
>
> v5.0.9: Build failed! Errors:
>     kernel/module_signing.c:92:11: error: ‘VERIFY_USE_PLATFORM_KEYRING’ undeclared (first use in this function); did you mean ‘VERIFY_USE_SECONDARY_KEYRING’?
>
> v4.19.36: Failed to apply! Possible dependencies:
>     e84cd7ee630e ("modsign: use all trusted keys to verify module signature")
>
> v4.14.113: Failed to apply! Possible dependencies:
>     81a0abd9f213 ("module: make it clear when we're handling the module copy in info->hdr")
>     e84cd7ee630e ("modsign: use all trusted keys to verify module signature")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>
> v4.9.170: Failed to apply! Possible dependencies:
>     3e2e857f9c3a ("module: Add module name to modinfo")
>     490194269665 ("module: Pass struct load_info into symbol checks")
>     71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>     71d9f5079358 ("module: Fix a comment above strong_try_module_get()")
>     81a0abd9f213 ("module: make it clear when we're handling the module copy in info->hdr")
>     96b5b19459b3 ("module: make the modinfo name const")
>     e84cd7ee630e ("modsign: use all trusted keys to verify module signature")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>
> v4.4.178: Failed to apply! Possible dependencies:
>     136cd3450af8 ("powerpc/module: Only try to generate the ftrace_caller() stub once")
>     20ef10c1b306 ("module: Use the same logic for setting and unsetting RO/NX")
>     3e2e857f9c3a ("module: Add module name to modinfo")
>     490194269665 ("module: Pass struct load_info into symbol checks")
>     4c91bd6eeabb ("powerpc: Merge the RELOCATABLE config entries for ppc32 and ppc64")
>     71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>     7523e4dc5057 ("module: use a structure to encapsulate layout.")
>     81a0abd9f213 ("module: make it clear when we're handling the module copy in info->hdr")
>     96b5b19459b3 ("module: make the modinfo name const")
>     a5967db9af51 ("kbuild: allow architectures to use thin archives instead of ld -r")
>     b67067f1176d ("kbuild: allow archs to select link dead code/data elimination")
>     be7de5f91fdc ("modules: Add kernel parameter to blacklist modules")
>     cd3caefb4663 ("Fix subtle CONFIG_MODVERSIONS problems")
>     da4230714662 ("powerpc/32/booke: Fix the build error when CRASH_DUMP is enabled")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>     faaae2a58143 ("Re-enable CONFIG_MODVERSIONS in a slightly weaker form")
>
> v3.18.138: Failed to apply! Possible dependencies:
>     136cd3450af8 ("powerpc/module: Only try to generate the ftrace_caller() stub once")
>     3e2e857f9c3a ("module: Add module name to modinfo")
>     490194269665 ("module: Pass struct load_info into symbol checks")
>     4c91bd6eeabb ("powerpc: Merge the RELOCATABLE config entries for ppc32 and ppc64")
>     6da0b565150b ("kernel:module Fix coding style errors and warnings.")
>     71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>     7523e4dc5057 ("module: use a structure to encapsulate layout.")
>     7d485f647c1f ("ARM: 8220/1: allow modules outside of bl range")
>     81a0abd9f213 ("module: make it clear when we're handling the module copy in info->hdr")
>     926a59b1dfe2 ("module: Annotate module version magic")
>     96b5b19459b3 ("module: make the modinfo name const")
>     be7de5f91fdc ("modules: Add kernel parameter to blacklist modules")
>     cb9e3c292d01 ("mm: vmalloc: pass additional vm_flags to __vmalloc_node_range()")
>     cd3caefb4663 ("Fix subtle CONFIG_MODVERSIONS problems")
>     da4230714662 ("powerpc/32/booke: Fix the build error when CRASH_DUMP is enabled")
>     f314dfea16a0 ("modsign: log module name in the event of an error")
>     faaae2a58143 ("Re-enable CONFIG_MODVERSIONS in a slightly weaker form")
>
>
> How should we proceed with this patch?
>
> --
> Thanks,
> Sasha
