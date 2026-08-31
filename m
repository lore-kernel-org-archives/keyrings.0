Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5B400E11;
	Mon, 31 Aug 2026 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170755; cv=none; b=dPE0dygOr69q9gRKk5zMOYwlqkwVLSbrD/dg8DPmm+sbJEZits+prfxauEZrkKRgEcQyqyJiBPblyZZ6hCKoz3gfwNC90Z4xMeNhQWqQD2p30PjRB7/gR/Y1Rvhk65bcwzQaeob0zNJTsuuvxBtauUvVduz53plDvQP9csGBfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170755; c=relaxed/simple;
	bh=h8ce9T6dZEF9PYG4PTtv8uYgwTYSzu5Kf2Ntf8tc0J8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CBYwf1RP3GavXI/keGttXfQmfr9UzwxHZamC6eQ0P8Oo3RjgAnSc8woHS3DeaUGV4j3ZVVheGVDh1xSqATpNEJGxeiBFxoMI717zfSeDm/yJ/esrWyWphPzN5HCFbYjyCRay9Glm5WTOFJVAxpXVBCIaUIUpC1kMB1Y/KV1GK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozlap6xj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozlap6xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7022E1F00A3E;
	Mon, 31 Aug 2026 10:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170753;
	bh=b+bb6qy3Vks2DTci65HDAJRP0GPwsd621wm1xuybzeo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Ozlap6xjAPdRvJS7vZSZWP7pEO/nCSX6Bk/FNtEu/vjooVYgLquQ0ezMvpl35sjJL
	 dPCZxVvOgCqhjVP+eqY3UBvbSler2I0NatiqKs3aXgvScL+9BQx7eEF32r8L5eL40b
	 2W+pl1nyOJwWnv3VLmzwgzEBVAIh952qlg2SBAboJHJ51aovcLj0nHmk+M/DkSeKzx
	 hv1r5WIVF303+/w99ZEVL1lRY9kyKBd6exnf3ABXgI9j/AYkyNIDH6vaETssDhRt63
	 PrMFLTbqw7fMX3j9LgONePhIcSkUcwRig4Zm3sXeH1YbGfVWeBVo8v/a0YVK1jR6Vr
	 pF9zMa1SF+wmw==
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v4 01/11] bpf, keys: Add a bpf keyring for
 program signature validation
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, 
 ast@kernel.org, john.fastabend@gmail.com, a.s.protopopov@gmail.com, 
 bpf@vger.kernel.org, dhowells@redhat.com, jarkko@kernel.org, 
 keyrings@vger.kernel.org
In-Reply-To: <20260828175227.1537793-2-daniel@iogearbox.net>
References: <20260828175227.1537793-1-daniel@iogearbox.net>
 <20260828175227.1537793-2-daniel@iogearbox.net>
Date: Mon, 31 Aug 2026 12:05:45 +0200
Message-Id: <20260831-rotwild-kindgerecht-lohnnebenkosten-926aa816ea49@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h8ce9T6dZEF9PYG4PTtv8uYgwTYSzu5Kf2Ntf8tc0J8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNDfxlmFXc2zfnbH99YNkzlzvHtzI57jHbOG3ldbbrG
 jcWfc7+11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFQ8Z/ucWdHp61ImIn/bp
 WOZyW2/Dm7Q528pfcFydw7DPOlBZwoCR4cilFA6B3+zNT0TvnmTpehpy/FqL/6sq/R0lnhn2fon
 lrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> BPF program signatures can currently be verified against one of the
> system keyrings (builtin, secondary, platform) or against an arbitrary
> user/session caller-supplied keyring named through keyring_id. There
> is nothing in between: the system keyrings need a kernel rebuild or a
> vouched-for enrollment to rotate a key, while a caller-supplied keyring
> is fully controlled by the loader and therefore carries no trust on
> its own (unless explicitly combined with BPF LSM to protect against
> key tampering).
> 
> Add a dedicated bpf keyring to fill that gap, modelled after the
> dm-verity keyring which was added in commit 033724b1c627 ("dm-verity:
> add dm-verity keyring") and which can eventually be used also via
> systemd [0] through the same enrollment method as in dm-verity's case.
> It is selected with the new KEY_SPEC_BPF_KEYRING special key id and
> gives an operator a place to enroll a BPF-only signing key at boot,
> specifically scoped to BPF program loading and nothing else in the
> kernel's trust hierarchy.
> 
> The id is reserved from the KEY_SPEC space so that the latter is not
> linked into any process keyring, and lookup_user_key() resolves
> KEY_SPEC_BPF_KEYRING constant instead of having to look it up via
> /proc/keys first.
> 
> By default the keyring is sealed empty at init. Systems that want to
> provision keys pass bpf.keyring_unsealed=1, which leaves the keyring
> open for the initrd to add keys to. The keyring is only ever consulted
> once it is both non-empty and restricted. An unrestricted keyring is
> ignored.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://github.com/systemd/systemd/pull/43549 [0]

Looks good,
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 

