From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 19 Jan 2018 23:15:34 +0000
Subject: [PATCH] NFS: reject request for id_legacy key without auxdata
Message-Id: <20180119231534.77293-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <001a113f932c93a1400563282ce8@google.com>
In-Reply-To: <001a113f932c93a1400563282ce8@google.com>
To: linux-nfs@vger.kernel.org, Trond Myklebust <trond.myklebust@primarydata.com>, Anna Schumaker <anna.schumaker@netapp.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

nfs_idmap_legacy_upcall() is supposed to be called with 'aux' pointing
to a 'struct idmap', via the call to request_key_with_auxdata() in
nfs_idmap_request_key().

However it can also be reached via the request_key() system call in
which case 'aux' will be NULL, causing a NULL pointer dereference in
nfs_idmap_prepare_pipe_upcall(), assuming that the key description is
valid enough to get that far.

Fix this by making nfs_idmap_legacy_upcall() negate the key if no
auxdata is provided.

As usual, this bug was found by syzkaller.  A simple reproducer using
the command-line keyctl program is:

    keyctl request2 id_legacy uid:0 '' @s

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring")
Reported-by: syzbot+5dfdbcf7b3eb5912abbb@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # v3.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/nfs/nfs4idmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 30426c1a1bbd..22dc30a679a0 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -568,9 +568,13 @@ static int nfs_idmap_legacy_upcall(struct key_construction *cons,
 	struct idmap_msg *im;
 	struct idmap *idmap = (struct idmap *)aux;
 	struct key *key = cons->key;
-	int ret = -ENOMEM;
+	int ret = -ENOKEY;
+
+	if (!aux)
+		goto out1;
 
 	/* msg and im are freed in idmap_pipe_destroy_msg */
+	ret = -ENOMEM;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		goto out1;
-- 
2.16.0.rc1.238.g530d649a79-goog

