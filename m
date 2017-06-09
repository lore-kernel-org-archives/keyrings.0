From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 09 Jun 2017 10:27:03 +0000
Subject: Re: [PATCH v2 0/6] Appended signatures support for IMA appraisal
Message-Id: <87d1adihhk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
In-Reply-To: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org
Cc: Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, James Morris <james.l.morris@oracle.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-ima-devel@lists.sourceforge.net, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.

I still want you to implement arch_kexec_kernel_verify_sig() as well :)

cheers
