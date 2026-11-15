Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745070;
	b=ciWk8bvwjXGiunVRngXXjncINPRu4EAu6oPaDUehaLU4/VjglSeK3anYkE7x0nBvh7Vc
	 RnkyfGBwYmfUVOz7JiiXqytYawjeI+b0qFQ7RlhH4+gh6dByTfX2pl1/tlnXkZLttUj9Q
	 8meBLJA/AohCK634VidwiqPPhQvDNy//C1yuhYmScrRM52oxg3MfGMXwacBfmzuJSKoBh
	 ZLbdeG7XJ0+obFZsHKr9TXAeb7GYMBcGJ7ujZyMKjhZaOQymXPeL/RY/CIstMuROZgMcC
	 k7To9fNxVjx8PXKuPWO/WBu+XF0wPyssUzf4kNNlrA1sUizKUvV0sdIJyiuMh86KOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745070;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EluYiwlFKYuh/LI+cnM/6qB8JrNrz30s4NvnPy3YyL0=;
	b=I9lXKyHaS72PcCpa0G6mlSVZKmjsn0K+u7Dh1P2NCX9pnc3PD9i1f9cAehI8aqg+zUoE
	 USCdPIa16HieL1W6WX7+f2nXLVcPX6IagYR85s/t4u/bXn5RzDv8xkwmNLE+VpjWnaYme
	 XKFfSqGGjQrOEvkRAlZ/9LaqRUSq9YP+UW6AfKcCs9+nKjPrOLbjaGx+2+lBmmToiB/O1
	 ix2m845HG2oapx4+sf7kakKhov5Pc5LIYEMWZI6qnXP9Ody65iXM9yQTPmuieWlvH+ShZ
	 V0S/dxv563zF7pHrAjh5aSSJu4usn308k4+TQG1nijTM15A+a7gqX/oH8kaIkflS6Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=OUAq5Fc9;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEF606A327;
	Sun, 15 Nov 2026 12:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CDEF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=OUAq5Fc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1794745067; x=1795004267;
	bh=EluYiwlFKYuh/LI+cnM/6qB8JrNrz30s4NvnPy3YyL0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OUAq5Fc9kmK9eU6iD30wyyVivgL5YQ7TnSXW00wEYIR9CYYpjLs54b4s0ZtR9WJ0I
	 8nbv714q1kGMRxiksvmn5vnC+02HF8sV9rptv6MQRUddkj4/L9UahuAFU7i807wuI/
	 g3wi3KzbE9oDuPr4GwdIScq0oDZVZP5UQgok5sSV8WvEvawpzZlYCh1IZpM1fnc6b7
	 MhPy79br/0jiXsgbok4tjLeyTl8B/PCwpH9K7zyIIqPcDukLk9EFMnh+J7o4yv63LH
	 Rjm/Q3GdsUMgtng5578auYkh881eHnokX3LtOS/kur5gFSo3gJ1jBYphhOkPRAowtX
	 hAsPrIbzce6UQ==
Date: Sun, 15 Nov 2026 12:17:40 +0000
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] keys: serialise instantiation against keyctl_chown_key
Message-ID: <20261115121722.206-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 62b592fa9ecff3d6048e83be9e5f68d5467bc76f
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

keyctl_chown_key() replaces key->user under key->sem, but the
instantiation path reads key->user without it: __key_instantiate_and_link()
and key_reject_and_link() bump key->user->nikeys under
key_construction_mutex only, and key_payload_reserve(), called from the
type's instantiate op, reads key->user once for spin_lock_irqsave() and
again for spin_unlock_irqrestore().

A chown of an under-construction key that lands between those two reads
locks the old owner's quota spinlock and unlocks the new owner's.  The
paravirt unlock slow path reports the unheld unlock and the old lock is
never released, so the next quota operation on that uid spins with
interrupts disabled:

  pvqspinlock: lock 0xffff88800f94dc38 has corrupted value 0x0!
  WARNING: CPU: 2 PID: 215 at kernel/locking/qspinlock_paravirt.h:504 __pv_=
queued_spin_unlock_slowpath+0x1dc/0x2e0
  Call Trace:
   _raw_spin_unlock_irqrestore+0xe/0x30
   key_payload_reserve+0x230/0x300
   generic_key_instantiate+0x47/0x230
   __key_instantiate_and_link+0xbd/0x310
   key_instantiate_and_link+0x3f0/0x490
   keyctl_instantiate_key_common+0x246/0x410

The same unsynchronised read lets the instantiator touch the old
key_user after the chown has dropped the last reference to it.

Hold key->sem for write across the instantiate op and the owner-record
updates so that instantiation and chown serialise on the lock that
already protects key->user.  key->sem nests inside key_construction_mutex
and the destination keyring's semaphore here; nothing takes the
construction mutex under a key's semaphore.  The acquisition is
annotated as nested because a keyring instantiated into a keyring shares
the destination's lock class; the key under construction cannot be a
destination itself, so no cycle exists.

Reproducer: a request_key() helper that chowns the target key between
two uids from one thread while instantiating it from another, as root.
Triggers within tens of milliseconds on 6.12.104 and on mainline.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
An AI tool helped with the analysis and the patch. I reviewed and
tested it myself: the unpatched kernel hangs within 40 ms, the patched
one ran the same workload for 60 s with lockdep on and no report.

 security/keys/key.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -439,7 +439,13 @@
=20
 =09mutex_lock(&key_construction_mutex);
=20
-=09/* can't instantiate twice */
+=09/* can't instantiate twice; key->sem keeps key->user stable against
+=09 * keyctl_chown_key() for the instantiate op and the quota update.
+=09 * Nested: the caller may hold the destination keyring's sem and the
+=09 * key under construction may be a keyring too, but it cannot be
+=09 * anyone's destination yet, so there is no cycle.
+=09 */
+=09down_write_nested(&key->sem, 1);
 =09if (key->state =3D=3D KEY_IS_UNINSTANTIATED) {
 =09=09/* instantiate the key */
 =09=09ret =3D key->type->instantiate(key, prep);
@@ -469,6 +475,7 @@
 =09=09=09=09key_set_expiry(key, prep->expiry);
 =09=09}
 =09}
+=09up_write(&key->sem);
=20
 =09mutex_unlock(&key_construction_mutex);
=20
@@ -600,7 +607,8 @@
=20
 =09mutex_lock(&key_construction_mutex);
=20
-=09/* can't instantiate twice */
+=09/* can't instantiate twice; see __key_instantiate_and_link() */
+=09down_write_nested(&key->sem, 1);
 =09if (key->state =3D=3D KEY_IS_UNINSTANTIATED) {
 =09=09/* mark the key as being negatively instantiated */
 =09=09atomic_inc(&key->user->nikeys);
@@ -621,6 +629,7 @@
 =09=09if (authkey)
 =09=09=09key_invalidate(authkey);
 =09}
+=09up_write(&key->sem);
=20
 =09mutex_unlock(&key_construction_mutex);
=20
--=20
2.56.0

