Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72943FD1F;
	Tue, 25 Aug 2026 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667944; cv=none; b=ntgw60pC/jilYJ0oQc3sRSNov6/wRoRuVsjq8Y3gezbupOZ5OrjfSjaMlmDkVpZ93alCwpXogCXaw7Y8Mh57GsnABluArdc+N1jNBbpbRfaxf1JQI352qomEvx3RNCaJQzCFEBXZFRaaeIKLKXx4k9OKeujpUAwJwaXTNpyxV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667944; c=relaxed/simple;
	bh=5GZWTRj7yplohetEmsgkZZyftn52XJ69moZ1IMxtf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdTIXOkbz701mjkhpQzelwHCxpDdvbG1wy3T2L0eZ/wXg+zF6VbAfrm35YKhaQIzCcfSzKw4k/ywbHUZq2r+ekJWe69aVevIDSiJOObw55Ni9sO/+4obAFVmlcv4Y+KSw76MARAk+AMI1ysABpH2o8/CcTBQSSEVy94XvBOUBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=graH9iZQ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="graH9iZQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=giaGPwAFTktmgiR7kYIsQwUaOPVHTJFYj2+LWiXvA5o=; b=graH9iZQYqKPo4E4QelDs1reTZ
	7L5ljOPONjBovYWLqM4XqLenX3SS7GUinyJjqH73XzjCbjIWvsLHyuQUbDecj1R041ZO+uGsuQlIh
	l3jEmaJutCTLxfv77iEZXj8ciuvpCKLnwFZ+PxuKjuEz1GlALDHRU/4ETXyHPeW5B3Y83iYMxctFb
	GFh7HIbcvxaCRFjvPhDoWUhcHw9o0kRUKLrg9HNMddpPjhGyXWY5k/BIpWpWNOsLiZoD4Wla/zysZ
	HCTmK6a355naxawoQJ+xhSWnHJodFadf9guvt1Vp6R/Fwe3MbxlN8S4t89hT+D/885kT5aUPTxB0X
	MFdXmp/A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5o-000N96-13;
	Tue, 25 Aug 2026 16:25:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH bpf-next v2 06/11] selftests/bpf: Rebuild signed lskels when signing key changes
Date: Tue, 25 Aug 2026 16:25:25 +0200
Message-ID: <20260825142530.1329706-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825142530.1329706-1-daniel@iogearbox.net>
References: <20260825142530.1329706-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

The signing key is regenerated whenever verify_sig_setup.sh changes,
but the signed light skeletons only depend on the BPF object and on
bpftool, not on the key they are signed with. Thus, add the certificate
as a prereq so a new key forces the skeletons to be signed again.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5f1a3bfc0569..05b3ee64290f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -663,7 +663,7 @@ $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	}) && \
 	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
-$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+$(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) $(VERIFICATION_CERT) | $(TRUNNER_OUTPUT)
 	$(Q)$(if $(PERMISSIVE),if [ ! -f $$< ]; then			\
 		$$(RM) $$@;						\
 		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
-- 
2.43.0

