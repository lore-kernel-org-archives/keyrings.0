Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169500;
	b=eq4mRAJMqz/78q4DKoM4z2/4lyXkC+xn2IUv1C42NMsqEs8CbzPAltyqwQqyx3WmULZv
	 xhZcilxkVNxrh/lodm4/DdTJ+ZUB4mH3T6jIrpcNQULGwcJLjE4umMdS/xVzIYqUz38gZ
	 IukiWnINvjqQVd/HftpgN90DXXtrMbys9IwLC4N05T9TrT4mt6LxzoB7+TgXbdXqOSvJE
	 EwxeSCbvDyQNVvFACtQNamh/yES2p7Yps1cXX861iC+5V3EZVJIJKckDngyI9VCLBGm5i
	 sFcUN5cOQGFEYxBaVlbhGmhZgG6pyIdUj+4/G+5GMpvCzQWwKT5qjH9+YSRd0cKzw3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169500;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=dZiF4/CWqCQ7gcRMAMR0YOlOB4gblyvSfeSB/PEX/KA=;
	b=h6SgTZjoTjHOv9rV8PkkW4LWiSC6YJDI2B5z5NLOhVIzedol0ybvnSRuaHoha7yhmnhT
	 88/1uRukpZYYJca1UMBbMujbIEA/Fqd4j6w7xOpBYvk+M2/bJDi8K5KqsjhemaAwB6VrZ
	 bdSDlm3XpfJNU7D3HNYmvAzChIraXZxsyy1qOKRPVgX/fLjlPA4m8y3HF5r7HJQGSgvZn
	 0MLyi4R2fJVGTWhEnxpG+YQVjfOhaldA6thDM+9mayrb3WtFWBVG9aQDXZ6cphsbFTGrq
	 YN6C7qpRl12jQNRaRNgG4oezWI2pAq5sTiLeoRyySsunyO44zyiMLWp5ZGMZ153SAoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bhEWf/3U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955B606A326;
	Fri, 20 Nov 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhEWf/3U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886951F000CA;
	Fri, 20 Nov 2026 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795169500;
	bh=dZiF4/CWqCQ7gcRMAMR0YOlOB4gblyvSfeSB/PEX/KA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bhEWf/3UVSV5Oj/LaVfj5iyFojab9TYNDhaX1mHwwaJAwXpdymbQOnxSokoln8AMY
	 mX9mf4v6rXtAee5qHVWTUcejqpeGe/FkoS9Zzds8aXx3HJn35atom00NnbYxDM3e4z
	 W4lRRn7krZTg4Xx68Ti4Pn5x4zLUufyP2G3OeRRrOJPpnrkx2mDd/w6A+blHcAFoc+
	 8jsVCtIM79JK8gWtPvQx3NJdPTVkpIv1SLIm6unPRy/rgIv1D6q1SOLBYgH59Hx6ve
	 eumgNRPrSC1g3HeBPTkLeny1Ub6+j+i7sZRoyfjYVbGLx+ge1hPbdrcXBaCatzCdEp
	 DTHGPS7zjwGbg==
From: Christian Brauner <brauner@kernel.org>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Josef Bacik <josef@toxicpanda.com>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>
In-Reply-To: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
Subject: Re: [PATCH v11 0/3] capabilities: close the ways around the
 CAP_SETFCAP rule for uid 0
Message-Id: <20261120-zutun-ausgearbeitet-erregen-ebd3834404ea@brauner>
Date: Fri, 20 Nov 2026 11:11:34 +0100
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Tue, 17 Nov 2026 19:54:23 +0000, Josef Bacik wrote:
> v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
> v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
> v3: https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/
> v4: https://lore.kernel.org/all/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com/
> v5: https://lore.kernel.org/all/20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com/
> v6: https://lore.kernel.org/all/20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com/
> v7: https://lore.kernel.org/all/20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com/
> v8: https://lore.kernel.org/all/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com/
> v9: https://lore.kernel.org/all/20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com/
> v10: https://lore.kernel.org/all/20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com/
> 
> [...]

Applied to the namespace-7.5.misc branch of the vfs/vfs.git tree.
Patches in the namespace-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: namespace-7.5.misc

[1/3] userns: don't let setns() lend CAP_SETFCAP
      https://git.kernel.org/vfs/vfs/c/711bc24f1d8f
[2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
      https://git.kernel.org/vfs/vfs/c/c1e5f4d36d2a
[3/3] selftests/namespaces: test the CAP_SETFCAP rule for user namespaces
      https://git.kernel.org/vfs/vfs/c/cbe977960cb3

