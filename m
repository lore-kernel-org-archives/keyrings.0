Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4125B09E
	for <keyrings@vger.kernel.org>; Fri, 25 Sep 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323562; cv=none; b=M88ubgCyyRP6MmbnCHpWkMHf84ZGnjqFjklxy/vYphb4oWwvNoNlt7Fh8ktQyRgswD+F9hhyiMRlx83dmmoaf0Y57C0iPGxgSqphbWJuaSIJLLmdWF/lj26enLMxXPdtfya/LdnsGgi/Id4hp84QVCcFlWlcF3ObFn+pKFBcUqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323562; c=relaxed/simple;
	bh=gdmQpihoyQcuoWFdoC0anc0GvxaES+Hgxm9kPd2m3Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjUAGjGyMmZOT+T/kA2GSvymiM4z35PaYa6VnlgWBQCG7JUxco+ALUxN0AuwGT3OxDLIzhVARs4hiDHeMAexKR84wDSWVUryTQbRXI4yIC+hznWP4WraiylXiqgPie1gclJu5xUQeaQ322BNe32kgdxDZGx+37RFsQ+V8rvsC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKYmlBw5; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKYmlBw5"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso88183a12.0
        for <keyrings@vger.kernel.org>; Fri, 25 Sep 2026 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790323561; x=1790928361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YnaaXthyPwcI3fGykM5beILFyTVEfvHP2y22x1uXtRw=;
        b=sKYmlBw54IeB6J5TfxJukYoAMHgSX90p3+r71cC7dSYZksWJxACcwRdW9HwYKZ9z/P
         FTjiLUcGRmku+YG+nSNlBgdeb4TNtBP5N4NnUpPWWIvf1UM3HkCQUc6k/6pIBPpEWlsO
         1DQED1NvXzOuoEmgSffemobS4tqTUjlkk9QcsJsARtal8ZyAAtL+o7jsoics5gQWBMS3
         H2urErNbIfMeo2sua2KIjUSv+GxWodpGOe30nPFo9fCh/Qx2/YJpdQ4/EbJfbwx9/CAB
         +SZ5ZgU+2aLhNx8BAnranW1ekpYDrw4OcGHo1/Afu+F8jV288rStEE5TJivSEI/ORQjB
         ldRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790323561; x=1790928361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YnaaXthyPwcI3fGykM5beILFyTVEfvHP2y22x1uXtRw=;
        b=JChaFMryPxlSJNzNKUfSTYVigZI6QRNYzNM4sWK0vR0HI58Yiy6xpDyheRwlAQ/89T
         xW6iol1PVfQ3NGJM4DOsLbvPaBUTOLT+XQJ7zHYuBNMrwEthNHv9UufxZIxbGvMuv6wD
         FHNhA3pJmFs0aXGYDaWVl2492zOjCtnlQF0E1RspYM+cjvMqKDdHTtUZrfRL9KaLVWAQ
         ZvQ15ZOgHGSbCDFdwCT98t1ACTsBEQ75M1vMbQqJUPHeMaml8sSBOQgKcjTU1S2JBtZ7
         +0+UncMO6A9gEMKcCZRS8y7x4QQyV0lqQInhGtlOXqCObydakOxHpWPjVvZjKK2QTDOz
         g5Pg==
X-Forwarded-Encrypted: i=1; AKwUvBxDcOoyHbg2GLvXYsXc184tJjOmpzMwqgyGRWdvmoFhzjD99S5Rgl6zwL0Jh+NXHGuJ/ls4PKw0SQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nNBS1TG1bZVfby3sqWTCZLI9mIlzjr6QZpnDZSb4nJPk+gZ3aQ
	z/guCmJLrf8LNQKTUFDXJabXeV0xJdqb0vNG0fJyAG7AZFyXubGr8XE8SrLvWg==
X-Gm-Gg: AYBFou21hBlENSR4fpkXNX1QCQpCGZDMqWOzWp4qcppaqYYn7LHO16kEPJK00Si7yxi
	w4xF8kdyY78qTpn7TgBz67N4fRY0Fqpq9JrjskvAE+jkfJbMo9iqnLHFCQgqdn9I7wNpJQf9/9+
	mT8jOzak5Qm1UjM06iUWuyLYzul0hRY0BvImFus8EEW4aEtwDn5wiknhjvENQ83+Wd82SMg+h4m
	TWB7t05YSnJJOR1Qk6CJExVc4qg+hZM+VW/vjgdkSIVms4rLjNBrGPhkK5z+x9szC9Z5orA0UNm
	c+jBzCSE5QVd+0zJdLeovaV1v+UOcejXWMNWCGPOzLKmn1sKMj675OWfjo3CxDHWkmBYsAH+XWi
	T9N5Bx+Luuj9VHRX2az67xtUSEIs9KwirgBPam2RUulmMFo8QTGwrPDG7pjg2oVjZJGpBU0N0iP
	z55Jjg4QK4RRoy6eqnKEEYmJdAzmuTY5Q2rn86YWg5SFZHBeySj7xBYB4GEJtTBmUViYOG4dgtO
	XmAO32ebPpr62LrBQsgAw==
X-Received: by 2002:a17:90a:bc9:b0:3a0:a515:c477 with SMTP id 98e67ed59e1d1-3a0a515c8a1mr2115793a91.16.1790323560568;
        Fri, 25 Sep 2026 01:06:00 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09766210bsm9123588a91.8.2026.09.25.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:05:59 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] assoc_array: discard shortcut when collapsing a leaf-only node
Date: Fri, 25 Sep 2026 17:05:48 +0900
Message-ID: <20260925080548.2505640-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

assoc_array_delete() can collapse a subtree into a node that contains only
leaves while retaining the shortcut that led to it.  If that node later
fills, all_leaves_cluster_together replaces it with another shortcut.  The
first shortcut then points directly to the second one.

assoc_array_apply_edit() publishes this topology and propagates branch
counts from the new child node.  It skips the inner shortcut, encounters
the outer shortcut where it requires a node and triggers the BUG_ON().

Linux v7.2 and v6.12.105 are affected.  The same root remains at the
base-commit below and in every supported stable branch checked down to
5.10.  It requires CONFIG_KEYS, but no capability, user namespace or race.
A UID/GID 1000 process produced:

  CONTROL_BEGIN mode=exact uid=1000 gid=1000
  CONTROL_CapEff: 0000000000000000
  kernel BUG at lib/assoc_array.c:1388!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 1000 PID: 154 Comm: exploit
  RIP: assoc_array_apply_edit+0x4aa/0x690
  Call Trace:
   __key_link
   __key_instantiate_and_link
   __key_create_or_update
   __do_sys_add_key
  Kernel panic - not syncing: Fatal exception

When deletion produces a leaf-only node, bypass its preceding shortcut as
garbage collection already does.  Retire the shortcut and old node together
after an RCU grace period; reused leaves keep their references and the
deleted leaf is still freed separately.

The exact trigger reached the BUG in 3/3 unmodified v7.2 KASAN boots and
completed cleanly in 3/3 fixed boots.  Fixed v6.12.105 also passed 3/3.  A
source reproducer is available privately on request.

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 lib/assoc_array.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index b6c9723e12ced..841dfe07dc962 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1210,8 +1210,22 @@ found_leaf:
 				goto enomem;
 			edit->new_meta[0] = assoc_array_node_to_ptr(new_n0);
 
-			new_n0->back_pointer = node->back_pointer;
-			new_n0->parent_slot = node->parent_slot;
+			/* A shortcut above a leaf-only node is redundant.  Drop it as
+			 * GC does so that a later split can't create two shortcuts in a row.
+			 */
+			ptr = node->back_pointer;
+			if (assoc_array_ptr_is_shortcut(ptr)) {
+				struct assoc_array_shortcut *s =
+					assoc_array_ptr_to_shortcut(ptr);
+
+				new_n0->back_pointer = s->back_pointer;
+				new_n0->parent_slot = s->parent_slot;
+				edit->excised_subtree = ptr;
+			} else {
+				new_n0->back_pointer = ptr;
+				new_n0->parent_slot = node->parent_slot;
+				edit->excised_subtree = assoc_array_node_to_ptr(node);
+			}
 			new_n0->nr_leaves_on_branch = node->nr_leaves_on_branch;
 			edit->adjust_count_on = new_n0;
 
@@ -1225,21 +1239,15 @@ found_leaf:
 			pr_devel("collapsed %d,%lu\n", collapse.slot, new_n0->nr_leaves_on_branch);
 			BUG_ON(collapse.slot != new_n0->nr_leaves_on_branch - 1);
 
-			if (!node->back_pointer) {
+			if (!new_n0->back_pointer) {
 				edit->set[1].ptr = &array->root;
-			} else if (assoc_array_ptr_is_leaf(node->back_pointer)) {
-				BUG();
-			} else if (assoc_array_ptr_is_node(node->back_pointer)) {
-				struct assoc_array_node *p =
-					assoc_array_ptr_to_node(node->back_pointer);
-				edit->set[1].ptr = &p->slots[node->parent_slot];
-			} else if (assoc_array_ptr_is_shortcut(node->back_pointer)) {
-				struct assoc_array_shortcut *s =
-					assoc_array_ptr_to_shortcut(node->back_pointer);
-				edit->set[1].ptr = &s->next_node;
+			} else {
+				struct assoc_array_node *p;
+
+				p = assoc_array_ptr_to_node(new_n0->back_pointer);
+				edit->set[1].ptr = &p->slots[new_n0->parent_slot];
 			}
 			edit->set[1].to = assoc_array_node_to_ptr(new_n0);
-			edit->excised_subtree = assoc_array_node_to_ptr(node);
 		}
 	}
 

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.55.0

