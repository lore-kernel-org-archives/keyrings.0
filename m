Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F62364E92;
	Mon, 27 Apr 2026 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332113; cv=none; b=QeCBg+4r8XCPNjK8OHSPbeRTsr8MOrXTUkra2gkoSc9g1OnVxguP8I4jQEhxRQrVlmQhsyAkd67SNJA+bd9a/zuBvl0RtifpVDJzhICS4chlbheB3BxRl5w3BzmYONsMSMyaGSrn6lWmHIRMYgTTwvOQpyFalFWhoKM1Cp3hl7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332113; c=relaxed/simple;
	bh=Q2hQsgYw45RQ6lsi5Z/STthBpvPXGMk2unvl5kytVUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbOMcaNwYq/Ep81+5nRq8gpRA3P+A617LHzC3K6eg4rvFh+JkoNzcdTYn4w3rACw4KXv4FJP7VKUgtWqMlMmskZuOBG3b7uQORiyFTJlokzCWS+7s5qv0GkSlfOwZsko6yY/yoBdGGH4zPJRoMaYkDcm3qZlx9ME3rJGGwZMhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpaqMdl2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpaqMdl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426DEC19425;
	Mon, 27 Apr 2026 23:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332112;
	bh=Q2hQsgYw45RQ6lsi5Z/STthBpvPXGMk2unvl5kytVUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fpaqMdl2a8ebYpyDMjN1575+a0FgqoEi2U0gT+5RN4H1nn8N3frBjBQX5YmMOkNfo
	 SWGKSYU+4hlcJc+NAE5mcmKhPjfmYs3wAKHK8/I0D0CFbzfeaS6mF8S9G04jhz88OT
	 cICNl0qP+lhEBeubdB16wJRTiZsJEA5c9e53BnN6g7ytx6UR6ObgFjZ+yo1xjiMAQW
	 Yk4BkALpWq+e1Xp+h/HfanCpl2wyVHlZxoc+ObYm7VZPmk2in3ufZbe0WPRx2mlvJy
	 oBtOvsfC0LB6qUwSgE25UAZ7lLprxtXUA6AVIYvUFcZvgfb6UEW6ojkscLyL/wWwNE
	 5Xhve7SgE1ILQ==
Date: Mon, 27 Apr 2026 16:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Tim Bird <tim.bird@sony.com>,
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <20260427162151.37fee368@kernel.org>
In-Reply-To: <20260427114422.313356-3-thorsten.blum@linux.dev>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 13:44:23 +0200 Thorsten Blum wrote:
> Subject: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data NUL terminator

to be clear - I expect "keys" maintainers to handle this, not net-next
directly.
