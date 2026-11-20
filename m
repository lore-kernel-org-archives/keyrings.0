Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187267;
	b=kyofdsZ+eIsmWJoHi6v78C565o+ITgiZZ5/stuk95K96ST/aaFN+3usFTl92mgrNC0Dq
	 C/fD/tk5S1rYCkSwmWsGP2svMBMXyuYdK9HnGDa43VbI36nj7sig+zAUox28wOMAQDU34
	 0Kn6/hOnrfRSUQCwv0GrIb0JwZMoQwtWhTb+jvVk5vE56O9EwhB5CofA+zVpqw4WCcOG6
	 mtWDyInTdgEJH9owXq2AfNL+rtK8Y26pAlLKqIEY4MwmCikKwsRrdNc1FNJkyrqYG4PBO
	 bM2cRicL5bhTQOvX5GPmQEojOOiy4UDZN7hH3KK97XAwSXhJOybYvWl+lAcnT8kk6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187267;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=Y19BKETf5oUm82mKKFF5ItJ2gBQ8z02cArjHB+PHKS8=;
	b=D/wd44dH06WshzB4S6ck5TH7Gh0Bzrjq4YcltRdEWt3GhgvEREmP8PBHgIGRoXXGVLjG
	 gw8DFqaMQcHn2igM/jeqeo8YpMAhVYB+xvifKgZHOL3iQsuOevysR90fwkqiQwIGdXrI+
	 bDTySmhRZYy228/C1jiMrwHyjYgGvN5YSgbXVruthc5/lUDm3ASNU6C80BZm//U8qqRXM
	 6rWU82nT+nH913xv0ahc7ZVIJBZT15zhuMr910itqcIOof8SvM3L7YvkqNNpDxWNmAQTq
	 EsyckVPVuBQwevp3ySgZ7ZPR2Fg6tnWh9J9Q2mNqrEc65YVumIVy4cLjy6nfJeJZNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hde4NuG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 77511606A320;
	Fri, 20 Nov 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hde4NuG7
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 955EF1F000D0;
	Fri, 20 Nov 2026 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795187267;
	bh=Y19BKETf5oUm82mKKFF5ItJ2gBQ8z02cArjHB+PHKS8=;
	h=Date:From:To:Subject;
	b=Hde4NuG7iyNA5R4PWtjGPOjhDABcyYj0BGdSn0LKgL84UWrN27VQMgQ8AVJnH44p7
	 tMpCQDdvVO9c/gc8sXYqjpjphrQo5z9pJFo1BYUwyk1W2U+HjTKLdEFbsjPm8fMsll
	 4iwneGI8Yq5w+wCk55eQm87vXvKRgp5UWQwGP/yN/XXytE8napWka/SKk6IBHTKfHU
	 3tejdoIiD66abIjoiodBOXGO9J00PFsItP7pE5Iwyl79FxOnytBNk1fjBrc6VJ0RZI
	 sAKtgVC/8CNv9wDz8i8W3M+MEomljEfaLNgzn8gxby9DzHuizEXvwT3Ug2H6/Tvkqm
	 /w68UMz3Go8jw==
Date: Fri, 20 Nov 2026 17:07:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Subject: On holiday, next week
Message-ID: <awBiPwMS8fUt9bxk@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On holiday next week, so responses will take some time.

Br, Jarkko
