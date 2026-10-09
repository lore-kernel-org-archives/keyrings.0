Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4694078CA
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541163; cv=none; b=U0LErfyC0FO+KZnqhKrhi3jpmB9gIho4ashRvqtNCfZp9GaxqpLnOFUaT9fZ1+uaxlmbknv8DZdndQc/5YjB9fodWDJdXGMFPy9joFRhc+/YrJcyGTvsWmnT94bDDggO8/FAcp42aEv1ZNefbEFAOmqkaV8RFvrg887WOJmmXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541163; c=relaxed/simple;
	bh=hZhsorpyhrdePy/eS4UBgZy3PoTlUAnavPITsk1OkvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhND7sa5nFh+9ivuXCt+iLaxmd1Qo3SRZVFWcVCaOicEdK4Z2tH25SFiQJUuOO1f8cInUwIREb3o5ENn28tCAACKaRxd/RPzxgOTrztEf+w4Oxn/CFf/2XaFv1OQhFniTlozCTZVnK9Yn6k+BGr+9L9pCo1sZt8vEizUSH87xZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=egicon.com; spf=pass smtp.mailfrom=egicon.com; dkim=pass (2048-bit key) header.d=egicon.com header.i=@egicon.com header.b=BvDBnx8n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=egicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=egicon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egicon.com header.i=@egicon.com header.b="BvDBnx8n"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1923f15afso333825e9.3
        for <keyrings@vger.kernel.org>; Fri, 09 Oct 2026 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egicon.com; s=google; t=1791541159; x=1792145959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/IxRkMGThu4h80nLCH1Odchuo85RZD5Hjt36tJqVTTI=;
        b=BvDBnx8nC08RrqlYhZSKKf6LOvcsIv8KTrEy6A2VHCUy73c5jWtJlCNEllUFvT5g87
         m50sq3t4TALfi+YhlZ1Nm5OObhWXWAGUKxAsrOzxaSeepYRKW9NszwXNkMzmcDRXZH+7
         4d1OFKfcsMGqJsJCE5zLvW+8Srf3XhKJf+i842p0gs914TNjlLHhaMFrkH7LGEQ7mAHW
         wsiO8iV/h2sK0H/lUVaX/lubC0dUvXqS58vN//SU+2khTKRtlnO0C9otOhpPlOeWLKgN
         f+Y9q9GuIIF3Mkyg90Z6nsOpknv2Gox9xWXEajsSII4LW99rfrBpIyQ1cfNrTV4Zbk/N
         YAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541159; x=1792145959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/IxRkMGThu4h80nLCH1Odchuo85RZD5Hjt36tJqVTTI=;
        b=rG0N8lG5xoU5xOrixCklOwc3cvkEiaK6NqEqVDieN4w+Xchn7CYsRaFfje73kt09oL
         bdUmWKvvdUG+rgR4aMBbmga09lXg0pjDkiG+/OBryC2rT1BZpKW7tnzg4oNS/vNYrkBk
         +69oZqawtNgESL0L7Namx39PAgIGFgKZYmAnJXMYvJpvErKbN6D15X6OjpTK9wjGyX4W
         itKBfYz/IM0VvFVBw3Bjm6bCX3L6rT6kkkaqY2sgNe3/MDUSk+Z1W1VpGsnXhmyoxg1W
         ogRZ7MeKqWFZaW5mFuyL9g2UWw14hzWd3O6fMSmyD0siP/48GIn32BtaMWgE7Jzrs/p3
         0xiw==
X-Gm-Message-State: AFuF++mimaBlkfCDTeja2/Zywv9pioVqxY8COyozfyTWf5Kzr9OsZUpb
	1lG5qI171owdR+2sqq8nwnLXjGIBfJ6QiWa9Oj/6JmRZd8yUJmzYLptIYWPC64rLCg==
X-Gm-Gg: AYBFou3IoadbQ5P87pbqPX5P1izUPuL2a5+7uaBXPkrjn9A5GkoVW6KC32p9qd/E2x7
	MoaZOMBDek/UAroVTESEegXRhxsOn+NwZpatSJQOHw/F0uf0JmGfLjSplmtQJk+w2BhJIm+tCkr
	1uScYyAXWIXbfMzBYZBHBESAWKXHMSCl8hezIU/CUCLWShiczhZ24kHCNpZJoHF9e3UAtRdnDBt
	jmUgP01/F5mZiZH6xjOvMSqgwlE7DtZ4SfV5r0d7EhpezHixANat9QCxLQUYLYDI7cCbszr2bLZ
	Yfb0++xEfUwBXmqUOGTe78JA5uIirc3R1/oIRWChsVjYO0s6Yjkk8JS2f8Hx5HSvuq88It6p6jV
	ze1+wM52ZO7PydxG8IDxS1Wi+nZ7KcyvfqAHGn3lC15HD7aH1v7+iTD9RBfOYZBdvXC9mwCJKLo
	2pdkLfo4lXd+Nfbv29RekBDiCFtlxOpNMLDD7S9W5c1RAENJIR2uZ+8wwSLotQ6NCZ4TuxZiimi
	jPniRg1XZAlg5cekAzhK6SZCEVZW1Qfmmt0EJwrE55l5QuSh/yFVJqB3IHlpBZJ
X-Received: by 2002:a05:600c:3494:b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a18e4fb31emr24381795e9.34.1791541158877;
        Fri, 09 Oct 2026 03:19:18 -0700 (PDT)
Received: from xpsmax.egicon.com ([37.179.95.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acf12bsm3189363f8f.46.2026.10.09.03.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:19:18 -0700 (PDT)
From: Massimiliano Marretta <massimiliano.marretta@egicon.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Massimiliano Marretta <massimiliano.marretta@egicon.com>
Subject: [PATCH 0/2] Add bulk signing support for PKCS#11 keys
Date: Fri,  9 Oct 2026 12:19:13 +0200
Message-ID: <20261009101915.495734-1-massimiliano.marretta@egicon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for signing kernel modules in bulk when the signing
key is stored on a PKCS#11 token.

Currently scripts/sign-file signs one module per invocation. When
the key lives on a PKCS#11 token (e.g. a Nitrokey HSM or a
SmartCard-HSM), every invocation pays a fixed initialization cost
of 25-36 seconds, which dominates the actual signing time. For a
typical build with hundreds of modules this is impractical.

This series adds a '-b' (bulk) option to scripts/sign-file and
teaches the kbuild system to use it automatically when the signing
key is provided as a PKCS#11 URI. The classic one-module-at-a-time
behavior is preserved when the key is a PEM file.

Patch 1/2 also extracts the body of the signing logic into a
dedicated sign_single_file() helper. This is done to keep the
new bulk loop in main() readable and to avoid duplicating the
argument parsing logic. The extracted function contains no
functional changes with respect to the current upstream code.

Measured on a build with 50 modules and the key stored on a
SmartCard-HSM:
  - before: ~24 minutes
  - after:  ~3 min 17 s

Note on checkpatch: the series produces a few "trailing statements
should be on next line" errors on sign-file.c. These come from the
switch statement in main() that is moved within the file by patch
1/2. The affected lines use the exact same style as the current
upstream sources (case 'x': stmt; break;) and are not introduced
by this series.

Massimiliano Marretta (2):
  scripts/sign-file: add bulk module signing support
  kbuild: sign modules in bulk when the signing key is on PKCS#11

 scripts/Makefile.modinst |  43 ++++++++++-
 scripts/sign-file.c      | 159 ++++++++++++++++++++++++---------------
 2 files changed, 142 insertions(+), 60 deletions(-)

-- 
2.43.0

