Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7A13D8B1
	for <keyrings@vger.kernel.org>; Sun, 12 Jul 2026 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820722; cv=none; b=knKYvNdQNSnuFkfPJV/MhImvI86vyMi+LsObxwWzxUIwW1Faool0dVqOQmrK4LNXh2Qqe3HZpvzT6+oL5+gqjmflRMpInxglMspBeVPpIJ6cF8U+sCUcrjtc+cFnh0P2Jn1EabdbNnY6RVh5iLka0u8afU6xbbC+a8blQzkNExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820722; c=relaxed/simple;
	bh=9RRZcFgrtBWsMm88TekPA+n+ES8ipoI28R2xVaJ1owk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt8HI+jjP1kN2ot3pA6WQtG4COidTkxm9/YkIBsDdfrgY6gBf76JFP5jQ76XkFuAiQ4ra+/NsSghcLKXaYYFEKWczsz9tGXzte2cq2KFsyEUlzfMsrYqv4AYUjMrQABV+ZxyCtGYb0khvm96GS8yqS9mE0RxO2vvNo/urFhcGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOAVqsKn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOAVqsKn"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e99ef0902so115206485a.2
        for <keyrings@vger.kernel.org>; Sat, 11 Jul 2026 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783820720; x=1784425520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=mOAVqsKnEXzVNnxxHmtOnBI0O5GwVAAxaZVK2neEQ22cW4OPhl/pI8fMptk0v5l8uM
         JnZcV8o6s4MYNi7VBngU/mTXmbvyi5oFyxFAklEw0+yGsuqt/uW0jnaOt9hT814DCyl/
         ggPNoQIJsgkcDGz7G5qqPI8CEKU3MgjZpddk7OARVTyG5IVSRVTkGTqJiPQNXu63GZE3
         7PelUakgmXfcKg2p6JM5XYugkOjvM1FOGxlo9vYrMRR15c7Ib+KqDe9EMLH68yunftI+
         lp3Xbc0Ax2VW0fTLivoLTFou9uvAj7jDcIBAzUNZX7D56zV/c7yi+ed+oFInuQDsH+Ly
         O6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783820720; x=1784425520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=lYJXNSYIw/9GvSs+KUSUSKPU7y9dFW7pIJtexWdOQ1LVZA2eB5eqIs79Wa1j+T+/sR
         g/josZrwYJjN/wBLz2EuIM/dzk0KsgONL2zyLJQuxZ+kpoXd+Kdu5XxHN5fRttFCj7m8
         VXlilHMt32ejrAve+m/fju0B2V18GjvihSfY8J+ZEfl+GObiIK/yqaFpR77z9yEwrKRA
         7A75a4r/r2xWkpzlTml16S2CjCJDW9fUEk+IFzevTfpnQq6fTJvTY7MITf9RlV5tu5Ns
         f5khk6coyGKihbXi7obr0Vpv906873MVbkvZHnAcp5cF3TZUfi2Q0F11tS4I3P2VPWJ4
         kHTQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7kT56uQDn12Qs35MNHCmxQI76PgdOX2IpQEhB3a/J6Jebnq8gZRJrz/MfiC9CNtWaH5vwtvkcaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzrAZmQP0QzLh14lp86VKFRRjihLX1J8DLaWpNfM6JA62/Ph7
	PJQ8Lb2H1JZmiNJnwVfhgcsP4ki0qVIqNxw09p63q92pskR6gmmM7anR
X-Gm-Gg: AfdE7cmMX0GuU21PdObhlegLf0DmpZca5T8fIpMcMtSEmHo6BjHFIl/kEuoBuyk1FqT
	BYLAvuHdb2BV8CigJQ+rzt52cMDW2gBlv8v+cvaGEdlGfjgj/ilszo9Z3NfO63eMqy/J1Jh6RwZ
	XpJuVrNtkODXkHn6w1wOKZEdhuzefsYgOZwuBgSitSm6JgPo/pd7rtmGCsaKYuSzxRL7eVVL6nB
	LtZeDk4ASmFfVS23Ol5cNDylBdFvawMMv3BXeB+CQPmpjOyqcKjuEDVScDLFmlRFvrJyLtPHB+x
	V39rSnfcDSEDOguCDZrto4B7tt+8V3yxrNjsMfaCjM7jnI1XvHu73AHFrBcWCK+npkZK9NgsMg5
	R3RZRx74zqusFhDLALSQes8XmqivYvj8z4Ziv4aFMA0EYXlYw5ulpBUOHbLdA3hNoe5bYRja/nF
	A/aeOLoP1TZmcJpoBMjhgWVBN2VVfkDQRXWXfipqKQbL5EWOTY8ZrZyc1xzxkPbcAAMj19H6Ab6
	PuM/Ftl0g==
X-Received: by 2002:a05:620a:29c7:b0:914:d093:abbe with SMTP id af79cd13be357-92ef2af0f1bmr455686085a.12.1783820719770;
        Sat, 11 Jul 2026 18:45:19 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm624902185a.9.2026.07.11.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 18:45:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] keys: make keyring key-chunk byte order agree with keyring_diff_objects()
Date: Sat, 11 Jul 2026 21:44:59 -0400
Message-ID: <20260712014500.480410-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260712014500.480410-1-michael.bommarito@gmail.com>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

keyring_get_key_chunk() loads description bytes into the index chunk low
address first, while keyring_diff_objects() numbers the first differing
bit from the low end and folds the absolute byte index into the level
without removing the inline-prefix offset the level already carries.
The two disagree on byte order and bit position, so the array can be
told two keys first differ at a bit that does not differ in the chunk
the walker uses, letting crafted descriptions collide into one node.

Load the chunk in the order keyring_diff_objects() assumes and drop the
inline-prefix length when folding the byte index into the level.  This
only changes the in-memory ordering used to place keys within a keyring;
add, search and read of non-colliding keys are unaffected.

Fixes: f771fde82051 ("keys: Simplify key description management")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 security/keys/keyring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1739373172ad5..e7066893e6ffc 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -292,9 +292,10 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
+		d += desc_len;
 		do {
 			chunk <<= 8;
-			chunk |= *d++;
+			chunk |= *--d;
 		} while (--desc_len > 0);
 		return chunk;
 	}
@@ -375,7 +376,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	return -1;
 
 differ_plus_i:
-	level += i;
+	level += i - (int)sizeof(a->desc);
 differ:
 	i = level * 8 + __ffs(seg_a ^ seg_b);
 	return i;
-- 
2.53.0

