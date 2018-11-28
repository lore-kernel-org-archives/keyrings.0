From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 28 Nov 2018 23:19:41 +0000
Subject: Re: [PATCH v2] KEYS: always initialize keyring_index_key::desc_len
Message-Id: <20181128231940.GB131170@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <000000000000a722550577796543@google.com>
 <20181103015854.7380-1-ebiggers@kernel.org>
In-Reply-To: <20181103015854.7380-1-ebiggers@kernel.org>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Fri, Nov 02, 2018 at 06:58:54PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> syzbot hit the 'BUG_ON(index_key->desc_len = 0);' in __key_link_begin()
> called from construct_alloc_key() during sys_request_key(), because the
> length of the key description was never calculated.
> 
> The problem is that we rely on ->desc_len being initialized by
> search_process_keyrings(), specifically by search_nested_keyrings().
> But, if the process isn't subscribed to any keyrings that never happens.
> 
> Fix it by always initializing keyring_index_key::desc_len as soon as the
> description is set, like we already do in some places.
> 
> The following program reproduces the BUG_ON() when it's run as root and
> no session keyring has been installed.  If it doesn't work, try removing
> pam_keyinit.so from /etc/pam.d/login and rebooting.
> 
>     #include <stdlib.h>
>     #include <unistd.h>
>     #include <keyutils.h>
> 
>     int main(void)
>     {
>             int id = add_key("keyring", "syz", NULL, 0, KEY_SPEC_USER_KEYRING);
> 
>             keyctl_setperm(id, KEY_OTH_WRITE);
>             setreuid(5000, 5000);
>             request_key("user", "desc", "", id);
>     }
> 
> Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Cc: <stable@vger.kernel.org> # v3.13+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: In proc_keys_show(), assign index_key directly
> 
>  security/keys/keyring.c          | 4 +---
>  security/keys/proc.c             | 3 +--
>  security/keys/request_key.c      | 1 +
>  security/keys/request_key_auth.c | 2 +-
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 41bcf57e96f21..99a55145ddcd2 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -661,9 +661,6 @@ static bool search_nested_keyrings(struct key *keyring,
>  	BUG_ON((ctx->flags & STATE_CHECKS) = 0 ||
>  	       (ctx->flags & STATE_CHECKS) = STATE_CHECKS);
>  
> -	if (ctx->index_key.description)
> -		ctx->index_key.desc_len = strlen(ctx->index_key.description);
> -
>  	/* Check to see if this top-level keyring is what we are looking for
>  	 * and whether it is valid or not.
>  	 */
> @@ -914,6 +911,7 @@ key_ref_t keyring_search(key_ref_t keyring,
>  	struct keyring_search_context ctx = {
>  		.index_key.type		= type,
>  		.index_key.description	= description,
> +		.index_key.desc_len	= strlen(description),
>  		.cred			= current_cred(),
>  		.match_data.cmp		= key_default_cmp,
>  		.match_data.raw_data	= description,
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 5af2934965d80..d38be9db2cc07 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -166,8 +166,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
>  	int rc;
>  
>  	struct keyring_search_context ctx = {
> -		.index_key.type		= key->type,
> -		.index_key.description	= key->description,
> +		.index_key		= key->index_key,
>  		.cred			= m->file->f_cred,
>  		.match_data.cmp		= lookup_user_key_possessed,
>  		.match_data.raw_data	= key,
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index 114f7408feee6..7385536986497 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -545,6 +545,7 @@ struct key *request_key_and_link(struct key_type *type,
>  	struct keyring_search_context ctx = {
>  		.index_key.type		= type,
>  		.index_key.description	= description,
> +		.index_key.desc_len	= strlen(description),
>  		.cred			= current_cred(),
>  		.match_data.cmp		= key_default_cmp,
>  		.match_data.raw_data	= description,
> diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
> index 424e1d90412ea..6797843154f03 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -246,7 +246,7 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
>  	struct key *authkey;
>  	key_ref_t authkey_ref;
>  
> -	sprintf(description, "%x", target_id);
> +	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
>  
>  	authkey_ref = search_process_keyrings(&ctx);
>  
> -- 
> 2.19.1
> 

Ping.  David, are you planning to apply this?

- Eric
