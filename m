From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Fri, 09 Jun 2017 21:19:19 +0000
Subject: Re: [PATCH v2 0/6] Appended signatures support for IMA appraisal
Message-Id: <87efusyi3s.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com> <87d1adihhk.fsf@concordia.ellerman.id.au>
In-Reply-To: <87d1adihhk.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-security-module@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, James Morris <james.l.morris@oracle.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-ima-devel@lists.sourceforge.net, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> On the OpenPOWER platform, secure boot and trusted boot are being
>> implemented using IMA for taking measurements and verifying signatures.
>
> I still want you to implement arch_kexec_kernel_verify_sig() as well :)

Yes, I will implement it! We are still working on loading the public
keys for kernel signing from the firmware into a kernel keyring, so
there's not much point in implementing arch_kexec_kernel_verify_sig
without having that first.

The same problem also affects IMA: even with these patches, new code
still neededs to be added to make IMA use the platform keys for kernel
signature verification.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

