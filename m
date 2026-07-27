Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBF348C5C;
	Mon, 27 Jul 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177963; cv=none; b=E3HwpeCBrUbA/rR5uiQfCec0O5McD8Rmy0SHFhWzbNWLlQfcVuB2Nav+j4jursTP1Nq1xt6nQDTqS18oGdjxjiKqP6VerJ8Ocl/VpAXw9+K+SeaRiuf0T47NhC0enRjSZnz6/2US8a5niEyaTYy/E8pv5swx+uz+ZzvPzuM92TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177963; c=relaxed/simple;
	bh=Qx94Wj5XUfL7qlT8nEaGaonKmvZPZ1FeC5KzWsa7ldc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hIeLmN8KZGTb6tpedC5Ao2+IDAsuezuVuY+T+Yrzafj1mnL1gvqBnCB9LVyLwteF9GcJW9IqLVXWR2xbAGyEf7r7enMtxuqn4h+rCBFW/gdxMp2DRwJKUpMmx1taeTRagFEdUGZQK/bsZEcNQTeyfLnwVCP8GRX4sHjRFV8gB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrswsKJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrswsKJe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7A8431F00A3D;
	Mon, 27 Jul 2026 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177962;
	bh=i+V2FsapE4APPhyF/J/VExib7DecvDP+CvBeJ5DvYhA=;
	h=Date:From:To:Cc:Subject;
	b=HrswsKJeigHrA4MkIad+ECm62Bd594MepvHemMXUlVScXSnthvnhVwa2Kpy+pcYjy
	 qZXrN4RhtYri0ohzzhWKSfJbkbOVLDHYqbWSU6JtKb5kay3a7AQ4wpl9YqeTL3GME2
	 SXmIoTPGGlqZmNrKxMzJw4aiV3vinCHNWg3gPT9MQFf6MkMT1qoWWlHvwizbw4d3Hu
	 8UbTpsNYs+tF+KjayhOI8rpXM3+kivzbPwO1Pb9tUZbgkFMumbjFUUcYD6FTocJ47+
	 5rQosh/oH9UPCApwVbC+H/BzHqsVOMSkDc8ewyaa4SYjEjjl1tSHKAR5uOOmwb7vtn
	 hnXtMP8qttbIA==
Date: Mon, 27 Jul 2026 21:45:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Fabrice Derepas <fabrice.derepas@canonical.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [GIT PULL] KEYS: for-next-keys-7.2-rc6
Message-ID: <amenZnA_QgqwMNeC@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 248951ddc14de84de3910f9b13f51491a8cd91df:

  Merge tag 'hwmon-for-v7.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2026-07-21 08:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc6

for you to fetch changes up to a82c8a05e86f3f84e09698f65b4515b5d04633f6:

  assoc_array: trim the final shortcut word using the current chunk end (2026-07-23 18:23:45 +0300)

----------------------------------------------------------------
Hi

This pull request contains bug fixes discussed in [1] and two fixes
(in one commit) from Fabrice for DCP trusted keys backend..

BR, Jarkko

[1] https://lore.kernel.org/keyrings/amINZJVhEBwxEixP@kernel.org/

----------------------------------------------------------------
Fabrice Derepas (1):
      KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type

Michael Bommarito (3):
      keys: fix out-of-bounds read in keyring_get_key_chunk()
      keys: make keyring key-chunk byte order agree with keyring_diff_objects()
      assoc_array: trim the final shortcut word using the current chunk end

 lib/assoc_array.c                        |  3 ++-
 security/keys/keyring.c                  | 14 ++++++++------
 security/keys/trusted-keys/trusted_dcp.c | 15 +++++++++++----
 3 files changed, 21 insertions(+), 11 deletions(-)
