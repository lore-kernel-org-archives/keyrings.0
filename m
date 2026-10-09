Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A13DA7D3
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522371; cv=pass; b=ZRlTSZCxqB7rPNHxueVSQIULBgqppzLtV4pvImscDoSCz2QI7peQ1gtqfXiDA7ImIwKrLigvJ9eLVGJmIr8gKzqlwuH7WoM+AtNpPyTsBU6TFh+Gbj/5RC9PsTBffslevZWw+qqpwhI0iLe+TPD6RBBlXYKoRZG65An9LlXOCNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522371; c=relaxed/simple;
	bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+VaTJipgIRYnQ/VOg05uwgV2N2U+Mw7+vpP4t5Au/g4w3HUCYegf0glKiCXGxdXevzWf7acewU7souquKWqZEJWL2+sNI/UNFgp522vkFWYq/MMc9SQnKxw18nDwgTzwfm8xNYqMEN028JgChhuiCU++bs5YerHgjwodu3X/uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X68XKz3G; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X68XKz3G"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67694513f2fso3667315d50.1
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 22:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791522368; cv=none;
        d=google.com; s=arc-20260327;
        b=JsoEP4bOKKJyAR+nYM57i2vmc/3/lqLwvCj2YXmmQ6WaqMvqkL/XAisA7L7ZloI2Xc
         A/tWSxNGKrCnKTu9rq2dk88zxIeOxBGHcNcaOZF7lTlZCtoQ9YGgPFg+qiIxIXk+kGfM
         8crxcPzSDsXWrqMdxHM1MCacYBVpLFbctTv+ZCyOkwP8iRre8AVxBHNKjicVmXGECzJ/
         MbfhyqUEJFbwIE6IqyZlyQ7j2Wfl4EVZ5dLO4POU1xsTYbITUF8mbnQJOvVng/b4t+dJ
         ohIvEcsPtG/9CZbOlrS6I5JF5f76guaTcS3qA3AqYCUpQz6WTnL2msv12SnONgt5y5kL
         cfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
        fh=wmfj2dBiKMsVgEtKApjQJd9ii/AIKGewYI0rYjkV0Pk=;
        b=ZyYEnK2mkcdeyLbbkPj1BUx+TbnAsrsBlhlHDeXW1WGB0w1qkl299fPFBZvWGi6XMM
         TZkzcSpkvt8i3C5085nPv6LDdP3spUHPHNuahhdcmKwHeEthM21qpIE90zOac2k5Jy0d
         dw6I6LjBldT2buhuAEEF8od/Dtfzk9oUnCXBng4ld2mafLetI+NbGAsZ9mz5aF2to50Z
         u+Aa/f/g8PZ+iwOSzXBDekkgM0J0ObXFJOpZGs+6nLqpD801s/WJQxFUxqs2QawbOJ3X
         U06ZT3tebgFTnpkA8tL++Wt9fjSwA75roKY0DTwCCyv667R5b1sqTjqw32CFyCdz8YPV
         DIOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791522368; x=1792127168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
        b=X68XKz3GK/g1wVOTb+wV0jy/KUia5G9SXxhqc4OITBUK6CooVak0aOnYFqKVu65zeU
         6JbTSoBA9TQmKfVJGOGi3pdSj+U9+HhkGl0/7KUZD0Znefy9hIQkdiWSeMQ1HUSOhZkF
         cSlC/hYALPmWAH6mjQQ8KpO29CfbxWJU6uHzNN/QvlzVTbA9IPJUQoRFk8SulgyDa+Er
         1tc0iy3Wh01uG5aIACIqQKwNjeqr6D9o4jmKPbQfsFk+wef5DJsnXl2JWK+e2zaTqFHl
         SqEfNjXPsdC2KGS2vMQj2ajTnvnpiECiRwQ6Y7kn42MBU2aN1avmhrzTuxl/cPAIgrt/
         ixYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791522368; x=1792127168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLEH35XDmiCTcy4TwWz+bK3Tk5dXuZwQrYMswqmAf0Q=;
        b=RX5d130AmkxWG52Fvha7Q8tbSHPFT920ArdYA4xPJzUnWVxKLewpbukP69zJ8GttMu
         voZjZtRW8tJybkhQ8xXq8XhT0NcVRvzAKSQJaDvjbtmGNla5RL+fDp8rgJiqlCkK0Lfa
         QJfDXlPqY7S8EeEJUJ7yi9BfXEgOMFpdcB+9df5Dd9L7DKbQgRgkLPIt8zjph47IBtBT
         7WgkQm5B2RmQwgdfOC4+mdFP9HUPTF1LY5a2xDiiVfKqdsLmVsU3b22ZVJVTdg/tLNZj
         cKfOwyqt93yPbDusPY67u6MyzRx7/s7stEgs+aZzMHoeHylmPvJBvgDPJPll3oT67YuQ
         9tKg==
X-Forwarded-Encrypted: i=1; AKwUvBxwzWdxw+sWW69Hlp9Ik1dgKa9As4RwfZ9Z/KtiFP+wOFgjGPicKHYOzWgp48GId/W4Lmoz3kP7iA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLV2qXYBOsVjlqwLF2qyg+hfjTEEm2MBu96kfJWiYH6oJMkI+Ui
	KBKXtk87zfS9CDWO/WNvBnYmzFrqa+NBuk/d+w0PvKb2EjRdsm2ZLSpFRHaIhiyQ6MDtK0dWo6E
	Ui0inRd2wt84rHYOYyYtueTAgmvZnFIE=
X-Gm-Gg: AYBFou0oe112ywcPka7ttKRkQQY6qzewEhvi4+zOQZoeaMVD3Fd8iT8T430LT/KHSjl
	5IY0Hq9ApyktH6oJiBAe+5A5yWsPNXnddASFbc51lfFkT+9sAgcVmShOQaJml2WFPi8mWQDChjm
	ieAG8QlOLWd+eCSHqqdl1hEvqSYXETPXpoMBsLZjo9XMHKWElWQ8tAF4ukZjFqfgsSgp0ACkzOH
	81fOmWU5TC13w1cud43cCbyWKFtgO1SUS2xAjpt8OnjcM5LQnjKV2gxq6JdaFqT4yyyFJHJOccj
	dZHvVKb6hVXG0O2e7KW60KgCS7wetvbPBWR3wx8vWsr9taj5YRB9vN+tfg==
X-Received: by 2002:a05:690e:4403:b0:66e:5d40:6dab with SMTP id
 956f58d0204a3-679362825damr160377d50.23.1791522368308; Thu, 08 Oct 2026
 22:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0002-v2-dd6c20a1d92928b33ab7@gmail.com>
 <asfZfZcusHMRiUYY@kernel.org>
In-Reply-To: <asfZfZcusHMRiUYY@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 9 Oct 2026 13:05:55 +0800
X-Gm-Features: AclHuK92MCPHMkbThkXyJZrzV_KAbzt10KrIGn0E5G2gyILDquLox3Gbjywre7Y
Message-ID: <CAFRLqsVwB3s4OQRkBzZb3O7ZmvPuiOYti8xjK72pL4HqnvGKHQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Avoid the owner account dereference in named
 keyring lookup
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, sergeh@kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 01:57=E5=86=99=E9=81=93=EF=BC=9A
>
> Similar nit. Not sure but I think even just having these two lines would
> be sufficient or is there something that follows that would be
> meaningful?
>

Thanks for the review. I've shortened the Oops report for v2.

Best regards,
Cen Zhang
