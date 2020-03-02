From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 02 Mar 2020 12:52:19 +0000
Subject: Re: [PATCH v3] KEYS: reaching the keys quotas correctly
Message-Id: <7c44c7c9745d81361f3d38206e0a68095a06c171.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
To: keyrings@vger.kernel.org

On Fri, 2020-02-28 at 12:41 +0800, Yang Xu wrote:
> Currently, when we add a new user key, the calltrace as below:
> 
> add_key()
>   key_create_or_update()
>     key_alloc()
>     __key_instantiate_and_link
>       generic_key_instantiate
>         key_payload_reserve
>           ......
> 
> Since commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly"),
> we can reach max bytes/keys in key_alloc, but we forget to remove this
> limit when we reserver space for payload in key_payload_reserve. So we
> can only reach max keys but not max bytes when having delta between plen
> and type->def_datalen. Remove this limit when instantiating the key, so we
> can keep consistent with key_alloc.
> 
> Also, fix the similar problem in keyctl_chown_key().
> 
> Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
> Fixes: a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
