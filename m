Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592814;
	b=yH5j+v9BAvj8Ghw31DjhuLK/A5rz6HL8SDwxlPIfHyQKQ1oJm8JO9W1gC7RJEl689qGG
	 laEVuv69juHnuMlW/DXxcmFH86tzdYmlR0phwoi9fQf2st8rwiZ1ADc5T4BVYVebxj/FA
	 bGEuqJkmboNumAy27nuapBozVkWVaI1l14zqy/x6mIJTkaQ8PAnrbykkWJYsmbjzHp8kj
	 zvuzhQLRKMFQvLM8Mq4f1OGEAUGTP+5ioM7gis3jt/YUSrR9CgH07Fw5fjlVdBbgoT1Nk
	 YtxqfrTvP1wcd2LDzm7+ChDnveWCwUe53dClv5gLboaoKfJqBHf17Oa/roXGVE4PHXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
	b=SA6tpWOxifVRHzBvAjrwrfKWwu/LEbsiClk5P+J1217bShgv2BFQIuqvxf1kLN58NYh0
	 WK2V6Oh2/IQdmFCxhieKt1/JmOfxoBmDY2JMcap4xIUAtqjuCnYBllVrkOwzGpSSobF56
	 QE2lZdCeomobMVBDALScWa3o0f0JoxF8sdsYk4689QMgbcXkrBKuZmBsO0MBhFNYsQ0/l
	 iM2og9CmQXz8597EZD1mohReu5BVCGL6ByQZwwsmF8tvD1KaNTTc8sAo2g3dq0dmf/aty
	 lvHHH0Yj8lmiu9hGRiTdkPJGLhp/AhfyxttM2dZnf6WZKOQdjyEA+vukF/9g2NNpGog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B5606A329
	for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E3B5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4550d8ab15so89885066b.2
        for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592812; cv=none;
        d=google.com; s=arc-20260327;
        b=jA4PGfyxgA8j5o2M2sQjI43ALo96qfvVZjoFTHxFJe1EQuJDx3CtlCXKw+fJPiDiT3
         PNYHgkV9MGp2kbbq3tLXN8ASYgRFPz/PYtA9cTSXWWzheE1zfmQ1qcS/undaMniXX7p6
         Ced/CjW1daXFvRuKYMuAymxUayJAfioN9HEn6QhPMqqFygsxeKB+NCP/8m+LD2pBBzum
         Sk5TWnCkZxoDsLgMNzO9i/WNGyoluU8wgXOKG0h54zFV9TU/0/ChG1QV6qHQ17lMjFvS
         44j9hg7eyBOV/a9W2IW+fWtCB7UHn807P/LONI/NVUFcFM6FesKFVuZxaiRTCWAEDcHX
         W92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        fh=kZfE1hfv4hHejX3r4uaGqay0jv6tHzMtSkA53zT5KjQ=;
        b=PTYVSYGAeNs3FERIwdUk7CPfg4hp+jVfyRWZ+/0JXzVYSBFfmZExBOcWhPSxs0Ea+4
         xLCM1D/ER79SkQdMxvUl8PGIKpUbkTTAtwsNPS05xh67ULu0OOV+2U5qN7E+g3/fiGU0
         NJFD1cnR6WmyGR9+idCflaUrNHYIEPAkVMwQG2vor2KqmE8cDfD0kTfhXGIEff6kDYqY
         igqfQzyVBES6/Z2GdZzdT0/bRHcvJ//ExrZchX7eO51ztUPcrzOqr4LO1+f6NXpn+8WN
         Ve45eQwcEZLcDkfylQAwXLD3WuvCYmoTTVxD6ApjA1v8/rosiqk7hrHgo10rZNV2/ZrB
         ZI0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592812; x=1793197612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=BRqHAhOJRFQGCZ0436cerbXsvDGcjOTtcEFCOpJRV+nbVKbSAKMl662tBLFTfb2Sg5
         NFxQNyHoxxgYHQR13h13k71ankQp/N0fxgwfPZdFZZwD0LZwBvhOQiky2tnvBNcGVE92
         vpRJ7hzp6lhKrZveGyDGkQ94JZjS5rrim4/SQCOenhyqo5st97RuKWVFwTkWZQ5bTbIw
         iWX7FjROAHIvHplEaKREmJYGpSp7sUQFKLAPhXVjYlSpM8WQnUK4iSviJf2DCzgxJwf5
         mmlBS+ISZT3vDsrX9Xx3+f3KYgz6TnHUVdIwJP9bY9OfNIdfJdTh5lFsIo+qwhCRzOmH
         nAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592812; x=1793197612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=Kw0S5ieFw+56GyTa3mmO9KNf2lXlMiV6i6a62IKgDOtYcaKoFGK0Ke6mBxy+IfiBmK
         9Vv19kgbGx+wm0NhxUXs1maL5GvL6luCll046f+tDaWvfsoAPBeqWG0CORqBXNi8Mdd4
         s9tdox5vqX/8nAQV69w/NwvsyUK1f2nxz6XvIGLD0Av6P80k2GHuxqdYbxNcKUYgPRKe
         ZwsT9GfE3ySvC7URymn6+AqdTYtGmCdnhLe0aCLj/R3Cu2c1+kMVVDe0HUVwdnbRhmU0
         UoRufLE8EOvhYpo1hAX9SJK+130uoI8FEXpniAqUadmkiLEp4NcS/bnKX/A4DjED6GT6
         JZ4A==
X-Forwarded-Encrypted: i=1; AKwUvBzViUKLueBbOZDCw5rBftbYjPtH91nWwV6BlD1C4ZgbNrWPvWqFr+BNfqfi1mVRiB10mZ89X6EDKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJBdCRkZPWVjfKHmFKHd2FVzsBRn7MQEcwS1kMg4E4HEXxeNVBm
	TCIFvXBG0IovY6Zs4TVwttwDi634Pt+YTjZDVr3ZXVViUtqTFAR2XQ05zSA5HC+7RPgreOG74vS
	n/13/StNhIk/6XbMbLYkatMgmdqHyD/g=
X-Gm-Gg: AYBFou1sL6S0mijK5EHBbWTFwv/R+ZftmisbT4N2PUvIx01e8nPNPHs/hU0mZBDqHOE
	BCEpdD7pXuvBcTqNBL9BFjH+HFmibb30uDTmK/p4npmgWIUifminoERK5yHOWYbd0Ey91W51Q/6
	Sg1iHRF+4iSPqSOotcucnnK3knoYBQI+B6m6SRA6DTCoPG8SZW0QB6ExAR4J54+ZiD6JhsptUzY
	hY8XpoWAMO0Mvaz+OyGN/m1pgjw4YgBIgK7vEjyg3Lga/jhpKPbuVYizxmlce6mLpwf0eQ3CQn5
	O+3oE6XlUdv1oNoTHmMQVOPGj3TRGK6CAmlR2WgIoTVgEywE+GLFpDDjhY9lG6VFUYf119UBPPV
	aMX5jfvuHddod5vJwA8f+gaML3hGXUoFJ7zuD
X-Received: by 2002:a17:906:c105:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c46796b58cdmr190770166b.28.1792592812271; Wed, 21 Oct 2026
 07:26:52 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 Oct 2026 16:26:15 +0200
X-Gm-Features: AclHuK9oo5ZYObAiFZur0ih7xDKEBxlKdO-BvoDx6w0mXhpoTx1_PdEXJcogV54
Message-ID: <CAPJSo4UJPnhLFAYRXE-_M2_Nin6=Ff02AjayD10cB7946MvJDQ@mail.gmail.com>
Subject: Adding dreaded Windows SID-style, or. Repeating history, the bad
 chapters. UUID/GUIDRe: [RFC PATCH v2 00/41] UUID and GUID user and group ids
 (*_r system calls)
To: Jan Koester <jan.koester@tuxist.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, audit@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 13:24, Jan Koester <jan.koester@tuxist.de> wrote:
>
> Hi,
>
> this RFC series lets a user or group id be a UUID (RFC 9562, version 4)
> or a Microsoft GUID as well as a classic 32-bit number. Processes can run
> as such a user, files can be owned by one, and credentials, ACLs, keys,
> System V IPC, sockets, signals, audit and procfs carry the whole id.

Are you Linnux guys aware that this is just a variation of the
*DREADED* Windows SID that this patch tries to introduce, just with a
new name?
Maybe, before doing this, read about Windows SIDs, and why they are so hated.

Secondly, the whole idea of doing 128bit hashes as UUID is not new,
IBM DFS had it, and had many iterations of security issues via hash
collision exploits. 40 years later all this horror comes back. Does
history really have to repeat itself?

Lionel
