From: David Howells <dhowells@redhat.com>
Date: Tue, 21 Aug 2018 15:57:09 +0000
Subject: [PATCH 03/23] TPM: Provide a platform driver for the user emulator driver
Message-Id: <153486702979.13066.16900998092976336647.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
To: denkenz@gmail.com, jarkko.sakkinen@linux.intel.com, jejb@linux.vnet.ibm.com
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

Provide a platform driver for the user emulator driver.  This seems to be
necessary to stop tpm_chip_find_get() from blowing up because it assumes
unconditionally that any device will have a driver attached:

		if (try_module_get(pos->dev->driver->owner)) {

However, this doesn't then work right because if I remove the TPM device and
re-add it, the tpm ID isn't recycled (ie, /dev/tpm0 becomes unavailable and
the new TPM is /dev/tpm1).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 drivers/char/tpm/tpm_user_emul.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_user_emul.c b/drivers/char/tpm/tpm_user_emul.c
index b96350592bca..e5b13358c71e 100644
--- a/drivers/char/tpm/tpm_user_emul.c
+++ b/drivers/char/tpm/tpm_user_emul.c
@@ -656,17 +656,39 @@ static struct miscdevice tpm_user_dev = {
 	.fops	= &tpm_user_fops,
 };
 
+static struct platform_driver tpm_user_drv = {
+	.driver = {
+		.name	= "tpm_user",
+		.owner	= THIS_MODULE,
+		/* .pm	= &tpm_user_pm, -- do we need pm since there's no h/w? */
+	},
+};
+
 /*
  * Initialise a device
  */
 static __init int tpm_user_mod_init(void)
 {
-	return misc_register(&tpm_user_dev);
+	int ret;
+
+	ret = platform_driver_register(&tpm_user_drv);
+	if (ret < 0)
+		return ret;
+
+	ret = misc_register(&tpm_user_dev);
+	if (ret < 0)
+		goto error_dev;
+	return 0;
+
+error_dev:
+	platform_driver_unregister(&tpm_user_drv);
+	return ret;
 }
 device_initcall(tpm_user_mod_init);
 
 static __exit void tpm_user_mod_exit(void)
 {
 	misc_deregister(&tpm_user_dev);
+	platform_driver_unregister(&tpm_user_drv);
 }
 module_exit(tpm_user_mod_exit);
