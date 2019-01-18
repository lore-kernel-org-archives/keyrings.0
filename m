From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 18 Jan 2019 11:53:52 +0000
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify the kernel image
Message-Id: <1547812432.3982.55.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190118091733.29940-1-kasong@redhat.com>
In-Reply-To: <20190118091733.29940-1-kasong@redhat.com>
To: Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com, linux-integrity@vger.kernel.org, kexec@lists.infradead.org

On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> This patch series adds a .platform_trusted_keys in system_keyring as the
> reference to .platform keyring in integrity subsystem, when platform
> keyring is being initialized it will be updated. So other component could
> use this keyring as well.

Kairui, when people review patches, the comments could be specific,
but are normally generic.  My review included a couple of generic
suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
term "preboot" keys, and remove any references to "other components".

After all the wording suggestions I've made, you are still saying, "So
other components could use this keyring as well".  Really?!  How the
platform keyring will be used in the future, is up to you and others
to convince Linus.  At least for now, please limit its usage to
verifying the PE signed kernel image.  If this patch set needs to be
reposted, please remove all references to "other components".

Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
Acked the original post.  Can I include it?  Can we get some
additional Ack's on these patches?

thanks!

Mimi


> 
> This patch series also let kexec_file_load use platform keyring as fall
> back if it failed to verify the image against secondary keyring, make it
> possible to load kernel signed by keys provides by firmware.
> 
> After this patch kexec_file_load will be able to verify a signed PE
> bzImage using keys in platform keyring.
> 
> Tested in a VM with locally signed kernel with pesign and imported the
> cert to EFI's MokList variable.
> 
> To test this patch series on latest kernel, you need to ensure this commit
> is applied as there is an regression bug in sanity_check_segment_list():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id�3a110319a4a60aadbd02f6defdebe048f7773b
> 
> Update from V3:
>   - Tweak and simplify commit message as suggested by Mimi Zohar
> 
> Update from V2:
>   - Use IS_ENABLED in kexec_file_load to judge if platform_trusted_keys
>     should be used for verifying image as suggested by Mimi Zohar
> 
> Update from V1:
>   - Make platform_trusted_keys static, and update commit message as suggested
>     by Mimi Zohar
>   - Always check if platform keyring is initialized before use it
> 
> Kairui Song (2):
>   integrity, KEYS: add a reference to platform keyring
>   kexec, KEYS: Make use of platform keyring for signature verify
> 
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            | 22 +++++++++++++++++++++-
>  include/keys/system_keyring.h     |  5 +++++
>  include/linux/verification.h      |  1 +
>  security/integrity/digsig.c       |  6 ++++++
>  5 files changed, 43 insertions(+), 4 deletions(-)
> 
