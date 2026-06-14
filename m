Received: from smtp153-166.sina.com.cn (smtp153-166.sina.com.cn [61.135.153.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029F296BBA
	for <keyrings@vger.kernel.org>; Sun, 14 Jun 2026 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473904; cv=none; b=nBBwmpQCgNMkkdVrJp9q4mBUAUQPmQj+0beAHBP+ZWALA3WORursM/7oR3FTzcfgOAKQRHziylxKqfbFLVbzVzJuA8Wz1CDBQSluWBh4FQ6cxEsOZfv7iI/JAu/VT4/6Ol/R/qqjeYEToKFZEpbmPRm4GF38UOOmHk8qI3rapfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473904; c=relaxed/simple;
	bh=navlVoBp1kQky6qKHwqTrj7fZXVVpB0aQ4+B0v/QQL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQv1E6K54nF5F7a5XACaVxDYLy3vwObaLsSgOoBKOMJWKxSUDsNy5iBxLqaYGpRD88T/N5iLMKFz/B2G2ERkOQ4hfRQjYIW4+TBtV7VGVyOpgzPSfMTegUaL9QjVEbSEOglFJpb4qfVbREmvPpUzXqQBDJf1BOAOX2sg8HdDUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=xakN2n9U; arc=none smtp.client-ip=61.135.153.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="xakN2n9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1781473898;
	bh=MxEzgnVaJJNN8RKQtn+yY2RRWYcWvNqZBHZWDQPhb4o=;
	h=From:Subject:Date:Message-ID;
	b=xakN2n9Uoif3tYWyjFysBo2/RSMRfTYD3VSQrFCyiTxODy4kNS9VQ+yiBqEimkC8v
	 Z7v/uqmgXOvUazb4DRBZlyvYWTg7p8bRyiCQGE4q+kkBe9y+o6ssRqMz5JAdlF0jGs
	 BkJxP1gBrqBB9jxvyf3fKWt3S0Zwq7F1sQhS43BE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A2F2026000049F1; Sun, 15 Jun 2026 05:41:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6070456685379
X-SMAIL-UIID: 9BEF5C9187CE499A8DE2736CA6569A98-20260615-054159-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com>
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	dhowells@redhat.com,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: avoid filesystem reclaim while holding keyring->sem
Date: Mon, 15 Jun 2026 05:41:49 +0800
Message-ID: <20260614214150.1791-1-hdanton@sina.com>
In-Reply-To: <20260614150041.21172-1-med08elkadiri@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Sun, 14 Jun 2026 16:00:41 +0100 Mohammed EL Kadiri wrote:
>
#syz test upstream master

__key_link_begin() runs with keyring->sem held and calls
assoc_array_insert(), which does GFP_KERNEL allocations.  Those
allocations may enter filesystem reclaim, evict an fscrypt-protected
inode, and reach keyring_clear() via fscrypt_put_master_key() --
taking a keyring semaphore of the same lockdep class and closing a
keyring->sem -> fs_reclaim -> keyring->sem cycle reported by syzbot.

Wrap the assoc_array_insert() call with memalloc_nofs_save() /
memalloc_nofs_restore() so reclaim cannot recurse into the keys
subsystem while keyring->sem is held.

Reported-by: syzbot+f55b043dacf43776b50c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f55b043dacf43776b50c
Fixes: d7e7b9af104c ("fscrypt: stop using keyrings subsystem for fscrypt_master_key")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/keyring.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5a9887d6b7be..21bb2e7e7cca 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <linux/sched/mm.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
 #include <keys/keyring-type.h>
@@ -1298,6 +1299,7 @@ int __key_link_begin(struct key *keyring,
 		     struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	unsigned int nofs_flags;
 	int ret;
 
 	kenter("%d,%s,%s,",
@@ -1315,10 +1317,12 @@ int __key_link_begin(struct key *keyring,
 	/* Create an edit script that will insert/replace the key in the
 	 * keyring tree.
 	 */
+	nofs_flags = memalloc_nofs_save();
 	edit = assoc_array_insert(&keyring->keys,
 				  &keyring_assoc_array_ops,
 				  index_key,
 				  NULL);
+	memalloc_nofs_restore(nofs_flags);
 	if (IS_ERR(edit)) {
 		ret = PTR_ERR(edit);
 		goto error;
-- 
2.43.0
