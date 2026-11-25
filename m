Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609135;
	b=2ZjeNQzrdB8n5xR2pci70WLhAtSV8tqq8hqK9jev03chxRdA6vH8R1tzM2B91y83Kq9f
	 Sd1j0xKokQ9rw2MyDfX0XiCzTMoQZN0o6cskiD+sjoLDxEDlpSKW1ruVwuqyLVmPzBmCj
	 B4+TwjAigfGgi31XcA6ojA71241e+IylJF5BRoJGOowtjMmUZuH/QPn00389jsauZwh1a
	 5T577oxxmTi9fXxvFMVbuVT8bDlMDZ3jd4RvjusrTNf7wdAf/h0rR0y1sy+G3tAYTnEyR
	 fawwLLhivSB6Sc965WVeeSrnp5EjNkgBL9VAuloJfNu0sZxwXifcVnhJ5QBr2HrnlGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EipLtkhh3uSERmjoF+5iUVrp459pGW6lqIvnKgJ36K4=;
	b=c8rmZD2Sywt1+1TTnYHipEkRUqbv12RlvAw6hSTNOi0mThGAMhpyYGa5FSD9ky3vK3eg
	 2/GeHq8GtFBjHAIpmBoJzgZK9lZjsIm7mi+nfOgtrRRmrfFXUJgt9D78nxGbh1xFPq6RV
	 BTuM4RRE3hbO5mbUo33PrRMPlASeFsGVIY9ZPS4vLOuaMhVuNH/GDcVUuQ6FXmPcEJyBo
	 0qeHpPMjC4Gc6m5LxF9QqG3V4kjs8oe/22RORSppXqn9u7g/GxET9GOU8Vgoju6BW9Ofb
	 NdJb8sEUj5OQhhD0BtEcW5JglvxIMoxPfxqfjKt2m2hNL2cX2lydT8jQ5IchqO/+CGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jzZq5tRm;
	arc=none smtp.remote-ip=74.125.224.136
Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA8606A323
	for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 12:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDFA8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jzZq5tRm
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8b35e6f613dso11615027b3.1
        for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609134; x=1796213934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EipLtkhh3uSERmjoF+5iUVrp459pGW6lqIvnKgJ36K4=;
        b=jzZq5tRmC+1AmCi2cqdA7tvizyeSmyiH4VGF02a+e6qFRIZZl2Z2yNkYJADWApHtNz
         25RNrhrndPHEoWZbI3BjlSTjK6gnrgayPHp/FFTDuWG+Io58ot0hsM0OmgXIm6/9TZDM
         2av90NcIm40kvdM44XLq3aRT4z1XkIhJqGEzcg9vmh8C83gSW5t3BexKlNnnQ3TNTRh2
         3p3PSRKW7PNVrZq6Ee/6hTuF2eDtHBioM3SKhYooPlsYg9ao7mDIseFQZ5+sFArwkmlU
         GC1wnRDsCsMU0d5hTkWzaMvqbMGbaTZWeNmJzzh/1vJMLhNg4uQ9TPzSZFDBJk7IWd0C
         MaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609134; x=1796213934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EipLtkhh3uSERmjoF+5iUVrp459pGW6lqIvnKgJ36K4=;
        b=OxxVhy73UzQ1C5jEOu8K0iw6vIesi4z9GXQ+b3+db6b5XX/KBtneaoi1mhdhv6ewbt
         fSSmAiDLoFn4JouDZwQK9SZElWoOR3lT5//2JU5O5SalBH/4UWYx/uG9c0zxxLaDN4Hq
         EkRS5JfzCv532hmZLc6hGsQOsX6ApeviNjq02m8igrwZNJJrSpFagoI9sS/luDCFjrYL
         K7vfhSCSckE7/DddZMM8PYNLhe/3S0DLaY5iNeOHMUv62u0rKSiuQMkHCDYtGp6SXHCW
         6vB6uZ6dERqyAhEbnL/9LsTfwmYB4zmJl/3lWHqbHdxUAOd0ZkC1n93PtoGIk1kYsoAL
         JzXg==
X-Forwarded-Encrypted: i=1; AL+hErE/qtNY+pbKrBnHifgAzparGE3+VYpS5467Opdc7YD5g6Ad96Yasf7bUpDGhscn0tzjY+eGzqM7fw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+6jNJImSkUVtN9TNMuSCxmwjtBukyChcC3S+dbyUPoim4om040
	ulzLA6oCLk+/6z8lXOEh9FRAhITgPgFJAorKvfE+iRbZ/Fs8EXenp33/
X-Gm-Gg: AZFdTZeuGuHVowx0AC7Tiv/3q7MBjv1pTw+A6P1SGbMkwBWYNZp1YbI7Mt1zNYr7z+p
	omWWLxr6OmgUEA9rfAA6RLvkupW0INbwdl0Fx8+SSCpFC+HXu8pprj9jncb9Acu46oqmHYOFYFM
	XbIDJb9DX90uJNzVqSgbfgZW1+7WvUUXPG4Bd3gNp0Wb49nvfxHgvnsVMjlLLbuN7PMOGbISQ8m
	RBIqyAQaBMaEMVEak/viP/v2UEBtGFdYW3efcuOx5Z3uZLWBX4mZU1tqCrPB526FdCFna/GDMyt
	kZddDD19mqyiaKWfQ9rXj1clB3/25IilVK+G6v0+URXxh+8wu96l8+txo1cs3OBy4w0KL0tfAhc
	uaO8QKNm1zQDtnPiamNRK2Obi25A+gAoOraH+3vhizGV4DB8lTg6ZvrkQGq+V34+6utq08LJV6g
	FU7PvoP9BzDoX1l6cL/V9/PzXtHQyQA/AGSbEhxG/2QdJUZyawTELiMH+ws1waC3BrCX6SDmbLp
	ylO07SLgOuiP5XU+NLbiu9bY8clyITSlSUdazpVzfbdYxSGQ5/ame2v7Zjm/3lxdCv/jteXDaar
	FANCUUKrdYA9PXOh1TvWiDUefAlB77HvnQo=
X-Received: by 2002:a05:690c:905:b0:8b4:dfc2:bea3 with SMTP id 00721157ae682-8b5204e9094mr85848277b3.50.1795609133907;
        Wed, 25 Nov 2026 04:18:53 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202b09c6sm72601307b3.17.2026.11.25.04.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 04:18:53 -0800 (PST)
Message-ID: <a71a3d9f-0f19-45f4-bc98-a5663ad537b2@gmail.com>
Date: Wed, 25 Nov 2026 07:18:52 -0500
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
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
To: Hannes Reinecke <hare@suse.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
 <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
 <20261124213222.GD2227373@google.com>
 <c2163003-948c-49fa-815e-b1f91814a80a@gmail.com>
 <561e1abd-2430-4808-af99-cbdd3fd86d31@suse.de>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <561e1abd-2430-4808-af99-cbdd3fd86d31@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/26 02:26, Hannes Reinecke wrote:
> And the other problem with your approach is that DH-CHAP
> key don't actually have 'names'; they are just binary blobs.
> If we want to refer to them by name we first would need to
> agree on what the name actually _is_.
>
> What we could do is to store the key serial in struct
> nvmf_ctrl_options; that would allow keysd to provision
> the keys and rotate them via 'keyctl update' (or whatever
> it's doing internally). And would get away from the
> business of having to come up with a name for the key.

Yes, a key serial works for me. The kernel then needs no name for
the key. The key description stays a userspace matter:

- The admin names each secret in the configuration: the connection
  configuration of nvme-cli or nvme-discoverd refers to the secret by
  that name, and nvme-keysd's configuration (or the KMIP server) holds
  the secret under the same name.
- At boot, nvme-keysd adds each secret to the keyring with
  add_key("dhchap", <name>, ...). The name becomes the key
  description.
- At connect, libnvme takes the name from the connection
  configuration, looks up the serial with keyctl_search() and passes
  the serial to the kernel, as tls_key= does for TLS. libnvme already
  does this lookup today, to check that the key exists before the
  connect.

For rotation, the serial must stay the same when the secret changes,
so that a connected controller uses the new secret at its next
authentication. For this, v7 needs an .update operation in the
dhchap key type (user_update() should do). nvme-keysd then rotates a
secret with add_key() under the same description, which replaces the
payload of the existing key. nvme-keysd does not need to know which
controllers use the key, and no sysfs or configfs write is needed.

For the sysfs and configfs attributes:

- For a key from the keyring, a read returns the key serial, as
  tls_key and tls_configured_key do. The serial names the key the
  controller uses. The description is available with keyctl describe.
- A write of a serial is rejected. The serial is set at connect, and
  after that the keyring is the only way to change the secret. I do
  not want a second way to change a key: a writable serial would be
  one, and it would let a write point the controller at any dhchap
  key on the system.
- A write of a raw secret (DHHC-1:...) keeps the current behavior,
  because existing tools use it.

The same applies to dhchap_key and dhchap_ctrl_key in nvmet configfs.

Martin

