Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772370;
	b=1rH6i9Ky9XkxLfuVvfUjI9zhWcoctb1XjQSYwvhUjy5ZmgRjbFDQZ2lQRNkQqtMQOHIM
	 CHbJm/SXR/KpIenvGR5vxkucxmYIRHAifcRPb7zJKOkAgL5Z4swrC3/o3+l3QNMCm2/Gm
	 2ED/XYMNNTmnh7mqfpGVFjYJ1ok3XinKbsVvmGJ9kCyFeyP11YmXVPRYcXeM8LUT6Ssb4
	 RsyAl1j5+uNksxxpYN63J/3U+rPZS++ElsPDbrHaTgS4WxFUj+A5pkXsQVk6g/YXyXWo4
	 5Z6aAUJBj7fzYAH4tiN/efNymNxzRpBBbEQbCAtikV8b7WlHtQMPze/HT1VtrM6L1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772370;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=DbsfeVuNDd/O9KgSXbjfoNSkQ1mJ1BIK1MlFT59Pjm06q3u5quMHMA0xcVX6dumUPXBk
	 st0uhFYb8ZfhrYT/HnEEdDXJ8oyNgqc/fYOypa3cRi+oCEhl24lLN69NgJJ9U1DMbzlKa
	 FUTQyLrdpZDEPd3IsMSIwpDeSD5RSiXQxKVkKU+AZ7eDtoz9MvP3hFPGi1WVpJFNOuYri
	 7DnXGDSxP3+xFA8Ecn6y/XQv+D0VZAKO+N0pzFmPcr4ssrqeHXygEeQgaJLqvpXmOVQd/
	 AavqJYIuPSVXMqBj7pJvtjZ7/TbPy+G1n3EdJAfepn3y0th5TaLQPeaV4XL7r0Az6xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IfriXSdI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IfriXSdI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6B606A324
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 09:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD6B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IfriXSdI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IfriXSdI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2EE21BCC;
	Fri, 27 Nov 2026 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795772368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=WqyzI4d7OF9Jx9D9ARNvg0y0zZbLvGXgJRJHnh9/KfdBYMtynivhi2GbdkkT2SiYV61Eui
	ST8QQLG+5EQwzh/rgfxDTFsdff9R+29ZcH4bOMu+F/84Sig7z2DaeNXtxOPadcVIDFpAWI
	uRACx8Bvuk/M1HuYIsqC04HuAPVMGjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795772368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=IfriXSdIZh9wxCVuuOI6gNhy0elbuaD1+0f2dQU0xXBBiW9QkNadahMT84f7IaWF1W5huM
	N+d10tU4dQ/UXRAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WqyzI4d7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IfriXSdI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795772368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=WqyzI4d7OF9Jx9D9ARNvg0y0zZbLvGXgJRJHnh9/KfdBYMtynivhi2GbdkkT2SiYV61Eui
	ST8QQLG+5EQwzh/rgfxDTFsdff9R+29ZcH4bOMu+F/84Sig7z2DaeNXtxOPadcVIDFpAWI
	uRACx8Bvuk/M1HuYIsqC04HuAPVMGjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795772368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsJKbMAgoe57B/eAJ5UPuK/eULIUPcvMFQ6VPBcDQw=;
	b=IfriXSdIZh9wxCVuuOI6gNhy0elbuaD1+0f2dQU0xXBBiW9QkNadahMT84f7IaWF1W5huM
	N+d10tU4dQ/UXRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA9413432;
	Fri, 27 Nov 2026 09:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C/x8Is9PCWvfJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 09:39:27 +0000
Message-ID: <cea9934e-e152-4160-be9d-3a88886d6c04@suse.de>
Date: Fri, 27 Nov 2026 10:39:27 +0100
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
Subject: Re: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into .nvme
 keyring
To: Martin Belanger <martin.nvme.dev@gmail.com>,
 sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
 <sashiko-outbox-235710@kernel.org>
 <45f16f1a-66f7-4300-bffb-3d279b6c4bfb@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <45f16f1a-66f7-4300-bffb-3d279b6c4bfb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C2EE21BCC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,lists.linux.dev,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,redhat.com,lwn.net,linuxfoundation.org,infradead.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00

On 11/26/26 5:49 PM, Martin Belanger wrote:
> 
> 
> On 11/26/26 09:30, sashiko-bot@kernel.org wrote:
>> [Severity: High]
>> Does nvme_keyring_unlink() remove a pre-provisioned key that originally
>> lived in the .nvme keyring or is shared across multiple controllers?
> 
> Hi Hannes,
> 
> I can confirm this one with a test. nvme-keysd adds the dhchap keys to
> the .nvme keyring. After the first disconnect, or a failed connect,
> the keys are gone from the keyring, and the next connect fails.
> 
> I think the kernel should not add keys to a keyring or remove them.
> A pre-provisioned key is either in the keyring or it is not. If it is
> not, the connect fails, and it is up to the user or the key manager to
> fix that. While a controller uses the key, the reference it holds
> (ctrl->host_key) keeps the key alive. So I do not think
> nvme_keyring_link() and nvme_keyring_unlink() are needed for
> pre-provisioned keys.
> 
> Otherwise the design works for nvme-keysd: each authentication reads
> the key again, so a key the key manager updates in place reaches the
> next authentication.
> 
Yeah, linking keys was a bad idea. I'll remove it from the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
