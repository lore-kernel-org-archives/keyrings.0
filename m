Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD34B95BB;
	Mon, 28 Sep 2026 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596736; cv=none; b=j+6qrp6RAj3ZnkXxAnIEkKj5NZ70nr/gsotIiJtJAqpPRBe6126iECWGpf0fitFrNorojqcgwZ2FJYEm3lcvflj2vukxKP3GqfjaWB7vWk/0MLcjmjwRmKebP5kFjSbVJ42j3nf2lE9Bf0Ne2bZ2ZxrLpmJa1V5SV97byROaCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596736; c=relaxed/simple;
	bh=ekvRhtO90bqV2FfI8e4HIlD3mlaI0So/2yQ5E4G17jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sn+iX4XJyms4ESOObFt35b1QiWTyfBIsSRM5BiZqlHmcx9QWF4fpxvWeo4persR8fIAM7tuMuxf7WLmJlVn7Qg+Z510D0ItCOGfvfJFAZAmP9whhrVb5gNalOFfPET/L8Bmjd+NvUM4hQ6IT2eJ1968R3FVX87mib2oF6EIEhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i6wwXSCk; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i6wwXSCk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oKCFLwVE40G9JXDKK/zKyWnWBxKb+0ihAxkPTgPLbOY=;
	b=i6wwXSCkIEIgMmwF/wHRY1TXPMujmNDJUNJ8L7zr4In81DcD5mxF7lwzcJHzl2uS3Wkl9L4cL
	uwbcz2PMX7BxpY0zyBqG7zYTnAf4jvM3UvLPe7CxKqb4qqOAM99KCu3LFImkBv5hri8KmXc+QBh
	9aew8xKDk70wyy+BF5iIiZA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4htffR3FrCzRhQs;
	Mon, 28 Sep 2026 19:46:39 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B79F4057F;
	Mon, 28 Sep 2026 19:58:44 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 28 Sep 2026 19:58:43 +0800
Message-ID: <89d1aecd-d4df-47e0-9b5a-9c5b6830aeb5@huawei.com>
Date: Mon, 28 Sep 2026 19:58:42 +0800
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: keys: Fix comment of
 search_process_keyrings_rcu()
To: Thomas Huth <thuth@redhat.com>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
CC: <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260928072024.91664-1-thuth@redhat.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260928072024.91664-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/28 15:20, Thomas Huth 写道:
> search_my_process_keyrings() has been renamed to search_cred_keyrings_rcu()
> in commit e59428f721ee ("keys: Move the RCU locks outwards from the keyring
> search functions"), but one spot has been missed in a comment.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  security/keys/process_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index a63c46bb2d148..570c131d90d5c 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -528,7 +528,7 @@ key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
>  
>  /*
>   * Search the process keyrings attached to the supplied cred for the first
> - * matching key in the manner of search_my_process_keyrings(), but also search
> + * matching key in the manner of search_cred_keyrings_rcu(), but also search
>   * the keys attached to the assumed authorisation key using its credentials if

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>   * one is available.
>   *

-- 
Best regards,
Jinjie

