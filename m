Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279752;
	b=hPXnPAx86t11U8uffuUZform74GETt4HrYHIiIRArAUQtcTdGYJfXzw2OEyNVA9dSrB5
	 C1Qmx49MINEwYqQDC+P2871Jm+ty33pZ9K7W68TWY6QCmT2tuyZfcF0+fcBDv203VFxaP
	 HoCZ6pVqPPFjGbk7F1LQrZ0UUS+M3G/aOsMv/ziTlZ3K4MdpgmK4Gbe1igRRkYpf3LqBR
	 ogksJKSgU8bi1mNtf5ETEf/JczjH0WwnhGjxm8H88sDclNf7pH4hEyHxMC+au01+cxYz1
	 e6MU71j+MIkumCsL5GoaR0WRJYZoa+32JjDpOESlXpGKG365jtCqEivWgUn3W8gud2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
	b=zjkDQbNqU0kw6G5fZOzxf8UG9XWHuik6F0oDake4JlGeUSpgBdKXNDB9mDOTTzi9J9At
	 rN0DClyh1zA2PqCZMjKcP8TdAVlE9XNjuUzATBmNlcFgJn8qgpzVlbPl5qr8vlmoMbowA
	 KWy6Zv07MwCo4tlI9r4ziVL9qUwzVRatY2vMnJkCSIcBpu8YPWwuJLGH24ZHZsGUtfMIi
	 CdrQ3WPz2U317ARHA0+k2Had1EHB6O+AeQFhMXd2WyZ8vm+Rrbm1fXIt/FL5CsROf3kJA
	 7LcJJZgy+6VaZEnnRCo+nka3zI8A4xnxXQDvitlhwfGtrDe6/ToWcvTJdJVbU6h1N+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6AHZfyw;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C80606A326
	for <keyrings@vger.kernel.org>; Tue, 10 Nov 2026 03:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C80606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6AHZfyw
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a60f90a924so585739b3a.3
        for <keyrings@vger.kernel.org>; Mon, 09 Nov 2026 19:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279752; x=1794884552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
        b=m6AHZfywnNj4tR4b0GSl9VsmXD/S9+IKtsaMttHTfmvLEyuNPBVaeyrC6lZybk4qL8
         AqMx4gh9QY3A2GXi3T3Sl1KNT/PYRt4E28B4bMgBHPvpE7qHNa9zjSUQsa8agsfCwv70
         rg3VXJLclS4/RPoqCvxawkhdJhW4+YtVb8a3tCocYcSgyb58EDQwb/CRyXhtZ7YHu50U
         ILsbhkOeFxUCYUnyY50nyNPkbmiub34akV5jNBJl99EPlJFmrpITtmnkiFhkoYI4kYmZ
         2yxpPHcz4RDp1ojO4rhUmZwwxUiuDbnGIAjqY3xeCnND7EsZ6c0yZI8Lm8NN6TZEN35O
         Ihyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279752; x=1794884552;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMWgpEtU/gtg2eO84Q3N861jXy5hniFgHLN4W28H+nM=;
        b=bjAzn9zDod7zlGBnqnDQtynoJ7P4l/SFtqoQjWoyJdSONYZcM1fhedADFU8+2e8/+e
         2qGh6SDxMqxeoPxzgSl3qP58l1arre62eUNyY9kX2mEXAo571hSnVKv0ggSW2aCo93Cl
         BjyUeyQpCGhdRAi36LX/9ltIlaSmFJKgQRPi2h5O6MaSQymaO4luZ46EmHDzqK0VaBDE
         B6VW8y6003btlXTEgfEgIT+KuV+QNAlsA3XGTVHenIiKYzbWda2qLC3rJ3yLVEzV3D4Q
         HVJTYHgfs19X+4af8RrqwZZQ3X6dp9+nx5YMskGSIOd8fE4Dxd2WcUcGMYIrPrTv74VK
         KUYw==
X-Forwarded-Encrypted: i=1; AL+hErFGMTgypUOnz8R+opaeKL2unIyhNTM+b1y8LNQ3rZGZxRoNWGBv7mrFAokFcX/PFgQ7jHnJW3dkTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9KkLkMa1t3MqC8iAwr1W9Le4DeeKKhIKtS2y37AQmPQTNRwH9T
	YW5bV+BP8STjZSMFnqsASBhmLjO2Sk9SoB8yGVh3cVf03Rmz6348+6Gw5Jr9i1gqIpg=
X-Gm-Gg: AYBFou0Me2AtQoal0gvnpNKp3TOv0QSCYt1v6f/OBOOD+VxLDvJS1GA4C3zmu+Ualt6
	MW1uwhs6CrOsQt38iqdxMPNCyNxtH99kkb6h5s/qnhFONa7leal7rgf83C6VsnyYm4uQdtSCoQh
	ZDkaXkwL3+6rf6zzne+r3X4xOT31dXj8Un02FBMD5EXAtKch1/UNDWOQb9bKqBieLMQi2dcW78a
	SZuEyAb0LGox95aHkrYSja659rXJ6aqP4b2WDmaSPXFDHRllCFGdB1WNhqqPmMHMVjNBG77Etwz
	XO4gP7mNIZtnWs0uzJplJvuCNEud8VN58XaVnQDgcyeJ5KLGPuHTgii8RVH82hY5X4lYIOr3QX4
	DAdLAGSK7Rh6NfRDqq8QpK/4AaNyXMZpzSw/D3VLHPvrA2psgSlCk2cNgNTXjTqOPLjlDfbSuKb
	8DQv0zOubO/6OxMpG5yTw0/vPQwmWIBqvrHsBVzIsx5OWtebji22qul8+G3dgKTWS1A257a7ZAO
	s/bkfXdm+JRzxJOyr0ApVYHpa1zS/Rjun8+9VNk0hnCFbD0NmuDG87ukCK4W2Ww5pIj0cwkekZr
	z1oh3D40XmlTry2FGnBTdwkZJyCDF19J2v5I
X-Received: by 2002:a05:6a00:1887:b0:883:54dc:7892 with SMTP id d2e1a72fcca58-8ba876454bfmr1402875b3a.52.1794279751668;
        Mon, 09 Nov 2026 19:02:31 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.124.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab9d572fsm317021b3a.56.2026.11.09.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:02:31 -0800 (PST)
From: Yuansheng Yang <0xbeac@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type removal
Date: Tue, 10 Nov 2026 11:02:26 +0800
Message-ID: <20261110030226.9898-1-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avJ4KM-Erci0FkgZ@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org> <20261109055204.31673-1-0xbeac@gmail.com> <avJ4KM-Erci0FkgZ@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 03:49:28AM +0200, Jarkko Sakkinen wrote:
> > -	if (!params->key->type->asym_query)
> > -		return -EOPNOTSUPP;
> > -
>
> I think I asked to remove this. I need to revoke my reviewed-by from
> this version.
>
> It's not relevant for the bug fix.

You did, in the v4 review, and v6 dropped the check again by mistake.
v7 restores it: keyctl_pkey_params_get() is identical to 7.4-rc1 again,
and the diff does not touch it at all.

The two early checks in keyctl_pkey_e_d_s() and keyctl_pkey_verify()
stay where v6 moved them, in the key->sem section of
keyctl_pkey_params_get_2() and after the buffer size validation, so the
error precedence is unchanged.  Only the check you named is restored.

Sashiko's remaining point on v5 was that this check reads key->type
without key->sem.  That is how 7.4-rc1 has it and you asked to keep the
hunk out of the patch, so v7 leaves it alone; the call sites recheck
the method under key->sem before they use it.

> Also if possible try to make a bit more compact description of the
> fix. I did not ask this for reviewed patch because did not see it
> relevant enough but now that this needs a new round, you could
> address this part too.

Done: the race diagram and the paragraph describing the early-check
move are gone; the problem, the action, why it is safe and the coverage
list stay.

v7 follows right after this mail.

Thanks,
Yuansheng Yang
