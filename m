Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C7381EB9;
	Fri, 28 Aug 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939558; cv=none; b=qFX9XDxfrIjarqu6icCIxwLv+ibc4oD8k+xI4Ea6R3VTpGdE2wlWp5i524hD+4WYZcit/dunhO2XD3Uyc02qKwxp1zPFCOcWfG7/YliXAL0DgERPTqrURZetN/FfW/Y/G+b8+Jguw+t4tbVDB86e5WaYWpM/3BAKE1NPmXz/GVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939558; c=relaxed/simple;
	bh=5GZWTRj7yplohetEmsgkZZyftn52XJ69moZ1IMxtf5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQ/K5OHcze/WmiIKo/j1FumNhuNQZY9lzUjr/nC7yCjQonqEOWSbeNN/GQDdPml/6CiAAGOtDGx9NXOT6eSKc6eVxmNvbjSfVVcZ3PUwbht0naWO9AW5Pp9ud1o6e2Jo+WUAzLW64KXuULtoJlpUDVj9mWN1xFynVg3flpYfvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ptq8wGC9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ptq8wGC9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=giaGPwAFTktmgiR7kYIsQwUaOPVHTJFYj2+LWiXvA5o=; b=ptq8wGC9pRemA8c3mDb6DaEvOv
	HGAl9OCuJUX7FhxF34tRlyERTVnbyGFz8WZKZIxwr97/FztgODONSgxvIl9JkAkD1gOI7huoqaJ3K
	TRPqXtq6hNOKZIjUmHHOLziO4M+iDtdQ3/rq8Q8TKk5H6OL7rIC9TVyeaUsIGTUx3IFHSCeXKKc6s
	96D0ZdwAECL71cS3qAOnbOaDtzIQh4S0SiXRMad3l2iqDQeWbryxdqBfoz0Uakv0iP8DjfLJk0JsY
	3GwaCLv2OSlRtSgflI/p/JYxUPhSfSUeRMjHeM6YmSjRwImgimrZtg+kDBjXOguYRpRoHNo4NbYjU
	GQsFkzsQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00kj-0000bA-2B;
	Fri, 28 Aug 2026 19:52:33 +0200
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
Subject: [PATCH bpf-next v4 06/11] selftests/bpf: Rebuild signed lskels when signing key changes
Date: Fri, 28 Aug 2026 19:52:22 +0200
Message-ID: <20260828175227.1537793-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828175227.1537793-1-daniel@iogearbox.net>
References: <20260828175227.1537793-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28106/Fri Aug 28 08:27:08 2026)

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

