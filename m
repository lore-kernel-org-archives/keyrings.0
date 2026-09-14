Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A44779A4
	for <keyrings@vger.kernel.org>; Mon, 14 Sep 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404125; cv=none; b=a7ACYfM8a7OfKYJYCrWEfRTAhHkeDzhKSymyEhNQ3/v/uWc0WNqX7XATJKDqhxIT2q+gHRDJy4uYW3oVKjBz4x5RGe2wutBzo/wFZge2DVCw+LUmumGzGuBS2a9aQBS/3bGfxGR25cgj6iN2vyRwOYKT36swmoyggZXEwVjUAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404125; c=relaxed/simple;
	bh=+N9ZKaZxeybEwISedHcLFR5weaHCuqwm361zoPMxU4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LxjApIEyCnw00p0REfBGgBDQIyfsoNo52Jq3jmzeDuKK5RktL4QvnncSNKOaWb7uLzJU3q5U6VT8G/q1g7iHmz5Asvr+MIwm18P6T3h3uQhwh0QtRQUDyVd83NyKoqqaBt8KrMb677Qf+kOB0lTPHZQGKJsVaL2rgHue98egXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=WO9bU0iX; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="WO9bU0iX"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-671061b015eso3652317d50.1
        for <keyrings@vger.kernel.org>; Mon, 14 Sep 2026 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1789404122; x=1790008922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfEDwKZx2Ac2Zov3iFEW2DHPNztOR7nlXE153PDtqAw=;
        b=WO9bU0iXJcOVnCevtYrA5YksA5xFDXQ33CN3bwdR5wFYR3c398KJiptiBuY0ULyzCZ
         VcErnYSK+FGhwrruzXoMb0SG9cgAyv/JZ+AmjramI9rYv34AzMHMrnuv0O68jz9Lyh2C
         e1bFg3Nb90skmXYQx4dX4+/t/ztlH7j17ezNUkxeudEi8jDYQtyt2dCGTMKRB5XXZnCS
         ACByqlzdtrGsqbKRKHfpsegxqgyiBWyLNJFnijxj+BVjbMjeUlr9+Az/eGYT8nmKYeEw
         vzQFjZSxzdnugfHpf3NRdR2TWpLDE7hf1OgpeJu9rqYc+HG9JqXYqvsLYmB00TC2Rmpq
         EICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789404122; x=1790008922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfEDwKZx2Ac2Zov3iFEW2DHPNztOR7nlXE153PDtqAw=;
        b=QE0DPOkO+mCNLGlWTzPxiLbliuSRO4gCOaj6m1cReYrC8d5tChwfnHyoCq831fsNRp
         jmKswYKF8U/EEMMAGN3q8cy6xzdj7FbCRABoY+rHquY83j6QcKMm6ZFKM2iP0bCI02iZ
         wGBWTrBrcPR3lq7bzrnOHD7IMG1Iifzf0AQnuhTRFYfX9MbJQpmyHoG3xzlZWqkhRrmV
         DEWHetZylropbjIKonTs36K6zOoa6CQRVH1PWrJb64NxwbFMrOSg/rG7dth/97biSat2
         XNm3E2JH7cnaAXf3npcNmC2mYubxZwCyFZj44gg6iFHkuvQpcct8rLRuHYJlphuSl2Iq
         9Ofw==
X-Forwarded-Encrypted: i=1; AKwUvByGZILA6F39oh9SN7GlKgIW6kYJxPO4ZI2TRDB5D8EMm+///TC/enlAEFF5YIj74ufbAoARVL0SRQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nIG+CGNRsvuXV1Iud2PQC2IcLnH4Llz7gwqshVxJ6H7XfA34kA
	j+6qC1Wwr66/t428Ab0WntX6wDDOnozlasUQu+ATV9xN1rPZGirYaOlRxcAUyqBV+yAX
X-Gm-Gg: AYBFou2Lq/hBnNdOmUslJT8mLPro84ZtvNVYwhVAFmD5nVxeopXUBLIDAZSsPpkfK/5
	MSqZpDXgsleZ/WW86yrzFctYo9Bf94Q1BTv25L4feyNU4Mz2c8pfqlr9Hm4rvHiJkFEGFxlQLpV
	4gUzNuuFgq5e0smwvobtvbvrTVg0KM8MaBvPiNGySZencqgxOFtHE5j+f7M1wEI6IusVOWb4w2I
	V5669PyE+nMV8IZIQ9FwY6N59bDws/BzckIqExXO0PRJo4eVHS6ysYokr+2CLRoAQio4hiTF9db
	J0G9EaU1YGn6FD82yg6IyhQg3Et1NiKh/5X54naslSXTGDJwEiNnCEfoBJ3YS0+t1Zzf8ChMlxa
	Fg22QDMlcNIyFWn3xkuAsbieRndJ3iM1Zr31lgChMWszjOZsvHFP+U8rhhSvv7NB6WruvsNMnHf
	1ZfvOpn0HyCgw9wn/ZXM/7XknVG7a3F0KgJFDh4EolPTDtHSjslx45vn1ryDiOaQ==
X-Received: by 2002:a53:ac83:0:b0:66f:c1bc:c097 with SMTP id 956f58d0204a3-6714e1a194cmr1022205d50.95.1789404121718;
        Mon, 14 Sep 2026 09:42:01 -0700 (PDT)
Received: from [192.168.1.110] ([2600:1700:1ff0:d0ef::d15])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125df42a8sm4879023d50.8.2026.09.14.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:42:01 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 14 Sep 2026 11:41:42 -0500
Subject: [PATCH 1/3] keys: add KEY_SPEC_DM_VERITY_KEYRING
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ajhalaney-dmverity-key-identifier-v1-1-01922dc1366a@amutable.com>
References: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
In-Reply-To: <20260914-ajhalaney-dmverity-key-identifier-v1-0-01922dc1366a@amutable.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, fsverity@lists.linux.dev, linux-doc@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.14.3

The .dm-verity keyring is not linked into any process keyring, so
request_key() and KEYCTL_SEARCH cannot find it. Userspace has to scrape
/proc/keys for the serial to use.

That's not great, one could put in a bogus description containing
a newline to confuse userspace further. For example, thanks to AI
models, which I run as root but you could show off as any old user:

    # DESC=$'.dm-verity: 1\n0badf00d I--Q---     1 perm 082f0000     0     0 keyring   .dm-verity'
    # k=$(echo -n "1234567" | keyctl padd user "$DESC" @s)
    # keyctl setperm "$k" 0x3f010001

    # cat /proc/keys | grep dm-verity
    10402023 I------     2 perm 082f0000     0     0 keyring   .dm-verity: empty
    12e0bee6 I--Q---     1 perm 3f010001     0     0 user      .dm-verity: 1
    0badf00d I--Q---     1 perm 082f0000     0     0 keyring   .dm-verity: 7

0x0badf00d is not a keyring, it is the text inside our user's key
description. Telling the two apart needs a KEYCTL_DESCRIBE per row
which is annoying to do. i.e.:

    # keyctl rdescribe 0x10402023
    keyring;0;0;082f0000;.dm-verity
    # keyctl rdescribe 0x0badf00d
    keyctl_describe: Required key not available

Let's just give it a well known identifier, i.e.:

    # keyctl rdescribe -10
    keyring;0;0;082f0000;.dm-verity

This is exactly what
commit 264d8fd2794f ("bpf, keys: Add a bpf keyring for program signature validation")
did, and was the inspiration for this commit minus the spinlock bits
required due to dm-verity being a module.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 drivers/md/dm-verity-verify-sig.c |  3 +++
 include/linux/key.h               |  1 +
 include/uapi/linux/keyctl.h       |  1 +
 security/keys/process_keys.c      | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
index b2b55c41e2cb..da509dcdd7e5 100644
--- a/drivers/md/dm-verity-verify-sig.c
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -189,11 +189,14 @@ int __init dm_verity_verify_sig_init(void)
 	    keyring_restrict(make_key_ref(dm_verity_keyring, true), NULL, NULL))
 		panic("dm-verity can't seal keyring\n");
 
+	key_register_dm_verity_keyring(dm_verity_keyring);
+
 	return 0;
 }
 
 void dm_verity_verify_sig_exit(void)
 {
+	key_register_dm_verity_keyring(NULL);
 	key_revoke(dm_verity_keyring);
 	key_put(dm_verity_keyring);
 }
diff --git a/include/linux/key.h b/include/linux/key.h
index bd10fe45819d..ae8d3314fd93 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -441,6 +441,7 @@ extern int keyring_restrict(key_ref_t keyring, const char *type,
 			    const char *restriction);
 
 extern void key_register_bpf_keyring(struct key *keyring);
+extern void key_register_dm_verity_keyring(struct key *keyring);
 
 extern struct key *key_lookup(key_serial_t id);
 
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index fa85b9760391..75923941f1b3 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -25,6 +25,7 @@
 #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key auth key */
 #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest keyring */
 #define KEY_SPEC_BPF_KEYRING		-9	/* - key ID for the BPF-specific keyring */
+#define KEY_SPEC_DM_VERITY_KEYRING	-10	/* - key ID for the .dm-verity keyring */
 
 /* request-key default keyrings */
 #define KEY_REQKEY_DEFL_NO_CHANGE		-1
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 44358388e395..dba3df41638b 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -25,6 +25,10 @@ static DEFINE_MUTEX(key_session_mutex);
 /* BPF keyring reachable through KEY_SPEC_BPF_KEYRING */
 static struct key *bpf_keyring __ro_after_init;
 
+/* dm-verity keyring reachable through KEY_SPEC_DM_VERITY_KEYRING */
+static struct key *dm_verity_keyring;
+static DEFINE_SPINLOCK(dm_verity_keyring_lock);
+
 /* The root user's tracking struct */
 struct key_user root_key_user = {
 	.usage		= REFCOUNT_INIT(3),
@@ -607,6 +611,24 @@ void key_register_bpf_keyring(struct key *keyring)
 	bpf_keyring = keyring;
 }
 
+/**
+ * key_register_dm_verity_keyring - Publish the keyring for KEY_SPEC_DM_VERITY_KEYRING
+ * @keyring: The keyring to publish, or NULL to withdraw it
+ *
+ * Make @keyring reachable by userspace through the KEY_SPEC_DM_VERITY_KEYRING
+ * special key ID, so that provisioning it does not require scraping its
+ * serial out of /proc/keys first. dm-verity can be unloaded as a module
+ * and the keyring deregistered, as such serialize access with
+ * dm_verity_keyring_lock.
+ */
+void key_register_dm_verity_keyring(struct key *keyring)
+{
+	spin_lock(&dm_verity_keyring_lock);
+	dm_verity_keyring = keyring;
+	spin_unlock(&dm_verity_keyring_lock);
+}
+EXPORT_SYMBOL_GPL(key_register_dm_verity_keyring);
+
 /*
  * Look up a key ID given us by userspace with a given permissions mask to get
  * the key it refers to.
@@ -766,6 +788,17 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		key_ref = make_key_ref(key, 0);
 		break;
 
+	case KEY_SPEC_DM_VERITY_KEYRING:
+		spin_lock(&dm_verity_keyring_lock);
+		key = dm_verity_keyring;
+		if (key)
+			__key_get(key);
+		spin_unlock(&dm_verity_keyring_lock);
+		if (!key)
+			goto error;
+		key_ref = make_key_ref(key, 0);
+		break;
+
 	default:
 		key_ref = ERR_PTR(-EINVAL);
 		if (id < 1)

-- 
2.55.0

