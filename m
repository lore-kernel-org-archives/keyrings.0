Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674965;
	b=yUjl0nrsZBEVj2qJoWLEgQ8Fb/XN5CzmpUq1jxVEjOK9qAEFCIKbdUcRhdZ/hk2j5Ibv
	 SgZZ6SvEYLR+2dcBkKQniUsd5df9TaaxLc6rbe6k8yju1rFEVZOetiIAHE22sEpc25eDC
	 hZlF2EA2M8219VhA0Y6dZS4b5Ke5RUvnfMEiMMpvnC+LQ6ywxWjvc4MR5gfg5Ld6SMs/U
	 Eev+ylgI54XParyBMa3IXIs2QI+7f9kj9qSD4JwTYKWlLxXZYAXDwCtfDKJpCM3UoYwIT
	 hFqbitFC8RIc6+BYqp5n9Wte4d+DI4VzzDlrNn2iJuAYeFBEcSTtKcBEEHAE5yapFfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HbeNZQv0ykKKYaZtsI32V97es7WUM1tUrBOIJGxvuu8=;
	b=tL4BXApp41oeBhzHFhOVoSgirGzl7tZYCsiCq/dsZpybCc8ZQ5Ss3eCuuzgXxgW/qrcD
	 1XPDpzpYGhdC90GfMO6LngWtoAHDvc2SE3XpGklfgVsp3baGtz+aq8alR6WpU679NUSma
	 xijZnWsMC0CQO82NdZ/KmEXMkbry5zZZn8hIbPdJrrnG97z0dMHnK+wjZcktplfY/oKO/
	 zajlRYEljnoBFS95iH9JJbZPK5VQmrfA7dp8k8CYXYDMNjDRK5kwKzLX9fq274SfczlPG
	 QSlgTf6qGQ1V8L3U3dPUaPnn9xbOsv/FjZ7Jn6gnLtpZBlzOiTDMrzvvzfg6RnVhRjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1oSfw8w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0620606A32D;
	Tue,  3 Nov 2026 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1oSfw8w
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E38EB1F000C1;
	Tue,  3 Nov 2026 03:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674964;
	bh=HbeNZQv0ykKKYaZtsI32V97es7WUM1tUrBOIJGxvuu8=;
	h=From:To:Cc:Subject:Date;
	b=N1oSfw8wxKawnxXp6ZXVy0Ok0/LzqHHY/c8iu3lx4CFovyEZKRL9RPCjdIsTD43pe
	 NEDxbAlUmlcDUkagL+veb0KbQM3ZQQ1CKPBpMLNN9Sdwbf9sUbmGkhXvjlBiVkMi4X
	 TfJoMBAX28oHBdSHn4DjKIk8l+uec5ShFZ7QZITM7FWQ5EPVybD2g8apT63Wg4hfkQ
	 elP3qc+8w5qqXd2TICEFc53o1iljD3w+c9mh8+vTRpKagpWPLvl/z+bUfY7FLH5uyA
	 eJPk9cpFBZnIDHw6b6DTTXNfEJfojoIgDQo8C9u631MjTtTbtGpc5QB+ay8awhotBi
	 7jRFwAbNT1UwA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
Date: Tue,  3 Nov 2026 05:02:05 +0200
Message-ID: <20261103030226.2685251-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Remove key_type_dead and replace it with the regular module semantics.
2. Replace variable size workqueue items with fixed-size 64 key chunks.

The first change has user space visible effect: rmmod semantics will change
from always succeeding into returning -EBUSY when keys or restrictions have
the LKM pinned.

CHANGES
=======

v2:
- Used v1 as a test probe for Sashiko to detect the corner cases instead of
  trying to resolve even the known ones beforehand.
- Converted the client subsystems to be compatible with the module pinning
  semantics.

VERSIONS
========

Jarkko Sakkinen (11):
  KEYS: Add key_gc_flush() for draining RCU callbacks
  nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()
  dns_resolver: Clear .dns_resolver cache when the last client unloads
  NFSv4: Clear idmap keyring cache when the last client unloads
  smb: client: Clear idmap/SPNEGO caches when the last session is
    unloaded
  s390/cert_store: Track subsystem keys instead of re-registering
    key_type
  KEYS: trusted: TEE: Disable sysfs bind attributes
  KEYS: trusted: TEE: Synchronize session lifetime
  KEYS: Pin the backing kernel module for a key type
  KEYS: Remove key_type_dead
  KEYS: key_garbage_collector(): process in chunks

 arch/s390/kernel/cert_store.c             | 161 ++++++-------
 drivers/nvme/common/keyring.c             |   1 +
 fs/afs/main.c                             |   4 +
 fs/nfs/dns_resolve.h                      |   7 +-
 fs/nfs/nfs4idmap.c                        |  21 ++
 fs/smb/client/cifs_debug.c                |   2 +-
 fs/smb/client/cifs_spnego.c               |   8 +
 fs/smb/client/cifsacl.c                   |   8 +
 fs/smb/client/cifsfs.c                    |   8 +-
 fs/smb/client/cifsglob.h                  |   2 +-
 fs/smb/client/cifsproto.h                 |   8 +
 fs/smb/client/misc.c                      |  19 +-
 include/linux/dns_resolver.h              |  13 +-
 include/linux/key-type.h                  |   6 +-
 include/linux/key.h                       |   2 +
 net/ceph/ceph_common.c                    |   7 +
 net/dns_resolver/dns_key.c                |  28 +++
 security/keys/gc.c                        | 266 +++++++++-------------
 security/keys/internal.h                  |   7 +-
 security/keys/key.c                       |  61 +++--
 security/keys/keyring.c                   |  85 +++----
 security/keys/trusted-keys/trusted_core.c |  15 +-
 security/keys/trusted-keys/trusted_tee.c  |  87 +++++--
 23 files changed, 450 insertions(+), 376 deletions(-)

--
2.47.3

