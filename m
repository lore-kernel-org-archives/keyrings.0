From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Tue, 28 May 2019 19:14:30 +0000
Subject: Re: [PATCH v10 12/12] ima: Store the measurement again when appraising a modsig
Message-Id: <871s0i75nt.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-13-bauerman@linux.ibm.com> <1559052560.4090.14.camel@linux.ibm.com>
In-Reply-To: <1559052560.4090.14.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>


Mimi Zohar <zohar@linux.ibm.com> writes:

> Hi Thiago,
>
> On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
>> If the IMA template contains the "modsig" or "d-modsig" field, then the
>> modsig should be added to the measurement list when the file is appraised.
>>
>> And that is what normally happens, but if a measurement rule caused a file
>> containing a modsig to be measured before a different rule causes it to be
>> appraised, the resulting measurement entry will not contain the modsig
>> because it is only fetched during appraisal. When the appraisal rule
>> triggers, it won't store a new measurement containing the modsig because
>> the file was already measured.
>>
>> We need to detect that situation and store an additional measurement with
>> the modsig. This is done by adding an IMA_MEASURE action flag if we read a
>> modsig and the IMA template contains a modsig field.
>
> With the new per policy rule "template" support being added, this
> patch needs to be modified so that the per policy "template" format is
> checked. ima_template_has_modsig() should be called with the
> template_desc being used.

Right. Thanks for point out what needs to be done. After rebasing on top
of Matthew Garret's "IMA: Allow profiles to define the desired IMA
template" patch I changed ima_template_has_modsig() to check the
template_desc obtained from process_measurement().

--
Thiago Jung Bauermann
IBM Linux Technology Center
