From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:08:46 +0000
Subject: [RFC PATCH 09/27] vfs: Allow mounting to other namespaces
Message-Id: <155024692658.21651.7276705643207668882.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Currently sys_move_mount() and sys_mount(MS_MOVE) prevent the caller from
moving a mount into a namespace not their own.  Relax this such that any
mount can be mounted onto any given mountpoint provided that the source
mount is either detached or the same namespace as the destination.

This permits container namespaces to be built from the outside rather than
from the inside.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 22cf4a8f8065..804601b6297c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2627,12 +2627,10 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	/* The mountpoint must be in our namespace. */
-	if (!check_mnt(p))
-		goto out;
-
-	/* The thing moved should be either ours or completely unattached. */
-	if (attached && !check_mnt(old))
+	/* The new mount must be either unattached or in the same namespace as
+	 * the mountpoint.
+	 */
+	if (attached && old->mnt_ns != p->mnt_ns)
 		goto out;
 
 	if (!attached && !is_anon_ns(ns))
