Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792446045;
	b=RV5/JqdNT3x2XguNhUP5+L9l1dVJR8M6rp4FNUrgRhmL6HfMsdFUm77vmKAeKzNKGh0Z
	 jSFU7BeR8qSONCryLfiMw7No3g+IPUynrRGPICS53/2PdkEhKqZyZ244g/WfGElHq7g/7
	 HRfj8YuU3vm1yDNA6dfQ3Thal+cjD8IFqwm09MQb9FDeyCapkFpjtEmWikSCkcILyszlG
	 pejGenXXWZcH6qqZUbyS7DfON993CYP8yDaC3W1CpnntvtQMpMDs5KH5ZlcoU2IBqR8sj
	 eJRbxPJ5RKbqTwvJrCYGZ28J4SaZDTnUoaZumEZo8lxqnQH1JTviV9/cfC5C61vOodw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446045;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jurHIDrhl6KPL+vb3cebyYVtlyxHhq6VSQQuboTgOOs=;
	b=izbkxZGcxmdCkkvLfVnlJ0pQa23lh4r7+O0KJFkCEzwZxmfCMYBavLba6u8mLmzeRzY1
	 IB+nkkoVGfVt0y/2r74UEWiw/QGrpurtN2OkH0yQxFxAWhK3mfEiHpxxqgCh0lqTsqeae
	 obGFQRvi8Gsdp3wcbD1Xme/+39TXSZB48ceBMt9sWMu431/7wd+sx/8+yDRHPxpUShXm+
	 iuPmR/BPU9iqDcfQJpYvGVHJniiuoOROiqVvOJe2bG+2n6IhnVro4GVNZ6XkAQPkMqPNq
	 58tDfBCDiU0fs15lc7MCo/BB2RWjN7aaMiTN0xiDLmnBfOKY2XhjFGwNVKCayrXHQhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX3FU4EX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2D606A325;
	Mon, 19 Oct 2026 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX3FU4EX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792446045;
	b=qBQ5pdMi2udIK7P/5VKB+8k2QHAtPRL1EdC0OuNSsBJe11t6FQ/M7jGMRFfoKfS9i/JH
	 Mx1AMt7W4i7fd9itAwxqLLCUL3+c693bcDOpfbEjVuyRI+oXg6d3tIKup9dawPlQdQ9hx
	 GfqBM4dmd/4WCcifGvPyUWZwhx+KpPw1YjHxnL7mwH5vepQyu+Oatvh2LWQ8eEKE7IFtN
	 hPP5I3hOPjzfJmf+vLhPTqR0gHGwv48fno4y7tHgAAv9fgnpHeEqdnaRP7vBX1UOdLmYw
	 nz4oIroUuUpX//MjNyblJOrjkSlWwI+D5T3kRKRPPkTokJXkWnbxN6NsjKaFwoV/f3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792446045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jurHIDrhl6KPL+vb3cebyYVtlyxHhq6VSQQuboTgOOs=;
	b=pZVA8OuhuHl0LgX154R69ASxV+IdWcxdl5FsugfjCaerDAQ1bcgEc0rn5MdmhdkD8GVe
	 fpS9UDdojY740w37eVlYmTN/FtzHNeerFYIwj2cecsh02uhGQf3TRY3CpuBxGBaTjKLCB
	 geueYSczGcggsXnP6SrM51kadeKyBhoKmoeJSMWc431xro2bds+IARGS/jaoBHQKsO3BV
	 qTTWwxnCVTFO8SV+3p6/L/ceuXHhfk4CTUknuAZLSsreIdQxQtgenNJYYNSWKh5Y/rGSd
	 j/Ec+12aADh4aUxhKTBOZrQwtx5SM8fKyWAPK//TP2aWw70X5X4BvsDL1i8yY0RpTwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2D061F000C8;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446045;
	bh=jurHIDrhl6KPL+vb3cebyYVtlyxHhq6VSQQuboTgOOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kX3FU4EXdpRTv3843JHwzPjntQQHEOhC0Eq9Gn3p9xV6gG11QsLp18uqjbUMSzOak
	 ipGDQx3eFFZovxXzTzPQW648zEffuKJWBxYL0s9Ueict2qBiQvL/CMI4dR+thG4bjR
	 TyjJKsjtSvV/ZtCJPOaAN5qxIzOzStNzveMWN0ob6uAVQpoly9mdwpRj/OSjB5zau4
	 g9FP1ocPRAzsuKemGrxQRdf6O+e4vexpc/HgJckaxbWwaj45sphAQfAeQEIay292QM
	 pKVT7NFu4UaSi35KCxDZgzCDhWI6ixLuHl0WLhe2whzlcGAzz+XvdPTd9BQ0iKyjzr
	 mZc8MdyMb/piA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 155154063D;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Mon, 19 Oct 2026 21:40:27 +0000
Subject: [PATCH RFC 3/4] Documentation: ipe: document the IPE keyring
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
Message-Id: <20261019-b4-ipe-keyring-rfc-v1-3-156f0b93e843@nvidia.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
To: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manuel Huber <manuelh@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792446042; l=4917;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=bQSlVKSLE/vFXclrnH0WGlD57ySt0pDqaCI7PqKjvz8=;
 b=LeRG8q2weFYyCzPHBXqZC5UUlqvkvzwvk8VeM4N7+kedJjkHqVy+hnuVIQ+xrFVEi0iR32rAm
 7fUQYrHrKA3DBUiCrfmMsjOPbsMLoFlwYPYdpBypAVhMf9xZU2Fw6SJ
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com
Content-Transfer-Encoding: 7bit

From: Manuel Huber <manuelh@nvidia.com>

Document the .ipe policy-verification keyring and its additive use
after the existing trust sources.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 41 ++++++++++++++++++++++++++++++++++-
 Documentation/security/ipe.rst        | 16 +++++++++-----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index 9e82a2082b94..48ccad203301 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -238,7 +238,11 @@ unconstrained root, and deploying an "allow all" policy). These
 policies must be signed by a certificate that chains to the
 ``SYSTEM_TRUSTED_KEYRING``, or to the secondary and/or platform keyrings if
 ``CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING`` and/or
-``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING`` are enabled, respectively.
+``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING`` are enabled, respectively. IPE also
+provides a dedicated ``.ipe`` keyring for policy-signing certificates that are
+provisioned by userspace, as described below. The ``.ipe`` keyring is an
+additive final fallback and does not replace the configured system trust
+sources.
 With openssl, the policy can be signed by::
 
    openssl smime -sign \
@@ -251,6 +255,41 @@ With openssl, the policy can be signed by::
       -outform der \
       -out "$MY_POLICY.p7b"
 
+Provisioning the IPE policy keyring
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``.ipe`` keyring allows a system to provision an IPE-specific policy
+signing certificate without embedding it in the kernel or firmware trust
+stores. It is not linked into any process keyring. Userspace addresses it
+directly with the ``KEY_SPEC_IPE_KEYRING`` special key ID (``-12``), which does
+not grant possession of the keyring.
+
+The keyring is restricted while empty by default and cannot then be
+provisioned. To provision it, boot with ``ipe.keyring_unsealed=1``. Userspace
+can add a DER-encoded X.509 certificate and then apply a reject-all
+restriction::
+
+   keyctl padd asymmetric "" -12 < policy-signing-key.der
+   keyctl restrict_keyring -12
+
+Both steps are required. IPE ignores the keyring until it is nonempty and
+restricted, so a partially provisioned, mutable keyring is not a trust source.
+The restriction cannot be removed. More than one certificate can be enrolled
+by repeating the ``keyctl padd`` command before restricting the keyring.
+
+Restriction prevents adding keys, but it does not prevent userspace from
+removing keys or otherwise disabling the keyring. To lock it against further
+userspace modification, drop its write and setattr permissions::
+
+   keyctl setperm -12 0x08030000
+
+This retains the permissions needed for verification and inspection.
+Provisioning, restriction, and permission hardening must be completed before
+relying on ``.ipe`` as a trust source.
+
+Once nonempty and restricted, ``.ipe`` is searched after the configured system
+trust sources. An absent, empty, or unrestricted ``.ipe`` keyring is ignored.
+
 Deploying the policies is done through securityfs, through the
 ``new_policy`` node. To deploy a policy, simply cat the file into the
 securityfs node::
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4490aed5918a..80f9893dddb5 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -248,11 +248,17 @@ policy updates have to be done rebootlessly.
 
 To allow an update from an external source, it could be potentially malicious,
 so this policy needs to have a way to be identified as trusted. This is
-done via a signature chained to a trust source in the kernel. Arbitrarily,
-this is  the ``SYSTEM_TRUSTED_KEYRING``, a keyring that is initially
-populated at kernel compile-time, as this matches the expectation that the
-author of the compiled-in policy described above is the same entity that can
-deploy policy updates.
+done via a signature chained to a trust source in the kernel. IPE can use the
+builtin trusted keyring and, when configured, the secondary and platform
+keyrings. This matches systems where the entity that establishes the kernel or
+firmware trust store is also authorized to deploy policy updates.
+
+IPE also has a dedicated ``.ipe`` keyring for deployments that establish an
+IPE-specific trust anchor from userspace. The keyring can be provisioned and
+irreversibly restricted. IPE uses it only when it is nonempty and restricted,
+and only as a fallback after the configured system keyrings. This keeps the
+existing trust model intact while allowing a policy-signing key to be rotated
+across boots without changing the kernel image or a broader system trust store.
 
 Anti-Rollback / Anti-Replay
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
2.53.0


