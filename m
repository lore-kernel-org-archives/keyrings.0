Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8E198A17;
	Thu, 16 Apr 2026 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374510; cv=none; b=taAn8CA+xDLpsndcYY4ocpnYHQcRK+NyvBZU3+beID2c6C3Qsw8JQ4636X2O9bhqRwjDVPfZ2pTgUYhR/i+J0bJQw+eBGlRkWjojpD7AjmFHqT7h6O1SvSMs2MW/mtwVq3eog2luw/GXTwizoU9uemhwkWwDOEHKpPcoth5Oqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374510; c=relaxed/simple;
	bh=0A66zo/Lfk4qleLToQJ1y9UBbagG08xg62HQhV2NSh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sW2MnF94XX/IvE2RhTvOXT6t2EHHa34lhG7pXsQbI21obacVrelCe3zDQ57l+lHQgC0zqG+XgKnnh2E1s7NZHeWTCV9Urs2J5AyYGjK1pd4ir9YqWhqiSrtwE0yFpExHLE6J+dIO5PN4RMzUhgnrABEXGDwuNoZaqWNXxrHatHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao1i69/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao1i69/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B78EC2BCAF;
	Thu, 16 Apr 2026 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776374510;
	bh=0A66zo/Lfk4qleLToQJ1y9UBbagG08xg62HQhV2NSh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ao1i69/eS+dMjRfpuMEDbs5RypkrgKgwNwXDU+bNO8B6w4O3pUs2lBVS3YosBcUBQ
	 Z/aIUnWkG0mrLOFmvoX088hXa4k4Ja2PHxEAtAns5pLIH0MzuuZ18xYZWbT1XwuxEW
	 kvTd28xoA2lNfMFy3kOFyVGMzFbsKFFVo6c6p9B9ngsSHsLk5vFrdPeJ8K9LVT7JbS
	 7cW44/ssidio+fdYUOSzdvP508Fy0fDMdCU5VPEGndM4IQildNTEbW9HUPvbT+aWf+
	 satzbKv2sBMCmOP4Jt4vEvV/uCocr++HMG7cIDNgn37ermIV2Se2R2IJTELLwiUbFl
	 gS5yELI6Hcxzg==
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
References: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
Subject: Re: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Message-Id: <177637450781.4150069.540537972769992997.b4-ty@b4>
Date: Thu, 16 Apr 2026 14:21:47 -0700
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Wed, 25 Mar 2026 18:19:15 -0700, Nathan Chancellor wrote:
> A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> in clang under a new subwarning, -Wunused-but-set-global, points out an
> unused static global variable in certs/extract-cert.c:
> 
>   certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
>      46 | static const char *key_pass;
>         |                    ^
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git clang-fixes

Thanks!

[1/1] extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'
      https://git.kernel.org/nathan/c/4f96b7c68a990

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

