Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FD2C0303;
	Thu,  9 Apr 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740988; cv=none; b=jMNSRaUjyVyEBGK34m6wdE8FxJiBhfnuWWFqfPCg8ZaPOpCSJokoY1YH13JsloERiJKfCLoTLAsdmnkBokV6a6IKjDAmbvp6xjJhItvIzCiMuhiNTBJ+XBYWRQcljw/jSgQzDk8LfZPUbiCYm+qyegzJCzTaR4EPr1yFSTJ3Qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740988; c=relaxed/simple;
	bh=tqL1fimNDWlyLrxDSkoymopCMl8WNimZ9u/t901NIq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twO0weUwoTvbf0ES9QVBDarzikqFFBYgLCzmyOkfdNzgPgKI0pEhdCopIIg1/sgm146LPb6YNlfJqYWfe+adkvyFy7x1JzpegOvjC0VLmnCWrvtsAqKzU5jyh1dRBiBUgUHg1cObLx96BUpOa0eTgW2RC2rkus5PsqPZtO4CJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAVlBbSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAVlBbSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9666C2BCB2;
	Thu,  9 Apr 2026 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775740988;
	bh=tqL1fimNDWlyLrxDSkoymopCMl8WNimZ9u/t901NIq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAVlBbSwQ2EhjlAwBlMNJeosfz0dD/8/v41ae3TtdzbJ4z1x3dD4yTseDt0lVJtuY
	 bPPpYhmxSCVZyjh7JC0K0y5Dw2ZboOV+3v0qtTJfhHkOkdo8tkm1dRIIKCBDhYcCpw
	 62TcG886O1nJQIEV5zQUUb2JNYXEHY8UDWiHHh0habAexbRBhLpAkYw/Yf7Fu10JrT
	 6yEawp4pnmL1Vrsjz8Iq4dX+w+XzA9pmI1rgkQ5grLt0pzA3IDL93pcxKo2fB07nfV
	 2B7unxdgFM/y+9dQ1ApQeXfmvZtOnpQkyjMNYFbiVx96jPgwg8CrxgwCTE4Ymj7s9J
	 YKfVqZs9BLKVA==
Date: Thu, 9 Apr 2026 15:23:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Douglas Anderson <dianders@chromium.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "open list:CERTIFICATE HANDLING" <keyrings@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, "open list:MEMORY MANAGEMENT - CORE" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] treewide: Fix indentation and whitespace in Kconfig
 files
Message-ID: <20260409-kontraproduktiv-sterben-034defac1e79@brauner>
References: <20260407053945.14116-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407053945.14116-1-linux.amoon@gmail.com>

On Tue, Apr 07, 2026 at 11:09:34AM +0530, Anand Moon wrote:
> Clean up inconsistent indentation (mixing tabs and spaces) and remove
> extraneous whitespace in several Kconfig files across the tree.
> This is a purely cosmetic change to improve readability.
> 
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 
> $ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---

Sure,
Reviewed-by: Christian Brauner <brauner@kernel.org>
