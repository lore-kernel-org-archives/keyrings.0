Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB937A488;
	Tue, 14 Jul 2026 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995102; cv=none; b=LfGkQD2YqjtcvehViH2oVXs4+GXjdJioBnTJ5Agyl6UsFEYg4SHSbTvv9l93gwYllqzYfKYjEzITP/TlBppCMKplvy2F7VMm4TNlwRKyRHrkA5VIYOfZ6CT5zQ/P4eZ7zNoENgkj0eIC/WQ4dDvcqqVaUowwzMNwNRA4EqHW7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995102; c=relaxed/simple;
	bh=LH+ncc5W13z4uTGckXw/G1PC1R9Rv+kGZf1Nh/B79v4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lLzHCbIpbHQ7+hHcQT7J08OawAouPZvbG1cskBiDBEIYICzq4F5r2E6vy3foRTXonZXuh2lsNo9x2BxDafB8otmNqGqqfO3p875jZnS3oml1H39gE5LqKPz/IdwOZiZndT8sJ3qWj//mw3Di2/mMBGMCeUVxX5HCLLGjoDc7Ecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2rZEf+jv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2rZEf+jv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732601F000E9;
	Tue, 14 Jul 2026 02:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783995099;
	bh=UQLpreAualYM+lqCE/YvZ08vdZF7/8FsjDWQ1qmwzXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=2rZEf+jvnGWLNXCvfUizyWGL0sifgZDbAmWr+FGyJL36Kwx+dQt5hofpFv9PV/zf0
	 c2OOZEbkGRTCBZGTH+dPrq93nTwxoriNw9yYYceoOnY/KIwP/FlUsnwVCZ8XazhQ+S
	 9XbMiTOcxp3+Q9Fk6hnrK7PGEeYKQ85Igf9GAy58=
Date: Mon, 13 Jul 2026 19:11:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] keys: fix keyring assoc-array out-of-bounds read
 and index inconsistency
Message-Id: <20260713191139.bd71035dcfda958452cb425b@linux-foundation.org>
In-Reply-To: <20260712014500.480410-1-michael.bommarito@gmail.com>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 21:44:57 -0400 Michael Bommarito <michael.bommarito@gmail.com> wrote:

> keyring_get_key_chunk() advances the description read pointer by
> level * sizeof(long) past the inline prefix but only bounds-checks the
> prefix, so once the associative-array walk reaches a description-level
> chunk it reads past the kmemdup(desc, desc_len + 1) description
> allocation.  Reaching that depth needs two keys that collide through the
> hash, x, type and domain_tag chunks, which an unprivileged add_key(2)
> can arrange with a crafted pair of same-type keys.
> 
> An unprivileged user can thus read up to sizeof(long) bytes past a
> keyring key's description; on kernels built without init-on-alloc the
> same collision, read back with KEYCTL_READ, returns uninitialized kernel
> slab.
> 
> Patch 1 is the memory-safety fix and stands alone.  Patches 2 and 3 fix
> two index-key consistency bugs that let the crafted keys collide into a
> single malformed node in the first place, which is what enables the
> KEYCTL_READ disclosure.
> 
> The KASAN reproduction is on patch 1. Trigger is available off-list.

fyi, AI review might have found things, some pre-existing:
	https://sashiko.dev/#/patchset/20260712014500.480410-1-michael.bommarito@gmail.com

David, you might wish to take a look at the first assoc_array.c issue.

