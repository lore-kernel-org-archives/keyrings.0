From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 28 Aug 2019 13:43:41 +0000
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
Message-Id: <1566999821.6115.14.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
         <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
In-Reply-To: <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
To: Jordan Hand <jorhand@linux.microsoft.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

Hi Jordan,

On Mon, 2019-08-26 at 15:46 -0700, Jordan Hand wrote:
> On 6/27/19 7:19 PM, Thiago Jung Bauermann wrote:
> > On the OpenPOWER platform, secure boot and trusted boot are being
> > implemented using IMA for taking measurements and verifying signatures.
> > Since the kernel image on Power servers is an ELF binary, kernels are
> > signed using the scripts/sign-file tool and thus use the same signature
> > format as signed kernel modules.
> > 
> > This patch series adds support in IMA for verifying those signatures.
> > It adds flexibility to OpenPOWER secure boot, because it allows it to boot
> > kernels with the signature appended to them as well as kernels where the
> > signature is stored in the IMA extended attribute.
> 
> I know this is pretty late, but I just wanted to let you know that I
> tested this patch set on x86_64 with QEMU.
> 
> That is, I enrolled a key to _ima keyring, signed my kernel and modules
> with appended signatures (with scripts/sign-file), set the IMA policy to
> appraise and measure my kernel and modules. Also tested kexec appraisal.
> 
> You can add my tested-by if you'd like.

I really appreciate your testing.  Based on the recent
Documentation/maintainer/rebasing-and-merging.rst,  I'm trying not to
rebase patches already staged in linux-next.  Patches are first being
staged in the next-queued-testing branch.

FYI, I just posted a patch that adds IMA appended signature support to
test_kexec_file_load.sh.

thanks,

Mimi
