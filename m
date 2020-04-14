From: Waiman Long <longman@redhat.com>
Date: Tue, 14 Apr 2020 19:29:33 +0000
Subject: [PATCH v2 3/3] btrfs: Use kfree() in btrfs_ioctl_get_subvol_info()
Message-Id: <20200414192933.26846-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200413211550.8307-1-longman@redhat.com>
In-Reply-To: <20200413211550.8307-1-longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org, Waiman Long <longman@redhat.com>

In btrfs_ioctl_get_subvol_info(), there is a classic case where kzalloc()
was incorrectly paired with kzfree(). According to David Sterba, there
isn't any sensitive information in the subvol_info that needs to be
cleared before freeing. So kfree_sensitive() isn't really needed,
use kfree() instead.

Reported-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index eab3f8510426..5070bd2436b7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2691,7 +2691,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
-	kfree_sensitive(subvol_info);
+	kfree(subvol_info);
 	return ret;
 }
 
-- 
2.18.1
