Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674998;
	b=hfAlGAvzgutknKHgGVXLDhL8+H2swJS1s61/bV2l/f7RnMgkp6revfaC6RgT50hQKa+E
	 J5W7saNp2oiJ42R/hZvTZMvuQAzgs2rG/H6eVfw4iT9PnW8zDHvYEtSNeWFzZMe72xjaJ
	 iefgGWpMsVXIg8lrG5uimdqTOnDOHtjgdfh3f8CqmMcNucOHunSIdpyE3Ooj3Qce4WV1n
	 /z08avAkOMRL4AGn2WT3ePNDSJAklrhA/5xMdx70T8A+j2axZIgBNqBabRdWbqMyt72+2
	 KEk2uF/A0kv9xe5usWHaWKgNygenEcy26e+m6oZRKGNImN8H+26wTg8BFlbrQahRNbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LMWGk9gDJDuKIuq5BO2Fto/mxAJ3HEcBl5y5WIpfXJ4=;
	b=sroZknxmImIS0wi0KASusx/UQxNVXloSzPyqpMhkDiUvpOKXEP/Hm14gl6FbJasfejgH
	 z/A9tr54qmCpVOB3p373A22iCH4U/0ZjJtna4AD4G44IZmVxzabZBC9EdEJZl7gJ3qjfp
	 uH3wKATmd8lZeIOP5aJa7IxcHBbfhDWG11Ks/MIKPDUT9Rs+Llwj1yrqXFNcEh1mVdaZ7
	 eh3QNrU3/b0kVCxV/Q78Fo1Z9bLHK7y0boRrYnxe/suHMShgsz2vw454pJg93IoLu3YRt
	 FDZp7ZT0kivmqrbf4HxY8HeY43Y1u6BUfsXBET2wPoYld8JgFPqhx+YmOdBgtqjSedw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjcwGPPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DB9D7606A327;
	Tue,  3 Nov 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjcwGPPJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0E18A1F00A18;
	Tue,  3 Nov 2026 03:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674997;
	bh=LMWGk9gDJDuKIuq5BO2Fto/mxAJ3HEcBl5y5WIpfXJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjcwGPPJo6fXy0uGEgHALXFhsfwXqZkmBQZTHuMatyVfYo9ZVASYOOXEQvJkki82M
	 P25AEtdOYGsfgDqvyq9qZqAGj9M0gPtthKx+wUzy2FzV0rkaUhB3TxgoiZQGw+XPVN
	 v1ffea+WCBsytjhUGg9LXD24UIre58NVSrktKxJJauVXmR/7RirB6d9IVvd3DLdbGD
	 usJ6279QNk6ChFDJqkL9IbD+Wtk/5Iq2x/QqLphlSYB0Gv3zAKGFp4oIDG6mJUSmQv
	 ySpCrf5EuODXvJBMkct9htQ/vbfn0NUjKOJdC6GPq5K0vROxhFF8qsJm0S8F6K2Sju
	 3zRBTsfgy/h3g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
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
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2 07/11] KEYS: trusted: TEE: Disable sysfs bind attributes
Date: Tue,  3 Nov 2026 05:02:12 +0200
Message-ID: <20261103030226.2685251-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
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

Suppress sysfs bind and unbind attributes on trusted_key_driver so that
userspace cannot unbind the driver and unregister key_type_trusted while
the trusted module remains loaded.

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

