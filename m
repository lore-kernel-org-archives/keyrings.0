From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:26:57 +0000
Subject: [PATCH 10/17] tpm: add the null key name as a tpm2 sysfs variable
Message-Id: <20200518172704.29608-11-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com

From: James Bottomley <James.Bottomley@HansenPartnership.com>

This is the last component of encrypted tpm2 session handling that
allows us to verify from userspace that the key derived from the NULL
seed genuinely belongs to the TPM and has not been spoofed.

The procedure for doing this involves creating an attestation identity
key (which requires verification of the TPM EK certificate) and then
using that AIK to sign a certification of the Elliptic Curve key over
the NULL seed.  Userspace must create this EC Key using the parameters
prescribed in TCG TPM v2.0 Provisioning Guidance for the SRK ECC; if
this is done correctly the names will match and the TPM can then run a
TPM2_Certify operation on this derived primary key using the newly
created AIK.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm-sysfs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d52bf4df0bca..c2733252320a 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -310,6 +310,19 @@ static ssize_t timeouts_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeouts);
 
+static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+	int size = TPM2_NAME_SIZE;
+
+	bin2hex(buf, chip->tpmkeyname, size);
+	size *= 2;
+	buf[size++] = '\n';
+	return size;
+}
+static DEVICE_ATTR_RO(null_name);
+
 static ssize_t tpm_version_major_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -336,7 +349,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 };
 
 static struct attribute *tpm2_dev_attrs[] = {
-	&dev_attr_tpm_version_major.attr,
+	&dev_attr_null_name.attr,
 	NULL
 };
 
@@ -346,10 +359,24 @@ static const struct attribute_group tpm1_dev_group = {
 
 static const struct attribute_group tpm2_dev_group = {
 	.attrs = tpm2_dev_attrs,
+
 };
 
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
+	/* XXX: If you wish to remove this restriction, you must first update
+	 * tpm_sysfs to explicitly lock chip->ops.
+	 */
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		WARN_ON(chip->groups_cnt != 0);
+		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
+		return;
+	}
+
+	/* The sysfs routines rely on an implicit tpm_try_get_ops, device_del
+	 * is called before ops is null'd and the sysfs core synchronizes this
+	 * removal so that no callbacks are running or can run again
+	 */
 	WARN_ON(chip->groups_cnt != 0);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
-- 
2.21.1
