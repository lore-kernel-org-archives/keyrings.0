Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568641624C0;
	Fri, 28 Aug 2026 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882031; cv=none; b=a+WG4Rm2ST4rvFGq8wEWRj71Ci7u7UO9BcZ8PeT3tTT6ZnXVDIpYO4EB/b0uKdPmmhFC7IdClCTD7/mwlP51Q9iGEPql/yWo/OSfC2/vjha/99V2iRjEE7STlbYUq/HcxBqZ6bk/JUkf7jIprnOPgSVK9d+GXtS09vpyJPbXsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882031; c=relaxed/simple;
	bh=38aD5Z1llzQWEUWRyxWZi7A1+PE7kLPT2aOFcM0IotQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPQlE0v2V8iEZcxvnnuI5z87M+Wj/Z2ZntrVTvtF6HE4gJ7493BZ573Inlt5cSumb8dVedqGGabbqz0WzVXJjEn9SthHc+aOc/xrMqSe82wbhrqKCUmtYeB2uF++NiavJrmXiWD77qJ+isSVm7ZTPX7i3T7bVJPUtWWGK6ji7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlgepBem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlgepBem"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5C1C01F000E9;
	Fri, 28 Aug 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882029;
	bh=J+KiUj8K3vNiZHvNshThClNRWFPlWXgKFpM7uZcUsD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GlgepBemnFBZ92mm4s14pC/+w9mtI/vrlPJRxHHweeaT+vhA/T7eC9o9MK0BwinFa
	 UZBDWFVGSbJWKqSwAcCDyvhrZW6ZBcjuPwUvSyRdoalur6xtpNjRyYfsSdJBuu+oxu
	 QdCIaBrzn7gWSxwFPWdoon84aC8pOgJzJYdmmz1AVNMNVYojxV2mFajJ5ksieDqDd+
	 vU7A+i+V5MBwD23IpQZC+oJ5p1KSxKCa1RbYSy2N7csyTI7YK1OBZNyaNL1Uxqm+oh
	 fR758X+ock4GFCeJlLLeyScgvNCrNKpTTlhxAIB4sGoQ8CeOSlPMHLAw7IohGFwQ4U
	 DYgq+Q8Fos1BQ==
Date: Fri, 28 Aug 2026 04:53:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@polito.it>,
	David Safford <safford@watson.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Francis Perron <francis@akrites.dev>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Akrites SIRT <sirt@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	Cen Zhang <cenzhang@microsoft.com>
Subject: Re: [PATCH v2] KEYS: encrypted: fix integer overflow of datablob_len
Message-ID: <apDqKZ1vbdWRQ6r-@kernel.org>
References: <20260826154456.85974-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826154456.85974-1-blbllhy@gmail.com>

On Wed, Aug 26, 2026 at 11:44:56AM -0400, Cen Zhang (Microsoft Security FORGE Labs) wrote:
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@microsoft.com>
> 
> The datablob_len field in struct encrypted_key_payload and the local
> variable in encrypted_key_alloc() are declared as unsigned short, which
> has a maximum value of 65535. The datablob_len is computed as:
> 
>   format_len + 1 + strlen(master_desc) + 1 + strlen(datalen) + 1
>   + ivsize + 1 + encrypted_datalen
> 
> An attacker can create an encrypted key with a very long datalen string
> (e.g., 32756 characters of leading zeros followed by "4096", which
> kstrtol() happily parses as 4096), and then update it with a very long
> master_desc string (~32760 characters). The combined lengths exceed
> 65535, causing the unsigned short to silently wrap around. This results
> in a grossly undersized kzalloc() allocation, and the subsequent
> memcpy() in __ekey_init() writes ~32KB past the end of the buffer,
> corrupting adjacent slab objects.
> 
> Fix this by:
> 1. Using check_add_overflow() to calculate datablob_len directly into
>    its existing unsigned short destination.
> 2. Checking the total payload length the same way before passing it to
>    key_payload_reserve(), since key->datalen is also unsigned short.
> 3. Using kzalloc_flex() to allocate encrypted_key_payload together with
>    its trailing payload_data[] array.
> 
> Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@microsoft.com>
> Signed-off-by: Francis Perron (Akrites SIRT) <francis@akrites.dev>

Please remove "(Microsoft Security FORGE Labs)" and "(Akrites SIRT)"

> ---
> Changes in v2:
> - Keep datablob_len unchanged and check both unsigned short bounds with
>   check_add_overflow().
> - Use kzalloc_flex() for the trailing payload_data[] array.
> - Correct the attribution and sign-off trailers.
> 
> The initial version was discussed off-list and is not publicly archived.
> 
>  security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 59cb77b237b3..e07092ea301a 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -19,6 +19,7 @@
>  #include <linux/parser.h>
>  #include <linux/string.h>
>  #include <linux/err.h>
> +#include <linux/overflow.h>
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/encrypted-type.h>
> @@ -579,6 +580,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  {
>  	struct encrypted_key_payload *epayload = NULL;
>  	unsigned short datablob_len;
> +	unsigned short payload_totallen;
>  	unsigned short decrypted_datalen;
>  	unsigned short payload_datalen;
>  	unsigned int encrypted_datalen;
> @@ -632,16 +634,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  
>  	encrypted_datalen = roundup(decrypted_datalen, blksize);
>  
> -	datablob_len = format_len + 1 + strlen(master_desc) + 1
> -	    + strlen(datalen) + 1 + ivsize + 1 + encrypted_datalen;
> +	if (check_add_overflow(format_len + 1 + strlen(master_desc) + 1
> +			       + strlen(datalen) + 1 + ivsize + 1,
> +			       encrypted_datalen, &datablob_len))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (check_add_overflow(datablob_len,
> +			       payload_datalen + HASH_SIZE + 1,
> +			       &payload_totallen))
> +		return ERR_PTR(-EINVAL);
>  
> -	ret = key_payload_reserve(key, payload_datalen + datablob_len
> -				  + HASH_SIZE + 1);
> +	ret = key_payload_reserve(key, payload_totallen);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> -	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
> -			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
> +	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
> +				GFP_KERNEL);
>  	if (!epayload)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.55.0

BR, Jarkko
