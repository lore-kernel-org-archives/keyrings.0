From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:11:58 +0000
Subject: [RFC PATCH 25/27] keys: Provide a way to ask for the container keyring
Message-Id: <155024711895.21651.13875852239032339316.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Provide a constant that can be used in place of a key ID to indicate the
keyring belonging to the current process's container.  Used as:

	key_serial_t container_keyring 		keyctl_get_key_ID(KEY_SPEC_CONTAINER_KEYRING, 0);

Note that this is merely a 'macro' for the ID of the keyring.  To be able
to actually do anything with it requires the keyring to grant appropriate
permissions to the denizens of the container.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/uapi/linux/keyctl.h  |    1 +
 samples/vfs/test-container.c |   15 +++++++++++++++
 security/keys/process_keys.c |    7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 7136d14dd4d7..89ab609f774c 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -88,6 +88,7 @@ enum key_ace_standard_subject {
 #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring */
 #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key auth key */
 #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest keyring */
+#define KEY_SPEC_CONTAINER_KEYRING	-9	/* - key ID for current->container's keyring */
 
 /* request-key default keyrings */
 #define KEY_REQKEY_DEFL_NO_CHANGE		-1
diff --git a/samples/vfs/test-container.c b/samples/vfs/test-container.c
index 7b2081693fce..4716dd50b696 100644
--- a/samples/vfs/test-container.c
+++ b/samples/vfs/test-container.c
@@ -20,6 +20,7 @@
 #include <sys/stat.h>
 #include <keyutils.h>
 
+#define KEY_SPEC_CONTAINER_KEYRING	-9	/* - key ID for current->container's keyring */
 #define KEYCTL_CONTAINER_INTERCEPT	31	/* Intercept upcalls inside a container */
 #define KEYCTL_SET_CONTAINER_KEYRING	35	/* Attach a keyring to a container */
 #define KEYCTL_GRANT_PERMISSION		36	/* Grant a permit to a key */
@@ -160,6 +161,8 @@ static inline int fork_into_container(int containerfd)
 static __attribute__((noreturn))
 void container_init(void)
 {
+	key_serial_t ckey;
+
 	if (0) {
 		/* Do a bit of debugging on the container. */
 		struct dirent **dlist;
@@ -203,6 +206,12 @@ void container_init(void)
 		exit(1);
 	}
 
+	ckey = keyctl_get_keyring_ID(KEY_SPEC_CONTAINER_KEYRING, 0);
+	if (ckey = -1)
+		perror("keyctl_get_keyring_ID");
+	else
+		printf("Container keyring %d\n", ckey);
+	
 	setenv("PS1", "container>", 1);
 	execl("/bin/bash", "bash", NULL);
 	perror("execl");
@@ -310,6 +319,12 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	if (keyctl(KEYCTL_GRANT_PERMISSION, keyring,
+		   KEY_ACE_SUBJ_STANDARD, KEY_ACE_OWNER, 0) < 0) {
+		perror("keyctl_grant/s");
+		exit(1);
+	}
+
 	if (keyctl(KEYCTL_SET_CONTAINER_KEYRING, cfd, keyring) < 0) {
 		perror("keyctl_set_container_keyring");
 		exit(1);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index f296a1cc979a..f8f580a760c9 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -725,6 +725,13 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		key_ref = make_key_ref(key, 1);
 		break;
 
+	case KEY_SPEC_CONTAINER_KEYRING:
+		key = current->container->keyring;
+		if (!key)
+			goto error;
+		key_ref = make_key_ref(key, 0);
+		goto error;
+
 	default:
 		key_ref = ERR_PTR(-EINVAL);
 		if (id < 1)
