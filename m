From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:46:38 +0000
Subject: [PATCH 5/6] afs: Provide an RCU-capable key lookup
Message-Id: <155856519817.11737.3095092075887198321.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Provide an RCU-capable key lookup function.  We don't want to call
afs_request_key() in RCU-mode pathwalk as request_key() might sleep, even if
we don't ask it to construct anything as it might find a key that is currently
undergoing construction.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |    1 +
 fs/afs/security.c |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 2073c1a3ab4b..3090efcc823f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1237,6 +1237,7 @@ extern void afs_cache_permit(struct afs_vnode *, struct key *, unsigned int,
 			     struct afs_status_cb *);
 extern void afs_zap_permits(struct rcu_head *);
 extern struct key *afs_request_key(struct afs_cell *);
+extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_t *);
 extern int afs_permission(struct inode *, int);
 extern void __exit afs_clean_up_permit_cache(void);
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 5d8ece98561e..a6582d6a3882 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -49,6 +49,33 @@ struct key *afs_request_key(struct afs_cell *cell)
 	}
 }
 
+/*
+ * Get a key when pathwalk is in rcuwalk mode.
+ */
+struct key *afs_request_key_rcu(struct afs_cell *cell)
+{
+	struct key *key;
+
+	_enter("{%x}", key_serial(cell->anonymous_key));
+
+	_debug("key %s", cell->anonymous_key->description);
+	key = request_key_rcu(&key_type_rxrpc, cell->anonymous_key->description);
+	if (IS_ERR(key)) {
+		if (PTR_ERR(key) != -ENOKEY) {
+			_leave(" = %ld", PTR_ERR(key));
+			return key;
+		}
+
+		/* act as anonymous user */
+		_leave(" = {%x} [anon]", key_serial(cell->anonymous_key));
+		return cell->anonymous_key;
+	} else {
+		/* act as authorised user */
+		_leave(" = {%x} [auth]", key_serial(key));
+		return key;
+	}
+}
+
 /*
  * Dispose of a list of permits.
  */
