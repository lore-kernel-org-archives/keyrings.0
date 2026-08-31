Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4273E49C7;
	Mon, 31 Aug 2026 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170758; cv=none; b=ugIqDW8jxV/AMSTYTQRIyNHNxAWsNSWcS3WutjT8vGRQbo0yynVeNI7Er1otKOtl/6UVxUe2R8Sp+s8o5Alp2T5O53Z2L8C6mR7H0xc7jHDgzS3L4h9M6qk91zXr2CteH3LddCT3cJKRUbdUXkCnXv0glc2Yk9elNBqTksvJKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170758; c=relaxed/simple;
	bh=UPBw6UQAPtfPJZSN5SX5nEEXdsVDTv5KT0nTgC7CVY4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ktg6Zikb7rZjnYoIZTSnDXy4qX79lYxxM06YmgKkbIjm/KZG64CeJ11nGGSuaRy4BSI4wMRVTMX411/q2VhLmSlzkJkDFTXCMA+ojSXunfJi4ADwv1xRb0O9MSGyiyd22dOT/G/NA+vaJ9Ha4Fi5Rxcpd+0E3913pi/oaMtq9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mniglwtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mniglwtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFB71F000E9;
	Mon, 31 Aug 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170756;
	bh=q+bcTeUxYoW1AH1vH2/jyTO2afn/tK9JxUTdhdGto8w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=mniglwtnyszx/mdKt3UN591f/sK/6A4qfD5sKivkbHUKe9JGLem+jkMevxphC2JNn
	 6JgpBRrlx1Uo+TAQdR0yKnVRHUQljg3EbEIwxX3CjStRP11crvZaTjoO0jR/+Ew7hB
	 ZkL5OYCedgdshkXjQTSOEMK6cyjghHbSKxVC8PoUAEzonf2l5OQSIkTvoNiSeh0O8X
	 7CRMiG8d/LsO8GJHZX5z8HhBhh4Pe981X08Kdku5dKSqtA62Ss+bjOzGeHilEDv1Jc
	 vHSWs+BLJTmliBMjk3tHqNso+orRGJ+oJagLXyVMWRGfsHGutSLKOtwWwShdCJbWQZ
	 51dlz+BhwffoQ==
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v4 02/11] bpf: Refuse caller-supplied keyrings
 when the bpf one is active
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, 
 ast@kernel.org, john.fastabend@gmail.com, a.s.protopopov@gmail.com, 
 bpf@vger.kernel.org, dhowells@redhat.com, jarkko@kernel.org, 
 keyrings@vger.kernel.org
In-Reply-To: <20260828175227.1537793-3-daniel@iogearbox.net>
References: <20260828175227.1537793-1-daniel@iogearbox.net>
 <20260828175227.1537793-3-daniel@iogearbox.net>
Date: Mon, 31 Aug 2026 12:05:45 +0200
Message-Id: <20260831-entwurf-gemunkelt-unrat-770a28439b80@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UPBw6UQAPtfPJZSN5SX5nEEXdsVDTv5KT0nTgC7CVY4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNDfxV+Fhgle22+ZOnnXT69naLoMu2JNHlu/JFVi4NT
 +qR9jie1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARt9cM/2xUff77TzKZoT57
 R9mlIoPGkoWyNp+XZ2+LvvHw4gX3xI+MDA+kp2yq2ZzBZpxubcGz61Bx1a5yzc7J+9y0tbepSwQ
 EcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Nothing changes for systems that do not use the bpf keyring. Without
> bpf.keyring_unsealed=1 a caller-supplied keyring behaves exactly as
> before, which also lets it serve as the staging step for software
> installed onto a running system whose signing key is not enrolled
> anywhere yet.
> 
> Passing bpf.keyring_unsealed=1 states that the bpf keyring is the trust
> anchor for this boot, so from the first program load onwards a caller-
> supplied keyring is refused with -EPERM. Deriving this from the boot
> flag rather than from the keyring's runtime state keeps the decision
> immutable from userspace.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Looks good,
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 

