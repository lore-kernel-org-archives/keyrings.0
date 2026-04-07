Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285C72617
	for <keyrings@vger.kernel.org>; Tue,  7 Apr 2026 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540399; cv=none; b=GmJsufdPbiLn8nQMB7FO1a5nttqCy1Lco7McR/m7UY2uxlbXdhT5iceOh9EvsWNuiAbMBR8FZadXR4uDB+Z7ueOrRYC6jJsT8Mqx3+a0+sxr1TBEOz6EKuADKeUiNZzy4Ijk5oBlQzqarUIyT71Y8Se31Ltqdw3K2LlP2EJQBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540399; c=relaxed/simple;
	bh=CPbR4ynt7lEIxU7KeKqzmpsU+S0DEoU9918vVnGWAyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7lGtDg/eET/ziPZjBoj4Vd8IUstMAe5iw2II7M6tXd0segwHd19pELYf7qQKSPSmQe9nPlwKQ88F764wGKBwkKpZYbb2bGivxXWt5x6b4mrsQ3J7rthrYMcBg4bU8t0MBSTRu31EB32ouI1o+Stx0nHhGSYFIPDPGGQUc+VoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1HEselG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1HEselG"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2101113b3a.3
        for <keyrings@vger.kernel.org>; Mon, 06 Apr 2026 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540397; x=1776145197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6aWKXGZ6Pq+U28ptkw+X3vtfA+Mw7YFFm3cXv1/n54=;
        b=S1HEselG+5nNhY2Srz5kkiAmr2xgljZF73LFbllCg5dV2APgGIPPtGXQ7Z0H/O9d4U
         /nOu02Mnmmqff+ZxJKo4aVUhz/S6FrMxD/0E5xfnq4Ov69uZIhD742DUXdfuBqq5hbI2
         n5X+ghfPsMGJs3gVCPSZa9skLTvBYZog5MAwTQyJX3RfvcoRFl+ai29SAkIlpMnYhJpg
         Z++L9hry6+cgTmXb0e9f5UniMgRch8ATldMFvkzQ4x/uaVTFcbKmCXw6T5399KOGxIWv
         g3ptevnb/VVaBSax0HO6gKNY4tX1YocCIog44PmM+NeBXKHgutD+TLxvGnk7MHx36hd9
         H9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540397; x=1776145197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6aWKXGZ6Pq+U28ptkw+X3vtfA+Mw7YFFm3cXv1/n54=;
        b=QdGzT+aF6DUrxEuFPOQ02/Nhbe3TQxykqXnux3ui95OHAx2Q/duz3+mTJSRsZrx0Vd
         jYJzAoHta4ZK7fLMfmScVzRghb3/nesHzR/L3ml1GP8MIcQYLKY44EOZMdH8qP1l17vm
         mw6Lc00rDDIl1DI9c7fO0+6ZI3r3Ij8KgUIR064HYQyrtJTUDjLj+2koSXbc6qLvFtG8
         n+WbEbABtkSyYjQ0s4+oXZ6hyrcSCx+CPadlWL/UVUUKhlBXhypegunnsvh+G4QttHQt
         w8kHEz5zjn/QS4+YxefBmBcAFBeGv+/o9Rpe/AHF4/a2XXfgo0sI02AoxpceTDN5nxk5
         sudg==
X-Forwarded-Encrypted: i=1; AJvYcCVR/XERS3bomjxMbMnV9+GJwSJ9HoK1MFXkl8fHq/i7ZY3DzzD7ucBDXPhfayspnMd3h0idrcfXvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJIHUj/IEzv7DzYiH7SLDen9RqBKoz0cG3qpcLKTsdNmuaem8
	GMBAQ0yx1Pww5cXTrWvuFY8ZbqWmqLGdCxrc57MEYNlmFmHuGVE5zKn9
X-Gm-Gg: AeBDievF9vA9Clu+YYMZpC7wxTlUwOE4o5I681oKNXGu52VHJoyfCyUf8ze+CKL/+Lh
	K8qW6Bv5pkIJ6CgHB8QUnnVhp70Z8uMb9ZLSPuQ3PiCS00uQhw4guIo1dJURYobq8567r2pdmeM
	r94XNJssgzgbzfu3NrspnoOI0RZiWSQ2/IErj9Y8KXfIQeiC1VK4GEPgW+cV3BakLFWuxG0oKOx
	jgUtO71sAFucOJjAZ58vBQT329Irj8zLPiradsyizOmGkBpT0pe1hQc1OBMb+nXaLHNiPiyI3la
	EwVFAQHSLsNeDOEdbk+2dD5k4VvCP7tb+aZiT9cMi28q8Pah5qIRw46M80LXHrlof2rrfkPDU0Z
	oZiFJDaz5c2kGpCj/+aY+31s58GnTvWmA/t1Ubx/JOmzxI6GKpbCAjVoKmdcDPtnMiLZS/A2h6/
	1zxNXmMjqZaUwDHtNXJMll
X-Received: by 2002:a05:6a00:ab87:b0:82c:dc9c:e770 with SMTP id d2e1a72fcca58-82d0dbb2ad9mr14100756b3a.40.1775540397159;
        Mon, 06 Apr 2026 22:39:57 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b23c6asm20873248b3a.10.2026.04.06.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:56 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	keyrings@vger.kernel.org (open list:CERTIFICATE HANDLING),
	linux-kernel@vger.kernel.org (open list),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] treewide: Fix indentation and whitespace in Kconfig files
Date: Tue,  7 Apr 2026 11:09:34 +0530
Message-ID: <20260407053945.14116-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up inconsistent indentation (mixing tabs and spaces) and remove
extraneous whitespace in several Kconfig files across the tree.
This is a purely cosmetic change to improve readability.

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:

$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 certs/Kconfig | 16 ++++++++--------
 fs/Kconfig    |  6 +++---
 init/Kconfig  | 24 ++++++++++++------------
 lib/Kconfig   |  2 +-
 mm/Kconfig    |  4 ++--
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/certs/Kconfig b/certs/Kconfig
index 8e39a80c7abe5..9d2bf7fb5b9e4 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -6,14 +6,14 @@ config MODULE_SIG_KEY
 	default "certs/signing_key.pem"
 	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
 	help
-         Provide the file name of a private key/certificate in PEM format,
-         or a PKCS#11 URI according to RFC7512. The file should contain, or
-         the URI should identify, both the certificate and its corresponding
-         private key.
-
-         If this option is unchanged from its default "certs/signing_key.pem",
-         then the kernel will automatically generate the private key and
-         certificate as described in Documentation/admin-guide/module-signing.rst
+	 Provide the file name of a private key/certificate in PEM format,
+	 or a PKCS#11 URI according to RFC7512. The file should contain, or
+	 the URI should identify, both the certificate and its corresponding
+	 private key.
+
+	 If this option is unchanged from its default "certs/signing_key.pem",
+	 then the kernel will automatically generate the private key and
+	 certificate as described in Documentation/admin-guide/module-signing.rst
 
 choice
 	prompt "Type of module signing key to be generated"
diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa8775..74110311968aa 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -78,7 +78,7 @@ config FS_DAX
 	  --map=mem:
 	  https://docs.pmem.io/ndctl-user-guide/ndctl-man-pages/ndctl-create-namespace
 
-          For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
+	  For ndctl to work CONFIG_DEV_DAX needs to be enabled as well. For most
 	  file systems DAX support needs to be manually enabled globally or
 	  per-inode using a mount option as well.  See the file documentation in
 	  Documentation/filesystems/dax.rst for details.
@@ -116,8 +116,8 @@ config FILE_LOCKING
 	default y
 	help
 	  This option enables standard file locking support, required
-          for filesystems like NFS and for the flock() system
-          call. Disabling this option saves about 11k.
+	  for filesystems like NFS and for the flock() system
+	  call. Disabling this option saves about 11k.
 
 source "fs/crypto/Kconfig"
 
diff --git a/init/Kconfig b/init/Kconfig
index 7484cd703bc1a..6fea1453c2941 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1036,14 +1036,14 @@ config PAGE_COUNTER
 	bool
 
 config CGROUP_FAVOR_DYNMODS
-        bool "Favor dynamic modification latency reduction by default"
-        help
-          This option enables the "favordynmods" mount option by default
-          which reduces the latencies of dynamic cgroup modifications such
-          as task migrations and controller on/offs at the cost of making
-          hot path operations such as forks and exits more expensive.
+	bool "Favor dynamic modification latency reduction by default"
+	help
+	  This option enables the "favordynmods" mount option by default
+	  which reduces the latencies of dynamic cgroup modifications such
+	  as task migrations and controller on/offs at the cost of making
+	  hot path operations such as forks and exits more expensive.
 
-          Say N if unsure.
+	  Say N if unsure.
 
 config MEMCG
 	bool "Memory controller"
@@ -1125,7 +1125,7 @@ config GROUP_SCHED_WEIGHT
 	def_bool n
 
 config GROUP_SCHED_BANDWIDTH
-        def_bool n
+	def_bool n
 
 config FAIR_GROUP_SCHED
 	bool "Group scheduling for SCHED_OTHER"
@@ -1625,10 +1625,10 @@ config LD_ORPHAN_WARN
 	depends on $(ld-option,--orphan-handling=error)
 
 config LD_ORPHAN_WARN_LEVEL
-        string
-        depends on LD_ORPHAN_WARN
-        default "error" if WERROR
-        default "warn"
+	string
+	depends on LD_ORPHAN_WARN
+	default "error" if WERROR
+	default "warn"
 
 config SYSCTL
 	bool
diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb96106476..4b0026954a370 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -589,7 +589,7 @@ config OBJAGG
 config LWQ_TEST
 	bool "Boot-time test for lwq queuing"
 	help
-          Run boot-time test of light-weight queuing.
+	  Run boot-time test of light-weight queuing.
 
 endmenu
 
diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687e..10a4ce4247fa1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1304,7 +1304,7 @@ config ARCH_HAS_PTE_SPECIAL
 	bool
 
 config MAPPING_DIRTY_HELPERS
-        bool
+	bool
 
 config KMAP_LOCAL
 	bool
@@ -1435,7 +1435,7 @@ config ARCH_HAS_USER_SHADOW_STACK
 	bool
 	help
 	  The architecture has hardware support for userspace shadow call
-          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
+	  stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
 
 config HAVE_ARCH_TLB_REMOVE_TABLE
 	def_bool n

base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
-- 
2.50.1

