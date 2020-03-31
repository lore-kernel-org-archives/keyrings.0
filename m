From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 31 Mar 2020 06:51:08 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <20200331175108.588b80c0@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/ADYCqD70cxQvyKWhrdsW12R"
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
        <1449138.1585578664@warthog.procyon.org.uk>
In-Reply-To: <1449138.1585578664@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net, andres@anarazel.de, christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

--Sig_/ADYCqD70cxQvyKWhrdsW12R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 30 Mar 2020 15:31:04 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
>       pipe: Add general notification queue support

This commit has a (reasonably simple) conflict against commit

  6551d5c56eb0 ("pipe: make sure to wake up everybody when the last reader/=
writer closes")

from Linus' tree.

Also a semantic conflict against commit

  52b31bc9aabc ("io_uring: add splice(2) support")

from the block tree needing this fix up (white space damaged)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fb8fe0bd5e18..8cdd3870cd4e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2470,7 +2470,7 @@ static int io_splice_prep(struct io_kiocb *req, const=
 struct io_uring_sqe *sqe)
=20
 static bool io_splice_punt(struct file *file)
 {
-	if (get_pipe_info(file))
+	if (get_pipe_info(file, true))
 		return false;
 	if (!io_file_supports_async(file))
 		return true;
>	security: Add hooks to rule on setting a watch
>	security: Add a hook for the point of notification insertion

And these have a conflict against commitinclude/linux/lsm_hooks.h

  98e828a0650f ("security: Refactor declaration of LSM hooks")

from the bpf-next tree (will be in the net-next tree pull).  That
requires taking the net-next version of include/linux/lsm_hooks.h and
then applying the following patch:

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9cd4455528e5..4f8d63fd1327 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -252,6 +252,16 @@ LSM_HOOK(int, 0, inode_notifysecctx, struct inode *ino=
de, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ct=
xlen)
 LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
+#ifdef CONFIG_KEY_NOTIFICATIONS
+LSM_HOOK(int, 0, watch_key, struct key *key)
+#endif
+#ifdef CONFIG_DEVICE_NOTIFICATIONS
+LSM_HOOK(int, 0, watch_devices, void)
+#endif
+#ifdef CONFIG_WATCH_QUEUE
+LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
+	 const struct cred *cred, struct watch_notification *n)
+#endif
=20
 #ifdef CONFIG_SECURITY_NETWORK
 LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *othe=
r,

--=20
Cheers,
Stephen Rothwell

--Sig_/ADYCqD70cxQvyKWhrdsW12R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6C6FwACgkQAVBC80lX
0Gzu0wf+LiRwTbiERIhH0CCtMDGKGwnN9AytVinsNAuHxXdlMgmLpMKKkO6Y45CJ
xJtvK/JAkBX1Hmt21jmbuWIMKpQQ+Egz/9J1ZrivaOLsPcFo6nXAuMHXQD/6g4/y
7Knm4iGOMAAOG5fgI/vujVmgFCABaH4V5qOYAnS5iZhV91JtQlnIsHpUe9gFzCMb
JdoOaQHIJqSYZUnDxgRZ9w3qXtnor2dBLZUrD2xtGp6XmHj/1aOv42cP47VyC4P9
yiXHpoGyQ/w6b2fqmvUHd0AY1ThM/4EL1fgS6DWeoXAQPzLa4ppj3i2R+354fjO1
EwHWYnPAMmDpWOO0BPFiW3yA9R10mQ==
=EyQE
-----END PGP SIGNATURE-----

--Sig_/ADYCqD70cxQvyKWhrdsW12R--
