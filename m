From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Date: Fri, 04 May 2018 01:20:16 +0000
Subject: Re: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
Message-Id: <04EE0041-8DF1-4FF3-9C59-64ECF0182CC5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
 <alpine.LRH.2.21.1805040311050.12843@namei.org>
 <1525383720.3539.76.camel@linux.vnet.ibm.com>
In-Reply-To: <1525383720.3539.76.camel@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Keyrings <keyrings@vger.kernel.org>, Linux Integrity <linux-integrity@vger.kernel.org>, Linux Security <linux-security-module@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, George Wilson <gcwilson@us.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Patrick Callaghan <patrickc@us.ibm.com>


> On May 3, 2018, at 5:42 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> On Fri, 2018-05-04 at 03:11 +1000, James Morris wrote:
>> On Wed, 2 May 2018, Mehmet Kayaalp wrote:
>> 
>>> These patches add support for modifying the reserved space for extra
>>> certificates in a compressed bzImage in x86. This allows separating the
>>> system keyring certificate from the kernel build process. After the kernel
>>> image is distributed, the insert-sys-cert script can be used to insert the
>>> certificate for x86.
>> 
>> Can you provide more explanation of how this is useful and who would use 
>> it?
> 
> I'm involved in a number projects that rely on a kernel build group to
> actually build kernels for their systems.  Reserving memory for
> additional public keys, allows product groups to insert public keys
> post build.  Initially the product groups might insert development
> keys, but eventually they would insert the product's public key.
> 
> Mimi

With CONFIG_SYSTEM_TRUSTED_KEYRING, we have a system keyring populated
with keys that we trust. Initial keys are compiled-in:
-The module signing key, as specified by CONFIG_MODULE_SIG_KEY,
-Additional keys, as specified by CONFIG_SYSTEM_TRUSTED_KEYS.

In userspace, we can add more keys to the system keyring, only if they can be
verified by keys already in the keyring.

In kernel or modules, we can bypass this restriction by using the
KEY_ALLOC_BYPASS_RESTRICTION flag. As far as I can tell, only the compiled-in
keys are loaded this way in the upstream kernel.

Other asymmetric keyrings can specify the same restriction using the
"builtin_trusted" option. Currently, CONFIG_INTEGRITY_TRUSTED_KEYRING creates
".ima" and ".evm" keyrings with this restriction. As a result, in order to
add a key to an integrity keyring, either that key needs to be compiled-in,
or it must be signed with a key that is in the system keyring, which again
needs to be compiled-in.

If a user is not compiling their own kernel, and has no access to the module
signing key (or any other compiled-in key), then how can they add their own
keys to the integrity keyrings?

This patchset allows the user to take the kernel from a distro, insert their 
own key, sign the resulting image as required for their secure boot method,  
and when booted, the system keyring will include their key, which can be used 
to control the integrity keys.

An alternative way is to allow the "secondary" trusted keyring to verify the 
IMA keys with CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY, but 
it is the same problem. Some distros carry patches that populate the 
secondary keyring with UEFI keys during kernel initialization, which would 
mean having access to a UEFI key (which is also needed with this patchset, 
for signing the resulting image), would be enough to add integrity keys. But 
that is much more permissive, since ANY key that goes into the secondary 
keyring, coming from UEFI, could then be used to control the integrity keys. 

Mehmet

