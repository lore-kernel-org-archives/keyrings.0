From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 04 Jul 2019 06:45:07 +0000
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
Message-Id: <87k1cyl2mk.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190628021934.4260-1-bauerman@linux.ibm.com> <1561991934.4067.17.camel@linux.ibm.com>
In-Reply-To: <1561991934.4067.17.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Thu, 2019-06-27 at 23:19 -0300, Thiago Jung Bauermann wrote:
>> Hello,
>> 
>> This version is essentially identical to the last one.
>> 
>> It is only a rebase on top of today's linux-integrity/next-queued-testing,
>> prompted by conflicts with Prakhar Srivastava's patches to measure the
>> kernel command line. It also drops two patches that are already present in
>> that branch.
>
> Thanks, Thiago.  These patches are now in next-queued-testing waiting
> for some additional reviews/acks.

Thank you very much, Mimi! Now I think I'm only missing acks for the
PKCS#7 changes in patches 2 and 3, and an ack for the s390 changes in
patch 1.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
