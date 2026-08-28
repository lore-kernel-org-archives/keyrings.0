Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8918C02E;
	Fri, 28 Aug 2026 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882114; cv=none; b=DaDDhvAOVNo4II6zIe7J9DmTrwCthSkg2SnyQVgEmwxVDUD4qDipu5DO4LANYZ/iGYB8MjFYfz7sELyUCibTiZspvmzt+rkcslzrwGjgWYF7eGVKJaFQWgUkOs5j060fV+q+OpcNSx9DZ0VgppYa/RwNfojdxjfId8O4Z/oGAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882114; c=relaxed/simple;
	bh=HOi1EJIHIkS1hcIW1kmW1WaIUvnW86l1JshGs/YxUQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9KnAP6NzL3t5+UVe9wnoklh1FroQkLV0bBfpWC25ep0G4g1ePDsAdS8/xIoMB8c0dfyZyciISqlP0g32PoxHt8f7GJRTrhboL5eAZWJXVtMwF/9sSXroRLmaS6RfBe6qBbneap8uKKfrbCS7+xbHq00WzBsMDptCOsc+qbvYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gajaH5hS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gajaH5hS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F3E181F000E9;
	Fri, 28 Aug 2026 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882112;
	bh=Tv3ZqTtgZ264J1wiziBzoGlZWfmFHd92dq+9ueZK8Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gajaH5hS7/I7JMfV8QA730m+Op0UEOhWsXNKnU1U8aKzcavdSR4dlXS4bYxzARTzM
	 BcH1JDw7vKIscUAspkSsLDCvaFkt9jEL2QcB1cfs2KJTkAiWMEjX4CHjzilW98n3qY
	 qNBR9it3x6+UY0fNAQ81OqKOibv0dQgD58+yZTyWKil3GT7sLVlklSXMtk3fbPuBwJ
	 O64MOQaKTK+LEPfhoX8N/WtS/zVz+zAJ2cf7IxZqC7A290uDiUIRz1ZTNsb8JI5njP
	 XumaGfvjvmE/QmUmEKw0LVofM5qpKraMog2BaYkob0Q21Zok34Ble6xBX8eAM9rJGV
	 CIz/CDpkjwaYQ==
Date: Fri, 28 Aug 2026 04:55:08 +0300
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
Message-ID: <apDqfGUFiZv_2Gpv@kernel.org>
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
> ---
> Changes in v2:
> - Keep datablob_len unchanged and check both unsigned short bounds with
>   check_add_overflow().
> - Use kzalloc_flex() for the trailing payload_data[] array.
> - Correct the attribution and sign-off trailers.
> 
> The initial version was discussed off-list and is not publicly archived.

I have no recollection of being part of this discussion.

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
