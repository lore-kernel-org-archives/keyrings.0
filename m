Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792446045;
	b=Mq0yBs5YII/RtjPhnPmTdKRo11oc5NvurJcSEUpxMobmFVA1TAc/So8MbE5xog7uRW99
	 PqOyH5z7TvaQJN1NWXGi8kKDnwmkfxHHXUgttWOy1txUe/BDqG8qAXRgqak7hm4ouYU8v
	 hG6usVvrMdpxK1N/66+XHl4BsfkO3fd9iW/bRRAVA/23cT3J9kErRY+mAm6wKVGRMEd2E
	 9q4F5MGU4QH5lis00ck5O/WlLU0fC3+gCmrWCxW6VrpLqi00NGWQqOPGbKBpJq8bUZHOj
	 jUFCHc8GuL9Z5gTpIWk+8FhQcifvzKrePBkV7KmKGz/B6CecyaPwyIFMpuBNUL7Z4DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446045;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6GJN1th4CMtwapjnje2N+N42yjiIBXhALvroNWjHZT0=;
	b=Uw+NcVwyrP2Lv4ld7tEqSxbyOhRwEPxGNOIsSuWCIH1CfdKOWMpvnJjWg2XJzrr6l7zp
	 5SoW8emYd0KbMSCyR6SttaO5FXt9RiqgCGxfXhMS4d6yykb7K0XPu2CjlLKtI3+5hTlEL
	 vb+yqAq29Kv7h4U1bz0q4sSwYHdp1XlBm4VQl9TqjU8jRI+NUCWslupKL/Xqv63Znl6d4
	 J7PwDmJSD8o/D7jDdHOPChR1M8raGbOZlIKvv3vQiHYz0eDWSxbQI1n8akrky4JsKeRKx
	 NPg2bNxMQPd7OcXVOuZerHJhsEdFcysEr6e0ZKJECjerzS7nMJCRfwH1LVNK4U15m7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CkG/Jsyc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B7606A31F;
	Mon, 19 Oct 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkG/Jsyc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792446044;
	b=AqvwL991H/sezuVC2WR18ixI4JiaTS9+swE1nc+zEyIGdcEnG2u+inh6nPFYD5utf7dm
	 3U/NGTD/0+iavVbkSrqG3H6tzJWxlj2DSH0DiG+95wiiGRSb72djiKp8+cNMAWSTuLRoJ
	 XupJMhR5uz+UOJjTbdokVT44hQEZiglKGllcw2+lK9wV5xce3uk8PPh8P/944szbzWCLs
	 P/ZrvANWiIobHyhwFk4KTn7qga2qwfHcW89QCjmUD3eW3ao1ouSCetI731M0oemkMoiPE
	 8U1EuTAKLHsRPkL1XAD2s7eWi599DdFX8maGXUja3pygGRJZ35PTGU1p6mTIGxr+tcw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792446044;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6GJN1th4CMtwapjnje2N+N42yjiIBXhALvroNWjHZT0=;
	b=zXLn8/9EgjCF9gUK+JryvFf8gwe+qsHwP7Ou5c3oPncifzmkOz1P7ULhWCNcntBTqz1S
	 FSns/qBr+iDA/vBzvjhHGznNLVbxySeM9MRkESI/LOjfitS3Z/Z6Km7KU+f6QgpD+LE4X
	 qZ5LWbEikJVZ8sOvJMErfR4ORps+l4PlmkNJxZaJjV5sM0LWQF74+/SA6VlF2KNxoHiLT
	 Mzhn07+TMOCOL4qfK6EgayRP70VWVZ3pyLg5DUguYEqNZmBJsuF8EzvBMUuF7pDrEAtbZ
	 3zTFRVbYowf4g0UdzaXX7N8eocbBomVJmZGqO+WGTmxZnJxup5qJRaXxqfOYNDQjoVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2C9E1F000C7;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446044;
	bh=6GJN1th4CMtwapjnje2N+N42yjiIBXhALvroNWjHZT0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=CkG/Jsycf5k3To5VbUAfB/ZCX+5KQwW2iLCjb3t9lDdDx44vdIg8FBqSMEntBh6aF
	 PrjXGMn090QQSB921317efnSPu6leetmSyqToobF1cEp/m3+QLnF/DqlFS1ZntPMyn
	 zoNavV+rL65EhPOp+EqifVTzdGLwDm6550yvDhUf3XW3V+MZ5tPFWBTz61KIeiC0oL
	 T4shbIbIAMRte/afoIGQE4jrqJ2Kh1VYi0MihSlpyk/O0lbmkfGIuCFmL80oBNEFE0
	 GqMhzW1/N+ftUyEyne8Rf/J6lm40lu6Ez8LszFQZf1vTeLk8ZydIsApGIwvlo6OpmS
	 Bd3TNoX+NXlAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F30CE40633;
	Mon, 19 Oct 2026 21:40:42 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Subject: [PATCH RFC 0/4] IPE: add a dedicated policy keyring
Date: Mon, 19 Oct 2026 21:40:24 +0000
Message-Id: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgO2ilBXwQO4ikOrUYNQJQVRp
 He3OL7h/xcCCVOAJntB6OLAh09QeQbTZv1KyHMy6ELXqlAGXYV8Eu70CPsVZZnQmdIZS0obqyG
 Fp9DC9z8doO9aGGP8AH+7iDNpAAAA
X-Change-ID: 20261019-b4-ipe-keyring-rfc-b93b9ae129a2
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792446042; l=2751;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=6WPcEAqFx8dpbBNrw8M+IL0uMQ7Yp3AICptgIgyBFtA=;
 b=gkxyREkuboghZ5svc2zXzJmD9W9S2bUyNSjdWo563ECwGLU3xuBDMg9oYuexLJePZ5edkrcMn
 iUDB19Lgr1ICwRUnqLsI5JMzrO0MYWKnXfSeG9B8v1dUd48rmk8lKcC
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com

Add a dedicated ".ipe" keyring for IPE policy-signature verification,
modeled after the dm-verity keyring, allowing userspace to provision
IPE-specific policy-signing certificates. Systems that do not provision
the keyring retain their existing behavior.

This RFC is based on commit 48f936e302a9 ("ipe: update the project and
test suite links") from ipe/next so review can begin before the
prerequisite keyring work reaches that branch. The series will be rebased
onto a refreshed ipe/next once that work is available there [1].

The keyring readiness check currently follows the dm-verity and BPF
implementations. A parallel keys RFC introduces keyring_is_empty() for
this purpose [2]. A later revision will use the helper if it is available
in the submission base.

Testing:
- Built an x86_64 kernel with GCC 15.2.0 and Clang/LLD 21.1.8.
- Passed all 33 IPE parser KUnit assertions.
- Passed all 4 sealed-default keyring selftests under QEMU TCG.
- Passed all 16 provisioning-mode keyring selftests under QEMU TCG with
  ipe.keyring_unsealed=1.

[1] https://lore.kernel.org/r/20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com
[2] https://lore.kernel.org/r/20261016215326.4110064-5-jarkko@kernel.org

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
Manuel Huber (4):
      ipe: add the .ipe policy keyring
      keys: add KEY_SPEC_IPE_KEYRING
      Documentation: ipe: document the IPE keyring
      selftests/ipe: test the IPE policy keyring

 Documentation/admin-guide/LSM/ipe.rst           |  41 ++-
 Documentation/admin-guide/kernel-parameters.txt |   9 +
 Documentation/security/ipe.rst                  |  16 +-
 Documentation/security/keys/core.rst            |   9 +
 MAINTAINERS                                     |   1 +
 include/linux/key.h                             |   2 +
 include/uapi/linux/keyctl.h                     |   1 +
 security/ipe/Makefile                           |   1 +
 security/ipe/ipe.c                              |   2 +
 security/ipe/keyring.c                          |  80 ++++++
 security/ipe/keyring.h                          |  16 ++
 security/ipe/policy.c                           |  10 +
 security/keys/process_keys.c                    |  23 ++
 tools/testing/selftests/Makefile                |   1 +
 tools/testing/selftests/ipe/Makefile            |   5 +
 tools/testing/selftests/ipe/config              |   7 +
 tools/testing/selftests/ipe/test-ipe-keyring.sh | 357 ++++++++++++++++++++++++
 17 files changed, 575 insertions(+), 6 deletions(-)
---
base-commit: 48f936e302a9c48cfc032eb5944c3a6246bc9043
change-id: 20261019-b4-ipe-keyring-rfc-b93b9ae129a2

Best regards,
-- 
Manuel Huber <manuelh@nvidia.com>


