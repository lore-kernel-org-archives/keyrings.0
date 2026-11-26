Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705730;
	b=XTGLzzp9zUGjj8DZg+SHtMtiue76gm5hxqBC1r2oVZQj/YUEd3iM6kDQIc/zTED76wyI
	 FridMOoCyPvp8O/V55sFyb3fwp9STR8+yZvMQI1AYQpHB6+pVRSk6uJm1yH181/4t3N+S
	 wiG16S8rk+6Ip6JM9c1IaM3ktwpl89DkqjXyG4LvpR2gwGLXeTg8rUi7xeDVJ+yXBputI
	 VuVWPK8eoMf99w66zUUYpjEU1iroJRWpSrYkwXEWKG2jEe3AgEqVAxWlXZ2awy4fcZHSN
	 r3cLqx8xw8hc9OzMcMFX1NYyJ/pvl7e3yWCSA4kiSlJEkCtagKz7jAK1vX45NhaaTCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705730;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=MYvlyPAzdLKxqcVB5WYrSd9FfMGIgTIGE8B18oKA6EM=;
	b=IbUJpai5z9gUYWtrpW1bdUf9vU1eF4owtFyhrOMmvQugGpcmzmWZj/4oTAzQ7MEBY9f8
	 oZDe9rW7oMDRBFLbP3xFzMrHWKcjisYS05uFCLqifKNmgjHumhuF7NQybFNOCFdiwqWpe
	 bNc6yNEqTcR9ShJpcyFTPeZKZudyX2OMyqziODzm2qGdB2Tq47z+Nf0CKrnoHvvslIcs2
	 SxSMX3Asj+F9w5VT7Y5ZE5J4UodRWeDTOhP6Dpg7HgJVeNEU2vpIeVUE+d7FvXv2sQ1TI
	 1AMcASNr5WjG0wYwdMcWnI2meEHuJYsn1FkWc+fuxWbJAfLfQWlwHsd1W21D/dglnHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B93VLq0v;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Dga5WfSu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B93VLq0v;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Dga5WfSu;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B85606A330
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 15:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B85606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B93VLq0v;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Dga5WfSu;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=B93VLq0v;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Dga5WfSu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B770022325;
	Thu, 26 Nov 2026 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795705726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYvlyPAzdLKxqcVB5WYrSd9FfMGIgTIGE8B18oKA6EM=;
	b=B93VLq0vZbgPYzYmTsuTjLaHgNcy4FLJxyTzmM0LKmUtMpalSAjEz/uIlsuZEP9d2QM2s5
	nofI8MrKhW+o8x7RuBRXeei/ckZX2IsyXX8b4tQelpUN32RaUJKGnBTSOyGIsWzWAF1zlW
	dlmwCbamZLNwyQmLTyf+n1CzcI1rCYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795705726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYvlyPAzdLKxqcVB5WYrSd9FfMGIgTIGE8B18oKA6EM=;
	b=Dga5WfSullacnGq4Q9XliNzLuVCbb10xL6hD8bJpbYTfzNipu7HOTLZRXG/c2oorW3msKD
	GE6hsrRBKBT3ppAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795705726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYvlyPAzdLKxqcVB5WYrSd9FfMGIgTIGE8B18oKA6EM=;
	b=B93VLq0vZbgPYzYmTsuTjLaHgNcy4FLJxyTzmM0LKmUtMpalSAjEz/uIlsuZEP9d2QM2s5
	nofI8MrKhW+o8x7RuBRXeei/ckZX2IsyXX8b4tQelpUN32RaUJKGnBTSOyGIsWzWAF1zlW
	dlmwCbamZLNwyQmLTyf+n1CzcI1rCYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795705726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYvlyPAzdLKxqcVB5WYrSd9FfMGIgTIGE8B18oKA6EM=;
	b=Dga5WfSullacnGq4Q9XliNzLuVCbb10xL6hD8bJpbYTfzNipu7HOTLZRXG/c2oorW3msKD
	GE6hsrRBKBT3ppAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 769F013432;
	Thu, 26 Nov 2026 15:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 45tuFH5LCGtjTgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 26 Nov 2026 15:08:46 +0000
Message-ID: <e56a0523-240c-460b-815b-16dde093e978@suse.de>
Date: Thu, 26 Nov 2026 16:08:45 +0100
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
Subject: Re: [PATCH v7 02/14] nvme-keyring: add 'dhchap' key type
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
 <20261126-dhchap-keyring-v4-v7-2-ee438ffea527@kernel.org>
 <sashiko-outbox-235714@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235714@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 11/26/26 3:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [Critical] nvme-keyring: out-of-bounds read in
>    nvme_dhchap_psk_preparse() via sscanf()
> - [Medium] nvme-keyring: nvme_dhchap_psk_read() returns -EINVAL when
>    buflen < keylen
> - [Medium] nvme-keyring: missing .update callback in
>    nvme_dhchap_psk_key_type
> - [Low] nvme-keyring: inverted kernel-doc for
>    nvme_dhchap_encoded_key_size()
> - [Low] nvme-keyring: unbounded kzalloc() in nvme_dhchap_psk_preparse()
> --
> 
> commit 96ec6bac915bae99bd1eb311a1d2b97cd0c724f7
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-keyring: add 'dhchap' key type
> 
> This commit registers a new dhchap key type to store DH-HMAC-CHAP secret
> keys with a user-type compatible payload and base64 read formatting.
> 
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index 87cb51e1f5a7f..de8dab10fa105 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
> [ ... ]
>> @@ -253,6 +256,205 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
>>   
>> +static void nvme_dhchap_psk_describe(const struct key *key, struct seq_file *m)
>> +{
>> +	seq_puts(m, key->description);
>> +	seq_printf(m, ": %u", key->datalen);
>> +}
>> +
>> +/**
>> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
>> + * @prep: preparsed payload of the key data
>> + *
>> + * Decode the DH-HMAC-CHAP key data passed in @prep and
>> + * store the resulting binary data. The binary data includes
>> + * space for the CRC, the version, and the hmac identifier,
>> + * but the data length is just the key data without the CRC.
>> + * This allows the user to read the key data via the
>> + * 'user_read()' function. The additional 'version' ahd 'hmac'
>> + * data is used in the ->read() callback to generate the
>> + * base64 encoded key.
>> + */
>> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
>> +{
>> +	struct user_key_payload *upayload;
>> +	size_t datalen = prep->datalen;
>> +	int ret = -EINVAL, offset = 0;
>> +	char *p;
>> +	u32 crc;
>> +	u8 version, hmac;
>> +
>> +	if (!prep->data || prep->datalen < 10) {
>> +		pr_debug("%s: Invalid key data", __func__);
>> +		goto out_err;
>> +	}
>> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
>> +		   &version, &hmac, &offset) != 2 || offset != 10) {
>> +		pr_debug("%s: invalid key header\n", __func__);
>> +		goto out_err;
>> +	}
> 
> [Severity: Critical]
> As reported by Martin Belanger on v5 [1], can sscanf() read past the end
> of prep->data?
> 
> add_key() copies plen bytes from userspace into prep->data without
> appending a NUL terminator:
> 
> security/keys/keyctl.c:SYSCALL_DEFINE5(add_key) {
>      ...
> 		payload = kvmalloc(plen, GFP_KERNEL);
> 		if (!payload)
> 			goto error2;
> 
> 		ret = -EFAULT;
> 		if (copy_from_user(payload, _payload, plen) != 0)
> 			goto error3;
>      ...
> }
> 
> Inside vsscanf(), each integer conversion calls skip_spaces() before
> parsing digits, which scans until a NUL byte and ignores prep->datalen.
> A non-NUL-terminated payload of 10 or more bytes starting with "DHHC-"
> or "DHHC-1:" followed by whitespace causes an out-of-bounds kernel memory
> read before the offset check runs.
> 
Fixed by allocating a temporary, NULL-terminated buffer.

>> +
>> +	if (version != 1 || hmac > 3) {
>> +		pr_debug("%s: invalid key version\n", __func__);
>> +		goto out_err;
>> +	}
>> +
>> +	/* skip header and final ':' character */
>> +	if (offset > prep->datalen) {
>> +		pr_debug("%s: invalid key data\n", __func__);
>> +		goto out_err;
>> +	}
>> +	datalen = prep->datalen - offset;
>> +	p = memchr(prep->data + offset, ':', datalen);
>> +	if (p) {
>> +		datalen = (p - (char *)prep->data);
>> +		datalen -= offset;
>> +	}
>> +
>> +	/*
>> +	 * payload is < key | version | hmac >
>> +	 * base64 decode will always return less data
>> +	 * than the encoded data, so allocating the size
>> +	 * of the encoded data will be large enough.
>> +	 */
>> +	upayload = kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
>> +	if (!upayload) {
>> +		ret = -ENOMEM;
>> +		goto out_err;
>> +	}
>> +
>> +	/* decode the data */
>> +	prep->payload.data[0] = upayload;
>> +	ret = base64_decode(prep->data + offset, datalen, upayload->data,
>> +			    true, BASE64_STD);
>> +	if (ret < 0) {
>> +		pr_debug("%s: Failed to decode key\n", __func__);
>> +		ret = -EINVAL;
>> +		goto out_free;
>> +	}
>> +	if (ret != 36 && ret != 52 && ret != 68) {
> 
> [Severity: Low]
> Should datalen be checked against the valid base64-encoded key lengths
> (48, 72, or 92 bytes) before calling kzalloc() and base64_decode()?
> 
> Because add_key() allows payloads up to almost 1 MiB, an oversized
> payload without an early trailing colon triggers a large physically
> contiguous GFP_KERNEL allocation and decodes the entire buffer before
> being rejected by the decoded length check.
> 
Added a check at the start to catch overly long keys.

> [ ... ]
> 
>> +/**
>> + * nvme_dhchap_encoded_key_size - Size of the base64-encoded key
>> + * @size: size of the encoded key
>> + *
>> + * Returns the expected size of the key after base64 decoding
>> + * include 4 bytes of CRC.
>> + */
>> +static inline int nvme_dhchap_encoded_key_size(int size)
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc for nvme_dhchap_encoded_key_size()
> has the input and return value reversed: @size is the raw decoded key
> length (32, 48, or 64 bytes, excluding the 4-byte CRC), and the return
> value is the base64-encoded length including the 4-byte CRC.  Also,
> nvme_dhchap_psk_describe() above is identical to nvme_tls_psk_describe()
> in the same file (and to user_describe()).
> 
Fixed with the next version.

> [ ... ]
> 
>> +static long nvme_dhchap_psk_read(const struct key *key,
>> +				 char *buffer, size_t buflen)
>> +{
>> +	const struct user_key_payload *upayload;
>> +	size_t datalen, keylen;
>> +	u8 version, hmac;
>> +	long ret;
>> +
>> +	upayload = user_key_payload_locked(key);
>> +	/*
>> +	 * Expected output string length:
>> +	 * strlen("DHHC-") +
>> +	 * version (= 1) +
>> +	 * ':' (= 1) +
>> +	 * hmac (= 2) +
>> +	 * ':' (= 1) +
>> +	 * encoded base64 key length +
>> +	 * ':' (= 1)
>> +	 */
>> +	ret = nvme_dhchap_encoded_key_size(upayload->datalen);
>> +	if (ret < 0)
>> +		return ret;
>> +	keylen = ret + 11;
>> +	if (!buffer || !buflen)
>> +		return keylen;
>> +	else if (buflen < keylen)
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Should nvme_dhchap_psk_read() return keylen instead of -EINVAL when
> buflen < keylen?
> 
> The key_type->read() contract and keyctl_read_key() expect ->read() to
> return the required size without copying whenever the caller's buffer is
> too small, so returning -EINVAL breaks keyctl(KEYCTL_READ) callers that
> probe the key size with a small non-NULL buffer.
> 
Fixed with the next version.

>> +
>> +	memset(buffer, 0, buflen);
>> +	version = upayload->data[upayload->datalen + 4];
>> +	hmac = upayload->data[upayload->datalen + 5];
>> +	ret = sprintf(buffer, "DHHC-%01hhu:%02hhu:", version, hmac);
>> +	if (ret < 0)
>> +		return -ENOKEY;
>> +	/* Include the trailing CRC */
>> +	datalen = upayload->datalen + 4;
>> +	ret += base64_encode(upayload->data, datalen, buffer + ret,
>> +			     true, BASE64_STD);
>> +	buffer[ret] = ':';
>> +	ret++;
>> +	return ret;
>> +}
>> +
>> +static struct key_type nvme_dhchap_psk_key_type = {
>> +	.name           = "dhchap",
>> +	.flags          = KEY_TYPE_NET_DOMAIN,
>> +	.preparse       = nvme_dhchap_psk_preparse,
>> +	.free_preparse  = user_free_preparse,
>> +	.instantiate    = generic_key_instantiate,
>> +	.revoke         = user_revoke,
>> +	.destroy        = user_destroy,
>> +	.describe       = nvme_dhchap_psk_describe,
>> +	.read           = nvme_dhchap_psk_read,
>> +};
> 
> [Severity: Medium]
> As reported by Martin Belanger on v6 [2], should nvme_dhchap_psk_key_type
> define .update = user_update?
> 
> Without .update, keyctl(KEYCTL_UPDATE) fails with -EOPNOTSUPP and
> add_key() allocates a new key with a different serial number instead of
> updating an existing dhchap key in place, breaking key rotation for
> controllers referencing a pre-provisioned key by serial number.  The
> later commit "nvme-auth: allow to update pre-provisioned keys" in this
> series mentions adding .update to the dhchap key type, but adds
> .update = user_update to nvme_tls_psk_key_type instead.
> 
> [1] https://lore.kernel.org/r/463a55e8-c2ef-4d83-94ff-7599c7d931e6@gmail.com
> [2] https://lore.kernel.org/r/a71a3d9f-0f19-45f4-bc98-a5663ad537b2@gmail.com
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
