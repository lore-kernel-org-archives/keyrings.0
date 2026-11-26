Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702358;
	b=KN+/rSTZ09DouyqtJRX5lWBEP4uogJJrsdI+84+0Ql77BiwkDMHf0iujJTV+Vrboi3RH
	 oqfoqB8uwZZsFEj5NaZjlKv0sO3jONt4UtxxDzAfLVssmPjeVe/DaZYHeeCNQxdER8hLf
	 6OKMgSoOp9TaTU0bxIBa4zza27Ghhe8hhRXHJJJlWmnP2mrdmjBchIbYTIBgc81gNVi3P
	 trWKZvauMCmMXsLPlkEGeaYLi3nNq2YO2jp5G7c5BmJ2wMSQUb4u5fqA7d4JFMQSL+mxg
	 3Ph8EFzBvLIZzQkWmksAXv+s7ocZtmWO5ueN12G8T2gr4/S4bIv4+6qtWAp3emuJMMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702358;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2bZHJ+NzaqOrSFu4+4BGl1SG3jfELd4rw0w18kP2wbg=;
	b=NNRqi0SBT1iimnbN8E15U44Q12h5QCXw90USTNJk1gOwzTp5NkC1fZG0GahgNm/E9vuC
	 SBnHJHcuyCs62j7K9zFXmys5b6wC7aW43xPv+l/JOlRH4/XmI//jw3U0Or0tg5AVPy9jT
	 9wnVetrjp62GW/RxPXOoZnYR6oIbZMA+9RR1wGg3yVVAAaxycrL4ua+11zj+UUVdO8Pmc
	 n/LF1+l+3cm7jGXjc4IZBmDs1NDCn5nRtpfzvogSmZEa+2SfnuegBNgCJlmhqlNDnp8VP
	 pwteBGlSgNtupNy6TkILfQQT7JCegQUazW7Z4HLwHD3co1FI4D/xseJmFJ2ITYL490g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTbw2A9R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1E606A32C;
	Thu, 26 Nov 2026 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTbw2A9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332831F000C6;
	Thu, 26 Nov 2026 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702357;
	bh=2bZHJ+NzaqOrSFu4+4BGl1SG3jfELd4rw0w18kP2wbg=;
	h=From:Subject:Date:To:Cc;
	b=GTbw2A9RSzuDMIwAEHA0GuV4TMo2zTYsWqIU29XfSnw3bFGheGTDSvkyRR0RgLH+S
	 bhEx85YHeAR8jCvVLzukUcYzq1IKU6LlIxWj42wbnx3YDSdTeIcltFzpIDYRu4lZ1q
	 TShe3vSuKojvVJCdieOayyDRjRiWfmUVLExHeXFDwd5os/0L/6bZk3YpnCawrz6RcH
	 Z6AztOy5cG3SGEFy70NHU5oqo+xGC7xZfWS+kMEg+QJjCg4dBpEhXvSgKQ3rDXed1F
	 +zcWPd8TdI1KbXhLU5B3RB8ZtoHFZbilKeJ4L2DTnud6XelrluxySYP/WXurzgQSmn
	 wkH7HsD8D9oqw==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v7 00/14] nvme-auth: switch to use the kernel keyring
Date: Thu, 26 Nov 2026 15:12:18 +0100
Message-Id: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAEM+CGsC/4XOTQ7CIBAF4KsY1mIA+WldeQ/jgsLQkpq2AUNsm
 t5d6Eqj0eV7yXxvFhQheIjotFtQgOSjH4cc1H6HTKeHFrC3OSNGmKSUEWy73E+4hzn4ocWJY1I
 70mhDbWUEyndTAOcfm3m55tz5eB/DvE0kXtpfWgGxcJVRtq6ZBDj3EAa4HcbQosIl8UocvxEiE
 xUFcA03RDH+Qci/hCxfkIppXisqdPNGrOv6BJZw8D45AQAA
X-Change-ID: 20261120-dhchap-keyring-v4-09f0bac1d8c5
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
 Martin Belanger <martin.nvme.dev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=4000;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=EVI8g3eOLrBTbCyDoqJaqfs500gdELPondgS7V0OTX4=;
 b=ovEYJtFJK1YaKtphlFBOoRWM24BKtrrMquCyqbuIM8bplwP1RekL+gg8Z86KY2nEPHeiWV0bU
 Z+mD6g80RV1B7/KcxGswujiQ3Y/xNAjBkAzeFgOd7J6h1oySm8KRttS
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Hey all,

the current NVMe authentication code is using a hand-crafted key
structure; idea was to have the initial implementation with a minimal
set of dependencies.
(And me not having a good grasp on how to use the kernel keyring :-)
That had the drawback that keys always had to be specified on the
nvme-cli commandline, which is far from ideal from a security standpoint.

So this patchset switches the authentication code over to use
'struct key' to hold DH-HMAC-CHAP secrets. User-facing interfaces
(namely argument to 'nvme connect') remain the same, but the key data
is converted into keys which are stored as a new key type 'dhchap' with
a random UUID as description in the .nvme keyring.

With this I have updated the dhchap arguments to 'nvme connect' and
the configfs interface to either be the keydata (ie the original
interface), a key description, _or_ a key serial referring to a
pre-populated dhchap key in the kernel keyring. This allows for external
provisioning of keys and avoids the security risk from having to specify
the key data on the kernel commandline.

The entire patchset can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
branch dhchap-keyring.v6

As usual, comments and reviews are welcome.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
Changes in v7:
- Fixup next round of issues from sashiko
- Modify to use key_serial_t instead of 'struct key' to pass key references
- Include suggestions from Martin Belanger
- Link to v6: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org

Changes in v6:
- Fixup next round of issues from sashiko
- Fixup kbuild robot issues
- Link to v5: https://lore.kernel.org/r/20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org

Changes in v5:
- Fixup issues found by sashiko
- Link to v4: https://lore.kernel.org/r/20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org

---
Hannes Reinecke (14):
      nvme-auth: modify nvme_auth_transform_key() to return status
      nvme-keyring: add 'dhchap' key type
      nvme-keyring: drop nvme_tls_psk_revoked()
      Documentation/security/keys: fixup function name
      nvme-keyring: link addtional keyring into .nvme keyring
      nvme-auth: switch to use 'struct key'
      nvme: parse dhchap keys during option parsing
      nvmet-auth: parse dhchap key from configfs attribute
      nvme: allow to pass in key description as dhchap secret
      nvme-auth: allow to specify the key by key serial
      nvme-auth: wait for authentication to finish when changing keys
      nvme-fabrics: allow to pass in keyring by name
      nvme-auth: link pre-provisioned keys into .nvme keyring
      nvme-auth: allow to update pre-provisioned keys

 Documentation/ABI/stable/sysfs-nvme  |  10 +
 Documentation/security/keys/core.rst |   2 +-
 drivers/nvme/common/Kconfig          |   2 +
 drivers/nvme/common/auth.c           | 232 ++++++++++------------
 drivers/nvme/common/keyring.c        | 370 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/Kconfig            |   1 -
 drivers/nvme/host/auth.c             | 176 ++++++++++++-----
 drivers/nvme/host/fabrics.c          | 169 ++++++++++++----
 drivers/nvme/host/fabrics.h          |  12 +-
 drivers/nvme/host/nvme.h             |   6 +-
 drivers/nvme/host/sysfs.c            | 300 ++++++++++++++++++++++------
 drivers/nvme/host/tcp.c              |   5 +-
 drivers/nvme/target/Kconfig          |   1 -
 drivers/nvme/target/auth.c           | 250 +++++++++++++++--------
 drivers/nvme/target/configfs.c       |  84 ++++++--
 drivers/nvme/target/nvmet.h          |  15 +-
 include/linux/nvme-auth.h            |  17 +-
 include/linux/nvme-keyring.h         |  47 ++++-
 18 files changed, 1257 insertions(+), 442 deletions(-)
---
base-commit: 68099cf27253a8c89d703a282d3d811446d9453b
change-id: 20261120-dhchap-keyring-v4-09f0bac1d8c5

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>

