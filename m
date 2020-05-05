From: Will Deacon <will@kernel.org>
Date: Tue, 05 May 2020 09:19:59 +0000
Subject: Re: [RESEND] security/keys: remove possessor verify after key permission check
Message-Id: <20200505091958.GD16980@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

On Thu, Apr 30, 2020 at 10:34:03AM +0300, Alexey Krasikov wrote:
> In security/keys/keyctl.c: keyctl_read_key() after key_permission() check
> is called is_key_possessed(). According to the current logic, if the caller is
> a possessor, then it can read the key regardless of whether it has rights
> to do so.
> 
> if I remove the possessor read rights:
>     keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_SETATTR));
> the calling process will still be able to read the key if it is possessor.
> 
> In other words, if the possessor doesn't have read rights, it doesn't matter.
> 
> ---
> I may be misunderstanding the logic behind it, but here's the patch to
> stir the discussion.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  security/keys/keyctl.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Hmm, looks like this still didn't make it to the keyrings@ list :(

On the off-chance that my reply /does/ make it, I've left the whole of the
patch intact below. Please can somebody have a look?

Will

--->8

> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index 5e01192e222a..61e53c6b5adb 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -845,22 +845,9 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
>  
>  	/* see if we can read it directly */
>  	ret = key_permission(key_ref, KEY_NEED_READ);
> -	if (ret = 0)
> -		goto can_read_key;
> -	if (ret != -EACCES)
> +	if (ret != 0)
>  		goto key_put_out;
>  
> -	/* we can't; see if it's searchable from this process's keyrings
> -	 * - we automatically take account of the fact that it may be
> -	 *   dangling off an instantiation key
> -	 */
> -	if (!is_key_possessed(key_ref)) {
> -		ret = -EACCES;
> -		goto key_put_out;
> -	}
> -
> -	/* the key is probably readable - now try to read it */
> -can_read_key:
>  	if (!key->type->read) {
>  		ret = -EOPNOTSUPP;
>  		goto key_put_out;
> -- 
> 2.17.1
> 
