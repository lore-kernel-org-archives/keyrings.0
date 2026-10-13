Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A8485511
	for <keyrings@vger.kernel.org>; Tue, 13 Oct 2026 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931559; cv=none; b=BJ+IVS1HGPI1h5tzVZGp21SaK/gXlNpPbPM0mHUlJTmAmoUk9MKsgoL7IuKaiem65Wbwn9YTC3RTOuwPFBf8hBeQcgbCRvNdbr7mKN2Fyt03TBQs8Nv48c8J5f1YAmgQlLNWgWyAOy83Wu8WdqMDTI1/Yoot1h+L/OF5TFfKx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931559; c=relaxed/simple;
	bh=7oUfc7/a0wQ7bLyNKzkXv/xXe7gJDQ6XuXtCaXQL7i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cL3P0pPPD8xq4STewuDvVCwzYyq6Jr3l49CWjX+Za4mbsnrr9Z0CJM1kWRfCV3TYZO83W8cdCMq3BBWaFDv6SHyXDMWcTfiIu0OSFudS4DFFRrAo5F0LdH3OR3wDNm2CVe2ZRqIpnuNTGRarMRFLMWzW3eje5XUa0dU/MkFcEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdUQq2n2; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdUQq2n2"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a4d2e39acso1202339eec.1
        for <keyrings@vger.kernel.org>; Tue, 13 Oct 2026 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931557; x=1792536357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaC5p7lBreXJFrDTlX//tAKrHbRA93HCXS6PgHHIrBY=;
        b=AdUQq2n2MgCnGOTR/w45BbSdlsFVJG3ic48vAbdefRPGWnaa138K+WbXZlNs8HYZGO
         n7KX7zQppUHwh9omch07hkoWnnkSkLfwCKy94nNh5VR0puxqLHGJ+/Zw6zKMq6qfx03l
         SFwqGApMoVCFHMa3hJX78STC4VajgaVHHGZ2EBPrB0WG7Rlk9B5b2RTw3oRxNUgdWvHp
         Dvuj3GqEyInQYVeuyIgYikntfhX6PZEfy60qrtWtHAhLKZdFzivwXPngKQL1p00zO+e7
         E1kNZCLcYctIHbofVPm2KzBZT5fFS8hNMtB0i2H8nDtROj3TJOsv9OjzpRwOkjhNT9Fy
         dgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931557; x=1792536357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaC5p7lBreXJFrDTlX//tAKrHbRA93HCXS6PgHHIrBY=;
        b=F/sAI/d2sbY+vXd6Oede/pQwK2qnwOG6ysM9Pvp+l4CPPIZ9MDJdAHbnvdAXNv8LNx
         v9OJ0dVflv3q4mR523qmRlQkDUkWo38APsdAq60tkCMFcbhm/B0LJAn9gfT+j4C/JdyP
         C2XvENxtUoxob8zPG1OA6/NK0B1SI5/+SI7fOz/Cq36zOYH/yHcj1AYMqMaPNLmW7DKa
         BfZC366q/pCL9Yf141Y847IGQtyWKirQjCWN6b9dnc8xGvU1Gpwi4L6Aq3bMoFpvCc0a
         tTQLoAYIsZC6d/nE3dWl+Pw3pkx1W+nTBXdv2yW5EzK87VSz8BHBL0iHgZHtduHqwE9o
         luug==
X-Forwarded-Encrypted: i=1; AKwUvBw9jqh0myVQ43NhdOWlncYfqyc38cWPiEuiF3jjbRgyZjY3Kh55xsxLUBBwyWeUJo4DjUctAm2tKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI8WB0LGjnHZhq+xVKBC2ALdTTzeLUm+eAH+4Kg4KMX1hhILRAT
	mAAHGR63a/D9SXxWinSC0TXwF2Qnj3l5BftKv14RFxdwq99JyRNbmmPNk33XYdMOx/zSZdsgbtk
	ecv1Hlv+6J1Z7Sw==
X-Received: from dycph3.prod.google.com ([2002:a05:7300:dd43:b0:35a:5674:dda5])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:894c:10b0:351:78e9:944e with SMTP id 5a478bee46e88-3537e0945bamr21650637eec.41.1791931555233;
 Tue, 13 Oct 2026 15:45:55 -0700 (PDT)
Date: Tue, 13 Oct 2026 22:45:51 +0000
In-Reply-To: <8932791855928d9f12b7356648e2ebacfc126bee.camel@xry111.site>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8932791855928d9f12b7356648e2ebacfc126bee.camel@xry111.site>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013224552.557528-1-cmllamas@google.com>
Subject: [PATCH v3] certs: specify byte alignment
From: Carlos Llamas <cmllamas@google.com>
To: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Carlos Llamas <cmllamas@google.com>, 
	"open list:CERTIFICATE HANDLING" <keyrings@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Giuliano Procida <gprocida@google.com>

The alignments specified in system_certificates.S and
revocation_certificates.S are intended to be byte quantities.

However, the .align macro is architecture dependent and on arm64 it
behaves as .p2align. So use the .balign macro to avoid unnecessary
padding due to over-alignment.

Signed-off-by: Giuliano Procida <gprocida@google.com>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v3: tested, collected tags, rebased on top of mainline.

 certs/revocation_certificates.S | 4 ++--
 certs/system_certificates.S     | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/certs/revocation_certificates.S b/certs/revocation_certificates.S
index f21aae8a8f0e..a53b49d49931 100644
--- a/certs/revocation_certificates.S
+++ b/certs/revocation_certificates.S
@@ -4,14 +4,14 @@
 
 	__INITRODATA
 
-	.align 8
+	.balign 8
 	.globl revocation_certificate_list
 revocation_certificate_list:
 __revocation_list_start:
 	.incbin "certs/x509_revocation_list"
 __revocation_list_end:
 
-	.align 8
+	.balign 8
 	.globl revocation_certificate_list_size
 revocation_certificate_list_size:
 #ifdef CONFIG_64BIT
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 003e25d4a17e..ea6984b427c9 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -4,7 +4,7 @@
 
 	__INITRODATA
 
-	.align 8
+	.balign 8
 	.globl system_certificate_list
 system_certificate_list:
 __cert_list_start:
@@ -20,14 +20,14 @@ __cert_list_end:
 system_extra_cert:
 	.fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
 
-	.align 4
+	.balign 4
 	.globl system_extra_cert_used
 system_extra_cert_used:
 	.int 0
 
 #endif /* CONFIG_SYSTEM_EXTRA_CERTIFICATE */
 
-	.align 8
+	.balign 8
 	.globl system_certificate_list_size
 system_certificate_list_size:
 #ifdef CONFIG_64BIT
@@ -36,7 +36,7 @@ system_certificate_list_size:
 	.long __cert_list_end - __cert_list_start
 #endif
 
-	.align 8
+	.balign 8
 	.globl module_cert_size
 module_cert_size:
 #ifdef CONFIG_64BIT
-- 
2.56.0.385.gd3acb90ef8-goog

