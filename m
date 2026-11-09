Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243226;
	b=IqnNGzuaEof1BdkahcS+Snum3U0wyPOokLkIq/GE4TmGC2y4MPaQ55lWnOf5z+bMkhrE
	 sq6nNvJ5PcTZmtG8rr5YXqjgH5gvNw7Zj2W2Pm1J2h09TGqZ6GZreVa0nVLhg2uijLefk
	 JT7zKKeyu51bf/95eS+HzgY7/b/A56MG9bvn05ttbccSyjnYw+t+ipk7yktQVZEhuWDiy
	 +TDo5sNmgG/yy0shZvzkHnKTqGz9HKsnAKQ+NBlmR5t6kaqIq5uUDk7IqjH8KHA6+EU21
	 w3bbz+5xNQrg+ZUJndq+JuDaHvE6I6B9LyF0IhHkqphFjlk5WK583uEXUWNcphCT7og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243226;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-Mailer;
	bh=PQOmlDR9uumCxk4igEelnDFvdmZ/YsslB4fRmX3ecrM=;
	b=BMjiQi/S4ExkYp+2CveFe/7Y4s9f180rGbPswuVmZxbpmbvXhKDAz1chmeazOyYtK2ao
	 jGfZ6+JSd+zAOVbYo65P15NbPU90DnPdriHHVmhgK0cJgXlINGXn4s0yCDJVVcT+U93+B
	 VVJulJoEiZdBNIXakJf+39LSR9688VLKIWvYFJsQrx2iQH6vEb4ZqmRMu/CcW22cfkgmJ
	 DDKI0aGUW1T2P0jr11Xgu4uhlM60jeb6koFdhPb4Ns5H/SLXpq5fVQbRfiKGTyXytPWPu
	 5N7N2zjEUECs79ehXRzAkE+V7qcpRUMErZ1D8kos7kmrlaqiKdpLYiMHpbtlyqZLXbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe1AiO76;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6BF24606EEB4;
	Mon,  9 Nov 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe1AiO76
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 738A11F008A1;
	Mon,  9 Nov 2026 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794243226;
	bh=PQOmlDR9uumCxk4igEelnDFvdmZ/YsslB4fRmX3ecrM=;
	h=Date:From:To:Cc:Subject;
	b=Qe1AiO76rw8y0xq7On+MMZG+E/B//eeT/TWkiEX1N0oWyEt1xhAkfw3/8wPhrZprv
	 l72pUWKIO7LVGzWGd1zXoT0Ff9cI51L+F7nzKClFhIbKygOEbMMaJ9xG/kYWQPhjzq
	 rbPhFbAXp0Z33YfyyMzlhH6D9yAbeFNdj0/xmTlHSfS2syk73B+Q4ZLD5zqr+5GAMg
	 cxaKg0F3Gu1FrHryxxiHsXd0LQptlb0j7ZnBUM95GJuKNJBm2X4uF7Kg5G1qSDv5SI
	 Rc+1wJ4M9GCPriXXwsVEiErr98cDrn5fuWTzxdKrss0C6UMMCY/9i/d2CxbUY0G+kR
	 noUvcX2QBKYxg==
Date: Mon, 9 Nov 2026 18:53:42 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] KEYS: changes for v7.4-rc3
Message-ID: <avH6lqK4nq9j5aKs@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 05441d697f7f9a927264f4058cbbc6a03dfcac9d:

  Merge tag 'cocci-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2026-11-03 08:36:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc3

for you to fetch changes up to 51bcd09b9ffca7a2a3b66fb57182bb391364f612:

  KEYS: Protect the update method check against type removal (2026-11-05 19:19:36 +0200)

----------------------------------------------------------------
[GIT PULL] KEYS: changes for v7.4-rc3

The first three bug fixes are side-products of the rhashtable work, which

1. Expand key->datalen and key->quotalen in order to avoid integer
   truncation and the leak of quota.
2. Enforce KEY_MAX_DESC_SIZE limits across in-kernel and payload-generated
   paths.
3. Verify the key identity in __key_unlink_begin() as type and description
   could also refer to a more recently linked key with matching properties
   as the one being unlinked.

51bcd09b9ffc ("KEYS: Protect the update method check against type removal")
highlights the disperancy of being able to remove key types while keys of
that type still exist.

As a consequence, I've implemented a patch series, which pins the key types to
their LKMs, and removes key_type_dead related keyring GC functionality as the
net result:

https://lore.kernel.org/keyrings/20261108222719.304712-1-jarkko@kernel.org/

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Cen Zhang (1):
      KEYS: Protect the update method check against type removal

Jarkko Sakkinen (3):
      KEYS: Expand key->{datalen,quotalen} to unsigned int
      KEYS: Reject descriptions larger than KEY_MAX_DESC_SIZE
      KEYS: Verify the key identity in __key_unlink_begin

 fs/smb/client/cifsacl.c     |  6 +++---
 include/linux/key.h         |  7 +++++--
 security/keys/key.c         | 26 ++++++++++++++++++--------
 security/keys/keyctl.c      |  2 --
 security/keys/keyring.c     | 13 ++++++++++++-
 security/keys/request_key.c | 14 ++++++++++++--
 6 files changed, 50 insertions(+), 18 deletions(-)
