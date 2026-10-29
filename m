Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793233877;
	b=DfV5U2od0YLdBuA4q82vXaRF6iMIWvfaiEjnD0YzuNOZSBDL7ea1AA9h7V2DxAUqw8vi
	 fzaHR1Pt/mY/R/k4b7UETDc24p/KY9/22hhC1EtI6/PCwLSjgBbpnpLSdS0F5Xuh68wGb
	 HyO6f2QWXu55VxjckbOfBsEUgVAQ5qrZSfPI8EbU5fDPGyIV1LR3rYiNUfdMGKTN1h+cu
	 iaxi29kNxw5phF2/R915uISzWTGMrgCWp9wo1WfNCrdE1xjkCkfaox+ECuHaGpdILQb/F
	 dRI6yUJV+tmN505aGqviMuuJRD4Jr+Ee8pirocKtVf4q00snhbXI5BDe9kmZjeMrHww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233877;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OpMMrA8IeY8HAs415SbOKXgXLWzFA9y2fARLg8NLTxs=;
	b=O7MzYo8Juo8zkCfLMyqLKcsgK0lpTw5apiYMBhUEEgB5rrHkI+1E3YUvxeM6uCIS+Mo4
	 wSohtW6sRWh+smm3j3Z4lkSmwiopJr89C+/Lj9AbxCqvv9E3vyilnS2Mv61zl1/E35CDx
	 Xq1WfCpp9JHVRgCR25mMs2VrBqT2Bb1d7CUkzYhMo5FsJF1D4xIGhATlPfrY8YkwrDdfT
	 VAHBtsax/4TYVDo/e0W6os4qW5hk/0NtKTyj5uGDXkFoF2JSLHDlQblb4glHazCs4MQHX
	 4VsfDEcBVMv4Y/c/lI686s/ob1n88igoh3qQ27l5dXJ7qIR6XbH3STLhBMpEoh14gVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nfz3RUUd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E81606A31A;
	Thu, 29 Oct 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nfz3RUUd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793233876;
	b=NpBw3wMl2q2aBddvn84rIEI4VUaVvNOmGY9OYrcYpj/Otr7lG/KumFTt5fuWjoktiErJ
	 m8/Xd+J0wJ94SitekaGZkZvHRwAoDMfsks42ggJME7Xpg4M5thlwgT22fRn+XeG1twTKT
	 XM/akkBhM1xsgrz1bI34VwPOaFc7sd+RZGumjeBIEUmMSo/juRHsBgj+KRmY/BDLEhOnh
	 rOceijNA+jPZP1BPAqhCBE2QmiFVSaRSxtfH72h5LZvP5oDN93pmKudo5uJndjmZjw3V+
	 doSUdLhD44AivL7PzOUdVjqZyzs3MuK3lHgqs3baq3TyhW82np4RUEkCVT4g3cdPyzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233876;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OpMMrA8IeY8HAs415SbOKXgXLWzFA9y2fARLg8NLTxs=;
	b=tgVLNSIMglT/dYeR0PnoV3R249yUwR5h0mRToV6jIBmLg/0T70G8Eyfeb4bLEmd5xLAl
	 bXQjWzQA34LKggUdp7j5KkEilPmkuVylRSPZTvmnr3CSlgVUVHcGBXJvbkrbXjCTkK6Q4
	 mBekmDijE6ZSejkKbA6OsKmVjp3TjtT4lvAf7kpEriwN6Ou8r0bOScyL7B/AUi5uVCDz8
	 7OFLLpbXVPiCqThdA3FOu7vSPUF/s0kzJyxBcNqsA+Ef69dt3RkQnp/3R0gtWW+8zZ/Oh
	 vYcCIfl/B6H39bBVVRrjv7miRknuBE+cP2jTjSb2Z5Zl1Iggoa9XQ0P+TMnQ0eDbIHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 139991F01825;
	Thu, 29 Oct 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233876;
	bh=OpMMrA8IeY8HAs415SbOKXgXLWzFA9y2fARLg8NLTxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nfz3RUUdVaaeDjohiUQxcZmUJjBUMDCINlWEkJHWUq30WO+tLOaLElujHHbClXZiw
	 3LbftPXjyzECWCtImLyhcGKyMabiZUvYLsydNdG4L2LiCUOA2wi9Dh77uvJP7nCSxL
	 gimfXAHFGNh3X0AFfShWOR1DJbM1RKQ+yLsBCIwNcElWZAdRK34LY+cbz4hUgE/ZpS
	 DgybvOhW4KA03TmapV/i9WlG2GeXWwJENFm4uxlcOUOMv1jGZtKrgP3GCW19clr7BJ
	 r8if+Uj8bKP02kz/mNPsDY35TRp6lxByvV0tjUJCpT3cqJk6vaTONjPDcsSQwlrw3q
	 U3mEc6gjb3fqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8A8E245650;
	Thu, 29 Oct 2026 00:31:15 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Thu, 29 Oct 2026 00:30:40 +0000
Subject: [PATCH v2 3/3] Documentation: ipe: document the IPE keyring
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
Message-Id: <20261029-b4-ipe-keyring-rfc-v2-3-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793233875; l=7376;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=c6HprXLFky8e7ORPVl+bvRdWeZ7XXPIzbHqXHBte+VI=;
 b=fqWIj+x7IAsvMeqhgtjjcM8LcyN96AZBIQzGOknWaN9odCkUskRFI0rpxcBDMxkJ0b88dLgP5
 vsQIeWDAZkoCW1yAFKrgVijdj8mY3fD7Niv7PxYmgh6FslzyTGNtDH1
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com
Content-Transfer-Encoding: 7bit

From: Manuel Huber <manuelh@nvidia.com>

Document the .ipe policy-verification keyring with its additive use
after the existing trust sources and the userspace's role in
sustaining trust. Mention requirements for maintaining policy trust
in kexec scenarios.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 77 ++++++++++++++++++++++++++++++++++-
 Documentation/security/ipe.rst        | 19 ++++++---
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index 9e82a2082b94..273f9c3d62e2 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -150,6 +150,39 @@ Additionally, IPE draws hard security boundary between userspace and
 kernelspace. As a result, kernel-level exploits are considered outside
 the scope of IPE and mitigation is left to other mechanisms.
 
+Userspace-provisioned policy trust
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When ``CONFIG_SECURITY_IPE_KEYRING`` is enabled, IPE can authenticate policy
+signatures with certificates provisioned into the ``.ipe`` keyring. This
+differs from IPE's other policy trust sources, whose roots of trust originate
+in the kernel image or firmware: the userspace component that provisions the
+``.ipe`` keyring becomes part of the trusted computing base.
+
+That component must fulfill various requirements. The component must:
+
+- run before any untrusted userspace component runs
+- be backed by code from a trusted location
+- obtain its policy inputs from trusted sources
+- complete provisioning without failures before allowing untrusted code to
+  run. This includes adding all intended certificates, applying the
+  reject-all keyring restriction, and removing the keyring permissions which
+  would allow later modification.
+- destroy the policy-signing private key after signing the policy, if it
+  generated one.
+
+The ``.ipe`` keyring authenticates policy signatures; it does not make the
+active policy immutable or otherwise change authorization for IPE's
+securityfs control interfaces.
+
+Note on Kexec: Kexec bypasses firmware and bootloader trust checks and does
+not preserve the ``.ipe`` keyring or active policy. Deployments must thus
+prevent unauthorized kexec or establish equivalent trust in the replacement
+environment, including any initramfs and command line. Controls that deny
+further kexec loading do not prevent execution of an already-loaded image,
+so any previously loaded image must satisfy the same trust requirements or
+be unloaded before those controls take effect.
+
 Policy
 ------
 
@@ -238,7 +271,12 @@ unconstrained root, and deploying an "allow all" policy). These
 policies must be signed by a certificate that chains to the
 ``SYSTEM_TRUSTED_KEYRING``, or to the secondary and/or platform keyrings if
 ``CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING`` and/or
-``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING`` are enabled, respectively.
+``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING`` are enabled, respectively. When
+``CONFIG_SECURITY_IPE_KEYRING`` is enabled, IPE also provides a dedicated
+``.ipe`` keyring for policy-signing certificates that are provisioned by
+userspace, as described below. The ``.ipe`` keyring is an additive final
+fallback and does not replace the configured system trust sources.
+
 With openssl, the policy can be signed by::
 
    openssl smime -sign \
@@ -251,6 +289,43 @@ With openssl, the policy can be signed by::
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
+The keyring exists when ``CONFIG_SECURITY_IPE_KEYRING`` is enabled and starts
+empty and writable. If the option is disabled, using
+``KEY_SPEC_IPE_KEYRING`` fails with ``ENOKEY``. Userspace can add a DER-encoded
+X.509 certificate and then apply a reject-all restriction::
+
+   keyctl padd asymmetric "" -12 < policy-signing-key.der
+   keyctl restrict_keyring -12
+
+Both steps are required. IPE ignores the keyring until it is nonempty and its
+restriction is the reject-all restriction installed by the second command, so
+a partially provisioned, mutable keyring is not a trust source. The
+restriction cannot be removed. More than one certificate can be enrolled by
+repeating the ``keyctl padd`` command before restricting the keyring.
+
+Restriction prevents adding keys, but it does not prevent userspace from
+removing keys or otherwise disabling the keyring. To lock it against further
+userspace modification, drop its write and setattr permissions::
+
+   keyctl setperm -12 0x08030000
+
+This retains the permissions needed for verification and inspection.
+Provisioning, restriction, and permission hardening must be completed as
+described in `Userspace-provisioned policy trust`_ before relying on ``.ipe``
+as a trust source.
+
+Once nonempty and restricted, ``.ipe`` is searched after the configured system
+trust sources. An absent, empty, or unrestricted ``.ipe`` keyring is ignored.
+
 Deploying the policies is done through securityfs, through the
 ``new_policy`` node. To deploy a policy, simply cat the file into the
 securityfs node::
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4490aed5918a..8afa8172c9ec 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -248,11 +248,20 @@ policy updates have to be done rebootlessly.
 
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
+When ``CONFIG_SECURITY_IPE_KEYRING`` is enabled, IPE also has a dedicated
+``.ipe`` keyring for deployments that establish an IPE-specific trust anchor
+from userspace. In this case, IPE uses it as a fallback after the configured
+system keyrings, but only when it is nonempty and has a reject-all
+restriction. This model makes the userspace component that provisions and
+restricts ``.ipe`` part of the trusted computing base, for instance a
+component running in early stages of the lifecycle of a system. The
+threat model and provisioning requirements are documented in
+:doc:`/admin-guide/LSM/ipe`.
 
 Anti-Rollback / Anti-Replay
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
2.53.0


