Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561229;
	b=rIWtdLLBEJrX9ZrTlJSJP8uudQXK8mZdxxOPE8sVXdrDY4DJHYz38IEe9BjngwDnWnwu
	 pt+/EiPCJdivramMeOFI7P8Pb4VoTm9eOWu+BpEa6qBwM/Mxg/afdXulWgUzKGxmld0Ls
	 YGgtiFlXvZqp7rtO6mrH5EOLN/o6+xzT0g/ff/P0fqSQTsbQuN8LN/1UYPRis5G8zZOvt
	 DkstKdTFpakba37oYTiYtCdzR571Os1WQM/GngzmEmZ7Yr1w3aUuF49WHFCobDTbnsLhU
	 y9+R5eljynbPIBpl15gTEdI9GxsKGXFAyKdivE8ZpKwqYh0psI5Yghc9Jl9LwDUBAyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561229;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ep6SCRIYIbStpixZ7wEhVusC48UyfLD4TrkTg3oZ188=;
	b=b+egdj5qrzW3Deo1062X9pMAom93tVrtuC7JpqtQLTJE6nq1PGdfv3OXhiYRMSxkDDpX
	 mDz7nj0TSnfr6ZyfBSSxNMPn9AzQWBzFk4EdRG4FGclkAGtOu/CqXCLXLjrtsUY/kx3WA
	 sgz4+YGPBy9a9QLUJ/BDZ3Z+tqvd/PWjzTzq4Ka7Pp0V3DecpSXurwj3yFX/gfSs3wI6d
	 cxoMMq0MdDcyYwq9EppF/A46JSda/N0LVOlHXX4NcATr8+Nl/BD4Mj2QcK+mhyGPq8GUa
	 Jt7sE0Od7LP168mUqTkJ2dabGfOQGcqi2cLMuOgjvVTL4f5EcJVitHubsmburc1vMMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB3606A326;
	Tue, 24 Nov 2026 23:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BAB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d1b9f50ce85a11f19a56ed5b684f684d-20261125
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:eec460be-8fac-41b1-9066-05b27503b274,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:eec460be-8fac-41b1-9066-05b27503b274,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:25b574335cd683da1331a8fc84426721,BulkI
	D:261125014500UWOFTBKL,BulkQuantity:1,SF:17|19|64|66|78|80|81|82|83|101|10
	2|127|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0
	,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d1b9f50ce85a11f19a56ed5b684f684d-20261125
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 456235794; Wed, 25 Nov 2026 07:00:18 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] KEYS: Prevent key type removal during key_instantiate_and_link()
Date: Tue, 24 Nov 2026 18:00:16 -0500
Message-ID: <20261124230016.1211738-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124174035.1614480-1-jarkko@kernel.org>
References: <20261124174035.1614480-1-jarkko@kernel.org>
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

On Tue, 24 Nov 2026 19:40:35 +0200, Jarkko Sakkinen wrote:
> @@ -610,11 +628,12 @@ int key_reject_and_link(struct key *key,
>  		}
>  	}
>
> -	mutex_lock(&key_construction_mutex);
>  	down_write_nested(&key->sem, 2);
>
>  	/* can't instantiate twice */
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
> +		mutex_lock(&key_construction_mutex);

Here __key_link_begin() still runs before key->sem is taken and there is
no KEY_FLAG_DEAD check, so the link path is still taken: on 7.4-rc3 with
KASAN and PROVE_LOCKING, KEYCTL_REJECT with a target keyring on a dead
key returns 0 instead of -EKEYREVOKED. If pass 3 retypes the key before
key->sem is taken, __key_link() inserts it with an edit built from the
old type.

Taking key->sem before __key_link_begin() and skipping the link with
link_ret = -EKEYREVOKED when KEY_FLAG_DEAD is set avoids that, and still
lets the negative instantiation finish so request_key() waiters wake up.

In key_instantiate_and_link():
> +	down_write_nested(&key->sem, 2);
> +
> +	if (test_bit(KEY_FLAG_DEAD, &key->flags)) {
> +		ret = -EKEYREVOKED;
> +		goto out_unlock;
> +	}

After a modular type is unloaded, key->sem still carries the module's
lock_class_key, which lockdep_free_key_range() dropped. In the post-rmmod
instantiate test up_write() here warns "trying to release lock
(&type->lock_class) ... no more locks to release". Module pinning would
remove this; it still matters for stable backports.

The 200-round instantiate/reject race and encrypted-key instantiation
pass.

Thanks,
Guicai
