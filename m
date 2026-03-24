Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403603E1CEA;
	Tue, 24 Mar 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348510; cv=none; b=AWXSVheslyxmoQ0gqIKSjOdAaCdNlNiag4Je1Sd6M7xwkHaiHElQS3qI0GmZDq+li3q3VdDxyqUxjbOzm5Wbvd6MHUwjzAjlOkchdpUY9kBkZDK7Dgp8VyHPYRFtLKspGzkVZdDDI9P7pU4zl/zUVPVR7Xoym3OzNW7siGoQKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348510; c=relaxed/simple;
	bh=ozLikLvinqIb2bQ42DgDWdNkICnKWw52pWepRkNHFkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae4CwYOL/MdIXjVaTSfgrNqeSw5WZhyEDuPUC7oKAXbSSChSP9xDLPZozzPvLEc6oSJhanVoL8L+zqqQj7O5h2dh4D8XqULYPxtdK1gJfICnqwo38IuDle/buN22BvBCPP5WSWjTQZc+/+gFky0VBfKelT9jAwfvKZ+XiHeBdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnnNQ3qe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnnNQ3qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F90C19424;
	Tue, 24 Mar 2026 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348509;
	bh=ozLikLvinqIb2bQ42DgDWdNkICnKWw52pWepRkNHFkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnnNQ3qeiL76pbHy8+Fe+UascEhQ2QZuk06i6byF7axDxpxXE65ts1CdK5GnmmIGN
	 QOG296DavABcXeZ4wkg//XaTUQvVy+VxF1Ar8ASZ0PxGvR+i/DjBsD2EVu86DsHHH3
	 20RJDmMDkKEVJByy9ITBCvBAvlDcgxV8uXM3/EtGIWg09PZVYAKqaRzPYuExyjuM8c
	 LybbGJUHyF5NgeW50H7fwLo7iQo/dKzwmLTUgfYtpcMur7OfSH8TRSwjpUmy1Tdqvc
	 642KVy1hwvW4ry5OjiojRzdCuIKrnKo9qqzLvw7Mqp+hJANvac6sn3aFp8zmvTqVd1
	 oY+GFKFLgpK/Q==
Date: Tue, 24 Mar 2026 12:35:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Srish Srinivasan <ssrish@linux.ibm.com>,
	Nayna Jain <nayna@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Protocol debugging as a feature
Message-ID: <acJo2cBe2pfDWWGc@kernel.org>
References: <20260323090047.632499-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323090047.632499-1-jarkko@kernel.org>

On Mon, Mar 23, 2026 at 11:00:46AM +0200, Jarkko Sakkinen wrote:
> TPM_DEBUG is a non-standard way to specify a feature in Linux kernel.
> Introduce CONFIG_TRUSTED_KEYS_DEBUG, and use it to replace TPM_DEBUG in
> TPM 1.x trusted keys.
> 
> Given that protocol bus could contain sensitive data, harden the feature as
> follows:
> 
> 1. In the  Kconfig description postulate that pr_debug() statements must be
>    used.
> 2. Use pr_debug() statements in TPM 1.x driver to print the protocol dump.
> 
> Traces can be enabled e.g., by providing trusted.dyndbg='+p' for the kernel
> command-line.
> 
> Cc: Srish Srinivasan <ssrish@linux.ibm.com>
> Reported-by: Nayna Jain <nayna@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7f8b8478-5cd8-4d97-bfd0-341fd5cf10f9@linux.ibm.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

I'm posting a v2 update with HAVE_* flag and a bit wider scope.

BR, Jarkko
