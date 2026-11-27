Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774493;
	b=HumM9Xmih5EW7eCYwVU+3SlVBbKni/yi/8QF1ZKj22gzLtecSXmTOmOiNeT0dHtQ+IOn
	 T0e1uBtriW7/qp2nqumBztl1U/ec3dISypiEwYck9zecs3khN/33nQnToUIMbmjGDapdx
	 egdAJuustcZ2XgJotntoBhgzUTBG/EZCBzLhFEzNwbZ3oYCVrl3avq/qR7AScv6gOc87n
	 O7/y5ZMxXNShKpEvrFlvjapfIfdvNLRHkkh8HDkcVUYkaM7EKU/S8JP/0sjRUyTC1LGsu
	 Ox1+PtxxXAmzaRYSv/hUYbvDUr5cpVBYLy6PGOmV8Cf8iAM7TV/zLu821i8klBJhd9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774493;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=r9A6NR+BEmxL+j8pexTQFDWiFC8Yn4c1TefkuZ2mCAoEyNLKb+4vPIC1Y0zD30Qn5OvX
	 W2OcLMdZjmdRoNUHHkJOehoIhqufEV6igiRQZLrj7cHIDR8RM5Jvh/GiypFhUnvJb+UnO
	 04Z4g9SNAODCZerLIbqYEDO3eM1v9pBXxRaiHnvbpQ9k7YnQFMmsHMLfVqtqQZ1QORlAP
	 0iEJtDU+BkTK16nrWETtJKY/3xqNBcJ6I86rHPzzG0dfw4oWVzknfSuV2qh6Wwnu1VUz8
	 OB6z7rF4ZWUqaTbyrWRZQZg5hh21th4kuVFSkzmmgkHU7u/BDe5DljaWqx/sEjgJ6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ExYum4nB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RH8dXHS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ExYum4nB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RH8dXHS;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C860A3809
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 10:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 266C860A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ExYum4nB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RH8dXHS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ExYum4nB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RH8dXHS
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33CF51F813;
	Fri, 27 Nov 2026 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795774491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=ExYum4nBCF2yhW9z+pRPSTxQ2qDUkoh1MaukTrHQ79PfTB60spE3nkBvc1DVKRH29sJEFo
	2IU/I2S6S+S+IwylgbZ4JRlfjocmvMRz9hfB0mu46FEWFW+TBZ7vukOUoFXiRtB+CV7676
	v088bGVtXuzk1CkLZNxy648roigV5dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795774491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=8RH8dXHSVVOWyJYEqGUXTahEWOFIlYxfxW+L4Wis6UvTz/JddZIaln4cT2Z/GzLw7ef7oK
	rE8UhG1vXVeum6BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ExYum4nB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8RH8dXHS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795774491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=ExYum4nBCF2yhW9z+pRPSTxQ2qDUkoh1MaukTrHQ79PfTB60spE3nkBvc1DVKRH29sJEFo
	2IU/I2S6S+S+IwylgbZ4JRlfjocmvMRz9hfB0mu46FEWFW+TBZ7vukOUoFXiRtB+CV7676
	v088bGVtXuzk1CkLZNxy648roigV5dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795774491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=8RH8dXHSVVOWyJYEqGUXTahEWOFIlYxfxW+L4Wis6UvTz/JddZIaln4cT2Z/GzLw7ef7oK
	rE8UhG1vXVeum6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7836713432;
	Fri, 27 Nov 2026 10:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAyoABpYCWtBSgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 10:14:50 +0000
Message-ID: <4fa5e563-463c-4a45-bccc-00d2b2c947ce@suse.de>
Date: Fri, 27 Nov 2026 11:14:49 +0100
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
Subject: Re: [PATCH v7 12/14] nvme-fabrics: allow to pass in keyring by name
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
 <20261126-dhchap-keyring-v4-v7-12-ee438ffea527@kernel.org>
 <sashiko-outbox-235711@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235711@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33CF51F813
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
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50

On 11/26/26 3:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issues to consider:
> - [High] nvme-fabrics: NULL dereference and key leak in
>    nvmf_parse_options()
> - [High] nvme-fabrics: missing keyring link and key leak in
>    tls_keyring_store()
> - [High] nvme-fabrics: vmlinux link failure when CONFIG_NVME_KEYRING=m
> - [High] nvme-keyring: broken header stubs when CONFIG_NVME_KEYRING=n
> - [Medium] nvme-fabrics: unstripped newline in tls_keyring_store()
>    breaks lookup
> - [Medium] nvme-fabrics: missing key type and state checks in keyring ID
>    fallback
> - [Medium] nvme-fabrics: unsynchronized opts->keyring access in
>    tls_keyring_store()
> - [Low] nvme-fabrics: unreachable !keyring path in
>    nvme_tls_attrs_are_visible()
> --
> 
> commit cea520ca62b4a11b68d9d8f8ca9eeea627f871dd
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-fabrics: allow to pass in keyring by name
> 
> This commit allows specifying the fabrics keyring option by name in
> addition to serial number, enables the keyring option for all fabrics
> transports, and makes the tls_keyring sysfs attribute writable.
> 
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index bba6a4848f227..12a30ed16f9ef 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -663,8 +663,8 @@ static struct key *nvmf_parse_key(int key_id)
>>   {
>>   	struct key *key;
>>   
>> -	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> -		pr_err("TLS is not supported\n");
>> +	if (!IS_ENABLED(CONFIG_NVME_KEYRING)) {
>> +		pr_err("nvme keyring is not supported\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
> 
> [Severity: High]
> Can this fail to link vmlinux when CONFIG_NVME_KEYRING=m?
> 
> IS_ENABLED(CONFIG_NVME_KEYRING) is true when NVME_KEYRING is a module,
> while NVME_FABRICS in drivers/nvme/host/Kconfig only selects NVME_KEYRING
> if NVME_TCP_TLS is enabled.  If CONFIG_NVME_FABRICS=y (with
> CONFIG_NVME_TCP_TLS=n and CONFIG_NVME_HOST_AUTH=n) and
> CONFIG_NVME_KEYRING=m (for example via CONFIG_NVME_TARGET=m), built-in
> fabrics.o references nvme_tls_key_lookup() and nvme_keyring_link() in
> nvme-keyring.ko.  Similarly, when CONFIG_NVME_CORE=y, CONFIG_NVME_TCP=m,
> and CONFIG_NVME_TCP_TLS=y, NVME_FABRICS=m selects CONFIG_NVME_KEYRING=m,
> so built-in drivers/nvme/host/sysfs.o fails to link against
> nvme_keyring_name() and nvme_keyring_unlink().
> 
Modified Kconfig selection to include NVME_AUTH when selecting NVME_KEYRING

> [ ... ]
> 
>> @@ -993,14 +995,24 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   			opts->tos = token;
>>   			break;
>>   		case NVMF_OPT_KEYRING:
>> -			if (match_int(args, &key_id) || key_id <= 0) {
>> -				ret = -EINVAL;
>> +#if IS_ENABLED(CONFIG_NVME_KEYRING)
>> +			p = match_strdup(args);
>> +			if (!p) {
>> +				ret = -ENOMEM;
>>   				goto out;
>>   			}
>> -			key = nvmf_parse_key(key_id);
>> +			key = request_key(&key_type_keyring, p, NULL);
>> +			kfree(p);
>>   			if (IS_ERR(key)) {
>> -				ret = PTR_ERR(key);
>> -				goto out;
>> +				if (match_int(args, &key_id) || key_id <= 0) {
>> +					ret = -EINVAL;
>> +					goto out;
>> +				}
>> +				key = nvmf_parse_key(key_id);
>> +				if (IS_ERR(key)) {
>> +					ret = PTR_ERR(key);
>> +					goto out;
>> +				}
>>   			}
>>   			ret = nvme_keyring_link(opts->keyring);
>>   			if (ret) {
>> @@ -1008,6 +1020,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   				goto out;
>>   			}
>>   			opts->keyring = key;
>> +#endif
>>   			break;
> 
> [Severity: High]
> Does nvme_keyring_link(opts->keyring) pass NULL instead of the newly
> looked-up key?
> 
> On the first keyring= option, opts->keyring is NULL, so
> nvme_keyring_link(NULL) calls key_link(nvme_keyring, NULL) ->
> __key_link_lock(), triggering a NULL pointer dereference on
> index_key->type with nvme_keyring->sem held write-locked.  If keyring= is
> specified more than once in the option string, the previous opts->keyring
> is also overwritten without being unlinked or released with key_put().
> 
Fixed with the next version.

> [Severity: High]
> Does guarding this block with #if IS_ENABLED(CONFIG_NVME_KEYRING) expose
> broken stubs in include/linux/nvme-keyring.h when CONFIG_NVME_KEYRING=n?
> 
Fixed by modifying Kconfig selection in the next patch.

> include/linux/nvme-keyring.h {
>      ...
> static const char *nvme_keyring_name(void)
> {
> 	return NULL;
> }
> static int nvme_keyring_link(struct key *keyring)
> {
> 	return 0;
> }
> int nvme_keyring_unlink(struct key *keyring)
> {
> 	return 0;
> }
>      ...
> }
> 
> When CONFIG_NVME_KEYRING is disabled, nvme_keyring_unlink() is defined as
> a non-static function in the header, causing multiple-definition linker
> errors across fabrics.o, sysfs.o, and tcp.o, while the non-inline static
> nvme_keyring_link() stub becomes unused in fabrics.c and triggers
> -Wunused-function.
> 
Fixed with the next version.

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 4ebc03a8ddcae..0ffea12fcfb6b 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -1212,7 +1212,38 @@ static ssize_t tls_keyring_show(struct device *dev,
>>   		return sysfs_emit(buf, "%s\n", nvme_keyring_name());
>>   	return sysfs_emit(buf, "%s\n", keyring->description);
>>   }
>> -static DEVICE_ATTR_RO(tls_keyring);
>> +
>> +static ssize_t tls_keyring_store(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct key *keyring = ctrl->opts->keyring;
>> +	int ret;
>> +
>> +	keyring = request_key(&key_type_keyring, buf, NULL);
> 
> [Severity: Medium]
> Does passing buf directly to request_key() without stripping a trailing
> newline break keyring lookup by name from sysfs?
> 
> Writes such as "echo my_keyring > tls_keyring" pass "my_keyring\n" to
> request_key(), which fails with -ENOKEY and falls through to kstrtoul(),
> returning -EINVAL.  Other sysfs handlers in this file (such as
> dhchap_secret_store()) strip the trailing newline with strcspn(buf, "\n").
> 
Dropped this hunk from the next version, so all reviews to this function
no longer apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
