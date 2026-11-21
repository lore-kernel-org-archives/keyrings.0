Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259599;
	b=SDFReuQoVMnuiD9JEyzxbamUbUFjtl1IL7yM86sZJZ2ajZiljSsbcuceoGKSPQcd8MaD
	 Y/C5W3FedJct6H+tgCysmABLYQC2PY9RHPgD+UxMu4ZQhdItIlnrjZrreQZsHh6/Q+QUJ
	 Nnt4rINaX2tEsKitEIo7imdNM90ayQ3O15lHNok+W0OxAdpueqzfeb4dALAjcHXHI7sUp
	 Q4jbtNydQwsKmvnCxlUmywGCw5phixvRfFoza7kxpxeaxzoX8RlWCJ0T9N13bXceKYQlf
	 pa2qs5tVL0OfzKS+ueq+5lR38IcnH/QUvBKnBJJRxfj/PkMATcNhbptSKDoYXs7g+BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259599;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ugFk6s0GToyX3hg+udCNXOLZc1Yatauz4i+Os1cYmEs=;
	b=YzijeybPkayHJkAeNjcCKJN+Wv8JG758u/3ax0J6H6WzChTg4VquU1mznClQh+9yBFVK
	 6gD+U37tiioZsglfjZMQoR59bp5QfqchhnKqnw/AQ12YwgiWkYSTlBnSdjTwuDgdG8k6Q
	 L8ItVVqfd4mEobAL7XSID7e7bJ2UBw310ACZtMf4/khqdJRoPZSQgur9DxqNJT7Fj07n/
	 Jv5/1NxHrgi6SJd25984AEuvPStlCx9/Ht+NoDUAmRjdRCkV406YPlnv5yC26rvnIcAF+
	 eiNiCz8m9ly2sbF9PughHlX3ygmx9cPM4wXwvlAFRShTz1awXei47MRX95KzpR1fgKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=D9d7Cwuu;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC2606A320
	for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 11:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86EC2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=D9d7Cwuu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795259596; x=1795518796;
	bh=ugFk6s0GToyX3hg+udCNXOLZc1Yatauz4i+Os1cYmEs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D9d7CwuuuryxJxgAzo9AkZD9HAmaCWrP9YrQ6Rm5qy7xu9tKgY7Hptggm/7fDl9Zn
	 fQiOVWiHty1O7s1oZpwo8efzMIFm2G4/4oGrdFOX4VDgl9UZKE9AEiOEteiqwl+w/3
	 egj6RrbJVecTbIXFHl6u5BElcGMMjkFqLp+4FICFBlTlq04ZzzH4yvXZSqrypxD1E5
	 1cEghkaWK+VjDzf0E1q46jA7Be8VgQkIdEAN1SFelPBzEP69FYpdMAv87s7Hhz4VQ/
	 KUMR3nBN8zfdcbpovbPPDunUI0PYRBtXdRYTf4rSHpBz8MhUnC6KJ5TAJ14dxVYJ9/
	 HPNyUruJorE7A==
Date: Sat, 21 Nov 2026 11:13:07 +0000
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3] keys: serialise key instantiation against keyctl_chown_key()
Message-ID: <20261121111246.3478-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 517120b5293edfc1226501d884046b776994fa3f
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

keyctl_chown_key() looks up the target key by calling lookup_user_key()
with the KEY_LOOKUP_PARTIAL flag. That flag lets a caller with
CAP_SYS_ADMIN change the UID of an uninstantiated key during construction.
When the UID changes, keyctl_chown_key() replaces key->user under key->sem
and drops the old reference with key_user_put().

__key_instantiate_and_link() and key_reject_and_link() hold
key_construction_mutex during instantiation, but neither function takes
key->sem. Both functions increment key->user->nikeys, and
__key_instantiate_and_link() also calls key->type->instantiate() without
holding key->sem. When a key is in quota and its size changes,
key_payload_reserve() reads key->user seven times without key->sem. Those
reads include spin_lock_irqsave(&key->user->lock, flags) at the start and
spin_unlock_irqrestore(&key->user->lock, flags) at the end.

If keyctl_chown_key() swaps key->user between those two calls,
key_payload_reserve() unlocks the new owner's spinlock and leaves the old
spinlock held. By source inspection, key_user_put() can also kfree() the
old struct key_user while instantiation still dereferences it. That struct
key_user use-after-free was found by reading the code and did not trigger
during our KASAN runs.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  WARNING: bad unlock balance detected!
  7.4.0-rc2-g23c62304dde2 #3 Not tainted
  -------------------------------------
  request-key/163 is trying to release lock (&candidate->lock) at:
  [<ffffffff82698fff>] key_payload_reserve+0x29f/0x370
  but there are no more locks to release!

  other info that might help us debug this:
  locks held by request-key/163: 2, on CPU#3:
   #0: ffffffff871c10a0 (key_construction_mutex){+.+.}-{4:4}, at: __key_ins=
tantiate_and_link+0x38/0x370
   #1: ffff88800de4a8b8 (&candidate->lock){..-.}-{3:3}, at: key_payload_res=
erve+0x160/0x370

  Call Trace:
   lock_release+0x286/0x2e0
   _raw_spin_unlock_irqrestore+0x1a/0x50
   key_payload_reserve+0x29f/0x370
   generic_key_instantiate+0x42/0x230
   __key_instantiate_and_link+0xd7/0x370
   key_instantiate_and_link+0x40d/0x4b0
   keyctl_instantiate_key_common+0x2d2/0x450
   keyctl_instantiate_key+0x167/0x180
   __do_sys_keyctl+0x391/0x550

Take key->sem for write with down_write_nested(&key->sem, 2) inside
key_construction_mutex in __key_instantiate_and_link() and
key_reject_and_link().

Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner=
")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
In v3 I removed the tool paragraph and the two lockdep subclass sentences.

 security/keys/key.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 3f1f0fc..df31d10 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -441,6 +441,7 @@ static int __key_instantiate_and_link(struct key *key,
 =09ret =3D -EBUSY;
=20
 =09mutex_lock(&key_construction_mutex);
+=09down_write_nested(&key->sem, 2);
=20
 =09/* can't instantiate twice */
 =09if (key->state =3D=3D KEY_IS_UNINSTANTIATED) {
@@ -473,6 +474,7 @@ static int __key_instantiate_and_link(struct key *key,
 =09=09}
 =09}
=20
+=09up_write(&key->sem);
 =09mutex_unlock(&key_construction_mutex);
=20
 =09/* wake up anyone waiting for a key to be constructed */
@@ -609,6 +611,7 @@ int key_reject_and_link(struct key *key,
 =09}
=20
 =09mutex_lock(&key_construction_mutex);
+=09down_write_nested(&key->sem, 2);
=20
 =09/* can't instantiate twice */
 =09if (key->state =3D=3D KEY_IS_UNINSTANTIATED) {
@@ -632,6 +635,7 @@ int key_reject_and_link(struct key *key,
 =09=09=09key_invalidate(authkey);
 =09}
=20
+=09up_write(&key->sem);
 =09mutex_unlock(&key_construction_mutex);
=20
 =09if (keyring && link_ret =3D=3D 0)
--=20
2.56.0

