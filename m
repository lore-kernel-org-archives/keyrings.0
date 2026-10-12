Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB7493640;
	Mon, 12 Oct 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817318; cv=none; b=G3u1gAxnOk7mEWCskiHvgZHsjPeR7nMBKpgukyqasHwhGNETN5QayB8nu18CfwKrU80iyPFsHN6t33XM4iT4SbL2WVtH9+W506m8nO2W5eIVWQjfPBY0C24WEAMWX/euOF5YvmTNE9aWOrZv8XHlyHy3rhLDnJtUScTrplueUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817318; c=relaxed/simple;
	bh=0aPfQP/QJSB6xeoNXFyrgRRg7Vz0m8LnDB6K4n4MmLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/Ny2yISyagWnEE66/rCbzO+UzvnchwZ2Tj1Mvq3QJf6jjvJ29Lo0vvDe3BTSX2wDqQSQuBKotPx9Az0UiCKIQ6sTxZV82NLdnLaevsZBeDlLVrHMflHxd/xurpGsJq9AyUJtvevWeMYYFUb8PvlKacFgWeIOydphyvsTgcrb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaL9Vxn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaL9Vxn5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 846961F0089B;
	Mon, 12 Oct 2026 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791817317;
	bh=6NhGzOAqAfUDsaEmAU5oafNZ30ek+OVNIpVslt/snps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aaL9Vxn5rdLvZ28/VpHjL1+gGG7U1k2BIgndZ5U9AVVb3qFoUAtQGmz9WnCWDQqCI
	 QWY8UKzI8pS72ZwqaQGOBJu2RlMA6XiIq6jKi/3/WPaCr3H68ALcyTBl76kyNDP920
	 E6AxtsBVlbHfDoLOjkrAYpm+JaqjdHR8uYpby5UBC6NC0MZNCXjvqo8VnNfXmXpXmA
	 JX/oq6i+RGW51aoY5ryIrllx3n8DVTkW+l5MQ0yayvPB5ea4HiY8ta7Yd4JNCQcpzv
	 pxmg3WaLWsvN9BWciA7bT/izJOJvh/MDwd2rrKb0iwAaXlTWfUZRDa+cWvP9NG1b9I
	 yKpyKh/PKu8hQ==
Date: Mon, 12 Oct 2026 18:01:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
Message-ID: <asz2YfhterfAVIDH@kernel.org>
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org>
 <aszalro6U6BFO_D3@kernel.org>
 <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
 <CAFRLqsU7w=ctKeAv5FQwxcPVbdWO7EjC3WmE1JXywe_JWWY+gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFRLqsU7w=ctKeAv5FQwxcPVbdWO7EjC3WmE1JXywe_JWWY+gQ@mail.gmail.com>

On Mon, Oct 12, 2026 at 09:33:06PM +0800, Cen Zhang wrote:
> Hi Jarkko,
> 
> Sorry for the previous email — the line wrapping got a bit messy on my
> side. Hope it was still readable :).

All cool.

> 
> Best regards,
> Cen

Br, Jarkko

