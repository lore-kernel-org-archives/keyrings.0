Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77878346A10
	for <keyrings@vger.kernel.org>; Sat, 19 Sep 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857281; cv=none; b=mHEnHDxVKdLRAMmDPZS2pLyCfyKUxiYDeI4FNUFYtk6mMJzQ9X8Da3jxmXDGnQuDjrYbFdv0JEOD3SQivgcENpjMRIDegtHUeizZXlhI6Jy7+716T/VQ/6icHpOwQsCat1hFx6xeX9hGT4Ua2JfWuWg1Ucz5qmSWi5KpmGGzuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857281; c=relaxed/simple;
	bh=NoYLQ/BarOSRXyrwHUkedHUpGCwMk3EDs6vhrDTQqbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tslgaGfQ98DqzuZxbNkdcPKIP9owKhpfAoZiMzaA6OR/Cfzf0fYqitWCfXgjKRV5DHM72QoZnLhY7JnqkIG5QoqCQ5Im1/4xrMHbEtvYQf2rNMQNkWaW+7buVjCZY7LrczkNN2mfmk5yUHEdP/5dFDlyNe0iG2f29cPOi8ZvkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eppMT/VO; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eppMT/VO"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34908so1772229b3a.0
        for <keyrings@vger.kernel.org>; Sat, 19 Sep 2026 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857280; x=1790462080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjNrC87GI6r/hyASC6W4vHpCo4NDAOckP9GbczGyTro=;
        b=eppMT/VOKo+W8aU07XFPg+4/Yle1FNoJ7ea2FoWVslBUdRo3g8Cy8fbImqFP9KfDin
         2OXQ8HnPwp4V4UhrioLDm2Uz7bprb0MOk05bf+KWMCvjcdZ1x/bV3GPs0N3rhU44gF5E
         K6tAfyv3xz5yJOyg7ihUag8Od7BrEmXoxsSmuqj7mRoShGms5JDAfiFnI67YfXA/SOhT
         +wy7MHta+u7GGMRBuTeheqS0Ib8UufECdM/XaQd1rvjI/tnVy+3JItCKhUh9DuACkfIa
         4Vk0wG0Wg9EsxLbhn3CD3ucq3APqNa11oE9+nugwZ9ECg94J9lcVRfp1l/PSpLDw3HTJ
         QznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857280; x=1790462080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjNrC87GI6r/hyASC6W4vHpCo4NDAOckP9GbczGyTro=;
        b=x7YkjbYeThDsjiG+lMj3CJKpRQ5Nwda+niOC9++gI+FQBVR2fO7Sh4tLXgxn+c43Fv
         IHprTl8ynP5utJ3UtjyhoE8hoTH4YuHbbruaEGOTUVrjQbSEU8jggaGb74tz+fMvPwit
         b+ZVF03Okvdr0jzlEpT4SK0YZGLc+80ORq4TT5EKdr5/3XS1/6L8Abkadurqd1DkYKTi
         ITukaQSyxDwUIhC67Cj8Mk8VM4QLCp1AB3wcDwGkVi7HFakBSEODpkima1DwtCDNffyq
         /a2aZiQg0Va8v5GJwLH9mxfT19Ihd1WBfQy+HvPUf5aDNPimnW80V0Flk2c/O3PfI4J7
         Kq6w==
X-Gm-Message-State: AFuF++moVdh7rXZQPIpguB++nD83fC9ijwiB7oUhCOOeg6LLY3b2+aia
	DG7K/qxJw0mXMUEkLeblbfkEPRsaQqoYhff+6nZeC2Q11Fz/ZiqSjCID
X-Gm-Gg: AYBFou3pUf5x675UyCA6GZV/bDjiF7wse/7KSesSEVDqrZYEnjHdBYO+x9bUsMx+Att
	zu+qjeJdpR6XjmvffORucCiHsrY/ngOAOpMtk3h6U6L2/VohJywfQoV9KTlFMbiLBkr9edhYdQY
	rjSZFoxmox+AIgNzST0y4dOo3MxmlgN6pWs3NRmVm3JM76hiJANwo9AnBLDe5Rfbfy2VEMTXxoY
	mwPTYBBOQdic11r7vwUkACpkwxSk426Gb2NFxjYQEdwmC2lbhHTVTad0o+VM4RGoe+N0r22Sz1M
	3on7bPK1YGfQpyGLjXwstNf7gwF02fotvBcJykmJL9M54tP4/GgF+kIYq+MNI3G+BnlgYUnRA8g
	V5M2kjleZg5I97mWPUjCOG1n7PincQwGqzex2R7YMiE1b2K2VMEStqo/AAwx5XncqyoH4oy0xOD
	T1Hwxm+eyaN3EAXfQ/HfJ1b5eUbLDBY0qOkPm+ZUkTEPwEzl3Ivcw30rJGJ9tZxUu2TVZ9Aycg5
	qNsmpyC5PCVGGbjmn25rHaaUjlc7epdAb5zCinkDKo7Z6d2iZQbXBVT48K3VDzbVpG0HpkWdmlH
	XrcjcPwzIA==
X-Received: by 2002:a05:6a00:b49:b0:871:b1b0:e495 with SMTP id d2e1a72fcca58-874dc4f31aemr10100311b3a.15.1789857279724;
        Sat, 19 Sep 2026 15:34:39 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe533sm1391208b3a.10.2026.09.19.15.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:39 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: paul@paul-moore.com,
	dhowells@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI removal and check AKID len
Date: Sat, 19 Sep 2026 22:34:38 +0000
Message-ID: <20260919223438.3883567-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in netlabel CALIPSO and X.509 key parsing:

1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
   inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
   mappings referencing a removed CALIPSO DOI are removed.
2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
   length signature/AKID fields before key matching.

Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink protocol.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 25cf8ac7f257..5c9165a83f91 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	if (sig->algo_takes_data) {
 		/* The signature algorithm does whatever passes for hashing. */
-		sig->m = (u8 *)cert->tbs;
+		sig->m = kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL);
+		if (!sig->m)
+			return -ENOMEM;
 		sig->m_size = cert->tbs_size;
-		sig->m_free = false;
+		sig->m_free = true;
 		goto out;
 	}
 
diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calipso.c
index e1efd888b4a2..3756193b1c49 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -283,10 +283,21 @@ static int netlbl_calipso_listall(struct sk_buff *skb,
 static int netlbl_calipso_remove_cb(struct netlbl_dom_map *entry, void *arg)
 {
 	struct netlbl_domhsh_walk_arg *cb_arg = arg;
+	struct netlbl_af6list *iter6;
+	struct netlbl_domaddr6_map *map6;
 
 	if (entry->def.type == NETLBL_NLTYPE_CALIPSO &&
 	    entry->def.calipso->doi == cb_arg->doi)
 		return netlbl_domhsh_remove_entry(entry, cb_arg->audit_info);
+	else if (entry->def.type == NETLBL_NLTYPE_ADDRSELECT) {
+		netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->list6) {
+			map6 = netlbl_domhsh_addr6_entry(iter6);
+			if (map6->def.type == NETLBL_NLTYPE_CALIPSO &&
+			    map6->def.calipso->doi == cb_arg->doi)
+				return netlbl_domhsh_remove_entry(entry,
+								  cb_arg->audit_info);
+		}
+	}
 
 	return 0;
 }
