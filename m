From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Wed, 25 Oct 2017 15:37:33 +0000
Subject: Re: [PATCH] tpm: Move Linux RNG connection to hwrng
Message-Id: <CANc+2y6euhcMv7FV=1_6NzqQUxDX5f_U4ZOF7EZVGS_j5=B6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171024184235.GC1806@obsidianresearch.com> <CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
 <20171025151859.GB15557@obsidianresearch.com>
In-Reply-To: <20171025151859.GB15557@obsidianresearch.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, open list <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, James Morris <james.l.morris@oracle.com>, Matt Mackall <mpm@selenic.com>, David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>

Hi Jason,

On 25 October 2017 at 20:48, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Wed, Oct 25, 2017 at 08:15:09PM +0530, PrasannaKumar Muralidharan
> wrote:
>
>> > +static int tpm_add_hwrng(struct tpm_chip *chip)
>> > +{
>> > +       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>> > +               return 0;
>>
>> Can #ifndef CONFIG_HW_RANDOM_TPM be used instead? That way an if
>> condition can be avoided.
>
> Generally speaking IS_ENABLED is prefered over #ifdef as it reduces the
> set of compilation combinations.

Oh okay. No issues then.

Regards,
PrasannaKumar
