From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 23 Oct 2017 21:40:47 +0000
Subject: [RFC PATCH 14/25] ubifs crypto: wire up new ioctls for managing encryption keys
Message-Id: <20171023214058.128121-15-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171023214058.128121-1-ebiggers3@gmail.com>
In-Reply-To: <20171023214058.128121-1-ebiggers3@gmail.com>
To: linux-fscrypt@vger.kernel.org
Cc: Ryo Hashimoto <hashimoto@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, linux-api@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-f2fs-devel@lists.sourceforge.net, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, Michael Halcrow <mhalcrow@google.com>, Sarthak Kukreti <sarthakkukreti@chromium.org>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/ioctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 0164bcc827f8..09ede2d1898f 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -205,6 +205,15 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #endif
 	}
 
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+		return fscrypt_ioctl_add_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+		return fscrypt_ioctl_remove_key(file, (const void __user *)arg);
+
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -222,6 +231,9 @@ long ubifs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 	case FS_IOC_GET_ENCRYPTION_POLICY:
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.15.0.rc0.271.g36b669edcc-goog

