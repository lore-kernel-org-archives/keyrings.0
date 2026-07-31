Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CFC468C31;
	Fri, 31 Jul 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515274; cv=none; b=fhIQ9U1eMxmbU6bFD7kJdGSk8EADINrqFqc7z24kUhpO0gkTBE3hjA5AnzPX5Ow07b5Tz/aggxfR9fR80hbOKNCOyupmpO3pP3M2P5YGWr5/OHzFegqRXodwX4YNwddil96rKC9L2RyFJQ720WIlKgHlCjkgRvqvMdTdkQup/Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515274; c=relaxed/simple;
	bh=wnDbWj+1PJ4QZuNB2xApjO969pIH2+RuqA5XKIdiDAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUcj6FbFAmuVisMs+BCN2+wzIcnBzsrks/WEnnf3hRZntv2+LfG+3YH+kq/VR2Q5PjZcfMVlC1C8gez/qcDdMtMZ/37CLrZ5nUdbfSedkThQR45QYjazV0fdsVPpRo5rT1sAK4bB79R5BYA52z6EU+Rf36Ja0or8uGKGed0t2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de; spf=pass smtp.mailfrom=jaseg.de; dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b=hjt7qbI8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIog68RB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jaseg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaseg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.de header.i=@jaseg.de header.b="hjt7qbI8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIog68RB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 489707A012A;
	Fri, 31 Jul 2026 12:27:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jul 2026 12:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785515267; x=1785601667; bh=Ak
	DiARroLHl6KyOSQsFmxb3G2BExRBvYjwZc5Dx3u/U=; b=hjt7qbI8FvJ4RGjJdD
	r+b04gl7p1QRerLb0BU6Qjqhzsbe98Z9KzJqYf/dtm64O+FQPX83r8MVn85oNcty
	z0X4fZFhTfhtlnL9GJEb/+a7flBMG+vfdR1Z8OGNRSs9860DQe3FP3lGxPOBJdfn
	iljIDSVMfNMBuLzwSLjP1Dv6039KS+wRlPW3+67Dz/H/kriDQB19uCIYmaO1xgRV
	go5hJxjKfkxsRV77vUCZTtsB+3ZTzJyQotrho3ngrN10KtKDaBm2Jef43UPC5BrU
	5pb2ZAfkXZ4pNWPHtue5rCUStMagoYlbfT96d7YzpzdYcYncJSC3IXGTp/FglyPo
	9d+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785515267; x=1785601667; bh=AkDiARroLHl6KyOSQsFmxb3G2BEx
	RBvYjwZc5Dx3u/U=; b=kIog68RBao2r7bX5vkaWRkHXGnVWOrTvgIXKQuXYAo4z
	kFPTuTcql3TbCIEkT+M7cimQQ9oojLJ5yf8UfEABGVee1sfju96P87ZjZhnMfNmQ
	zz2mVGb38+bzWQhHbnN1ygw6LZDVhJjmctGkbeoSQWqhrpCJDXB2K707Q31UveL8
	Yhoq54BDIOgjwqH5Q0l5bSJO+DwUcNzEgbssWj66zFDgCd1Vpq8rKZGfqyaxiuWV
	KK9ZBvVEGWFNVf6MxO/J9vKG0oMJ2PiJLhN7uF0RjWn38b0IJ7LdRcrVl8X6D3oe
	w1eNj6FEIxQXooALj7DM9C0QOjBgz6KjQqB4+Hb3EQ==
X-ME-Sender: <xms:As1saiP_jfhX6GxIfUz0AEi6cQqX8LkLsBfks7M8Z8n7vSlCurwPXw>
    <xme:As1sahbKlAdCSupSrwigUrcTeai2C4AYFIMLY53SqrdDcTFC3DIaE7D9_C_WDbvOz
    zjakWFmFq_RZuHbL-Nf74z24lx09sjzy5B1FGyhMQRyC4Fin1e5Yg>
X-ME-Received: <xmr:As1sap_LOBHM-lQwmoMck9ftRnlGzUdL8mXA8NrTqsaDkaskAxgErhFqyqka3WYT6DgqSjX-mtGemuL2Fg>
X-ME-Proxy-Cause: dmFkZTERcFVP8HLW6lWAJcoFMNKyac4KI1WLdSW5Cwyv5Q1y5Mf4zQwvfs5MLKguSB69WD
    9WWeywtKpWZQupz8iqlVwAqXwfVPcIpA0zWAnoln2vFRMsZ5/0NyILUu8khRqxHSc+porj
    sEXnf9R/frKCLFuO4k5EcgxmebF1dFZDTkmYpB+ZAE5NcAqEp3I4Y3cayAywGXcJ60CYux
    wuFhlPiLKYPaRlGZg0yinrrIvHHDYX1E/rLPP65YNds5yJbzqICjaYNfhvUiefT9If22bU
    f7VjNiBbYA+da5ag1FbGIeOOmrseEOyOe8lOF/5OW7GKqFFgn78JwI4GwuDa0h1/tS+0In
    xKVxvjXkh6CkzfdyxZiM5OOVn0agfJYkWpqT6pE8JQII6BKhMdou4AjkmEHEb2BTkUnZzB
    NkpZb57BBGM+hRziXHB//LM/E+laIWVcdxlNrnssRcml3jAmjx5JQY+s/+BKxfzbU7FDXq
    6GHNqUAWLZWoW7/Nn1FFbqNIAqPGsJSPbn6lPot1Tu3108NWr/O0vU03IHdZ+xcLjc+t3W
    NcXQMmR1IZc3AYP+fNT+QWVFv+G0GdyzVBSTTl8DK45xcmmN4q9adVeLyiZFJv8kIme3ig
    97wsh6m3BzxC7g4Doe/g+fe9tu9zcKtl+74wrHDhGd+ST7cG6x7V1AhPjzjg
X-ME-Proxy: <xmx:As1saqRzf2z8nikH8v8Fgk7vE5ReXwTwewxy_kYa4GDi7drpBd2y8Q>
    <xmx:As1sarfN__oFApAvj1SGHFP3MrJMtgNiDb8ydhAAWqEKr_0CFdeS5g>
    <xmx:As1sakQC5jgRbzn602PtIDau365wCeo8O_PAZLpKdY79c-n97kTf_A>
    <xmx:As1savLmxUrf-42QUT7-WpWLe0rwf8vAz7bAQS3G9pxat6ux61-LmA>
    <xmx:A81sahcUa2-2m8h52Tj7OKAHdnM6S6QDlKncYBV6WH5ku6rJfAlLYW43>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 12:27:45 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
To: =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
Date: Fri, 31 Jul 2026 18:27:35 +0200
Message-ID: <20260731162739.158320-1-linux@jaseg.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm using linux on an embedded target in a Hardware Security Module-like
application. One requirement is that I want the system to be able to
quickly erase its memory when it detects physical tampering. I'm
approaching that by using kdump to load into a small payload that
instead of dumping RAM, erases RAM from start to end. However, writing
all of RAM, especially on an embedded target, is rather slow. For this
reason, I propose the mechanism in this patch series:

Add CONFIG_CRASH_ZEROIZE (default off), which when enabled makes various
subsystems handling secret data do a quick, targeted wipe of these
secrets before kdump. This behavior might also be interesting in cases
where you run a normal kdump kernel but you still want to keep things
like fde crypto keys out of these dumps.

CONFIG_CRASH_ZEROIZE is a best effort, defense in depth solution. There
are circumstances, such as when a panic is triggered after memory
corruption, or when a panic interrupts some operation that mutates data
structures under locks, when the kernel cannot safely wipe some memory
areas. The handlers proposed in this series will just print a warning
and skip the affected areas in this case.

This series introduces two handlers as a starting point: One for kernel
keyrings, and one for secretmem. Future places where such handlers could
be added would be for example drivers for crypto accelerators. 

The patch series applies on top of linux-next but should work on 7.0.0,
too. I've tested the patches on a Arduino uno Q (Qualcomm QRB2210)
embedded target.

Jan Sebastian Götte (4):
  of/kexec: fix typo in comment (usable-memory-range)
  kexec: add CRASH_ZEROIZE to wipe secrets before kdump
  mm/secretmem: zeroize secret pages before kdump
  security/keys: zeroize key payloads before kdump

 drivers/of/kexec.c                        |  2 +-
 include/linux/crash_core.h                |  5 +++
 include/linux/key-type.h                  |  9 ++++
 kernel/Kconfig.kexec                      |  8 ++++
 kernel/crash_core.c                       | 18 ++++++++
 mm/secretmem.c                            | 50 +++++++++++++++++++++++
 security/keys/big_key.c                   | 15 +++++++
 security/keys/encrypted-keys/encrypted.c  | 12 ++++++
 security/keys/key.c                       | 44 ++++++++++++++++++++
 security/keys/trusted-keys/trusted_core.c | 14 +++++++
 security/keys/user_defined.c              | 11 +++++
 11 files changed, 187 insertions(+), 1 deletion(-)

-- 
2.53.0

