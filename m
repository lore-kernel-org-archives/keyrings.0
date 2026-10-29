Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793233878;
	b=PcUiZEEbh7+6kX/lSTAsO1XYJQzHaJxwiR8bGBBqQaacnvmp0mjDFxECczhKQy0uLVpp
	 WPwQV1iURfg1EBOENwfYossdhYfLhoYZyi83ssvbbPgQ7oq7cO6X1njrAu6ctD+Fvt3l/
	 dr0aRT3L+pPqwKOL1+2nkNLhpnyPMMY4uCcnkjeo/3CrlxOGW2Yde5PNmj0WbqjnoatRB
	 5VwYYz4rlCN65Qyo8m4BSlH4ZYW1FaBz3LDiw7tuZ4ImX2ls5pNj3xRO3GoyEDD8woFky
	 +NYMy86jXwfAAnvrTTZzjFGvnZNs2T/Ud4vBmIVuWK1T2h6KjCZWSCbOTyrrbv8OwYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233878;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6igf4MLXgRFM8Z+Ioi87X451yx61Kkxpwy6iuQ6dvIg=;
	b=gsGi/mqby0yFy8gU2d3/ge6/xfrzM/Rm8Y3E1OOFuNcU4CYHTUP7JQa62YRX4C1yzwP+
	 YO6UBHheuBBW4eCzUNOWRuYEjHSsuZ/2fkQn57YOM/Bhbxihe+U7tsBFjR22wp3f4mYMw
	 0jVekljMXloYM/0ZV6jyyVuWbaftGGTQzm7Q7rLse5IV1JxloFddigyFYIY28twef9WyU
	 k/xvTpgluKr+EHzVFs8OU8wvPticZA4nrzZSyHE1o68G6n8k146nkQUDbMzFaRl4sMTBZ
	 PUJQAc0HsSlFsMZZUnR7rGxSNU4V83buEno67VKhVRhecJImt2N5FaNXogUHAtE+u1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6xGsjjW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337D606A333;
	Thu, 29 Oct 2026 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6xGsjjW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793233877;
	b=E+rhWHXBJvf6p4cOhKI9whpiK9dUTOU7eWxjgXUdX2e0BGgRHI5tCwSga+JifpfmfXgJ
	 abh1l2p9B8iWa33HeYSf2klH34ccxYE/hwE5T1Z6lTkJQwYF5Tv9sg/uaf/Bb5jdLRmtj
	 RKP3sFYe/6LqOyI4t9PnYVHBP+JSO1oHuECh2q4Dqyn7dczybJwM/VLvXNTzRJxTiaXMI
	 AXlIxC3eTIdiZBshfUNWurmYJyOjCjchxkCTcjdqzVCy9mZzzx+k0rTCnSK+weHfmnNFF
	 zNwWIqrKKUBBd2d8mk8UP75nemBV3IyWUumk/0+QKFmC3bKNgvZInj70Org4WIeBfwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233877;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6igf4MLXgRFM8Z+Ioi87X451yx61Kkxpwy6iuQ6dvIg=;
	b=llkj9ua2HGxYX/+GlmFQbtcjSRPwGpkyIxWeOtZ9xvNWS0KrYmb6TSgfsjf5MImTSQIX
	 o6RPqmKRHlHl/7QkCWq/6/VkkDvzJlkAZ0V+8ulQYFMbPnp98Na2TI5DH03h2s5HTofk9
	 RW2tijrj+kdsMU29y3gEMkA7MxwRiDhB07KeBu8KjGG2zRWCjRZ+ZU9X0JO9lLHYBFA6f
	 +x+KQNSbR+/xaq0Or0MW4uwt2KR/yhK4IGHjrkbK3SB7ViXJa2uB8fw5M0YlSmBJ+1c5A
	 9ndZaZsoPThzZhEY+pSuJDJe1fp1rlfTK4YrYZM/ii/5z8YM/hAmtwJihKtFwVDtsxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13A7A1F01829;
	Thu, 29 Oct 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233877;
	bh=6igf4MLXgRFM8Z+Ioi87X451yx61Kkxpwy6iuQ6dvIg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=U6xGsjjWZ8tm9J0oOSNTrociqWDbnnvih9DrVpkAWVLQrRhmxLJ/XPIiM1zceLgtC
	 kLESzZblSH1HDt1rPHi1zHWcVLUZfcHT9qJyBOx5XbFyMA66Ac9En3ufh8LzoL2EXO
	 Fa6/nIbI/aXbxemVeJ6EY8VRNAFfs/syK8EB8jzmOwMu5/wh7ZB/dtRtnE0EDDdDcZ
	 1+Db6rnvjBb0lV8anblHFl8ZMZpFaaSzC3n9r2wyURwBfDJ3GlroZ0i2XGQSE+jLXr
	 QEwPCh49UNezbyXDrKaomURbNGw0eaGyiXS8eizy2RXjYy64dMRKXfHxWx72eZNDFM
	 AEvdRXmJTMEbA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6227845648;
	Thu, 29 Oct 2026 00:31:15 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Subject: [PATCH v2 0/3] IPE: add a dedicated policy keyring
Date: Thu, 29 Oct 2026 00:30:37 +0000
Message-Id: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CIBBFr9LM2jFAayOuvIfpAujQToy0AUNsG
 u4u9gAu30v++zskikwJbs0OkTInXkIFdWrAzSZMhDxWBiVUL4XUaDvklfBJW+QwYfQOrW6tNiS
 VNgrqcI3k+XNEH0PlmdN7idvxkeXP/s1liQLlpfeihunatfeQeWRzdssLhlLKFxAewIm1AAAA
X-Change-ID: 20261019-b4-ipe-keyring-rfc-b93b9ae129a2
To: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, Manuel Huber <manuelh@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793233875; l=3522;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=pTATwWDEl4HWcrF9PyrJWcbEkLf1+DklVc30h0qdx5g=;
 b=vDmytWLoNFu6z92hq+UUXOOaRVOC9WPlYNxEWJbbVI+bBd9Wh4fTTtwYSB85f7xz/+Xf1p0iH
 oA0oLNoSbQSBRM0M3jPBepMg+EUjIqDohlmCmxUePa09iqheN2gf7ZR
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com

Add a dedicated ".ipe" keyring for IPE policy-signature verification,
allowing userspace to provision IPE-specific policy-signing certificates.
Systems that do not provision the keyring retain their existing behavior.

This series is based on commit 48f936e302a9 ("ipe: update the project and
test suite links") from ipe/next. The BPF, dm-verity, and fs-verity
well-known key IDs are now in mainline [1]; KEY_SPEC_IPE_KEYRING follows
these IDs at -12. The series should be rebased once that work is available
in ipe/next.

IPE currently checks the keyring's entry count directly. A separate
keys RFC proposes keyring_is_empty() to encapsulate this check [2].
This series does not depend on that RFC; it should use the helper if
available in the submission base.

Testing:
- Built x86_64 kernels with GCC 15.2.0 and Clang/LLD 21.1.8.
- Passed all 33 in-tree IPE parser KUnit cases under QEMU/KVM.
- Passed all 2,364 IPE CI cases under QEMU/KVM, including eight new
  .ipe keyring cases [3]. The CI changes are in draft PR [4].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62c457528529
[2] https://lore.kernel.org/r/20261016215326.4110064-5-jarkko@kernel.org
[3] The CI run used a local compatibility adjustment to locate
    usr/gen_init_cpio on this kernel base.
[4] https://github.com/Integrity-Policy-Enforcement/ci/pull/4

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
Changes in v2:
- Drop the RFC designation.
- Replace ipe.keyring_unsealed with default-off CONFIG_SECURITY_IPE_KEYRING;
  leave provisioning and restriction of the enabled keyring to userspace.
- Require restrict_link_reject before using .ipe for policy verification.
- Access the keyring directly instead of through a lookup helper, and panic
  if keyring allocation fails.
- Explain the per-guest signing use case and the reason for avoiding a
  static private key in guest build artifacts.
- Retain the well-known key ID commit, but refine its commit message.
- Define the IPE acronym in kernel-parameters.txt.
- Document the userspace-provisioned threat model and kexec requirements.
- Drop the kselftest commit; instead, add tests to IPE CI's policy_signature
  batch [4].
- Link to v1: https://lore.kernel.org/r/20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com

---
Manuel Huber (3):
      ipe: add the .ipe policy keyring
      keys: add KEY_SPEC_IPE_KEYRING
      Documentation: ipe: document the IPE keyring

 Documentation/admin-guide/LSM/ipe.rst           | 77 ++++++++++++++++++++++++-
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 Documentation/security/ipe.rst                  | 19 ++++--
 Documentation/security/keys/core.rst            | 12 ++++
 include/linux/key.h                             |  2 +
 include/uapi/linux/keyctl.h                     |  1 +
 security/ipe/Kconfig                            | 16 +++++
 security/ipe/Makefile                           |  2 +
 security/ipe/ipe.c                              |  4 ++
 security/ipe/keyring.c                          | 32 ++++++++++
 security/ipe/keyring.h                          | 17 ++++++
 security/ipe/policy.c                           | 17 ++++++
 security/keys/process_keys.c                    | 23 ++++++++
 13 files changed, 217 insertions(+), 6 deletions(-)
---
base-commit: 48f936e302a9c48cfc032eb5944c3a6246bc9043
change-id: 20261019-b4-ipe-keyring-rfc-b93b9ae129a2

Best regards,
-- 
Manuel Huber <manuelh@nvidia.com>


