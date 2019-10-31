From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 31 Oct 2019 13:59:43 +0000
Subject: [Patch v3 1/7] tee: optee: allow kernel pages to register as shm
Message-Id: <1572530323-14802-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
To: jens.wiklander@linaro.org, jarkko.sakkinen@linux.intel.com, dhowells@redhat.com
Cc: Sumit Garg <sumit.garg@linaro.org>, daniel.thompson@linaro.org, janne.karhunen@gmail.com, corbet@lwn.net, jejb@linux.ibm.com, ard.biesheuvel@linaro.org, linux-doc@vger.kernel.org, jmorris@namei.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, stuart.yoder@arm.com, casey@schaufler-ca.com, linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, serge@hallyn.com

Kernel pages are marked as normal type memory only so allow kernel pages
to be registered as shared memory with OP-TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 13b0269..cf2367b 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -554,6 +554,13 @@ static int check_mem_type(unsigned long start, size_t num_pages)
 	struct mm_struct *mm = current->mm;
 	int rc;
 
+	/*
+	 * Allow kernel address to register with OP-TEE as kernel
+	 * pages are configured as normal memory only.
+	 */
+	if (virt_addr_valid(start))
+		return 0;
+
 	down_read(&mm->mmap_sem);
 	rc = __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
-- 
2.7.4
