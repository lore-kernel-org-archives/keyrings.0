Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790138;
	b=SEkkOoASBN7y/2/leaB38HABbWuLl1vzW99TCBnq5UUbDQhQwk6/3VP1uZr29PNnTr0m
	 j/FZ3YjUhUlyPEZ9CaU+BM2IDblx7xnBoW2icUVMUpIO0/LXK6Sxply6eNVIuzXI92WxX
	 2GdhjRckgDlNeWY+AJImulE2ga9hTqGp5oN1Jwj5ij6QougGJukvDXXfy3eVYZnVBJhmK
	 YDwRCmdylS8lsjOMTOQRNGFa4fWfL3vxUku4OIo1XsvMgqn2sdhN4GhviAtqE0wB+X3hu
	 OLiRUPIqJVj6kvpxTPElOWNMMB/wM3gFON0aOtZho2zX6XFVPkX96zTbozo55+r138Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
	b=SZEXGHPAIOndaRnxV8yXqLWIZ5y071UmkJaCiH/VjM4g2ZflsU3x63J1d2qjJx17IXcU
	 1JrELBEAMlBY5QFGCAtaD14+wkkTAk9Vv9kgMLFnH/bfiYCQ5QwaIIzwHvGOQXsAminUi
	 m0RckoUdP2ARMiRn5/9gI7xHND16y//oV/0BD1hJxr5LPzzeY8jE5gYps9s6RPG25tcud
	 duoeIi4ExrEg0iXCq8Tv6au5iTgWlW9tpTr/FBzYtErrb5K3P0TVX0eMaJAGHbquMDzAn
	 ujDlnbwqwOxNcc/UweQ0F2E6o0kZmDsVURqILLuBGwlkPF3RYNWIg9oHDFOUk+FEY9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxYQVVVm;
	arc=none smtp.remote-ip=74.125.224.137
Received: from mail-yx2-f9.google.com (mail-yx2-f9.google.com [74.125.224.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A2606A321
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 14:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94A2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxYQVVVm
Received: by mail-yx2-f9.google.com with SMTP id 00721157ae682-8b343763c6eso9019127b3.0
        for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795790137; x=1796394937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
        b=PxYQVVVmOW3QTmnUGPn/8uXuLs5v4r8yVSS3T/M3GF2IsTX5jt4Nbh8H7ACddJ2jt2
         sYlu+5hx2ke6hDAaS5ELDKTx9oDWWXKf0Xx7w1AEpSzL9qY3UcL8IukZL1Lpvpg6jprA
         0nXF2LeidTFzmh2+cLVnwlFdTMS5jXC22NVlvhUL9BLe+wvmOFiA/0VehHoBpUnKrRMo
         FsI86FZf6QaVF9RfOqx+DHHPrSXJqATdlsFkcU4iPiSTu+e4wcQXRNPJnMk3IdRkKF8T
         ay2mGRYiqrJUCXFlzNHU1ozd/s7msf5nn1yAirhd7IxMikw63n2fNrWGC11qVGHImfdK
         iVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790137; x=1796394937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
        b=KPF/D/udVFkMMl+05KoyN4o9IIGfHalEsa2+M2fK7oMow36rZniSBtAOS1XMXTKn+u
         g/coRkkwKf3tPN5GdHfRd/vGWVzNhkt12o7a6Wqj7mo856820lcCUh6Ts19ITcmyM/SF
         Mh3N/818K+IrKy25DOJj9MTKHFTmJt9gFisglWBeDjONP71a54YgnNUdaRHrer4LeRO3
         R1+1qVJuvpZ/ACZkLAbIBZHPhgVMj1cP2oOvvsOsMMDpW5t+OqTftHwFgKeJoAisRjoE
         e4n4jKe7O6GFOTu+OY8IcDZJ2svsm/xfECSAbVwD4Qyb8TRVwplq2in2382jxRyeqPDx
         SAJQ==
X-Forwarded-Encrypted: i=1; AL+hErG2ycJB8s7eXxWvkWGYI0GI+1BRaogd6M25kxHn/50G09Fl/aHIjKtXSF+pX80jjW7VGG11m8t4mQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9sATz04/W+IQnhaDp0Qtae94TdBavg4XuSlF/lWIaff0r671OL
	U4mtrw+vYIs/px45BS2dwFzWwgT9MzjFYTxABktcMtf9Vco+Aopaibb5QTPl4hZ1
X-Gm-Gg: AZFdTZfK+Rt6ypilQjL52lHZjCv6IfkaHtaKaaplQ70iOfkpVHzCv7+19FGII141EJR
	XJVsGTcw7aNrG4Kg7yRWgQIUFPuuHM0I6LhA6U7g/Y4KYjnjjz1s3+N0B/NhcyWsKccfhjMk2bl
	UN7aP2ouQoq2bMftbTW3ipRi1X1qWEsghu0xp4LxU2/9ZMdWuA+tJvUvhnCChbI/c4yMAdo/Xdy
	UjsjeByrFYOkllJ2+uaGLjhOjNAI8rEid5dOdYSlpbyX1N0qXtgqe55NdIuT7g3WxKn3QvszgIq
	6mvczy1sqo1ou688UO9FGkSvcl62GrcK3lOlduyBmtCt1SYvgpzLnWSpiwuulDQkFux/wIqwGXk
	hPNPGm+Z19NrHMan/utDNIswgBNdKgxbkk9dKqRLy54nmUyGTFrO9XuFnjvMLPFSUL33yJH506k
	7/kWJbFjOgem1CYYQQXBdBrB87eKrQMujI5p1frrt4eLAqhFanLW4HOjwbKkfRhypRaFlEQpK5j
	a9B+l8/ZuzTRxVCtFsM4Er7+wX4ZrkQi722eVSuNoaeetV3cxOcB+tS6+Id8u5VpOAGAqI7cM9H
	t2sA1RSY5jnETMURgF5mk5kDTXKxITWq/rioD1lZXeLnNlMMoeygPKxa4A==
X-Received: by 2002:a05:690c:c04:b0:8b4:c8c5:6b11 with SMTP id 00721157ae682-8b5204f087fmr129405847b3.36.1795790136722;
        Fri, 27 Nov 2026 06:35:36 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b59a06f3e9sm1537207b3.25.2026.11.27.06.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 06:35:36 -0800 (PST)
Message-ID: <17a445a0-16ef-452e-a174-5bb09940d3fc@gmail.com>
Date: Fri, 27 Nov 2026 09:35:35 -0500
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] nvme: allow to pass in key description as dhchap
 secret
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 09:12, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
[ ... ]
> -     }
> +     } else
> +             count = sysfs_emit(buf, "%s\n", key->description);
>       up_read(&key->sem);

In my reply to the v6 cover letter (Nov 25), I asked that a read of
dhchap_secret returns the key serial. I would like to change that
request.

libnvme reads dhchap_secret and passes the value back on the next
connect. A serial in dhchap_secret would change what existing user
space gets from this attribute. Showing the description, as v7 does,
is fine there: the kernel accepts it on connect.

Could v8 add the serial as separate, read-only attributes instead,
kxchap_key_serial and kxchap_ctrl_key_serial ("%08x", like tls_key)?
NVMe Base 2.4 renamed DH-HMAC-CHAP to KX-HMAC-CHAP, so new attributes
could use the new name. libnvme can then use the serial, and it can
tell from the presence of the attribute whether the kernel supports
keyring keys. Today it cannot, because dhchap_secret= takes all forms.

[ ... ]
> diff --git a/drivers/nvme/target/configfs.c
b/drivers/nvme/target/configfs.c
[ ... ]
> +             } else
> +                     ret = scnprintf(page, PAGE_SIZE,
> +                                     "%s\n", key->description);
>               up_read(&key->sem);

The same for the nvmet configfs attributes dhchap_key and
dhchap_ctrl_key: keep them as they are, and add read-only
kxchap_key_serial and kxchap_ctrl_key_serial next to them.

Martin
