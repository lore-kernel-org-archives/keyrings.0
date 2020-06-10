From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 10 Jun 2020 15:49:21 +0000
Subject: [PATCH 3/5] test_kmod: Avoid potential double free in trigger_config_run_type()
Message-Id: <20200610154923.27510-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com
Cc: slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org, josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, bridge@lists.linux-foundation.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>, Luis Chamberlain <mcgrof@kernel.org>

From: Tiezhu Yang <yangtiezhu@loongson.cn>

Reset the member "test_fs" of the test configuration after a call
of the function "kfree_const" to a null pointer so that a double
memory release will not be performed.

Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index e651c37d56db..eab52770070d 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -745,7 +745,7 @@ static int trigger_config_run_type(struct kmod_test_device *test_dev,
 		break;
 	case TEST_KMOD_FS_TYPE:
 		kfree_const(config->test_fs);
-		config->test_driver = NULL;
+		config->test_fs = NULL;
 		copied = config_copy_test_fs(config, test_str,
 					     strlen(test_str));
 		break;
-- 
2.26.2
