From: Alex Dewar <alex.dewar90@gmail.com>
Date: Fri, 11 Sep 2020 16:09:20 +0000
Subject: Re: [PATCH] security: keys: Use kvfree_sensitive in a few places
Message-Id: <f0ac74e6-6e33-e736-494c-001e85327fdb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200911114400.82207-1-alex.dewar90@gmail.com>
 <f97076d2-de8a-4600-ee81-4cf4fcdc3ec1@linux.com>
In-Reply-To: <f97076d2-de8a-4600-ee81-4cf4fcdc3ec1@linux.com>
To: efremov@linux.com
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-09-11 17:05, Denis Efremov wrote:
> Hi,
>
> same patch
>
> https://lkml.org/lkml/2020/8/27/168
>
> Thanks,
> Denis
Ah ok. Sorry for the noise!
>
> On 9/11/20 2:44 PM, Alex Dewar wrote:
>> In big_key.c, there are a few places where memzero_explicit + kvfree is
>> used. It is better to use kvfree_sensitive instead, which is more
>> readable and also prevents the compiler from eliding the call to
>> memzero_explicit. Fix this.
>>
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
>>   security/keys/big_key.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
>> index 691347dea3c1..d17e5f09eeb8 100644
>> --- a/security/keys/big_key.c
>> +++ b/security/keys/big_key.c
>> @@ -121,8 +121,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>>   		*path = file->f_path;
>>   		path_get(path);
>>   		fput(file);
>> -		memzero_explicit(buf, enclen);
>> -		kvfree(buf);
>> +		kvfree_sensitive(buf, enclen);
>>   	} else {
>>   		/* Just store the data in a buffer */
>>   		void *data = kmalloc(datalen, GFP_KERNEL);
>> @@ -140,8 +139,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>>   err_enckey:
>>   	kfree_sensitive(enckey);
>>   error:
>> -	memzero_explicit(buf, enclen);
>> -	kvfree(buf);
>> +	kvfree_sensitive(buf, enclen);
>>   	return ret;
>>   }
>>   
>> @@ -273,8 +271,7 @@ long big_key_read(const struct key *key, char *buffer, size_t buflen)
>>   err_fput:
>>   		fput(file);
>>   error:
>> -		memzero_explicit(buf, enclen);
>> -		kvfree(buf);
>> +		kvfree_sensitive(buf, enclen);
>>   	} else {
>>   		ret = datalen;
>>   		memcpy(buffer, key->payload.data[big_key_data], datalen);
>>
