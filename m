Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765213;
	b=tkGwngE9vNSGjMMpK33MFNxXd4ucsCtSA+Sv4+W1le1VbKfdSOEpDihdUSzlzyex2Oqe
	 Q1/ky4G3ew1dXf0Qy613AcSULpGFma30e5NEM8pR4HsM20rB1nAjNwYY2LsGIVN7p8Pst
	 57b3FrRlkF56UihKS5jCI863zCl+zyhDEUL0O1F1mc4jGfBq2gvW1sF8tIboyjTSaJ1S2
	 y6QVpDMnXFwdNCwzgYZr75yoUFZvaqosJ3sNPgkfzUnShmbjAy0xl+aT+dfH3pOgfoRrp
	 /oZNlBNL75eHKcVaUT+onI9fW7Un95sE49Gkv/uOnPieg8YfgB17FGCPhZVzRc1HAjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765213;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=G6McPl9ZwOwzmOlTH2p43RSWFYYnSfyuOsr57EW7Dm5L+MnpMspj1COXC+yJY7M8nizd
	 lBpsO6NxBTD27pULWpJDJicampmGtLuM9V3KP1yDfWMU9Rd6VeMQFs4H16Fq6dpjxae3x
	 7XPKH/uheuEiHzgjsbqHv3XR3HXDrjnSp6tzwXUHT5Qkk+jml1I5uYWF0bWBBfUKo1oud
	 8PJ2Gc56vEzzuKMr1ptguWSN3ZrFUN/2c54QbrNk9XDpdUU1tLaOZu/9gtHs3bMHG6SSZ
	 5c1E4J2AOfcpks5ZzeW58gcsXPqq5r2u9jd0v0rhRvn7zdIm0Fj2w2PVAmRUZP0hASg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ECgggU4n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lojZlJUN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ECgggU4n;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lojZlJUN;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F28606A321
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 07:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35F28606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ECgggU4n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lojZlJUN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ECgggU4n;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lojZlJUN
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0112422730;
	Fri, 27 Nov 2026 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795765210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=ECgggU4nl9i3bvBsUBxSL/BP/CP9EiDhq4CHetH50PmsSNTt/Ijf6doVLrtOXtbQoKUjqO
	yxKRwFgT4yX777PxlYOSAtJY94pAevPde2c13Ox07vGs5QoE9njNDwvN3Tjh8b4QzhDMtJ
	HIf38hm5/uMlzkaspqLAB10J4w/swN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795765210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=lojZlJUNUug0DXDEtJ1/TXChzeN7otMLnlvWmQ5djZ05I4b34NawMERk2AzmxIJ6fKMmtf
	T+vW+vhkfje6s+AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ECgggU4n;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lojZlJUN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795765210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=ECgggU4nl9i3bvBsUBxSL/BP/CP9EiDhq4CHetH50PmsSNTt/Ijf6doVLrtOXtbQoKUjqO
	yxKRwFgT4yX777PxlYOSAtJY94pAevPde2c13Ox07vGs5QoE9njNDwvN3Tjh8b4QzhDMtJ
	HIf38hm5/uMlzkaspqLAB10J4w/swN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795765210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seaj0QlYAAGKFYCPwjvkTKuTijkUp2U+E5U19NldKYg=;
	b=lojZlJUNUug0DXDEtJ1/TXChzeN7otMLnlvWmQ5djZ05I4b34NawMERk2AzmxIJ6fKMmtf
	T+vW+vhkfje6s+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6539C13432;
	Fri, 27 Nov 2026 07:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SXQCEdkzCWtZLQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 07:40:09 +0000
Message-ID: <1485af79-af07-4b6f-82dc-f2f442cd9686@suse.de>
Date: Fri, 27 Nov 2026 08:40:00 +0100
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
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
 <sashiko-outbox-235701@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235701@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0112422730
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50

On 11/26/26 3:27 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme-auth: ERR_PTR dereference after key_lookup() in show and
>    init helpers
> - [Medium] nvmet-auth: wrong generated flag updated in
>    nvmet_auth_update_key()
> --
> 
> commit 23f2a5a7beef9101cd52fed1a3096af44469d991
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: allow to pass in key description as dhchap secret
> 
> This commit updates nvme_auth_extract_key() to look up pre-populated
> keys by description in addition to generating keys from raw secret data,
> and tracks whether keys were auto-generated so pre-populated keys are
> not revoked on teardown.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index ff0e8569d7067..54e79c8a7cae6 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -20,31 +20,38 @@
>>   #include "nvmet.h"
>>   
>>   static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
>> -				  struct key *new_key)
>> +				  struct key *new_key, bool new_generated)
>>   {
>>   	key_serial_t old_key_id = 0, new_key_id = key_serial(new_key);
>>   	struct key *key = NULL;
>> +	bool generated = false;
>>   
>>   	if (set_ctrl) {
>>   		if (host->dhchap_ctrl_key) {
>>   			if (host->dhchap_ctrl_key == new_key_id) {
>> -				if (new_key)
>> +				if (new_key && new_generated)
>>   					key_revoke(new_key);
>>   				return;
>>   			}
>>   			old_key_id = host->dhchap_ctrl_key;
>> +			generated = host->dhchap_ctrl_key_generated;
>> +			host->dhchap_ctrl_key_generated = false;
>>   		}
>>   		host->dhchap_ctrl_key = new_key_id;
>> +		host->dhchap_key_generated = new_generated;
> 
> [Severity: Medium]
> Should the set_ctrl branch update host->dhchap_ctrl_key_generated instead
> of host->dhchap_key_generated?
> 
> As written, host->dhchap_ctrl_key_generated remains false, so
> nvmet_host_dhchap_ctrl_key_show() prints the internal UUID description
> instead of the secret for auto-generated controller keys and replacing or
> clearing the controller key never revokes it.  At the same time, setting
> or clearing the controller key overwrites host->dhchap_key_generated,
> which can cause a pre-populated host key to be revoked or an
> auto-generated host key to be leaked.
> 
Fixed with the next version.

> [ ... ]
> 
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index f6bfda757f076..3defa3f948497 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -2248,13 +2248,15 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
>>   		down_read(&key->sem);
>>   		if (key_validate(key))
>>   			ret = sprintf(page, "<invalidated>\n");
>> -		else {
>> +		else if (host->dhchap_key_generated) {
>>   			ret = key->type->read(key, page, PAGE_SIZE);
>>   			if (ret > 0) {
>>   				page[ret] = '\n';
>>   				ret++;
>>   			}
>> -		}
>> +		} else
>> +			ret = scnprintf(page, PAGE_SIZE,
>> +					"%s\n", key->description);
>>   		up_read(&key->sem);
>>   		key_put(key);
>>   	}
> 
> [Severity: High]
> Can nvmet_host_dhchap_key_show() and nvmet_host_dhchap_ctrl_key_show()
> dereference an error pointer when the key is unset or has been unlinked?
> 
> drivers/nvme/target/configfs.c:nvmet_host_dhchap_key_show() {
> 	down_read(&nvmet_config_sem);
> 	key = key_lookup(host->dhchap_key);
> 	if (!key) {
> 		page[0] = '\0';
> 		ret = 0;
> 	} else {
> 		down_read(&key->sem);
> ...
> }
> 
> key_lookup() returns ERR_PTR(-ENOKEY) rather than NULL when a key serial
> is not found (including when host->dhchap_key is 0), so the !key check
> falls through to the else branch and dereferences ERR_PTR(-ENOKEY) in
> down_read(&key->sem).  nvme_auth_init_ctrl() and nvmet_setup_auth() also
> check !host_key and !ctrl_key instead of IS_ERR() after key_lookup(),
> which can similarly oops if a pre-populated key was unlinked after option
> or configfs parsing dropped its reference.
> 
Already fixed with updates to the previous patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
