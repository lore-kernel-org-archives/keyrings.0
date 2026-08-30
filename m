Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623925B087;
	Sun, 30 Aug 2026 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052914; cv=none; b=ooGmB+mRhTsAIEwbLymWYGXldk675RDNX/j7yrA92RIZ4tBHoCxF8GKwV5nYF/s/vRItnuSZ3MKFyCVNgX+ygqnrOrp41pn3ryOQ2i6OLy17gDlImmbesTjfuwNP8kSSx4AQEoLIkIqbzN3b1wOEon0MRi+r2XlsYqi9pG6QWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052914; c=relaxed/simple;
	bh=HgO8siUaNEjwFPnzPWO/HGM3OcXLU9/QjkkLMEFE+RI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rF8iXh/LQfRG6VR5AAdap6Voszg8Mr/tFDYhKaarGcmsMxS6Gc5NnrNzJeUsfnYuvliBOxqEm0C9/5tUdjX1d08dpfMNY9upQOorDer40chvqu8a6FHPS7WyGCmyCAaJ9Kg6qvEhp9K2q6mNi5j6JpFFLvAHO2g8i+IH8wqVm+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8z79eoY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8z79eoY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166781F00A3D;
	Sun, 30 Aug 2026 01:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788052913;
	bh=aCJ+HyOs7vd2iFttZBrYiwcNtOwCRvkC0MtdsVhctEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b8z79eoYA7H9NzgFsa2tKL43UymaPhHp8SNeLb2Vv35vemW58M8pWrwkmdJVs8+cd
	 haavQaAcs2Tml4IeaDvzOVN0kl5Kec/sIoZ6TZrwKgBqM5EBUGelQKLKbQ7+hSQcmZ
	 3aG2gdy5cMmaNDfIKY4LF2rFM9eFm10o+l0CdiuUaspv3KMaVy2IFXdyAo/sQPUm6z
	 1EkhrB2gUHem8M4HGH/CboepW/UI7HuUdcBVWvUgT8tDvY6Q1l7I/7mr39dN5RiEi4
	 xdg8hYJiW1jZJGSNZEoje5tkwSPU3Yi15s6wUY0Wq34nsO5BmqR2ghMu0yTxG2pJJw
	 WqFdwRKoHd4rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567AF380CEE0;
	Sun, 30 Aug 2026 01:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/11] BPF keyring and signed loader ML-DSA
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178805285688.3192144.16351453392396630478.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 01:20:56 +0000
References: <20260828175227.1537793-1-daniel@iogearbox.net>
In-Reply-To: <20260828175227.1537793-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, ast@kernel.org,
 john.fastabend@gmail.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org,
 dhowells@redhat.com, jarkko@kernel.org, keyrings@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Aug 2026 19:52:16 +0200 you wrote:
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
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/11] bpf, keys: Add a bpf keyring for program signature validation
    https://git.kernel.org/bpf/bpf-next/c/264d8fd2794f
  - [bpf-next,v4,02/11] bpf: Refuse caller-supplied keyrings when the bpf one is active
    https://git.kernel.org/bpf/bpf-next/c/abaa0835b4f3
  - [bpf-next,v4,03/11] bpf: Raise the bound on a program's signature size
    https://git.kernel.org/bpf/bpf-next/c/300b348e6d5e
  - [bpf-next,v4,04/11] bpftool: Support ML-DSA program signing
    https://git.kernel.org/bpf/bpf-next/c/d37168c99361
  - [bpf-next,v4,05/11] selftests/bpf: Add a test for the sealed bpf keyring
    https://git.kernel.org/bpf/bpf-next/c/6754aeca6022
  - [bpf-next,v4,06/11] selftests/bpf: Rebuild signed lskels when signing key changes
    https://git.kernel.org/bpf/bpf-next/c/e7ada0800ce2
  - [bpf-next,v4,07/11] selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
    https://git.kernel.org/bpf/bpf-next/c/1841d6cbc5c7
  - [bpf-next,v4,08/11] selftests/bpf: Add an end-to-end ML-DSA signed loader test
    https://git.kernel.org/bpf/bpf-next/c/478cf384def8
  - [bpf-next,v4,09/11] selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
    https://git.kernel.org/bpf/bpf-next/c/b638a82d64f1
  - [bpf-next,v4,10/11] selftests/bpf: Add tests for bpf keyring in signed loader
    https://git.kernel.org/bpf/bpf-next/c/1c8cb8bf7329
  - [bpf-next,v4,11/11] Documentation/bpf: Document the bpf keyring and improve examples
    https://git.kernel.org/bpf/bpf-next/c/8588fa592985

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


