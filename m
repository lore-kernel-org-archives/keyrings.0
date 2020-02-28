From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 28 Feb 2020 03:37:35 +0000
Subject: Re: [PATCH v2] KEYS: reaching the keys quotas(max_bytes) correctly
Message-Id: <0829856a-6caf-4e03-9aaa-b41f720c9cdb@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1582857177-29093-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1582857177-29093-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
To: keyrings@vger.kernel.org



on 2020/02/28 11:30, Eric Biggers wrote:
> On Fri, Feb 28, 2020 at 10:32:57AM +0800, Yang Xu wrote:
>> Currently, when we add a new user key, the calltrace as below:
>>
>> add_key()
>>    key_create_or_update()
>>      key_alloc()
>>      __key_instantiate_and_link
>>        generic_key_instantiate
>>          key_payload_reserve
>>            ......
>>
>> Since commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly"),
>> we can reach max bytes/keys in key_alloc, but we forget to remove this
>> limit when we reserver space for payload in key_payload_reserve. So we
>> can only reach max keys but not max bytes when having delta between plen
>> and type->def_datalen. Remove this limit when instantiating the key, so we
>> can keep consistent with key_alloc.
>>
>> Fixes: a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
>> Cc: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   security/keys/key.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/keys/key.c b/security/keys/key.c
>> index 718bf7217420..e959b3c96b48 100644
>> --- a/security/keys/key.c
>> +++ b/security/keys/key.c
>> @@ -382,7 +382,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
>>   		spin_lock(&key->user->lock);
>>   
>>   		if (delta > 0 &&
>> -		    (key->user->qnbytes + delta >= maxbytes ||
>> +		    (key->user->qnbytes + delta > maxbytes ||
>>   		     key->user->qnbytes + delta < key->user->qnbytes)) {
>>   			ret = -EDQUOT;
>>   		}
> 
> This looks good, but I see that both of us forgot to update keyctl_chown_key().
> Can you handle that too?
> 
Of course. I will handle this together.
> You could also use two Fixes tags:
> 
>      Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
>      Fixes: a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
> 
> ... to make it clearer that this is fixing an incomplete fix for the original
> bug, as opposed to fixing a regression.
OK. This is more clearer.
Thanks for your comment.

Best Reagrds
Yang Xu
> 
> - Eric
> 
> 
