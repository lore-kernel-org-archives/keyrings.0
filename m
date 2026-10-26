Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984355;
	b=BII2bBfSF7zkaIr/9Zx3/WywnSotnMW5J2T2Uf3PcmJefUgwxEfcs3JNG1GvPN9FsFAz
	 /AnoQHe1NNlavd3JzTxKo1hFSpNFrYQHZmOFprBfOlcDRQVgeT8EdJwcCDLqNaFb9aoE8
	 bv2i/X/OZZSvztgzjGTWcVIJGOSjd+mMHxcMcTJV0RQXxzUyBHYWHXXKudZFetzWjXHSw
	 4kGB1Ck39NzjDiEpXfF+4X6TFltOcUKCFoAzuKvMyiFW0hUi5vgglg+UyzjsYZwxoyNDU
	 VUpbT6g2cAxFZ60aE/oNMfbvy+fPSAl68e5oKzygL2Xe+sCwwc9NGe2for9bPFvKWVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aSZSlHOKHTqFuEgTVz6eRMU4HuhPxafGNpU/RY51Cdo=;
	b=MsKC0NTE4aGazW9Q/6UhBUU4tZw9B9bqnLPoN62dOISiUDhoCYrgALf1EW9sE4a5ds46
	 utBQC84wEmct1lMFxHuOUUwzh/xxfzC/9kEIOa0pQJmx26gaZlUuTy9Lo62j0bPFr5hON
	 YemdvbSAOx5KbFofs7v+Zedq1U6qDvcXxSLfpI/5DUK/lbtqlyL793bjzvnyfcHFCCtlW
	 Mk1KI3/Y7mARRU30pFHRYJ+7h60IjkbmsgfkTEkSXoh9Ki/P7ipoTfPuVzPdSTl0+67AH
	 3sZl5e/dGD+rFVgOWE0uTeCNKNj/lV3UDHk03JMcpSpwfTvVAzVRbxlHjxdB7SK6jBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P3L0/BgM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7272B606A31A;
	Mon, 26 Oct 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3L0/BgM
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D7191F01825;
	Mon, 26 Oct 2026 03:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984354;
	bh=aSZSlHOKHTqFuEgTVz6eRMU4HuhPxafGNpU/RY51Cdo=;
	h=From:To:Cc:Subject:Date;
	b=P3L0/BgMzBSgCyejyDwN/Nc1BA+u8HS7DfRiqDzxWrd6DHvgoLquW8GKWSatWGmnL
	 FARtHGT0hDM8skQxOsJhLYKBYBABfAPol0P9owPkzGA3mBd+geo4jJxl5qESDDz4V/
	 yx7QTTfogyolk4O5U9hZC3rN5OitVRQ8ahkH2SlrFcxtl1N2+DUIAsbULOi+oR1vOf
	 y9JBUeBjvQk1zk1YAYNNBhZW/VOAnMgl1vcE6GkSgl9wHdojlzuSYCmINzG4sw+Aep
	 xyZU2Bv53iHIm6nxrr3e3JfT4a4LA9S1A+8bXXtBsU8U6HPHSWFY1YQhc/lofoIzwV
	 ZQL8R1bTRmhdg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Date: Mon, 26 Oct 2026 05:12:18 +0200
Message-ID: <20261026031219.2627968-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

schedule_work() dispatches key_gc_work on the per-CPU system_wq, which can
choke the queue:

BUG: workqueue lockup - pool cpus=0 node=0 flags=0x2 nice=0 stuck for 30s!

Queue the work on system_dfl_long_wq instead, which is an unbounded wq for
long-running tasks i.e., it has the WQ_BOUND flag set and thus cannot hog
the CPU core.

Link: https://lore.kernel.org/keyrings/20261024042944.52493-1-hackerowskiy@gmail.com/
Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6ad35b60.7952420f.283480.0360.GAE@google.com/T/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
I sanity checked with perf that scheduler latency improved clearly as it
should, and used large keyrings that I expired, as the test payload.

It was ad-hoc testing but I can scrape from transcripts a test script
if wanted.
 security/keys/gc.c  | 8 ++++----
 security/keys/key.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d4..2337d39722e4 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -57,7 +57,7 @@ void key_schedule_gc(time64_t gc_at)
 
 	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
 		kdebug("IMMEDIATE");
-		schedule_work(&key_gc_work);
+		queue_work(system_dfl_long_wq, &key_gc_work);
 	} else if (gc_at < key_gc_next_run) {
 		kdebug("DEFERRED");
 		key_gc_next_run = gc_at;
@@ -85,7 +85,7 @@ void key_set_expiry(struct key *key, time64_t expiry)
 void key_schedule_gc_links(void)
 {
 	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
-	schedule_work(&key_gc_work);
+	queue_work(system_dfl_long_wq, &key_gc_work);
 }
 
 /*
@@ -119,7 +119,7 @@ void key_gc_keytype(struct key_type *ktype)
 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
 
 	kdebug("schedule");
-	schedule_work(&key_gc_work);
+	queue_work(system_dfl_long_wq, &key_gc_work);
 
 	kdebug("sleep");
 	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
@@ -322,7 +322,7 @@ static void key_garbage_collector(struct work_struct *work)
 	}
 
 	if (gc_state & KEY_GC_REAP_AGAIN)
-		schedule_work(&key_gc_work);
+		queue_work(system_dfl_long_wq, &key_gc_work);
 	kleave(" [end %x]", gc_state);
 	return;
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 6ebb8691551f..599626c897b2 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -668,7 +668,7 @@ void key_put(struct key *key)
 			}
 			/* Mark key as safe for GC after key->user done. */
 			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
-			schedule_work(&key_gc_work);
+			queue_work(system_dfl_long_wq, &key_gc_work);
 		}
 	}
 }
-- 
2.47.3

