Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD94381E87;
	Fri, 28 Aug 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943984; cv=none; b=lRZk7U7dGxq65yBMr1jb9fPo6fFkfIPrQ7mtN8iMxxhLTm1rByXRu+zQeaT/DgDWPENkFgjola22emvZmo7QJkVrIMDD4t7qkQUerx77/5WOjeVQE1Itv+cWNQX2zNSB2lPEVpNoiuIiRFexJU1lKB54qf4qa8cvwn81N+9Uqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943984; c=relaxed/simple;
	bh=NGmdIIkZKkalLCaTyCuKp0vrc2Fqaz0d5Otgz4tagzg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KeHk+iTjRcnycIgIRWvj1lCwMHOA6aE8WLlWcuv8+xYJji2bku6V04lFhPhNtWfL1DwtCh9G5RPMA4nYiWKfiB9YyRgsxdqhuZN5KgnagpG4+TAHKhDciOuJzfExV/Eln7M/VGE294u/ez/jkfrrnspAIkRcx19ulqfjX+T/uUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kETOT6c6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kETOT6c6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C1C1F000E9;
	Fri, 28 Aug 2026 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787943983;
	bh=FxI0u2XY3t6mBJ1SwmywPnCbpKTBMgDTbYScii2sYkg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kETOT6c61o7/Q7Hoowe7OZh/EEjk/3tSgb6H1Mu/aeV6s88ej+IaP78LW/i9T0Y/G
	 hb3DoUMlbUOEWGaqyXq9obdP/2ObYLFZSwr6YJoInTNhxLsjuHq7/K318NgIUX1KFW
	 wBy5ENv7E/SnTdQoKVRpVNIfeXjmYodotLmSWrPLY4pcuJijpFhEHxlCQau+B2R8kR
	 dQ9/D+WyzpDh/aGtEc5Bnp6ADnb/8jDX1YzC9EA1m2haoOGIvosHLHN4qTvwyUiolF
	 uElK40EhaR0c9ibW31jZOWAA5k3wPWSJIXLjKbPID41oLKvEJ02+sUS4peY/2Ydzf5
	 LeURVDQaKUurQ==
Content-Type: multipart/mixed; boundary="===============0675058009763020938=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3db4b7785339ffa18ca5e0c055477b362845724171008ca9a7b3ff8c1ba002ba@mail.kernel.org>
In-Reply-To: <20260828175227.1537793-2-daniel@iogearbox.net>
References: <20260828175227.1537793-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 01/11] bpf, keys: Add a bpf keyring for program signature validation
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 19:06:23 +0000 (UTC)

--===============0675058009763020938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     BPF program signatures can currently be verified against one of the
>     system keyrings (builtin, secondary, platform) or against an arbitrary
>     user/session caller-supplied keyring named through keyring_id. There
>     is nothing in between: the system keyrings need a kernel rebuild or a
>     vouched-for enrollment to rotate a key, while a caller-supplied keyring
>     is fully controlled by the loader and therefore carries no trust on
>     its own (unless explicitly combined with BPF LSM to protect against
>     key tampering).
>
>     Add a dedicated bpf keyring to fill that gap, modelled after the
>     dm-verity keyring which was added in commit 033724b1c627 ("dm-verity:
>     add dm-verity keyring") and which can eventually be used also via
>     systemd [0] through the same enrollment method as in dm-verity's case.
>     It is selected with the new KEY_SPEC_BPF_KEYRING special key id and
>     gives an operator a place to enroll a BPF-only signing key at boot,
>     specifically scoped to BPF program loading and nothing else in the
>     kernel's trust hierarchy.
>
>     The id is reserved from the KEY_SPEC space so that the latter is not
>     linked into any process keyring, and lookup_user_key() resolves
>     KEY_SPEC_BPF_KEYRING constant instead of having to look it up via
>     /proc/keys first.

This isn't a bug, but could this sentence be clearer? The phrase "the
latter" grammatically refers back to "the KEY_SPEC space" rather than to
the bpf keyring itself, which reverses the intended meaning on first read.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33197746599
--===============0675058009763020938==--
