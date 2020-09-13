From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sun, 13 Sep 2020 17:02:51 +0000
Subject: Re: [PATCH v11 4/5] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <1600016571.7833.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200912172643.9063-5-James.Bottomley@HansenPartnership.com>
         <202009131413.8dt8QEc8%lkp@intel.com>
In-Reply-To: <202009131413.8dt8QEc8%lkp@intel.com>
To: kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Sun, 2020-09-13 at 14:26 +0800, kernel test robot wrote:
> Hi James,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on integrity/next-integrity]
> [also build test ERROR on linus/master v5.9-rc4 next-20200911]
> [cannot apply to security/next-testing dhowells-fs/fscache-next]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/James-Bottomley/TPM-
> 2-0-trusted-key-rework/20200913-013201
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-i
> ntegrity.git next-integrity
> config: arm-randconfig-r013-20200913 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> 3170d54842655d6d936aae32b7d0bc92fce7f22e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master
> /sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> > > security/keys/trusted-keys/trusted_tpm2.c:19:10: fatal error:
> > > 'tpm2key.asn1.h' file not found
> 
>    #include "tpm2key.asn1.h"
>             ^~~~~~~~~~~~~~~~
>    1 error generated.

Do you have the actual build log for this?  On x86 the build process
builds any precursors first, which is the tpm2key.asn1.o, which
generates that header file, so we see:

  ASN.1   security/keys/trusted-keys/tpm2key.asn1.[ch]
  CC [M]  security/keys/trusted-keys/trusted_tpm2.o
  CC [M]  security/keys/trusted-keys/tpm2-policy.o
  CC [M]  security/keys/trusted-keys/tpm2key.asn1.o
  LD [M]  security/keys/trusted-keys/trusted.o

Is ARM doing a lazier version of that?  In which case the fix might be
to move trusted_tpm2.o to after tpm2key.asn1.o in the Makefile, this
line:

trusted-y += trusted_tpm2.o tpm2key.asn1.o

James
