Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A2C479864;
	Tue, 25 Aug 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667944; cv=none; b=SG0152qO7v0RmjJx9iDJrxs1JcJ6N/4as8x+P5gWzkr14DlNgcBRp8Z0g6KBlpRw8fL3CQG2yYt2Js+ScBkgmAUmTsx8oO3ZNAiBcL8T3VDxOFVYPDeDQ4V3bE0prTLQdkHncMb690h5DNb/gnKm+Rnvpdr7sySNey46YA2EolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667944; c=relaxed/simple;
	bh=yl2s78NHwAU4ziRyyfbQw6cPD13J76Z0zq+i3HACS7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJJLBO8LCMNUb3q2JKq7R0VsjcMjSn8Jmy+Z357JSg8ocq8gf4bveKWOPeV9Gq1VWMMy5sZS38kGLExbxdk0EwMwmMA/NYSBUMVb9rwcjTn0K1mYt1MceQfGJy12fCz0aM6AoOvPDKHvoyVAHeg7lKGLFqG8ti+uKoE90eECMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NZ+PUVqc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NZ+PUVqc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lOIqacCaOO0lRT/8ZLYteHcKSBItPjkI/hZV60Nh55o=; b=NZ+PUVqc+fP+DOGU52XEJNbXrA
	9ML2mYYP64G5KDu3XbYrSe4ms7qeJ+dC8sjRbG5ofVWpMMAtjqBNh1wxnqLxSKCln1d/cxhvBzvab
	r7A9FuvSDns8y4Y8F63sUHUTgj+brW3kJ8pnYSITX2eI5bMyEgoEv/9MBy5B//eJqNUteXzM99o16
	7Ydh4NS1eQRQEhq9shHV20SJoNfILDotZbKJB36tSYhiQQFEtBh3WfZf0neytRUWoa9+0BkGD/2nu
	y1x88ReniviHZacGJg1iQ9emD7hugFrzwcBhDJVxErmSi+/8avmJ1qOsNviuyb9hkf1bsTsuW5aJm
	sq62HM4Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5s-000NAD-1J;
	Tue, 25 Aug 2026 16:25:40 +0200
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
Subject: [PATCH bpf-next v2 11/11] Documentation/bpf: Document the bpf keyring and improve examples
Date: Tue, 25 Aug 2026 16:25:30 +0200
Message-ID: <20260825142530.1329706-12-daniel@iogearbox.net>
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

Key generation is detailled for RSA and ML-DSA, the load example sets
keyring_id to the bpf keyring with the session keyring shown only as
the staging variant, and the LSM admission example anchors on the bpf
keyring while allowlisting staged serials rather than treating a user
keyring as ordinary trust.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/bpf/signing.rst | 279 +++++++++++++++++++++++++++++-----
 1 file changed, 242 insertions(+), 37 deletions(-)

diff --git a/Documentation/bpf/signing.rst b/Documentation/bpf/signing.rst
index e73eaaebd8b1..6c03fb58b146 100644
--- a/Documentation/bpf/signing.rst
+++ b/Documentation/bpf/signing.rst
@@ -254,21 +254,25 @@ returned. Only after the program has fully loaded, at the next hook
 (``security_bpf_prog()``), does ``BPF_SIG_VERIFIED`` carry its full meaning:
 validly signed *and* fully verified.
 
-A more realistic admission policy than "is it signed at all": accept programs
-signed by a system keyring, accept a user-keyring signature only if the
-key/keyring it was verified against is on an explicit allowlist, and emit a
-tamper-evident record of every decision so that even denied attempts are
-auditable. (Illustrative - error checking elided.)
+A more realistic admission policy than "is it signed at all": base trust in
+the bpf keyring, accept a staging signature only while the key/keyring the
+program was verified against is on an explicit allowlist, and emit a tamper-
+evident record of every decision so that even denied attempts are auditable.
+(illustrative - error checking elided.)
 
 .. code-block:: c
 
-    /* Serials of user keys/keyrings we additionally trust. */
+    /*
+     * Serials of caller-supplied keyrings we are willing to stage. Empty
+     * on a system that has committed to the bpf keyring, where the kernel
+     * refuses them anyway.
+     */
     struct {
             __uint(type, BPF_MAP_TYPE_HASH);
             __type(key, __s32);             /* keyring_serial */
             __type(value, __u8);
             __uint(max_entries, 64);
-    } trusted_user_keys SEC(".maps");
+    } staging_keys SEC(".maps");
 
     /* Audit stream consumed by a userspace logger. */
     struct {
@@ -291,11 +295,19 @@ auditable. (Illustrative - error checking elided.)
             if (kernel)
                     return 0;                       /* trust in-kernel loads */
 
-            if (verdict != BPF_SIG_VERIFIED)
+            if (verdict != BPF_SIG_VERIFIED) {
                     ret = -EPERM;                   /* must be validly signed */
-            else if (ktype == BPF_SIG_KEYRING_USER &&
-                     !bpf_map_lookup_elem(&trusted_user_keys, &serial))
-                    ret = -EPERM;                   /* key/keyring not allowlisted */
+            } else switch (ktype) {
+            case BPF_SIG_KEYRING_BUILTIN:
+            case BPF_SIG_KEYRING_BPF:
+                    break;
+            case BPF_SIG_KEYRING_USER:
+                    if (!bpf_map_lookup_elem(&staging_keys, &serial))
+                            ret = -EPERM;
+                    break;
+            default:
+                    ret = -EPERM;                   /* keyring not in policy */
+            }
 
             d = bpf_ringbuf_reserve(&audit, sizeof(*d), 0);
             if (d) {
@@ -309,6 +321,11 @@ auditable. (Illustrative - error checking elided.)
             return ret;
     }
 
+Such a policy is what makes a caller-supplied keyring usable at all on a system
+that does not boot with ``bpf.keyring_unsealed=1``: the allowlist bounds which
+staged keys count, and the LSM itself has to protect them from being tampered
+with.
+
 Observing a verified load: ``security_bpf_prog()``
 --------------------------------------------------
 
@@ -381,8 +398,9 @@ that verdict covered all of its exclusive maps, rejecting any that did not - so
 a deny-by-default admission policy needs no second enforcement point. Use
 ``security_bpf_prog()`` to record or finally gate the verified programs once
 they carry an id. The ``verdict``, ``keyring_type`` and ``keyring_serial`` fields
-let a policy distinguish, for example, "verified and signed by a builtin key"
-from "verified by a user key". A policy LSM such as IPE could consume the same
+let a policy distinguish "verified against the operator's bpf keyring" from
+"verified against a keyring the loader supplied itself", which is the
+distinction that matters most. A policy LSM such as IPE could consume the same
 hooks to enforce system policy without writing any BPF, though none implements
 this today.
 
@@ -390,33 +408,154 @@ Keyrings
 ========
 
 ``keyring_id`` selects the trusted keyring the PKCS#7 signature is verified
-against. The well-known ids ``0`` (builtin), ``VERIFY_USE_SECONDARY_KEYRING``
-and ``VERIFY_USE_PLATFORM_KEYRING`` select the corresponding system keyrings;
-any other value is treated as the serial of a user/session key or keyring.
-The keyring is looked up first, before the signature bytes are examined, so a
-signature naming a non-existent keyring is rejected up front, and a failed
-verification aborts the load - so a program that loads successfully with a
-signature always has consistent keyring fields recorded.
+against. Four values are well-known; anything else is taken as the serial of a
+caller-supplied user or session key or keyring:
+
+.. list-table::
+   :header-rows: 1
+
+   * - ``keyring_id``
+     - Keyring
+   * - ``0``
+     - builtin trusted keyring
+   * - ``VERIFY_USE_SECONDARY_KEYRING`` (``1``)
+     - secondary trusted keyring
+   * - ``VERIFY_USE_PLATFORM_KEYRING`` (``2``)
+     - platform keyring
+   * - ``VERIFY_USE_BPF_KEYRING`` (``3``)
+     - the bpf keyring
+   * - anything else
+     - serial of a caller-supplied user/session key or keyring
+
+The keyring is resolved first, before the signature bytes are examined, so a
+signature naming a keyring that cannot be used is rejected up front, and a
+failed verification aborts the load - a program that loads successfully with
+a signature therefore always has consistent keyring fields recorded.
+
+The bpf keyring
+---------------
+
+A system keyring needs a kernel rebuild or a vouched-for enrollment to rotate a
+key, and grants BPF-signing trust to keys trusted for everything else in the
+kernel too. A caller-supplied keyring, at the other extreme, is filled by the
+very process that loads the program and so carries no trust of its own.
+
+The bpf keyring fills that gap and is the trust anchor which a signed BPF
+deployment should be built on top of: a keyring named ``.bpf``, selected with
+``VERIFY_USE_BPF_KEYRING``, that an operator provisions at boot with a key
+scoped to BPF program loading and nothing else in the kernel's trust hierarchy.
+It is owned by the operator rather than by the loader, and rotatable across a
+reboot without touching the kernel image. It is modelled after the dm-verity
+keyring (see ``dm_verity.keyring_unsealed=``) and provisioned the same way: an
+initrd runs the ``keyctl`` steps below before handing off to the rootfs.
+
+Provisioning
+~~~~~~~~~~~~
+
+The keyring is created during ``late_initcall`` and is **sealed empty** by
+default: it carries a reject-all restriction, so no key can ever be added and
+``VERIFY_USE_BPF_KEYRING`` fails with ``-ENOKEY`` for the whole boot.
+
+``bpf.keyring_unsealed=1`` leaves it unrestricted at init so the initrd can
+provision it. The keyring is not linked into any process keyring, so it is
+addressed by the serial ``/proc/keys`` reports. Steps would be as follows::
+
+    serial=0x$(awk '$8 == "keyring" && $9 == ".bpf:" { print $1 }' /proc/keys)
+
+    keyctl padd asymmetric "" $serial < signing_key.der
+    keyctl restrict_keyring $serial
+
+Both steps are required: the keyring is consulted only once it is **non-empty
+and restricted**. An unrestricted keyring is ignored even when it holds keys,
+so a half-provisioned keyring is inert rather than a weaker trust anchor, and a
+load naming it fails with ``-ENOKEY`` and a verifier log. Restricting cannot
+be undone.
+
+More than one key is enrolled by repeating the ``keyctl padd`` step; the
+restriction is applied once, after the last of them::
+
+    for key in /etc/bpf/keys/*.der; do
+        keyctl padd asymmetric "" $serial < $key
+    done
+
+    keyctl restrict_keyring $serial
+    keyctl show $serial
+
+The restriction bounds what can be added, never what can be taken away. A key
+that is already enrolled can still be unlinked, and the keyring cleared or
+revoked, by anything running as root. That does not weaken the anchor, since
+a keyring left empty is no longer consulted and a load naming it fails with
+``-ENOKEY``, but it does take signed loading out until the next boot. Dropping
+the user permissions the keyring no longer needs would close that; as a third
+step in the initrd::
+
+    keyctl setperm $serial 0x08030000
+
+What remains is ``KEY_POS_SEARCH`` for the in-kernel search during verification,
+plus ``KEY_USR_VIEW`` and ``KEY_USR_READ`` so the keyring stays visible in
+``/proc/keys`` and ``keyctl show``.
+
+Provisioning has to complete before control passes to the rootfs. The keyring
+takes any number of keys for as long as it is unrestricted, so it is the
+restriction that bounds the enrolled set, not the first enrollment. Before
+the initrd hands off control, it must therefore restrict the keyring after
+the last enrollment.
+
+Enforcement
+~~~~~~~~~~~
+
+``bpf.keyring_unsealed=1`` states that the bpf keyring is *the* trust anchor for
+this boot, so it does more than unseal. From the first program load onwards a
+caller-supplied user/session keyring is refused with ``-EPERM`` and a verifier
+log message, whether or not provisioning ever completed. The system keyrings
+stay selectable.
+
+Enforcement is readable at ``/sys/module/bpf/parameters/keyring_unsealed``, and
+read-only there: the flag is ``__ro_after_init`` behind a 0444 parameter. It is
+also derived from the boot flag rather than from the keyring's runtime state,
+so there is no window early in boot during which a caller-supplied keyring is
+still accepted.
+
+Caller-supplied keyrings are for staging
+----------------------------------------
+
+A ``keyring_id`` naming a user or session key or keyring is a *staging*
+mechanism, not a trust anchor: it is filled by the same userspace that loads the
+program, so verifying against it establishes only that the loader signed what it
+loaded. Its purpose is to let software installed onto a running system - whose
+signing key is not enrolled anywhere yet - run signed until that key reaches the
+bpf keyring on the next boot.
+
+A system that has committed to the bpf keyring refuses this path outright (see
+`Enforcement`_). A system that has not can still allow it, but a policy must
+never treat ``BPF_SIG_KEYRING_USER`` as equivalent to the bpf or system
+keyrings; it should allowlist the specific serials it is willing to stage and
+pair that with a BPF LSM policy protecting those keys from tampering, as in
+`Enforcement via LSMs`_.
+
+Recorded fields
+---------------
 
 Two fields are recorded in ``prog->aux->sig`` for an LSM to inspect:
 
 ``keyring_type`` (``enum bpf_sig_keyring``)
     Classified purely from ``keyring_id`` whenever the program is signed:
     ``BPF_SIG_KEYRING_BUILTIN``, ``_SECONDARY``, ``_PLATFORM`` for the system
-    keyrings, or ``_USER`` for a user/session keyring. It is
-    ``BPF_SIG_KEYRING_NONE`` for an unsigned program.
+    keyrings, ``_BPF`` for the bpf keyring, or ``_USER`` for a caller-supplied
+    user/session keyring. It is ``BPF_SIG_KEYRING_NONE`` for an unsigned
+    program.
 
 ``keyring_serial`` (``s32``)
     Set **only** on a successful verification, to the serial of the
-    **user/session key or keyring** that ``keyring_id`` resolved to - the
+    **caller-supplied key or keyring** that ``keyring_id`` resolved to - the
     object the signature was verified against, not the individual asymmetric
     key inside it that matched the signer. Passing
     ``KEY_SPEC_SESSION_KEYRING``, for example, records the session keyring's
-    serial. The system keyrings are trusted as a whole and expose no serial
-    here, so the serial is ``0`` for builtin, secondary and platform
-    signatures, and ``0`` for unsigned programs. In other words, a non-zero
-    ``keyring_serial`` is exactly "verified against the user key/keyring with
-    this serial".
+    serial. The system keyrings and the bpf keyring are trusted as a whole and
+    expose no serial here, so the serial is ``0`` for them, and ``0`` for
+    unsigned programs. A non-zero ``keyring_serial`` is therefore exactly
+    "verified against the caller-supplied key/keyring with this serial", which
+    is exactly the case a policy has to scrutinise.
 
 .. list-table::
    :header-rows: 1
@@ -436,16 +575,49 @@ Two fields are recorded in ``prog->aux->sig`` for an LSM to inspect:
    * - ``VERIFY_USE_PLATFORM_KEYRING``
      - ``BPF_SIG_KEYRING_PLATFORM``
      - ``0``
-   * - other (a user/session key serial)
+   * - ``VERIFY_USE_BPF_KEYRING``
+     - ``BPF_SIG_KEYRING_BPF``
+     - ``0``
+   * - other (a caller-supplied key serial)
      - ``BPF_SIG_KEYRING_USER``
      - serial of the resolved key/keyring
 
-Producing a signed object
-==========================
+Producing and loading a signed object
+=====================================
+
+Generating a signing key
+------------------------
+
+Signing is algorithm agnostic: the algorithm comes from the X.509 certificate
+and the PKCS#7 ``SignerInfo``. Anything the X.509 and PKCS#7 parsers understand
+works with no BPF-side change. Both examples below read the certificate request
+config from ``x509.genkey``, for which ``certs/x509.genkey`` serves as a
+template (see Documentation/admin-guide/module-signing.rst). RSA::
+
+    openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
+            -config x509.genkey -outform PEM \
+            -out signing_key.pem -keyout signing_key.pem
+    openssl x509 -in signing_key.pem -outform der -out signing_key.der
+
+ML-DSA-87 (FIPS-204), which needs openssl 3.5 or later and ``CONFIG_CRYPTO_MLDSA``
+in the kernel. Note the absence of a digest option: ML-DSA hashes the message
+itself and openssl rejects an explicit digest for it::
+
+    openssl req -new -nodes -utf8 -days 36500 -batch -x509 \
+            -newkey ML-DSA-87 -config x509.genkey -outform PEM \
+            -out signing_key.pem -keyout signing_key.pem
+    openssl x509 -in signing_key.pem -outform der -out signing_key.der
+
+``bpftool`` handles the following internally: openssl before 4.0 cannot combine
+ML-DSA with ``CMS_NOATTR``, so it falls back to signedAttrs, where only SHA-512
+is permitted. This mirrors what module signing does as well.
+
+Signing
+-------
 
 ``bpftool`` generates and signs a light skeleton in one step::
 
-    bpftool gen skeleton -L -S -k <private_key.pem> -i <certificate.x509> \
+    bpftool gen skeleton -L -S -k signing_key.pem -i signing_key.der \
             obj.bpf.o > obj.lskel.h
 
 ``-L`` selects the light-skeleton (``gen_loader``) backend and ``-S`` enables
@@ -454,12 +626,36 @@ signing; ``-k`` and ``-i`` supply the signing key and its X.509 certificate.
 reconstructs - and also computes ``excl_prog_hash`` as the digest of the loader
 instructions so the metadata map can be bound to the loader. The signature and
 hash are embedded in the generated header; the certificate is used only for
-signing and is not included. Loading the skeleton performs the
-create/populate/freeze/load sequence described above.
+signing and is not included.
+
+Loading
+-------
+
+The generated skeleton exposes ``keyring_id``, which selects the keyring the
+kernel verifies against. Set it between open and load; loading then performs
+the create/populate/freeze/load sequence described above::
 
-At runtime the trusted public key must be present in the chosen keyring (for
-example added to the session keyring, or built into the kernel's builtin trusted
-keyring) for verification to succeed.
+    struct obj *skel = obj__open();
+
+    skel->keyring_id = 3;           /* VERIFY_USE_BPF_KEYRING */
+    err = obj__load(skel);
+
+For the staging case the same object is loaded against a keyring the caller
+populated itself, which only works on a system that has not set
+``bpf.keyring_unsealed=1``::
+
+    /*
+     * Staging only: this keyring is under the loader's own control and
+     * carries no trust of its own. See "Caller-supplied keyrings are for
+     * staging".
+     */
+    key_id = add_key("asymmetric", "", der, der_sz, KEY_SPEC_SESSION_KEYRING);
+    skel->keyring_id = KEY_SPEC_SESSION_KEYRING;
+    err = obj__load(skel);
+
+Either way the trusted public key must already be in the chosen keyring for
+verification to succeed. For the bpf keyring that enrollment happens once at
+boot, see `Provisioning`_.
 
 UAPI reference
 ==============
@@ -487,6 +683,13 @@ UAPI reference
     The map content is not hashed separately at all - it is covered, as bytes,
     by the program signature.
 
+Kernel command line:
+
+``bpf.keyring_unsealed=``
+    Set to ``1`` to leave the bpf keyring unsealed for provisioning, and to make
+    it the only non-system keyring a loader may select for the rest of the boot
+    (see `The bpf keyring`_).
+
 Notes and limitations
 ======================
 
@@ -495,3 +698,5 @@ Notes and limitations
   exceed it.
 - The metadata container is a single-element array map, accessed through
   ``map_direct_value_addr``.
+- The bpf keyring needs ``CONFIG_KEYS``; without it there is no bpf keyring
+  and ``VERIFY_USE_BPF_KEYRING`` never resolves.
-- 
2.43.0

