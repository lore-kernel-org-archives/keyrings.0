Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184934E762
	for <keyrings@vger.kernel.org>; Tue, 21 Jul 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639571; cv=none; b=HiIMgu3200q8YEs7I1daVMW8XpJMiGYLZxFhNTpzuFZQHIBefuziKwuZh5d59LhkwDjA53ZnXKK8g6o9Ame2bij8Wsg2SfuOY0rvKpk37224yuJ6sApW29EQRXFxH/mKB71iI5gbDcNZ8gqaepdmtE7BFK+b7ytnR0UkEpi4idM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639571; c=relaxed/simple;
	bh=roviBJb1B7iQhUITwXosnTCAe4xvx3i/dIY5PCDwenw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw1fM9qMItMtoA69XG/R1/k8Z9lUNE1V9UJUIFzLg6z6qI7aSsz1byRC6PryNQfyZwbw01gN+NIUB724L/zTn2XELHQvq04kPsQ8N+yh3ZSMWmTY8c2C+zj6L1UdZceqXZ1ncZiATW00quHndS01ZA+delbHLNP52qB1TnR+NDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LoGxvBpD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LoGxvBpD"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f752b3423so1874753f8f.3
        for <keyrings@vger.kernel.org>; Tue, 21 Jul 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639565; x=1785244365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=LoGxvBpDEU586mANHKg0AlOVLSwjxUwcerLWqBCuDTqB3BKr12xDPuAeaITf0OJ5u7
         pW5MXZkNE0Spz9kUiB9YFRowyZ0wzFTcuAQcWOmZNSNocM1lGunteIJ6qMNsP+7LQHCn
         K9g4hWqiodIzksvb86yTlUcAOgIE59cm3keL138dQdp2+Aqm72Oe/K9ovJombOHk9b77
         q7K21gZoQ5BwAZI8RwxdUwRFZcTCvQniV3IZouqx83co77jWHl0m4ZIhqH83wfbTdKJo
         gJdyjf/44/40tPfp4ckSZbjo5gpkBplWyQ2sI3AVC3OjkfeUBdeeMBulLolpi/ubh9oF
         H8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639565; x=1785244365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=k5ClrGWTl7odcLoCyZQfZhKfNEdD4l9V+6+XFh/KRxti1GCqEtQVN/3nW+UZ+d052H
         vPCRUX0l3qx4s4JJLqCt/K4JZUoYeOLV5Ocpi7XywmHrJ+c/R7uxado5kuS2LpMc/QNx
         lc8Evg5DGKtk51T09YKTYvfGAMSr7sD9crwWRe+FlkKdCwNISEInkzNmPBX6h/ra3l6W
         BQPpmfZCLYycGCcjAkcr5BSV2BrJkex5Bwl+3qQCsW4Lh+LK0RGNgO3wIrc86ThvuaEL
         yrz4eHnWdFyIwmtb+mC1IaV1Zc/5+lJxCRZzwGcXHLGYTNon5nSzqf6rA4lQi0I2bvtT
         CnmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdKL2onT8wS0hjpOAKwv125gkMJvj+UvreGKZ8eHQReeFM6Mm76ykweyYAqYb1GgG5r6ta1OYqDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5RSnXjh/mfTrBVH8mP4O3V8oZlSHZMYQeS3iQoWZgnEdfUFe
	TrlBXEQWU6ut9qu0GtRyL30qVeBg5weHzP49B0jm8CV5FPUfvyjodqdpteAnQFXTQQk=
X-Gm-Gg: AR+sD12SqX6L6WKju1lJbStv289olDY1htmSB9FZJZa7uS8m0oL7PIIz4OSNERtW40E
	3wnqMGu/uqLU8kmVd2JHHoUMrGsv2vnq6FzEnxphFskJUpaDbTw4VyhEY6/aNNmgjgOnz0+6QHz
	imxnovxsNkrq64RHL4GHJ6NzYmYt7qtAmCHl1qcAos4QDRuHqjBspydsEBhwHa6lvodJZE0vB5J
	eeXqVw7qbdSX2InhHI8VXZRgtkDPLT4zNIQw4y9bKoVGK051GwsEh6B8Qy3qDblpAD8cGvrSNF0
	DqqmvVi+mW5Mks5OG1TBE5mxKin3vtgLV/XCLST553uglxpkfj+tsV3DHwTqcZHMG6dewCc5S2N
	2LT/btqu/e9nD14YIZc67G1EzNfbaGh92yh8x4qCiwywekMwTaU0nFv6ulusTxica81mNsxJlHg
	==
X-Received: by 2002:a5d:64e8:0:b0:47f:6fbd:8a17 with SMTP id ffacd0b85a97d-47f6fbd8e65mr15616435f8f.59.1784639564680;
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
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
Subject: [PATCH v2 3/3] module: Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:27 +0200
Message-ID: <20260721131207.803760-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
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
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
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

