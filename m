Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468814;
	b=q4GD1MjyqYE7BwvkopQT1zrbP8UoKrSu4ssWZuYr4czzkz3uy/6QUNqWouZji9WBrjy0
	 s122OV30981VB2IWqN9jNG5d2cA2LnZxVPSQraNBDcUN679pt5XxTZBJarw81hbPUmzaM
	 XdAoKc4gc/hyWDCL9pr22Xj2c64/lIXx13qcdMYLQc1aSsDMBhtmBm41m/XUcx6Zs4R1b
	 +x0xRwZ5ktJRgOIPMgBArdTltw+WAsEpLSDd9GFgAPXlN4aQLOImxjiPoBTfAnNGVg0KH
	 IPJJizlmo8h9nsiY4XikJJ/raM0bKnMA8zBxKEgk4JUs/bvPf1dJPLCGz70Dmo8l2Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468814;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Zn3tIAp1+uppY8sNhIJSnBaYVUecqPqv6i7tNq/cCs8=;
	b=DgieOeuP4e7NOVYHvMNkRWvyNnJtJWwEJtoRm7I+8RuMEolFMTLYC3RzLW9I0FjztPwG
	 sl6B2lRTPYvmiqcokOLwXGCqQHcBF+vlE3/os3pT11HKQN9j6r3GZ3+wqU+ClgRMIO9TY
	 6wLBfuJL2nrzvNLvdm51ZKdK2mXhOyOg2LdZbIPZldJ0StcpgR7Q0HuCOzkyYFFF2YDAk
	 HQVn4P8444Ks9mID8rXUnPv7MEB31j/R1iI2SixOt4c0bTHHl/EZtgGoVzn6cgKQ6G7DI
	 9HrIh6ingWtZvcAw3Ic3CK6vx/preJs5Ex6MqUATctdj5htVmTcPKlaFahv9T+C+EvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0eQnAZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B3FE4606A31E;
	Mon, 23 Nov 2026 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0eQnAZh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9AA0B1F000C6;
	Mon, 23 Nov 2026 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468814;
	bh=Zn3tIAp1+uppY8sNhIJSnBaYVUecqPqv6i7tNq/cCs8=;
	h=From:To:Cc:Subject:Date;
	b=j0eQnAZhNz0DypmcXj63CP8BaSTvUEDaEonNLo+6TWzNykoyxloYsF4/0xLCRzW77
	 yA7V/b47bv3jSIIKxURVY8tMH5vO6ZtCmzMrrIH8FRyjfNkYqaMSd/uJJXLb73S762
	 I5u7Pc71FQnvhdzbup7OG10KgDR4yziuLYyp55RiY20CcVl4w1sBWatNVlKnXiuAaF
	 f4gCZFg52+u+KDFYAU4Dqo5FzWbjZKL66/NsyNoByjoao7+Phpe6OuHi7GwCi2z+KO
	 BRLiXHLQkz/zsi7IcycalgZjKgSQUdU8d0xJzEGsimmaBt55RYGShIkNEyzlubIrI1
	 w4m0h3IclScCw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Guicai Ma <maguicai@kylinos.cn>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 0/2] KEYS: keyctl overflow fixes
Date: Mon, 23 Nov 2026 23:19:57 +0200
Message-ID: <20261123211959.4102708-1-jarkko@kernel.org>
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

Cc: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: Guicai Ma <maguicai@kylinos.cn>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>

Guicai Ma (1):
  KEYS: Fix userspace buffer overflow in keyctl_pkey_e_d_s()

Jarkko Sakkinen (1):
  KEYS: Fix asym key overflow in keyctl_pkey_verify()

 security/keys/keyctl_pkey.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--
2.47.3

