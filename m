Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83A4A23;
	Thu, 27 Aug 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811863; cv=none; b=ukUqHGk8ElcHaCYK3AqSHmEWwSlvClHx1RpEwy5jcSo9vR8KMgU/E/Wee6uQTP2Is21eNGAY58gz2lSFQOHpbIt2AXR7Hp4fvWUJ7ryFdTSB5c9mgRINtO5FHhozN0UynpPnXtA6MfZpdtHQWIauEa8fVi5sN/6bM2FGXyigucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811863; c=relaxed/simple;
	bh=lTa4mgB5brMBY0wAGVoE6J60rIaur/dIbKYrOPNcUxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjolBlBphV7hSgvxFCh+sxG7nFAlBpfGY0gdMOvBSNp85NwOyODOKe6IoQ89+FS1Qx8Nt/VhEW1aG09e7S18ReOfsnKQMUmREYEQgPz/NbdtYVSqd0MG0Njo1aCdpzn94rpv7b8hnwxPM8T8EabX1U8eI3Kn+3ysBTnc0d3a3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eTFA0Z5U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eTFA0Z5U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VdpT4139849;
	Thu, 27 Aug 2026 06:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1La7cD0eYNIXwOype
	e2b6JhRgxYPQoqE00wTeUx+ofI=; b=eTFA0Z5UQzksliIfEp+vRHQW6okgKXSy6
	x9UMo67tjKsprLtRDYBMqQGRVO02LWyxvMfBHjzrIzff6VnUMWjK4GKFbjdePz5N
	oBGMCqYWLyeeSAR3dRY0mWRJLUwhJ2y2JumrkLke1rf0eZiQyNJtiRRbTR4D8EDr
	mS/hPgORqsOna3Ebvh6gALIxdSdc4iD6xPWbzT9NkXG4a6/5mHoiOR5rScNQb4eU
	TSmxpSkjydbsVQ9QHbEDrGM3ofFH3j2OFk4okWgB0uTKNGjJUGpDIOVoIf3usbZ7
	Q4jJuQvxsdVWH0yQPLD8H6NoF/5Z2E1sFNNZehGLSXLPxkBqYrsWw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er3h7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BKS2000516;
	Thu, 27 Aug 2026 06:24:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qeq23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6O4KP12059012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:24:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F25992004E;
	Thu, 27 Aug 2026 06:24:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9486020040;
	Thu, 27 Aug 2026 06:23:51 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:23:50 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 3/8] pseries/plpks: improve type consistency and parameter validation
Date: Thu, 27 Aug 2026 11:53:03 +0530
Message-ID: <20260827062309.724808-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827062309.724808-1-ssrish@linux.ibm.com>
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iiicmCC5pDUR9BOlYozzW-dnzi95fTbk
X-Proofpoint-ORIG-GUID: cBB_1eG88gbzUY5EK5MQV0pNEoR6zCfH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfXyj0OBP2d6dmR
 Mvpc0p7VmD+jgDV4SOFaSocg5n0mM+2hFvSUUnp8x1qjs/PjX5F4i1+osIgaDFfl3ugDamxbYfn
 i5hoKQNKjZkJpVeQ5FWiLP+G0KOCXdKD1e9gvS3hazYv1OlMLR6veZlk9YUq1BlplF6rA8Qgt0i
 ahyZnAWg4yypQNfcAXhAata837Nt+9ibJwqp3s/LIWCO57ACMbIbc6W2Ma0Lk2B2tAeZ4VU2Jpj
 MtJcmT01aJrrZznvDC+plpD60Q9Ds0u5m9YNxDCBDiy5ZoqKCiJ2IG4wsDyUchKhUj7Wfys2bqV
 Bkzg93rxLW8rr4Oxx4b+rOomWm4HxvNYSJpEJBI/C9HzP8wCV/RCFB8P+eu4xcPrP5W6vAEf+gw
 9f44azRv2qD11RjzJGDGpKpzCcnbIljSAPDmY85TaX3K5T63SqPDj4v5o+5eYYq1TnvY6r3LI/x
 OEu0JqaYpxKxIAgHClA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8fd809 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lkDOvFPUoNuE0DTt1acA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX6sd2acnUrM64
 Xh1vESIbDRzHKd4bK9DBNLF7DH4jK7ZTGRrEElN7S9m2c4P3dGnl2Iijl7VbckQR9IGum2gPrjT
 2e/yvakiVJlLCvJuGMhiKqjPn3N3vDU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

Update plpks_wrap_object() and plpks_unwrap_object() to use u64 length
parameters, matching the underlying hcall data types for consistency.
Update the PKWM consumer, where these interfaces are used, accordingly.

Add explicit casts when copying values from hcall return buffers into
narrower data types. This makes the intended conversion clear and avoids
implicit truncation in PLPKS hcall result handling.

Also validate input pointers in plpks_signed_update_var() and
plpks_read_var() before dereferencing them, addressing missing validation
when reading and updating PLPKS objects.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Fixes: 899d9b8fee66 ("powerpc/pseries: Implement signed update for PLPKS objects")
Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/include/asm/plpks.h          |  8 ++++----
 arch/powerpc/platforms/pseries/plpks.c    | 22 ++++++++++++++--------
 security/keys/trusted-keys/trusted_pkwm.c |  4 ++--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index e87f90e40d4e..8b2ffb27db5a 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -118,11 +118,11 @@ bool plpks_wrapping_is_supported(void);
 
 int plpks_gen_wrapping_key(void);
 
-int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
-		      u8 **output_buf, u32 *output_len);
+int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
+		      u8 **output_buf, u64 *output_len);
 
-int plpks_unwrap_object(u8 **input_buf, u32 input_len,
-			u8 **output_buf, u32 *output_len);
+int plpks_unwrap_object(u8 **input_buf, u64 input_len,
+			u8 **output_buf, u64 *output_len);
 #else // CONFIG_PSERIES_PLPKS
 static inline bool plpks_is_available(void) { return false; }
 static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 7bd5c149dd09..45278c5a45c1 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -576,7 +576,7 @@ static int plpks_confirm_object_flushed(struct label *label,
 				 virt_to_phys(auth), virt_to_phys(label),
 				 label->size);
 
-		status = retbuf[0];
+		status = (u8)retbuf[0];
 		if (rc) {
 			timed_out = false;
 			if (rc == H_NOT_FOUND && status == 1)
@@ -637,6 +637,9 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
 	u64 continuetoken = 0;
 	u64 timeout = 0;
 
+	if (!var)
+		return -EINVAL;
+
 	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -822,6 +825,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	u8 *output;
 	int rc;
 
+	if (!var)
+		return -EINVAL;
+
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
@@ -863,14 +869,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		goto out_copy_policy;
 	}
 
-	if (!var->data || var->datalen > retbuf[0])
-		var->datalen = retbuf[0];
+	if (!var->data || var->datalen > (u16)retbuf[0])
+		var->datalen = (u16)retbuf[0];
 
 	if (var->data)
 		memcpy(var->data, output, var->datalen);
 
 out_copy_policy:
-	var->policy = retbuf[1];
+	var->policy = (u32)retbuf[1];
 out_free_output:
 	kfree(output);
 out_free_label:
@@ -1015,8 +1021,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
-		      u8 **output_buf, u32 *output_len)
+int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
+		      u8 **output_buf, u64 *output_len)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1134,8 +1140,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
-			u32 *output_len)
+int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
+			u64 *output_len)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index bf42c6679245..b6b5697426a8 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -83,7 +83,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
 	u8 *input_buf, *output_buf;
-	u32 output_len, input_len;
+	u64 output_len, input_len;
 	int rc;
 
 	options = trusted_options_alloc();
@@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	u8 *input_buf, *output_buf;
-	u32 input_len, output_len;
+	u64 input_len, output_len;
 	int rc;
 
 	input_len = p->blob_len;
-- 
2.52.0

