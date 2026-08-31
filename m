Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681263F4831;
	Mon, 31 Aug 2026 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170752; cv=none; b=l85EkhuJEbFamTwVRPRYn+6OKRhXCpoln5qpmkAvvRUg4wS+UUo7Zp4aiWn1osYNlYTPO3VJv6W8ZUosqOJ9J2qKdQ/wCau6vrFFCTP7ry4wsV97fBc2M6EC3J7doB2NKEKkmdbtb27dBocMoAFiUNrROZWOl5OZ53W/uPoddW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170752; c=relaxed/simple;
	bh=IG07tUuH3cX2ivZbeklWznGZHElgMLpvMWVhIuXl6aI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cNi4T8z3ZQb4NMHK5wlLbHNZXKAMxnVCxNLShkARkpssi3SUT9vHyhs1n04T09T4Op30GbtRGCHjSJBne94mTFwu4qFCxrO0KGHvrsEG5uQDMfXaUFGm5Q0On2bS5141/4OeLvgc9JoITnhmAbYpNgYo7a9GepW+9CFSwZy8fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB+Ssx6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB+Ssx6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7E01F000E9;
	Mon, 31 Aug 2026 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170751;
	bh=4MG4/KuLdfetrF9VARkaqn+udtfllmUDQ18jEJK+Twc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=cB+Ssx6/S/MQidaHRqsKt0Zmlu5fAUIBibZQZjzXF3cJzNXA9gFpz/3nD71rUqhTC
	 LQNKe7Krnx1tPHmjaXzloMODJKAhlXjnYAEAOifasdyQdjxOUetGiLL64W6VRKwJhd
	 DwjbIp2XT66Zg4QiemLXhteRY5rj4353jb3otsuXEgYjyRgKvV2LjCzhivrhlEpG2J
	 FUNs4GapfirkJhoalmKt39MfTmblyIFuutDXpF9QkD2gZhN+tSG8m1Z9VWmL5nTnOI
	 zpkWKfb22NIv6DtLhekKkIWDMCU18L1maBuU4HaU/RF6IV8Op+FuOiTxJMD9i23CXL
	 rmhQiNpm3TiXg==
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v4 00/11] BPF keyring and signed loader ML-DSA
 support
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, 
 ast@kernel.org, john.fastabend@gmail.com, a.s.protopopov@gmail.com, 
 bpf@vger.kernel.org, dhowells@redhat.com, jarkko@kernel.org, 
 keyrings@vger.kernel.org
In-Reply-To: <20260828175227.1537793-1-daniel@iogearbox.net>
References: <20260828175227.1537793-1-daniel@iogearbox.net>
Date: Mon, 31 Aug 2026 12:05:45 +0200
Message-Id: <20260831-geoutet-tatsachen-phasen-ac93c1dffa27@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IG07tUuH3cX2ivZbeklWznGZHElgMLpvMWVhIuXl6aI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNDfxVU79cb/7MndqHci+cuWdvybWNYe5Pnggt//UHb
 gjvlfNY2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR7V5Ghp+CP08caDb8nWa9
 4GPIctWOB6dVsnhedHO4itbwrZtgzMbwT03Ezag+i1PQKo7j1Va5f296lsRPF9d4Lqd2b87D+6I
 3GAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Add a dedicated BPF keyring which is integrated for BPF signing. It
> is modelled after the dm-verity keyring which was added in commit
> 033724b ("dm-verity: add dm-verity keyring") and which can eventually
> be used also via systemd through the same enrollment method as in
> dm-verity's case. It is selected with a new well-known keyring_id
> VERIFY_USE_BPF_KEYRING and gives an operator a place to enroll a
> BPF-only signing key at boot, specifically scoped to signed BPF
> program loading. Next, to demonstrate that BPF signing is algorithm
> agnostic, we add a few small tooling changes to support ML-DSA and
> integrate everything into BPF selftest for BPF CI to ensure nothing
> breaks with future changes. For more details, see individual commits.

Looks great to me. Note that the I already added support for enrolling
keys into the .bpf keyring into systemd-keyring-update:

https://github.com/systemd/systemd/pull/43549

The current mechanism is built so that you are allowed to enroll further
keys post-sealing provided the key is signed by a key that has already
been enrolled into the keyring prior to sealing it.

-- 

