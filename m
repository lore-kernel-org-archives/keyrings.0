From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 29 May 2020 08:15:27 +0000
Subject: Re: [RFC PATCH 0/1] security/keys: remove possessor verify after key
Message-Id: <20200529081527.GC1376838@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

On Fri, May 29, 2020 at 09:00:39AM +0300, Alexey Krasikov wrote:
> During the test I discovered that not all access rights restrictions working
> correct. Examples:
> 
> Remove possessor write right:
> 
> $ KEYID=$(keyctl add user john smith @u)
> $ keyctl describe $KEYID
> 47831201: alswrv-----v------------  1000  1000 user: john
> $ keyctl print $KEYID
> smith
> $ keyctl update $KEYID dohn
> $ keyctl print $KEYID
> dohn
> $ keyctl setperm $KEYID 0x3b000000
> $ keyctl describe $KEYID
> 47831201: als-rv------------------  1000  1000 user: john
> $ keyctl update $KEYID dohn
> keyctl_update: Permission denied
> $ keyctl print $KEYID
> dohn
> 
> That OK. So, next
> Remove possessor set attributes right:
> 
> $ keyctl setperm $KEYID 0x1f000000
> $ keyctl describe $KEYID
> 47831201: -lswrv------------------  1000  1000 user: john
> $ keyctl setperm $KEYID 0x3f000000
> keyctl_update: Permission denied
> 
> That OK. So, next
> Remove possessor read right:
> 
> $ keyctl unlink $KEYID
> 1 links removed
> $ KEYID=$(keyctl add user john smith @u)
> $ keyctl describe $KEYID
> 5927639: alswrv-----v------------  1000  1000 user: john
> $ keyctl setperm $KEYID 0x3d000000
> $ keyctl describe $KEYID
> 5927639: alsw-v-----v------------  1000  1000 user: john
> $ keyctl print $KEYID
> smith
> 
> How's that? I removed the right to read, but the possessor continues
> to read it!
> 
> I opened the read function code and saw the following:
> 
> ```
>   /* see if we can read it directly */
>   ret = key_permission(key_ref, KEY_NEED_READ); /* OK, we returned error */
>                                                 /* read access */
>   if (ret = 0) /* skip that */
>     goto can_read_key;
>   if (ret != -EACCES) /* skip that */
>     goto key_put_out;
> 
>   /* we can't; see if it's searchable from this process's keyrings
>    * - we automatically take account of the fact that it may be
>    *   dangling off an instantiation key
>    */
>   if (!is_key_possessed(key_ref)) { /* If we possessor = can read */
>     ret = -EACCES;
>     goto key_put_out;
>   }
> 
>   /* the key is probably readable - now try to read it */
> can_read_key:
> ```
> Why can we read the key, if we don't have rights for doing this?
> 
> Alexey Krasikov (1):
>   security/keys: remove possessor verify after key permission check
> 
>  security/keys/keyctl.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> -- 
> 2.17.1
> 

Thank you for the legit examples and effort in general. Looking into
this with time on Monday. Today I have to get unfortunately SGX patch
set out.

/Jarkko
