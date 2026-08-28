Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09483955FA;
	Fri, 28 Aug 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939559; cv=none; b=O/sXJb6qQuwiAKjFkAdZw/vDSk2X8RLDmjxL9ODHO9IIWF3fdGDfuLAppuhgFYFMqyBEnI+uthGoZxJxAzj7EEE23yPbWgeQr2FxMaJTzYw4LYz9Zx4UORFH6PDvi/SVjQ/HBzEQEhITKbFfp3UwbsM+CiV7D/RlAJdj3aXPxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939559; c=relaxed/simple;
	bh=16n4TsTUAu9GhjKP47wM3R+AbVWs08/PU6jhMT9OPOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3MLak//mCuCC7zHIc69rGZn/gNFOvoEKjMy/l0esiNkh/oyoqIFRe3ILX6654n8MJISMldA2DMM4ONpShlb1CLRm5VlnmqKS56TE2paIYxnFqD0qayc4bQ/r5bHpm9nTWVrI1FyzU3wPQxnmXd+Oxt5knYGU5Z0V2COCGPlozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G91k2Iex; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G91k2Iex"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EhgI/l6vnvOET2eYbP/oSJbkLO6aD2eQvyOMf26FBqw=; b=G91k2IexK+G/u3xww9aF1ojl+i
	qfaS40X/tqkpV1AGIAdzvx/lNZJF+83HydmC9ZAWgbAL74h6UXO2iYEd9UFRzb76lXdH1S8u04AbD
	oBfziTale314/1E0K/e3v1K9S75RbfalStcbHNziWvrtLOsRGAa2g1rpWW3csJFU81Nhfvmmy5E2+
	noR+lDc2loFprRPiCzMfRLn4nto7CNqBzrLFQ5ykkJQppFY4YcbW4aVloCWF1tstuqJhmIrST7/MC
	vCJ7PIoqTReRs8Jo16WpZku8QCF2GGdyrtXisTK20jNynikM9vtcJG/rhLNeQLdx9Us6fnHQ0JCNv
	X5rBLQ+Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00km-0000ba-0R;
	Fri, 28 Aug 2026 19:52:36 +0200
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
Subject: [PATCH bpf-next v4 09/11] selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
Date: Fri, 28 Aug 2026 19:52:25 +0200
Message-ID: <20260828175227.1537793-10-daniel@iogearbox.net>
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

vmtest.sh currently hardcodes the guest command line, so there is no
way to ask for such a setting without editing the script. Append
$KERNEL_CMDLINE_EXTRA when set so it can be used for testing the
BPF keyring:

   # KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1" \
	./vmtest.sh -- ./test_progs -t signed_loader

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/vmtest.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 6a3d026d76bd..e7e0b419a0b8 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -107,6 +107,14 @@ Options:
 	-s)		Instead of powering off the VM, start an interactive
 			shell. If <command> is specified, the shell runs after
 			the command finishes executing
+
+Environment variables:
+
+	KERNEL_CMDLINE_EXTRA
+			Extra arguments to append to the guest kernel command
+			line, for tests that need a boot-time setting. e.g:
+
+	  KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1" $0 -- ./test_progs -t signed_loader
 EOF
 }
 
@@ -286,6 +294,12 @@ EOF
 		QEMU_FLAGS=("${HOST_FLAGS[@]}")
 	fi
 
+	local kernel_cmdline="root=/dev/vda rw console=${QEMU_CONSOLE}"
+
+	if [[ -n "${KERNEL_CMDLINE_EXTRA:-}" ]]; then
+		kernel_cmdline+=" ${KERNEL_CMDLINE_EXTRA}"
+	fi
+
 	${QEMU_BINARY} \
 		-nodefaults \
 		-display none \
@@ -294,7 +308,7 @@ EOF
 		-m 4G \
 		-drive file="${rootfs_img}",format=raw,index=1,media=disk,if=virtio,cache=none \
 		-kernel "${kernel_bzimage}" \
-		-append "root=/dev/vda rw console=${QEMU_CONSOLE}"
+		-append "${kernel_cmdline}"
 }
 
 copy_logs()
-- 
2.43.0

