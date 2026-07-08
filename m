Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A440928C
	for <keyrings@vger.kernel.org>; Wed,  8 Jul 2026 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525572; cv=none; b=bivG2H52SBHrLBGzN3MynImtZsIzTJUziK9ZZjad1rIoi1K6OkZ2lmDK39XyzZf7lUgTVkWvwnpo0xJZMJmeVF0ppnloaqkgTmQVL3B2FkqhfyOBP6NtPabglw39V3dws+0b4m+OEKFclD0n1tBx5pVFmbMqHnXDMUU6WG45Vgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525572; c=relaxed/simple;
	bh=6o/Os/YHoHLpbGBJ/Oz87lOS4kylKBP062qGBWElKsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvHE2zanww49mcXyGxkLT90YXvv9dng/ST4qh/7XrPQh5GEaaF8z4xL6nTW3yak1+vM8sGKTWnyeLzrudxcRM6i9ZT86WAoZvcCLfHOGSJKJjaFwYu30IoSCycvoF2+F63tHIyubyOy1CWarjTBQIxTeB6UZ2ga3Ry0PXxeW0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F/xDcraq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F/xDcraq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4720d22c94aso808527f8f.1
        for <keyrings@vger.kernel.org>; Wed, 08 Jul 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525566; x=1784130366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=F/xDcraqE7zjRny9dGpElvcrYP+TvLHulDUmHNdZhg0hx4k/ecCY84wCOji4oou5cz
         VXJpUOkuokde7MMu0flycEjUugRu4z0NFWPcqjYItrQ3J4nRTl3+vzC1w1b3HnpGNxdf
         H64963aqUef7jrOhAPDPzwH79R8InoYlihBzie9t14dqKK4Fl1xxfHrt+T3uIIp5iYi4
         gfE2K5QZBbk3aiPJN4k0Xu9STGQab/mn2KuaphtmU3Nl1u9Dmd/gQc4sqc0+srk3Dgcr
         JHFdBIBj+w+scyPJLw/BVf9V6UaVNl407BpnFBOfTrzUF22wnSL5rqwEUY1MvfPw1fLm
         ueMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525566; x=1784130366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=qpy1x8nhzhDZD8KewaSfAGhY9FcrxHuxu9QDz0QzacRHayiZ+hwg1Yofhx01UT4TzD
         bsWydMNwgG+QdnvE2W3BQXLgA/mtj/0rx6x3+FjAvGlNzWf8zgiZR7wU50GYka4+L0Bx
         yguauQwQV1HoXnpTktyLkISdWSY8ujQDTNToKlYO3JAEuefLFbaua9Yq2k/gSV5mdQPq
         h6HthvftJYSTBoCTexsiUE6SzPtAnlKN0X7KqnqRmt8rwnqIKT2LISguKo8oH5Vu23c0
         00JwCIDxTHORK/Iln2d/5BqagVAhFtUYKqlQ/Da4mkvJ28vyTFHXKqCFxF8STJIUN8Zh
         ZHyg==
X-Forwarded-Encrypted: i=1; AHgh+RqphF+q5RfhIVdIEQSYOxlZ4hmb3Pixw2CfJQMdQ4lz8WZvKTXyvdfS3oXx0Z1HkNRtUPNTK4FRaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hxGW0r2rz/ZeEZ2r7oBIPQ/Q4D+SeexV/r6+8gqW0FDy/wxw
	aJ6rhNce3/s0WNejnx6qExd6wTBWworeKdd5TeE3twr40s8ZVD7wKp1NAaudDy3CuLQ=
X-Gm-Gg: AfdE7clVY+y30k4IdmfXbNWBPw4T3aqyYdqxmDxry9x6S14alFTaD6xO2RRAu6HrWoV
	NNniQ6GIth8gKmxC9Rn0PjFymVuY9loTnTclL9oPanCzvU30wpeCC3kmkfhqfYy7IH2uxCE9Lu8
	8r/G1nFfdjLzMsDxKp6ApftQntUX07a2yvV8sOT1ZYzIs/8ZHt/MuDBlzBWSVYFw1j8iop43u6W
	sArV6B8JwjIhBEoTrEUykz3Jjw9owFT4XAyKt2X2Cy9CfKBAvTIiCoye4FLnz0hF3MJveoSc48c
	W8I/tpULfSKIC5CjOK7mCUu0TBCW+os9Y2O+cd5IwPUnK3NW4qw93g1YxFmNRU0tMKMFzU+S+E5
	xHIBYH68hBBba5nzIbHZZoaZBneYwJVuEKd3EzfPxf1KSoa4KlR9VXS4da1Ku49GXZo47Ot/WoZ
	ECOk6yvDtqaCP6mRr8WPfBxgaAkBGFfg==
X-Received: by 2002:a05:6000:26d0:b0:473:673e:3836 with SMTP id ffacd0b85a97d-47df078bb73mr3861713f8f.28.1783525565920;
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] module: Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:30 +0200
Message-ID: <20260708154510.6794-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708154510.6794-1-petr.pavlu@suse.com>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value
-- 
2.54.0

