From: Jordan Hand <jorhand@linux.microsoft.com>
Date: Mon, 26 Aug 2019 22:46:57 +0000
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
Message-Id: <9682b5d0-1634-2dd0-2cbb-eb1fa8ba7423@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
In-Reply-To: <20190628021934.4260-1-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>

On 6/27/19 7:19 PM, Thiago Jung Bauermann wrote:
> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.
> Since the kernel image on Power servers is an ELF binary, kernels are
> signed using the scripts/sign-file tool and thus use the same signature
> format as signed kernel modules.
> 
> This patch series adds support in IMA for verifying those signatures.
> It adds flexibility to OpenPOWER secure boot, because it allows it to boot
> kernels with the signature appended to them as well as kernels where the
> signature is stored in the IMA extended attribute.

I know this is pretty late, but I just wanted to let you know that I
tested this patch set on x86_64 with QEMU.

That is, I enrolled a key to _ima keyring, signed my kernel and modules
with appended signatures (with scripts/sign-file), set the IMA policy to
appraise and measure my kernel and modules. Also tested kexec appraisal.

You can add my tested-by if you'd like.

-Jordan
