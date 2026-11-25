Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591600;
	b=2JtmV8Yk6pFdMpyIHNONpVI/B/i8qhxFW/5jhojKWT5iSqDbjogyavJYtwGr+8Tu52UE
	 gxapfds3hw7Rs6BCQdIC1FVu1tn0hFZAT5vCfP41AVqayWq0HDBmhU1m1wzYNTCDhbD6G
	 YYd1m9ubQLwOohNSTymr/92hJP89npCfLy3AOw6Gq5pQCxVKiaPvpG/1o44v6KiFdDPbo
	 Xuqo824z7n4Wj+IyHC62JXAFTcYWeXiUL1CIbzCHiSq0x3/xWOutAJoav+0oXvwWNSFGs
	 aNAwSK7KWAToqgHdPXO/klCJYUNywUcJWcDhcgv0Tt8UDjCDzPpAKRuPMJZfsQGWKpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591600;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=2a4mMSXkJJkI0aTn841fl09wJNNE88BpvXRrzYz8z1I=;
	b=fmADCWH9VCB31jGXjKU5Q9MlnV7qde6oWcpj6GuSkCr+bpjnQEL6ONVSxlDs79rgDPxT
	 LiZXmU3+MseqsRbgPRY8MMQ0iqQjTJUIJqLCrlEpM0wq+2umz82wVxgYVNkqeGozgCRRO
	 iNMlMM13bG63KegSPsuZFn32EoFJ6FwrpTDROSQWYcc1iMJVKcxkXSCHUhqZNTOG//AYb
	 6rsvsjVCQcrPn4u9GuEXZKUmuoNAhXad030J/bNRLg7+cJnAxHsYJltmXsNrWpn0srIIK
	 5V4HT0YFNsUPTiq1wHyHCZOeTz/4/EHiMttMlaO4sWn08vj0Q0MTW4LrDAj5mMzryiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="Op/kwJNF";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=di0fenA1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aYEvI6Jg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IiHmeZcr;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE31606A321;
	Wed, 25 Nov 2026 07:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE31606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Op/kwJNF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=di0fenA1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aYEvI6Jg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IiHmeZcr
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C54122379;
	Wed, 25 Nov 2026 07:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795591597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a4mMSXkJJkI0aTn841fl09wJNNE88BpvXRrzYz8z1I=;
	b=Op/kwJNFunoVi9G8rlqVzu42zt9Ng7Scs+HizcyoAHVPbvI/Hm4xRu8+cqrG5Ipqc8OT7J
	5cWHaRtEKus/fMjA2EIqcdXXCD4FtLdftoMlC4y/nFb67PhhoaMVYE2xdIfGmMTnCsoj1q
	Y9hXFzpfzBAkBMoSW+sEa7r9a4U7X2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795591597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a4mMSXkJJkI0aTn841fl09wJNNE88BpvXRrzYz8z1I=;
	b=di0fenA1SHktL2KU6C0A6Ki1KI4P7K2Ysk8qOgfLkty3nn4PXmalR/Ev1A6EieOL+f8Ikq
	tYBIvc9wCREuUiCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aYEvI6Jg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IiHmeZcr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795591596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a4mMSXkJJkI0aTn841fl09wJNNE88BpvXRrzYz8z1I=;
	b=aYEvI6JgVQc9/ILsDv4vhtP3usQepu3XRGYHsMqNm2mjHIUOiO1hKyx8chVhg91j/WpgqK
	M9bqlDnMoIyAtaEcZ520LL82+jdy4UlNv+ljK3H4dQYWkClJq9wrVDfQXYMGeXYDReNZ5F
	XEpmQsc0nHEgNPyCtD2EnjDF3kaxh60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795591596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a4mMSXkJJkI0aTn841fl09wJNNE88BpvXRrzYz8z1I=;
	b=IiHmeZcr0RS+M0NoIiuB6VN6ytN6UMFeHVQ+C+vMfjIRc9Hb5RM6o+uiziltnkDBZFqHwS
	+F9xZk6XCwXuvOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCCDD1339F;
	Wed, 25 Nov 2026 07:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ++x/KKuNBmsGKgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Nov 2026 07:26:35 +0000
Message-ID: <561e1abd-2430-4808-af99-cbdd3fd86d31@suse.de>
Date: Wed, 25 Nov 2026 08:26:35 +0100
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
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
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
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c2163003-948c-49fa-815e-b1f91814a80a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 4C54122379

Hey all,

On 11/24/26 11:13 PM, Martin Belanger wrote:
> 
> 
> On 11/24/26 16:32, Eric Biggers wrote:
>> Even if you actually need runtime key rotation without touching
>> configfs/sysfs (why, when nvme-keysd could just write those files
>> itself?), this series doesn't actually implement that.
> 
> Correct, v6 does not implement it. That is what I am asking for.
> 
> Writing sysfs from nvme-keysd would give two mechanisms for the same
> key: the keyring for the connect, and sysfs for every change after
> that. One mechanism is enough.
> 
> It would also make nvme-keysd controller-aware. Today nvme-keysd adds
> a key to the keyring and does not know which controllers use it. This
> is by design. To write sysfs, it would have to track every controller
> and know which key each one uses, also for controllers created later.
> 
> A lookup by description at each authentication avoids this. It is
> also how NVMe/TCP TLS PSKs already work.
> 
> With a lookup at each authentication, the sysfs and configfs
> attributes no longer need to carry secrets. For a key from the
> keyring, they can hold the key description: a read returns it, and a
> write sets the description used at the next authentication. The
> secret then stays in the keyring, and changing it needs no write to
> sysfs. Raw secrets given on connect keep the current behavior.
> 
Ah. So essentially you are saying I should drop the patch 'nvme:
parse dhchap keys during option parsing' and keep the
secret/key description in struct nvmf_ctrl_options?

Sure one could do that; but again the main push behind this
patchset was to precisely _not_ to have to store them in
any structure, but rather work with the keystore and only
access the key data once they are actually needed.

And the other problem with your approach is that DH-CHAP
key don't actually have 'names'; they are just binary blobs.
If we want to refer to them by name we first would need to
agree on what the name actually _is_.

What we could do is to store the key serial in struct
nvmf_ctrl_options; that would allow keysd to provision
the keys and rotate them via 'keyctl update' (or whatever
it's doing internally). And would get away from the
business of having to come up with a name for the key.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
