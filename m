From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Tue, 28 May 2019 19:27:17 +0000
Subject: Re: [PATCH v10 09/12] ima: Implement support for module-style appended signatures
Message-Id: <87y32q5qi2.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-10-bauerman@linux.ibm.com> <1557835765.4139.9.camel@linux.ibm.com>
In-Reply-To: <1557835765.4139.9.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>


Mimi Zohar <zohar@linux.ibm.com> writes:

> Hi Thiago,
>
> On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
>> 
>> @@ -326,6 +356,10 @@ int ima_appraise_measurement(enum ima_hooks func,
>> case INTEGRITY_UNKNOWN:
>> break;
>> case INTEGRITY_NOXATTRS:/* No EVM protected xattrs. */
>> +/* It's fine not to have xattrs when using a modsig. */
>> +if (try_modsig)
>> +break;
>> +/* fall through */
>> case INTEGRITY_NOLABEL:/* No security.evm xattr. */
>> cause = "missing-HMAC";
>> goto out;
>> @@ -340,6 +374,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>> rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
>>  &cause);
>> 
>> +/*
>> + * If we have a modsig and either no imasig or the imasig's key isn't
>> + * known, then try verifying the modsig.
>> + */
>> +if (status != INTEGRITY_PASS && try_modsig &&
>> + (!xattr_value || rc = -ENOKEY))
>> +rc = modsig_verify(func, modsig, &status, &cause);
>
> EVM protects other security xattrs, not just security.ima, if they
> exist. As a result, evm_verifyxattr() could pass based on the other
> security xattrs.

Indeed! It doesn't make sense to test for status != INTEGRITY_PASS here.
Not sure what I was thinking. Thanks for spotting it. With your other
comments about this if clause, this code now reads:

	/*
	 * If we have a modsig and either no imasig or the imasig's key isn't
	 * known, then try verifying the modsig.
	 */
	if (try_modsig &&
	    (!xattr_value || xattr_value->type = IMA_XATTR_DIGEST_NG ||
	     rc = -ENOKEY))
		rc = modsig_verify(func, modsig, &status, &cause);

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
