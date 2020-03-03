From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 03 Mar 2020 04:33:37 +0000
Subject: Re: [PATCH v3] KEYS: reaching the keys quotas correctly
Message-Id: <8cc77e68-244e-3ac8-dea6-edc51cf372df@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
To: keyrings@vger.kernel.org



on 2020/03/03 12:17, Eric Biggers wrote:
> On Fri, Feb 28, 2020 at 12:41:51PM +0800, Yang Xu wrote:
>>
>> Subject: Re: [PATCH v3] KEYS: reaching the keys quotas correctly
> 
> The subject should be in imperative tense, like
> "KEYS: reach the keys quotas correctly"
Sound reasonable, I think maintainer can change this when merged this patch.

Best Regards
Yang Xu
> 
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
>> Also, fix the similar problem in keyctl_chown_key().
>>
>> Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
>> Fixes: a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
>> Cc: Eric Biggers <ebiggers@google.com>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> 
> Otherwise this looks fine.  Thanks!
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> - Eric
> 
> 
