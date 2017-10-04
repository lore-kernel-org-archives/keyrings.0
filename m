From: David Howells <dhowells@redhat.com>
Date: Wed, 04 Oct 2017 13:09:42 +0000
Subject: [PATCH 4/4] KEYS: Add support for directly-specified uids and gids in key ACLs
Message-Id: <150712258210.28796.6772683563095078776.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150712255850.28796.13303640645489194914.stgit@warthog.procyon.org.uk>
In-Reply-To: <150712255850.28796.13303640645489194914.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org


---

 include/uapi/linux/keyctl.h |    4 ++++
 security/keys/permission.c  |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 134052cba4f4..6b554074402d 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -32,6 +32,8 @@ struct key_ace {
 #define KEY_ACE__ORDINARY	0x0000001f /* Ordinary permissions */
 #define KEY_ACE__PERMS		0x0fffffff
 #define KEY_ACE_SUBJECT_ID	0x10000000 /* Subject specified by ->subject_id */
+#define KEY_ACE_UID		0x20000000 /* UID directly specified by ->uid */
+#define KEY_ACE_GID		0x30000000 /* GID directly specified by ->gid */
 #define KEY_ACE__IDENTITY	0xf0000000
 
 	union {
@@ -41,6 +43,8 @@ struct key_ace {
 #define KEY_ACE_OWNER		3	/* The owner of the key */
 #define KEY_ACE_POSSESSOR	4	/* Any process that possesses of the key */
 #define KEY_ACE_SYS_ADMIN	5	/* Anyone with CAP_SYS_ADMIN */
+		uid_t		uid;
+		gid_t		gid;
 	};
 };
 
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 390885eb2bb7..4f20c6917287 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -105,6 +105,18 @@ int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
 				break;
 			}
 			break;
+		case KEY_ACE_UID:
+			if (uid_eq(ace->uid, cred->fsuid))
+				allow |= ace->mask;
+			break;
+		case KEY_ACE_GID:
+			if (gid_valid(ace->gid)) {
+				if (gid_eq(ace->gid, cred->fsgid))
+					allow |= ace->mask;
+				else if (groups_search(cred->group_info, ace->gid))
+					allow |= ace->mask;
+			}
+			break;
 		}
 	}
 
@@ -276,6 +288,14 @@ long keyctl_get_acl(key_serial_t keyid,
 			if (put_user(ace->subject_id, &_acl[i].subject_id) < 0)
 				goto error;
 			break;
+		case KEY_ACE_UID:
+			if (put_user(from_kuid_munged(ns, ace->uid), &_acl[i].uid) < 0)
+				goto error;
+			break;
+		case KEY_ACE_GID:
+			if (put_user(from_kgid_munged(ns, ace->gid), &_acl[i].gid) < 0)
+				goto error;
+			break;
 		}
 	}
 
@@ -312,6 +332,8 @@ static struct key_acl *key_get_acl_from_user(const struct key_ace __user *_acl,
 	ns = current_user_ns();
 	for (i = 0; i < nr_ace; i++) {
 		struct kernel_key_ace *ace = &acl->aces[i];
+		uid_t uid;
+		gid_t gid;
 
 		if (get_user(ace->mask, &_acl[i].mask) < 0)
 			goto fault;
@@ -324,6 +346,16 @@ static struct key_acl *key_get_acl_from_user(const struct key_ace __user *_acl,
 			    ace->subject_id > KEY_ACE_SYS_ADMIN)
 				goto inval;
 			break;
+		case KEY_ACE_UID:
+			if (get_user(uid, &_acl[i].uid) < 0)
+				goto fault;
+			ace->uid = make_kuid(ns, uid);
+			break;
+		case KEY_ACE_GID:
+			if (get_user(gid, &_acl[i].gid) < 0)
+				goto fault;
+			ace->gid = make_kgid(ns, gid);
+			break;
 		default:
 			goto inval;
 		}

