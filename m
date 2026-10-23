Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758490;
	b=RieYm6GnDjHicg7zubagZrOWM9hSkcDJlk4qD1DL6Mj8yOmtaKHR6txvwlrP9U1jLrBa
	 sfx4gXtmFZH3oX52oN/1m2ET41iGfRGAVU01+H/AHACNoLKWb5iF8uoeawL6bLrLY8Fe/
	 rVKWJfg5RalEFUkxryiJrQql8QA2VUEtHsjIQco0Dcq2SfiyPFQy9jwsIOAASJ8Z3diSK
	 WHo9isIMoiU8VatCxIel7/GvG2H9rxKFNk+ynoc89Di2l2hLfYTaNRvcJNC2ZRld0owB9
	 EsPFiwOMHnVw/HPg3uNW2AZviEvQcQJpYJA46Rb5mtiQmlV4Au9LPl9Tn9f5ttnBgPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+8g+zaUdwuaMAYX7tKZS8H/PpvML2JWI8kqV+Tu+IpE=;
	b=Dzi8Z8I2jUXci6LjCAdN+Js9TBeyNYKPAD8gvHe2caROmxcjmbtl5QioFqTiu0jFNnM5
	 yfibqbiFhGDo16T47VQnoF/oHtfGwbgn5yh4ZlFCWysmsdZgiQzRUdF1+HiEpv3ajfbN3
	 2TG++gHuIwfjhO60d6JB1F6jK7go1vKyBloCKozEPSXIgjqeuwMPANKdSV+1hR7IWnlTX
	 O7Gxxz4qss4VfouwEvsSOEWF+lZEy4GOhwwK7N8n6C+WimZkn0SGOxiR5dAWznClAvmvG
	 Vtk1KDuLYA0nmH594QPGBwG8tETxXBfeOp26E9bWjLy82pKQiCtYCj+f1PIdkeHx8Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU9jUqla;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 60C74606A31A;
	Fri, 23 Oct 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU9jUqla
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9369B1F01825;
	Fri, 23 Oct 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792758490;
	bh=+8g+zaUdwuaMAYX7tKZS8H/PpvML2JWI8kqV+Tu+IpE=;
	h=From:To:Cc:Subject:Date;
	b=LU9jUqla7mR+9SPXfT3tywrtxCbE5FiWfWoyKaU8cF8V3SnbvCXFb8udFfIyxhutL
	 L3UzYK/dTgHdDU/NIIGj8Gjg0YsvGluz56hTHqFIdo+Gv9/qv5KRmo8FlQxRbvQ9+q
	 cX+rHwhJ/2bX5x7mYJfAB9xqay4uoh1BrTmH0h1Sx3BzC8HGDwfu5RWs+4YTINUECQ
	 Yr4ZAtJCaaHTq+TZxrhAxqpFLEbvXtHPZaAIdd4vU0yT2uAJxjV6yOLjTlBwODbnBt
	 63Iuq6OzmoK4PdrOQYia/5gFceAgr9WJULV11GSN/duJ3BkPdVBpI0jDm4+Mtzi6yZ
	 +1wJd6oMogQYg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
Subject: [PATCH v2 0/6] KEYS: From assoc_array to rhashtable migration
Date: Fri, 23 Oct 2026 15:09:20 +0300
Message-ID: <20261023120953.1206778-1-jarkko@kernel.org>
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

The keyring subsystem depends on assoc_array for searching keys by their
description, type and domain. It is the sole user of this data structure,
which has during the age of LLMs transformed into a maintenance nightmare.

assoc_array needs to be replaced with a data structure meeting the
following criteria:

1. Must be suitable for a sparse key-value store.
2. Must have multiple in-kernel users.
3. Would be nice if it had dedicated maintainers.

rhashtable is likely the best pick from the available options as it is
designed for a sparse key space, has dedicated maintainers, and multiple
in-kernel users.

CHANGES
=======

v2:
- Tried to address all the issues pointed out by David and Eric. Tell me
  if something was ignored, as that would be an unintentional mishap.
- Updated and trimmed the source code comments.
- For assoc_array_edit I decided to go with two-element pointer array,
  which shifts a bit what David suggested.
- Dropped is_keyring flag. It was so obvious call so I mention it here
  just in case because too obvious maxes out my self-doubt ;-)
- Used cleanup.h primitives where I possibly could especially in order
  to make fallible initializations more bug-resistant.
- The already-ack'd bug fixes are included but will be dropped as soon
  as I've sent them over to Linus.

VERSIONS
========

- v2:
  https://lore.kernel.org/keyrings/20261016215326.4110064-1-jarkko@kernel.org/`

Jarkko Sakkinen (6):
  KEYS: Expand key->{datalen,quotalen} to unsigned int
  KEYS: Reject descriptions larger than KEY_MAX_DESC_SIZE
  KEYS: Verify the key identity in __key_unlink_begin
  KEYS: Introduce keyring_is_empty()
  KEYS: Replace assoc_array with rhashtable
  lib: Remove assoc_array

 Documentation/core-api/assoc_array.rst        |  564 ------
 Documentation/core-api/index.rst              |    1 -
 .../zh_CN/core-api/assoc_array.rst            |  473 -----
 .../translations/zh_CN/core-api/index.rst     |    1 -
 drivers/md/dm-verity-verify-sig.c             |    2 +-
 fs/smb/client/cifsacl.c                       |    6 +-
 fs/verity/signature.c                         |    2 +-
 include/keys/keyring-type.h                   |    1 -
 include/linux/assoc_array.h                   |   88 -
 include/linux/assoc_array_priv.h              |  178 --
 include/linux/key.h                           |   27 +-
 lib/Kconfig                                   |   14 -
 lib/Makefile                                  |    1 -
 lib/assoc_array.c                             | 1724 -----------------
 security/keys/Kconfig                         |    1 -
 security/keys/internal.h                      |    9 +-
 security/keys/key.c                           |   30 +-
 security/keys/keyctl.c                        |    2 -
 security/keys/keyring.c                       |  871 ++++-----
 security/keys/request_key.c                   |   24 +-
 .../dm-verity/test-dm-verity-keyring.sh       |    2 +-
 21 files changed, 457 insertions(+), 3564 deletions(-)
 delete mode 100644 Documentation/core-api/assoc_array.rst
 delete mode 100644 Documentation/translations/zh_CN/core-api/assoc_array.rst
 delete mode 100644 include/linux/assoc_array.h
 delete mode 100644 include/linux/assoc_array_priv.h
 delete mode 100644 lib/assoc_array.c

--
2.47.3

