From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 01 Feb 2019 17:33:30 +0000
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()
Message-Id: <20190201173330.GA5522@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <20190201133949.GE17861@linux.intel.com>
 <20190201134151.GF17861@linux.intel.com>
 <1549031589.6993.7.camel@linux.ibm.com>
In-Reply-To: <1549031589.6993.7.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, christophe.ricard@gmail.com
Cc: Roberto Sassu <roberto.sassu@huawei.com>, david.safford@ge.com, monty.wiseman@ge.com, matthewgarrett@google.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com

On Fri, Feb 01, 2019 at 09:33:09AM -0500, Mimi Zohar wrote:
> Thanks!  I just finished compiling, rebooting, and verifying the IMA
> boot-aggregate matches.
>=20
> While compiling, I saw some messages that "TPM_BUFSIZE is redefined"
> for tpm_i2c_infineon, tpm_i2c_nuvoton, and st33zp24. =A0Didn't look to
> see if this is a result of this patch set or not.
>=20
> The IMA boot-aggregate matches the PCRs.
>=20
> Tested-by: Mimi Zohar <zohar@linux.ibm.com> (on x86 for TPM 1.2 & PTT
> TPM 2.0)

Thank you.

I found the reason for that warning. It is redefined, for reason unknown
to me in drivers/char/tpm/st33zp24/st33zp24.h (commit bf38b8710892).

I'll post a fix to that commit ASAP. After that commit has been applied
I can apply Roberto's patches.

/Jarkko
