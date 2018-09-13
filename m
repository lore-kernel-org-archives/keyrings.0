From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 16:09:16 +0000
Subject: [PATCH 3/6] afs: afs_end_vnode_operation() needs to translate abort codes to errors
Message-Id: <153685495622.16086.10265386563835390377.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

afs_end_vnode_operation() calls the function to translate an abort code
into an error return, but never actually assigns the error.

Fix this by storing the looked up error back into the cursor.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rotate.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 1faef56b12bd..add0dbb18763 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -512,7 +512,6 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 {
 	struct afs_net *net = afs_v2net(fc->vnode);
-	int ret;
 
 	mutex_unlock(&fc->vnode->io_lock);
 
@@ -520,9 +519,8 @@ int afs_end_vnode_operation(struct afs_fs_cursor *fc)
 	afs_put_cb_interest(net, fc->cbi);
 	afs_put_serverlist(net, fc->server_list);
 
-	ret = fc->ac.error;
-	if (ret = -ECONNABORTED)
-		afs_abort_to_error(fc->ac.abort_code);
+	if (fc->ac.error = -ECONNABORTED)
+		fc->ac.error = afs_abort_to_error(fc->ac.abort_code);
 
 	return fc->ac.error;
 }
