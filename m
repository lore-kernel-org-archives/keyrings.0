Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621751;
	b=loMr7+yB4mp4LcTlHqrox54cfJixN+73E5evLVjP0DNVYBJPSjhztgFS5cFoOWKti4Eh
	 kZZrS3KIQzpS4OEqsWQEOTbH8esoqplVhKlXIpI919wA2KLmSRWKPaK8MkxCowlhLLNN7
	 kBzxIWA5+8D3+LamDYMmSm7uOOlmWnkg+hQQwIL9HMwRTVwNO2ZoIurknMbo7TFklaTKf
	 FA9SPXfmCJlDnfebZNodAGS/S8jUf0g9RRNhF4OPpFvayj5reJR3LoJaZUDfoRKYkjl1L
	 vTf0Sv5GG+OLCV+U0Uhd4vG9dfAmX5IoreJlsrOFlg/jwQ15xjeSmvz0MzGFAgHRuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vrjIaaTY4rP5gMOZGPWgOU5H4RXkCNbfFg6zhsfnwrc=;
	b=flrQEW1q4V8I6X8eQ5QHWjMghtZeXeotzot4+l91vouhQ+Qh9R7XIawvbwcgivoBV8Oy
	 cQBMQcT2k6mlXWKl1jJIx9T6eU6XoWCNJj1330B6khQ0FR73qKLyAuXTpy80jXg58U8cw
	 09r5dHlGKymoR4Iwlm5/oPLCuAl0QtJSlOye8TBxG+ODOqZuQlIcuNvEaxGZ0FrBHG5DD
	 asyZEULAlk+14uAbfCfy0lrKX6UpNPzckEl4+MW9MRmMIub+visVgHLbVMPnqkux7wZWQ
	 5TaNemyBjdHAdLp1VIOCyc5ygEb4CDH49spKFZEUaoRAbGc4ODF5p4UCsWzIb3t5apg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBnPCJBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 610AF60A3821;
	Mon,  2 Nov 2026 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBnPCJBn
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 94CFC1F0157A;
	Mon,  2 Nov 2026 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793621751;
	bh=vrjIaaTY4rP5gMOZGPWgOU5H4RXkCNbfFg6zhsfnwrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBnPCJBnK/NwKOsP3Pf4GIYNP0+zlX3kckJcBBbg4BswZH72L7APm7vhR0arAf9Ub
	 qH7yOWu2TFGotE4ucbMiygWCP8BCAoJX02zwcCwOU99rkmdLdEiWlEvlf9tHYVdbhq
	 Y0seUof8r+Tyr30TymO653OhdmUzOGZY505Vu7e+/vBr4NhEfgsuCrBOZwjGALpm6m
	 LF/MbWOT0bvtaejHL8PhskffFL/+AaHBPQ2kwferfiYBsmT7SFdC0Of25o/415FpLA
	 gBg44HMEGqGR9ffTEpYmWjUr/1hKkcBmc7qk5QOj1gh1PTQ+d9pFS8qBus9d2LQkr8
	 dll/QxWl6jIfQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED-TEE)
Subject: [RFC PATCH 1/4] KEYS: trusted: Disable sysfs bind attributes for TEE driver
Date: Mon,  2 Nov 2026 14:15:12 +0200
Message-ID: <20261102121518.1197453-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102121518.1197453-1-jarkko@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
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

trusted_key_exit() calls unregister_key_type() from the TEE client
driver .remove() callback. Suppress sysfs bind and unbind attributes on
trusted_key_driver so userspace cannot unbind the driver and unregister
key_type_trusted while the trusted module remains loaded.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tee.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index 6e465c8bef5e..5d1288189e5c 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -264,6 +264,7 @@ static struct tee_client_driver trusted_key_driver = {
 	.id_table	= trusted_key_id_table,
 	.driver		= {
 		.name		= DRIVER_NAME,
+		.suppress_bind_attrs = true,
 	},
 };
 
-- 
2.47.3

