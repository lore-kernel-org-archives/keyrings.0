Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372041;
	b=FB07pPVMmsLMUdRmS56keaK04sdap0GIZDYB0UyTRD42rz4jZk6i87+mFtTKg5CVfnD1
	 qCizdswQg66VS2J5Fssljzxs7Ps0zMmXCrz09Pkp59/bLXnTzCCh8wwEIymo+Jw/QaaUg
	 +7FMgYWb+5zAg65RYLl5kyWRjO2kiypHK6GOSdWVSiFj7aUY/lhzpPqKWOMkTQCsLIvT5
	 sM53L7VoikcLWwQ3e5pP98fQ4Z3no49JpUUxVgUIqfXpCmn1jKfKv77/ghKCXBW6SSg4I
	 D0kToIv2ThLesyc362p76NRqmItXgcKkxDVNVDOnFS7FQUI/dkWawxNzxc6DlMrb+2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372041;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=VF1dScveLDfDYKHjPuiQPzlF2Oiut+J/nZ75DLXEJbI=;
	b=hUEpMJwp0C4bHCKfa/6TS3zsYvSlc3MST19aloeoAaNP/25zKWDJwB8W1nFOzy3bVsmJ
	 mEaOrtXMa5RmeQLkW4hyzHifZ/TIyla/sltGFITS7bMqtUvAUOo7NELSeZY9DWGvZpI1I
	 CB992dHWOM3djLiJKd1kEdhWD0P6ma0CXHUNhaAtTiyUzphshXqk/DVsE129tZxszWMKN
	 cnYxjdgflxsv8eUTGfaQAlACK2DaA8AiGgC+sBIHD+ZDZKG1HKjPm+xOk1kZ7uGQmZjKx
	 RUaoZbxqAzYuZ009Nctu06Am8xfkume97NpyxziNnuaJThGX5Sqblck27T5AsPVQYLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVoySd1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24979606A31A;
	Fri, 30 Oct 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVoySd1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9302F1F000C1;
	Fri, 30 Oct 2026 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372040;
	bh=VF1dScveLDfDYKHjPuiQPzlF2Oiut+J/nZ75DLXEJbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nVoySd1BefO0bA0U0hjMJs6LpZfZ1/HWipwRXbnpCAhINHR+nIHutxYV9Pawg9SRc
	 xGKeEdocZQEBNAm2ViZLyc0cKaz6EnuEA37nG73wdVL1BEFlyqf8wWyIwqbiK9h8/w
	 zwcgb35ql9QM+/xwsUQU2ADd/tQy9yZx+/v/Fpdl+KgcBBaSq6spBGN/46dHYvzJxo
	 py7a4AyvbG1ZqYuDC3bTtvxeHs8RrMmiyDZJJK0dPkENDamjA0mi3dQF3LRkazoeZN
	 IsoJKa7Z1fyBWWzB1GF4oGwAEOrRMXq5iz3Ox7YlmsQiBCUOUYKDvA8V3HwDh+3TPF
	 8MHMqk4Nk87gw==
From: Christian Brauner <brauner@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>, 
 Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: David Howells <dhowells@redhat.com>, 
 Cen Zhang <cenzhang@linux.microsoft.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Bradley Morgan <brads@mainlining.org>, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
In-Reply-To: <20261029054136.1174216-1-zhiyuzhang999@gmail.com>
References: <20261029054136.1174216-1-zhiyuzhang999@gmail.com>
Subject: Re: [PATCH] watch_queue: keep info_id separate from rcu_head
Message-Id: <20261030-behagen-dekret-seelenruhig-2e32108c87c9@brauner>
Date: Fri, 30 Oct 2026 15:53:56 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Thu, 29 Oct 2026 01:41:36 -0400, Zhiyu Zhang wrote:
> struct watch overlays info_id with rcu_head. A notification poster reads
> info_id under rcu_read_lock(), but a concurrent final put can enqueue the
> watch with call_rcu(). Enqueueing the callback writes rcu_head before the
> grace period has elapsed, so it can corrupt info_id while the object
> remains legally visible to the reader.
> 
> __post_watch_notification() then merges that value into the notification
> info word without masking it. Pointer bits can corrupt WATCH_INFO_LENGTH
> and make post_one_notification() copy beyond the posting task's stack
> record.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] watch_queue: keep info_id separate from rcu_head
      https://git.kernel.org/vfs/vfs/c/53d72818f9e2

