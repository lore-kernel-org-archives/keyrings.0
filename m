Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168330;
	b=udqEqR00EH/vipg+S959jarntErC3ybsaUguWM0HYMZXVe4V9diGINMxOT086tiQb8Y+
	 g31U2VDJ7wY+Wy9ugjE4U1iL/t5nOF7ug240E2ny2EVrF/TZR4T2j5kpkoQLkcYqNw+Xf
	 SER4TfDtqNaEBV/RG0lKJqIXXTKP+frJMw4LzPDlANcBG1Mln+fuKzydZ21BlO3cofmnX
	 35A0A3wRtAJD3+MQT2z5QtX+lrcprUKfs65SDpJjmt+tigLtT25y5gZbvRkeJzTnAqmWw
	 Wuh6LofvrGC5gOGOxouphZN8dL0ffJtWr722aaJKJyqdbkS2/9FAaf9wyMqedkJ4W6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
	b=g76XJ24hE28SzgEQlqYFiOem944OR9BXN034e3r4nQj3f4efmBj3dTdzzfHggB2xbSdq
	 FICu0u01oEQbfp5uXqzClJdncmvCqzlsr8778c4GdzaQemyu+d+G+BQIqYtttbFKC7O3j
	 VoDx5NEPxhFk2oS4i9CrwtzdOHUXgmSQ7ObSp38DV9RO7bAmlq08Dr+F5bv5hIPXnW5c3
	 99+BuGj8uwngx+oslhjsl8wYimmmLzZtLPlpqxGWwuBhSHNfXpkqr1Al8NDN7OzGuaGOq
	 or08nZyc1gmIPFkvQTe3uBHxqyiqDKPUVOIEnlOoHzjlP0qdwn4PC+R9nVhsEGBX6Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ib7c6P66;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF3606A320
	for <keyrings@vger.kernel.org>; Sun,  8 Nov 2026 20:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEF3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ib7c6P66
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso2051785e9.1
        for <keyrings@vger.kernel.org>; Sun, 08 Nov 2026 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794168329; x=1794773129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
        b=ib7c6P66JcABRQVIYvbAfEuMzOdspSzPtZfn7p5hZaB2Rr9aWYVjAA8lHghOcTHkfP
         W1IBKWn61CtXgoJPbCEozcqCpgRPGxULcN94D7ITtmHErVGmr3isoGCQ02nfNqhbH+4n
         lUM22s4MKp/l6fyffg7/TutUQVALjesHSFnC4w+1WVPSvW0J5rknAYGDJAl4xvCRXDT5
         fBdxAtmJXU6SiF6lguNdvRiiwtq6Km8nyFGsRU6Tq+7fwVjsnnI/ZpxcJdUfsPAfNVOr
         BXFpKVyK/3a7Qj/Qjq4EwXbAdcjWWztzIsYea9a0P/MiY6n2EtEGPByGhhhA0f0X0qYJ
         P5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168329; x=1794773129;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsI7ZZLkYjCZutUVEg7TJNtNpCk2xGDMbVs7o+8cm3Y=;
        b=GKRxBA2P/fV5xlEBnfUTuU1mhMOxqRKXYseTI0dXFML+eDHx5mOLEWlmeYqo3f3XPG
         z36O3V77juZeC+I8DC36AOWX5idnXDA/Jv6iBxnwlZ5A2uXhAxIy2cbvg6jq5LZO9vrm
         87z/4I9sR7A+vlbU+u1+idTfM4d9+O9S20CDUuVrLbOIaqY2jrag+9akmw9YHEiR4Xuw
         3uKLriBru/iEIGA7BHOqbcNtjFfAXQvrTs8PDsnFJhJEzTEUO5ssdLQdUMOk3xHbuxC+
         YmV0ZEEAD3biB0NJTcg4cRgRU2U85SYbtXD/4hnDyG3WcUsdCOX5hii/R5IALhaFXst0
         0Z4A==
X-Forwarded-Encrypted: i=1; AL+hErGxT9QoPrrzlWoaIjKUzP8jrHas6moRSiELT0+3DgK/UuHVe1/8peb1m/N6PGfYz2OOuHbK2z11DQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xL9lh1EhZp2LzKbeczCBGeY4S98d+aLtKfaxzpejJc4b0nDvg
	jIW1AQtEl0RVVK597Ev6wtixjrhzTZlA9P6gDi8DTrCkiYrSfnc5q/dK
X-Gm-Gg: AYBFou0OXF7gj4ZIfRF3nvbiRlbp1XTrpd+1m0oOBstsv4kA1jJtcNn40OYsX4K7giR
	21paHK8vlPxdD71c+AwxDb42WqDUH9FxT/ENsP8E2wNAmVawRGNQmctzL/8NriVPUetiFuLjp8B
	90xaiVNmC8y6DznG4DWkRWZEPxtwvEEnnEnOoKRrsZ7EG7U2UX9Exj91h1noXzKdLT3Mf33UfS5
	Yn6Yvw8Ttz7Fj3SVlzUTO6KYl+tibPaeg8gi3Q3/eU2bkiBsgeM6R6mgFdWPXWO6laQyvPHsP73
	pqAh+rSvnAGdl+ika8ABhoDijnTW7mNctMbdCu3Tz//GGJABKEcomz/8ah5Q8KfDo2QuVHkPPBZ
	8KxYzqgKK6U43Ow75qPoOJ4yYFuFmYQA6lAz50UGaDnHCDtko78HFdCUVyHv8SI/BlYcr5766ae
	JBqkQXbwg+VxUTb5N5amcDvwDRyot8daHNVMYXtgSTAgygsGyozgslND2JWGL7cFBs06LqCLZu/
	A6uZprEE3PE9oNWDG2CcHOGnKBjhuWRSWLEyr/2dbx0dZaNoZYQdQ2cZkRGre33eldy09aOK5l1
	byy3fTsD5VmTUYx6MzZmZGUSFnDMz+zCzyJGYYeJjx1qWe2BH0WYTEEtbY//fAvGTj7KjmSjDJt
	8ML12Eq1S0w==
X-Received: by 2002:a05:600c:1c0c:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4b963c69d23mr43591205e9.19.1794168328561;
        Sun, 08 Nov 2026 12:05:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186ec5sm5768522f8f.33.2026.11.08.12.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:05:28 -0800 (PST)
Date: Sun, 8 Nov 2026 20:05:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 David Howells <dhowells@redhat.com>, bpf@vger.kernel.org,
 dm-devel@lists.linux.dev, fsverity@lists.linux.dev,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Alex Shi <alexs@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 Benjamin Marzinski <bmarzins@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, James Morris <jmorris@namei.org>, Jiri Olsa
 <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Paul
 Moore <paul@paul-moore.com>, Randy Dunlap <rdunlap@infradead.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Shuah Khan <skhan@linuxfoundation.org>, Song
 Liu <song@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Yanteng Si
 <si.yanteng@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 2/3] KEYS: Replace assoc_array with rhashtable
Message-ID: <20261108200526.43579e2a@pumpkin>
In-Reply-To: <20261106090516.GA1973@sol>
References: <20261105031401.956609-1-jarkko@kernel.org>
	<20261105031401.956609-3-jarkko@kernel.org>
	<27015846-0161-4700-b810-4643e1f7b63a@suse.de>
	<20261106090516.GA1973@sol>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 01:05:16 -0800
Eric Biggers <ebiggers@kernel.org> wrote:

> Side note: fips=1 actually has little do with security, and in some
> cases it actually decreases security.  See for example
> https://lore.kernel.org/linux-crypto/20261026183332.11402-1-ebiggers@kernel.org/
> where I'm fixing a vulnerability caused by fips=1.

Then there is the 'fips compliant' server we used for routing 911 calls between
TDM and VoIP.
Any kind of PCIe error gets routed out the the motherboard management module
which then proceeds to inform the kernel with an NMI.
At which point Linux crashes.
The NMI is too late to stop the kernel having to handle the ~0 from a read.
And even happens when there is no driver using that device.

David
