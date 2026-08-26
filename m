Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D142403B02;
	Wed, 26 Aug 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762541; cv=none; b=AwfI+IgIyM2IyxopCsXb6iL+Ze6C/bL0hSVEo/mhdHL9QJPra9jdFdpFwxUwwwJ7VzG3PGrrbTLZfuWolDYogET3kX7Oq4ldGGZh2tIfDWKcHZUUKl+SjrUNmAYTnsauecUWXp6y8vJZqrBHm0w6FFfHkNimKdxXMzhoJGVPReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762541; c=relaxed/simple;
	bh=5GZWTRj7yplohetEmsgkZZyftn52XJ69moZ1IMxtf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esvTRsuoQZlSP23MYDl/zmhHqw/cYQwDjrXaEqTEAfvKIz17oyYyKIquVm8gVkTMq9klYvoVbPImAqsYJeXhq5X940wPZb5VwtXR5QmqPgxSojikcD4sTPc+Gg05H1/MODwCkAsDEtR8bRE1dDXl1/1cVz76T2VXvrY/VL++ly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Ca+YoWMC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Ca+YoWMC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=giaGPwAFTktmgiR7kYIsQwUaOPVHTJFYj2+LWiXvA5o=; b=Ca+YoWMC6D3TImW9kF2nsJZ81a
	rp9xA7jjiiGfguAMrctA9LfZQxAUTEceU5C1xCSLH2JATaLcZROlKL0wtclh2j2wYSNv922WVspyC
	ETktDRDq9JmrKk/K4sN+wm3YhpL2zNN68uoOKxZsYAmjGhLmE9gOQgmO3DLiHWEwH8z7Y0hXZAuG/
	LB3mSV50b/6+jL0u2T1dB+Ng0e2/fpEw6XFNHh0lH9xb12S7jzzKJmEa7OxVsPc3vsJ563z39ukp7
	KfdLiQrxmn7+DdV+9V2T7UCb6ouWfP+VRQJzDqm8kPIv7emtrfqbqDZQ735aiY91LU4tDGrmuNYc8
	mvLeIiHA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wzGh4-000ILU-2Q;
	Wed, 26 Aug 2026 18:41:42 +0200
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
Subject: [PATCH bpf-next v3 06/11] selftests/bpf: Rebuild signed lskels when signing key changes
Date: Wed, 26 Aug 2026 18:41:31 +0200
Message-ID: <20260826164136.1400997-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164136.1400997-1-daniel@iogearbox.net>
References: <20260826164136.1400997-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28104/Wed Aug 26 08:24:01 2026)

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

