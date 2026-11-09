Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202770;
	b=vcRBEgxa6jYMaST3KSs1imYb6gkTLWRFNy9euT781c0ERaOvj1WI0P7+GYr8oFQGasuj
	 J4bvqSREE6cGhW4/qsih9dnzZidHFhLC73OtHc+H/6fS9RT53t6r7K6I77ohuLuzny0ya
	 OhaDbuhdzpWTaO3mhBjheg1tos64Ej3+r4wLFyem46CSXysRKt/9oslYkgWy3kNVxj4EP
	 PD8N1ovJVc2dcEGOxle44Q/Anze5oMOnzayq2c35BRy9xIzZqAA2TBo+7z1hOr5uAbu3U
	 sg2q0H5ReUVuKLf3ylS+f0wuJtJIIUYk2wDU0xBLBEN6z+lPgWvMHGVbXOC1feKMseQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Mailer;
	bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
	b=CrGIKD2aBZD9kRzt16mXs1/hYurywv8ALuPEXAPbBN4+M03zC9KRZ+ylFsmc1wrHSxP3
	 aaS5v/LqJSUjqHrAulU7Pottsj+x038A88fh2npIB9Cn3CtHRXDb4ZgfL4vuMVaJxBwq3
	 /VyuY1mMe/+ZD+L15uwn1z41LK+RpD390QqUXb+hUI7V3+v0nrBrNtk+J2dmc+bUN9XfD
	 hGJh+kvW1g8RY5YKGFLHcyjSkE8e7fLn+/KQOHGGfHsufByGPLgMBFo2rFocxwyZjk/vn
	 /1DTZd2wx+DLowbg9DR5yxVQ9CGLmLurN5ikk1zUu/l9XWs+hRlWpRAM8uaC3/lzjfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/c396Cw";
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF1606A322
	for <keyrings@vger.kernel.org>; Mon,  9 Nov 2026 05:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDF1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/c396Cw
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso273044f8f.1
        for <keyrings@vger.kernel.org>; Sun, 08 Nov 2026 21:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202769; x=1794807569; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
        b=m/c396CwshKMa2EHH+DQktTUWKdT+G4FYhJZRO1ZyIRIhcH4JLYWrzEMYp+ItdlBIA
         TfrpaAz5zE0hxf52AhEiwplZI2VXfKYLCOe+FYHpU03rM56D8UVCIbC4EkcKucUXujME
         UqLm9dyYq2Pd28HnP+Gy67SC8ArUdRCZcomkUowXHVNoiFIICmBTIVdlsiscdGA64vyO
         RBLD8ILK91ZHqy91P5VTxFDBpvH+IqxaQ1CA0lQRBHmprYuUvpkUhVStr1VvYNw7G1dZ
         nYRFBFec5K4S/6FdpKhkVPUYrgzt6s8D/Fsckxa/yVxaOe5ssdJEt9lk6iqQknhDSoKJ
         IOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202769; x=1794807569;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4uU3D93eNb0dcAsvNYKSr00RkTcidb/i2o2hNB/WLWc=;
        b=Cdx+Bl6JZeAUCP3k8FXug+NRNuHat+HbzxLIVi59UHugqHy/XZFdogda5rEVYyQZ71
         /Z2o2RzXqQV+SJyDHimcB6w4lvvLy+kw+9i8AqgdliYGSBkZeeunTAZzM5iVe6qU3hG+
         ZJkZnI7/vhu0x7CoBwrsyisHHRiO9qW8DTRQUbqPYIOHGd0gJWuULU1Q49e6TdBtpAfn
         Q+KLpfVJwHg0xZDIa7Dxq6t9FzQRW5qWxPWWpXdATU5pSrW4eZwj9y8R25UWgJ7nmcn0
         RDuviUAGS5SnBYFeUFhszZLm4otttJwZ8O2SRbzGr6TX/0LvxyL5EykYQpYMvo0TgpMy
         XzqA==
X-Forwarded-Encrypted: i=1; AL+hErEwzVXQpE/PvD7mv7YuSXknRIE9wYLgV4YC04/kiXjFwxrN+nw/PnaT7G2D+fRB/iPfgNaGTa69Gg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+DMXAAIFF8M9SakT12auWVXtUJz8S+n7zw3zgvPms4yMhf8syo
	Xw2sMlC/aBJ7YaXOzhhsTGBPKKf6920rrrKObxxXvk7+2ZVCe7w8DsLG
X-Gm-Gg: AYBFou2ejrVvQDcqqAgpq5c6FdHcExeHTJ54Fdt2oC1Sy5bpqBsKo7N2ZHxfTpKcBDC
	j/XZciQTvcx3IV00sYFwEjdbJAKsgYu5H5OWbMtMr6oQxFIXu3/MTjyiAwp/SE/oi41RohUB8Ie
	2sJKSIlrMkjgOwZYhu5QrL6NX0aj3/LvgFekGIYW4u4qFRZfW0ewmUGOV0Y66oJFvD1sc2ZAGHZ
	XzxMpy2a67UuQIe4JnK3cBia0G9dyP1Rg/OcI06Q+UnhJ+JkQOeVEOWTQje1+DIDjkBapqNjkZC
	tQbN+YLkKDSP3/3UGpH7c0mpFBcyb52FN0vAknZN9ogbTldw3okqLHZBhOhCPqDdoWgtHs+S3eF
	6EtaEC6f9R3RReUXqYvee3JeY9QJJ6VcoE5uaiQTiIl2sqPAEdsOdsaByyUPdpTi8ZXQYJYvEsi
	4pHQjmMR5lRIgqaKR+2fNda5ujLoCp9NCqv5YC067r/KjXKRCcge2CcOBo3hdmzXU1dbxc96RBI
	Ku8p7XmHmQEXUDK7hRAu2ioxC9wyVZ0Z9RM+X4IySqDnJIPyt3alen1dGKtGK/wHrxP41LujX6c
	3PGRi6sImQts/0RdN5t3fQMoV6AMKLj7JOlNZ4NZnMNhhZaB/YFBjnxig/x3BMokR7NkB3QOaUf
	X58LM0PlIPkL1vvT8R12lURvvNWDMVb30Js9vuEa6I3WH8n/RcCi07AeRUBwa1lwltw==
X-Received: by 2002:a05:6000:250a:b0:48e:d40:a87c with SMTP id ffacd0b85a97d-49423997d63mr12864728f8f.16.1794202768807;
        Sun, 08 Nov 2026 21:39:28 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4967a70a35dsm4750189f8f.9.2026.11.08.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:39:27 -0800 (PST)
Date: Mon, 9 Nov 2026 08:39:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] keys/trusted/tpm2: rename "bool" to "boolean"
Message-ID: <avFcjHwnh9mrOEnz@stanley.mountain>
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
X-Mailer: git-send-email haha only kidding

In C23, "bool" is a keyword so rename this array from bool[] to boolean[]
to avoid a conflict.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 30188a0ec676..2d6cc53539c8 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -59,13 +59,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			       asn1_oid_len(tpm2key_oid));
 
 	if (private->blobauth_len == 0) {
-		unsigned char bool[3], *w = bool;
+		unsigned char boolean[3], *w = boolean;
 		/* tag 0 is emptyAuth */
-		w = asn1_encode_boolean(w, w + sizeof(bool), true);
+		w = asn1_encode_boolean(w, w + sizeof(boolean), true);
 		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
 			return PTR_ERR(w);
 
-		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
+		work = asn1_encode_tag(work, end_work, 0, boolean, w - boolean);
 	}
 
 	/*
-- 
2.53.0

