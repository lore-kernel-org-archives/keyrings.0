From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Wed, 09 Sep 2020 22:44:37 +0000
Subject: Re: [PATCH v2] certs: Add EFI_CERT_X509_GUID support for dbx entries
Message-Id: <0D3BE738-67D5-41DB-B58E-FCD2ECD9A4F0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200909172736.73003-1-eric.snowberg@oracle.com>
 <5074bc5c-8dd4-16d7-2760-3e657b90bfa2@infradead.org>
In-Reply-To: <5074bc5c-8dd4-16d7-2760-3e657b90bfa2@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, dwmw2@infradead.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, herbert@gondor.apana.org.au, davem@davemloft.net, jmorris@namei.org, serge@hallyn.com, nayna@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>, erichte@linux.ibm.com, mpe@ellerman.id.au, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org


> On Sep 9, 2020, at 11:40 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> On 9/9/20 10:27 AM, Eric Snowberg wrote:
>> diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
>> index 38ec7f5f9041..d8f2e0fdfbf4 100644
>> --- a/include/crypto/pkcs7.h
>> +++ b/include/crypto/pkcs7.h
>> @@ -26,11 +26,19 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
>> 				  const void **_data, size_t *_datalen,
>> 				  size_t *_headerlen);
>> 
>> +#ifdef CONFIG_PKCS7_MESSAGE_PARSER
>> /*
>>  * pkcs7_trust.c
>>  */
>> extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
>> 				struct key *trust_keyring);
>> +#else
>> +static inline int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
>> +				       struct key *trust_keyring)
>> +{
>> +	return -ENOKEY;
>> +}
>> +#endif
> 
> Just to be clear, you want to do the #else block when
> CONFIG_PKCS7_MESSAGE_PARSER=m.  Is that correct?
> 
> If so, it might be clearer to use
> 
> #if IS_BUILTIN(CONFIG_PKCS7_MESSAGE_PARSER)
> 

I just added this part to fix a build error when none of the
asymmetrical keys are defined within a config.  I failed to notice
CONFIG_PKCS7_MESSAGE_PARSER could be configured to build as a module
too.  The code I added that uses pkcs7_validate_trust is always 
builtin. Taking this into account, please disregard this patch.  
I will need to solve this a different way.  Thanks for pointing this 
out.
