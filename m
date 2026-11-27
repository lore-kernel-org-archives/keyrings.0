Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764899;
	b=e5aMfWCnLAQr7ffz6MrIAbt3e9FPaA6mO1MApUXEm32CFHTL8AeNzaHmmC9s6OvwS7Zq
	 M1B/gi/41Jf30Z2HE5z0rBFNp49t8CfUynR3kE4xb/cfv6AEEKrDLjcXyTekeVRTCjZzp
	 iUTWAUlSV1YULIVvm3bDG+hmrTt/feaICvlPV0b5riWxsrTGnZ05RycP0a0EMSssIxibn
	 LKcszejon874EMK4IgRkcr/eKTB5aKZe8ot9MLPAkpfqgI1vC/1o9vazPQ/cGmYpV3nca
	 vqUH4NoVj7i3Adu1uTuCP+g2PZ+R1F8SSt8fF2pA3n+dQWZMNvv2zWW+cgt78x84tcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764899;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=dsP/AfyNUt09/fSh00asghRQCOnJYX9a0AsRu8e9/2627Mps3LIldfk4hWTijGuYFlgO
	 HEIWr8da28yf3ytM7OJV+X3k3AAc8E+L0uOj8YjbbvBPoWTeY8x1/m0PvdESSJ9h7Xngo
	 QNIBkCf0oY++zLldhMLOu8B9GtyR4RZ5l1UQveoPhEZuCA81rUw8i2qttySEx8Ab2x0iq
	 hxZgynIarkZbqPVlUIJmNAd2fiRGggw/R+S5ilFu+sxrfCq3O+2VRB7a4CnwGdvSbNL1x
	 VSlqBj90bN055eQwKhXWdENxxl3YOPM/L/O+FxxH1121Se4eoZPkpVGKs5Eh0iPkFpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTYuFEyp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UL4k7IZT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTYuFEyp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UL4k7IZT;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610E606A31E
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 07:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4610E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTYuFEyp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UL4k7IZT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTYuFEyp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UL4k7IZT
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8724422847;
	Fri, 27 Nov 2026 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=ZTYuFEyp0O6eFBgB/uufgy9Hde4Cuq2M6nFh22BRBoac89MK/Ggn/3f1YXQi9BB21xSw7g
	myZ5gJR96Ei6d1O1AZQJ+P9G4qzHNnwJqEA9sknfJl0DcSIN6NWaBnsAJ7jwe30byGE2DS
	aHl3kVCvUZEcY9liXuOhJyCy5K7cFoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=UL4k7IZTozHVaUV85Gta+JabDHiwk5FwpfCbUOER0vDlU9eI+UKmxibIocQGEVb7zWvef8
	FxomVih/Ul5WgWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=ZTYuFEyp0O6eFBgB/uufgy9Hde4Cuq2M6nFh22BRBoac89MK/Ggn/3f1YXQi9BB21xSw7g
	myZ5gJR96Ei6d1O1AZQJ+P9G4qzHNnwJqEA9sknfJl0DcSIN6NWaBnsAJ7jwe30byGE2DS
	aHl3kVCvUZEcY9liXuOhJyCy5K7cFoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=UL4k7IZTozHVaUV85Gta+JabDHiwk5FwpfCbUOER0vDlU9eI+UKmxibIocQGEVb7zWvef8
	FxomVih/Ul5WgWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E117913432;
	Fri, 27 Nov 2026 07:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y7UfKKAyCWsgKAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 07:34:56 +0000
Message-ID: <14ae3e78-ac9b-4bb8-99f1-a29a28d5984d@suse.de>
Date: Fri, 27 Nov 2026 08:34:56 +0100
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
Subject: Re: [PATCH v7 08/14] nvmet-auth: parse dhchap key from configfs
 attribute
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-8-ee438ffea527@kernel.org>
 <sashiko-outbox-235707@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235707@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 11/26/26 3:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] nvmet-auth: ERR_PTR dereference in key_lookup() callers
> --
> 
> commit b41d5ff16da6a60366fa816c551dfd75334950eb
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet-auth: parse dhchap key from configfs attribute
> 
> This commit converts the nvmet DH-HMAC-CHAP configfs attributes to store
> key serial numbers in struct nvmet_host and look up the keys via
> key_lookup() when needed.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index e1d92f5455219..ff0e8569d7067 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
> 
> [ ... ]
> 
>> @@ -186,22 +212,45 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
>>   		goto out_unlock;
>>   	}
>>   
>> -	if (!host->dhchap_secret) {
>> +	if (!host->dhchap_key) {
>>   		pr_debug("No authentication provided\n");
>>   		goto out_unlock;
>>   	}
>>   
>> -	host_key = nvme_auth_extract_key(host->dhchap_secret,
>> -					 strlen(host->dhchap_secret));
>> -	if (IS_ERR(host_key)) {
>> +	host_key = key_lookup(host->dhchap_key);
>> +	if (!host_key) {
>> +		pr_warn("%s: host key %08x not found\n",
>> +			__func__, host->dhchap_key);
>>   		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>>   		goto out_unlock;
>>   	}
>> -	if (host->dhchap_ctrl_secret) {
>> -		ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret,
>> -						 strlen(host->dhchap_ctrl_secret));
>> -		if (IS_ERR(ctrl_key)) {
>> +	down_read(&host_key->sem);
>> +	ret = key_validate(host_key);
>> +	up_read(&host_key->sem);
>> +	if (ret) {
>> +		pr_warn("host key %08x invalidated\n",
>> +			host->dhchap_key);
>> +		key_put(host_key);
>> +		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +		goto out_unlock;
>> +	}
>> +	if (host->dhchap_ctrl_key) {
>> +		ctrl_key = key_lookup(host->dhchap_ctrl_key);
>> +		if (!ctrl_key) {
>> +			pr_warn("%s: ctrl key %08x not found\n",
>> +				__func__, host->dhchap_ctrl_key);
>> +			key_put(host_key);
>> +			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +			goto out_unlock;
>> +		}
>> +		down_read(&ctrl_key->sem);
>>   
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index ff3a8d74de599..f6bfda757f076 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
> 
> [ ... ]
> 
>> @@ -2234,15 +2235,29 @@ static struct config_group nvmet_ports_group;
>>   static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
>>   		char *page)
>>   {
>> -	char *dhchap_secret;
>> +	struct nvmet_host *host = to_host(item);
>> +	struct key *key;
>>   	ssize_t ret;
>>   
>>   	down_read(&nvmet_config_sem);
>> -	dhchap_secret = to_host(item)->dhchap_secret;
>> -	if (!dhchap_secret)
>> -		ret = sprintf(page, "\n");
>> -	else
>> -		ret = sprintf(page, "%s\n", dhchap_secret);
>> +	key = key_lookup(host->dhchap_key);
>> +	if (!key) {
>> +		page[0] = '\0';
>> +		ret = 0;
>> +	} else {
>> +		down_read(&key->sem);
> 
> [ ... ]
> 
>> @@ -2267,15 +2292,29 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
>>   static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
>>   		char *page)
>>   {
>> -	char *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
>> +	struct nvmet_host *host = to_host(item);
>> +	struct key *key;
>>   	ssize_t ret;
>>   
>>   	down_read(&nvmet_config_sem);
>> -	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
>> -	if (!dhchap_secret)
>> -		ret = sprintf(page, "\n");
>> -	else
>> -		ret = sprintf(page, "%s\n", dhchap_secret);
>> +	key = key_lookup(host->dhchap_ctrl_key);
>> +	if (!key) {
>> +		page[0] = '\0';
>> +		ret = 0;
>> +	} else {
>> +		down_read(&key->sem);
> 
> [Severity: High]
> Should the key_lookup() checks in nvmet_setup_auth(),
> nvmet_host_dhchap_key_show(), and nvmet_host_dhchap_ctrl_key_show() use
> IS_ERR() instead of testing for NULL?
> 
> key_lookup() returns ERR_PTR(-ENOKEY) when a key serial is not found
> (including when dhchap_key or dhchap_ctrl_key is 0 because no key is
> configured).  Checking !key lets ERR_PTR(-ENOKEY) through and crashes at
> down_read(&key->sem) when reading the configfs attributes on a host
> without a key configured or when a key is not found during
> authentication setup.
> 

Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
