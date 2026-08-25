Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F6468C13;
	Tue, 25 Aug 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667942; cv=none; b=qRSqNSiq4IV6o7dCNbJyASshBT2T1h//NiKBVTFufGNYDeTtzJVFsotGCq53xl9p0g0rjKoGJMQITBFsUQoZk7pczxza51IMvyda0sn62yZz3OZU+nlCmJ91S4TaOm0x9EuXSVp9IP4pdZ83oQC+XerwLOTTVorSYkbSr7kB3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667942; c=relaxed/simple;
	bh=16n4TsTUAu9GhjKP47wM3R+AbVWs08/PU6jhMT9OPOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Il0xV16KmxTHIux9xykmjJKukjauNWgQuKps1vWfZ/dqVGGnngIAd69kaPi82nS0bKsuKSpXN4XRUzEn7dJys8v1qoHcoLQdx2EExO2Lr7T/pXRWRC/QJzKBpVyM0S50byKVVjuOpCM4TysthTeLt+HOcjpTYyDrINvco8ZYdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=iVZfSsks; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="iVZfSsks"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EhgI/l6vnvOET2eYbP/oSJbkLO6aD2eQvyOMf26FBqw=; b=iVZfSsksyCv1NSs5/riCdOG3z1
	jPXlGundtJRKMnsEQ1N5K/O8TmMTy5fQpNm1RiJDRz+9Lvq6t+8rUiZrRoU7t472hOwvexwb3bk2d
	RnGs1oA+HhmprGtaOQ4tdr2kMebPssgsi+kljr1YX63vll+F8Ne1hxlQeA9zPfqqhlthp5xzP+DBQ
	wZTeNkz49fCCu4rnpdDCq4Gg6LasIru5Ime8I2tZlIskngvoV2Jchc0IO26Z0pg9zkRXW4JHSZFXo
	HvTVdyUICa63Gxr4xFsbB5TR3E12uNKGRo4mOos1/+R2MaIqqfnfBkBdsVk5P6nEXb66hYO8OYxLp
	r8+YxksA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5q-000N9s-2a;
	Tue, 25 Aug 2026 16:25:38 +0200
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
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
Date: Tue, 25 Aug 2026 16:25:28 +0200
Message-ID: <20260825142530.1329706-10-daniel@iogearbox.net>
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

