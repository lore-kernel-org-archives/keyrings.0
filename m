Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516245;
	b=zufGbvGPRMbdSGY6y0DCbHa1wLeXx5mv70RFxlrBHQb5mGi9pL2yvACJ1NYoDMnHhRxx
	 741WbyM52lnUOcawIoglA0G0YnSCM4k2H9GOo9a5Ht/TaIaERsf0562DIxFL+N04p0DBW
	 vwUVQEJ5sLUqUjfb168Ixl+0pMgzNSdadFipm8acXF9YpIvHI7S024T2bM3whgkEP1p5P
	 G9adGFlZfUw/1XITBvwuM9EPsmLOIKToged6Lw1P3ljbWi4K/Kpndtt73ZOvQ6+h+xpzD
	 hIJekeRrZ64y9BbaFjakGTgyDc0K4GdWKLyjxJfpIDX+zRcLN6V0rF0pFvRewIKgBZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516245;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=h1Z0aG2ZB4ocZ0WSU3Ux+BgxwDtyBAIxvmuyQzy525E=;
	b=1l/9QtSGFwtj1SEZTX/I17y89XKmaBVLGCvWfji5ZuHiQySZjLRpa6hN97PKreHtJIZV
	 BiK/xJGAKcdJYZvJlD/l2e8LzC1/OdVyMqDMyDBGsSGDn/okHVkjLauHMkJAnIqWo9iR5
	 S1T/N2jIzXIz2/B5G54+3Yf7RFYK6wWeAqnLmvSRXg4TUaMV0yJkOLN0rM0ImnMBa9eL0
	 Y5dun5n/ABHnUHJC5SGRQaz4biqfPBvRery/CrOHrK95GBPAw5Xk+wWXulwtRV3QEuSN+
	 8hYPqX3OhFac1Mtst75GwUNPMNMP8pdweXhdkPGhmyWINGlXwb1x4EnzBLKskfXbWqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="Q/4wbPnO";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mhCOoaY0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="Q/4wbPnO";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mhCOoaY0;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D95606A32A;
	Tue, 24 Nov 2026 10:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D95606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Q/4wbPnO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mhCOoaY0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Q/4wbPnO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mhCOoaY0
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA4C2224C;
	Tue, 24 Nov 2026 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795516243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Z0aG2ZB4ocZ0WSU3Ux+BgxwDtyBAIxvmuyQzy525E=;
	b=Q/4wbPnOqeqTQ6XbsDvX9bCWCF1jmNuVKMDRe+WHvXh/LT3j8DPWPgV+iWikZfunR+YzXo
	FS+Q+03flkiUbzRaLZJpRd9H410ZWvO8oFLKikKMQHPoeZ3YYf+JwO4YBndgbEksBpLchy
	EJVkUAdTfuvMl0GCKGnJkFyrARUmk8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795516243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Z0aG2ZB4ocZ0WSU3Ux+BgxwDtyBAIxvmuyQzy525E=;
	b=mhCOoaY0RVM7radUWUxS2jAZZbJq4EzkQPXGf+VwkZxR0SP8q/0aWRJ5l2o4RN5QNeCiYf
	BA6BYZeVnAfHD6Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Q/4wbPnO";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mhCOoaY0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795516243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Z0aG2ZB4ocZ0WSU3Ux+BgxwDtyBAIxvmuyQzy525E=;
	b=Q/4wbPnOqeqTQ6XbsDvX9bCWCF1jmNuVKMDRe+WHvXh/LT3j8DPWPgV+iWikZfunR+YzXo
	FS+Q+03flkiUbzRaLZJpRd9H410ZWvO8oFLKikKMQHPoeZ3YYf+JwO4YBndgbEksBpLchy
	EJVkUAdTfuvMl0GCKGnJkFyrARUmk8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795516243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1Z0aG2ZB4ocZ0WSU3Ux+BgxwDtyBAIxvmuyQzy525E=;
	b=mhCOoaY0RVM7radUWUxS2jAZZbJq4EzkQPXGf+VwkZxR0SP8q/0aWRJ5l2o4RN5QNeCiYf
	BA6BYZeVnAfHD6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAC8C1339F;
	Tue, 24 Nov 2026 10:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZfqAHlJnBWtPCgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Nov 2026 10:30:42 +0000
Message-ID: <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
Date: Tue, 24 Nov 2026 11:30:42 +0100
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
To: Eric Biggers <ebiggers@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261123212105.GA18468@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EA4C2224C
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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

On 11/23/26 10:21 PM, Eric Biggers wrote:
> [ +Cc keyrings@vger.kernel.org ]
> 
> On Mon, Nov 23, 2026 at 06:10:00PM +0100, Hannes Reinecke wrote:
>> Hey all,
>>
>> the current NVMe authentication code is using a hand-crafted key
>> structure; idea was to have the initial implementation with a minimal
>> set of dependencies.
>> (And me not having a good grasp on how to use the kernel keyring :-)
>> That had the drawback that keys always had to be specified on the
>> nvme-cli commandline, which is far from ideal from a security standpoint.
>>
>> So this patchset switches the authentication code over to use the
>> kernel keyring. User-facing interface (namely argument to 'nvme
>> connect') remain the same, but the key data is converted into keys
>> which are stored as a new key type 'dhchap' with a random UUID as
>> description in the kernel keyring.
>>
>> With this I have updated the dhchap arguments to 'nvme connect' and
>> the configfs interface to either be the keydata (ie the original
>> interface) _or_ a key description referring to a pre-populated dhchap
>> key in the kernel keyring. This allows for easier provisioning of keys
>> and avoids the security risk from having to specify the key data on
>> the kernel commandline.
> [...]
>>   16 files changed, 1140 insertions(+), 386 deletions(-)
> 
> This should have been Cc'ed to the keyrings mailing list.  I found it
> via lore search.
> 
Oh, sorry. I had hoped that 'b4 --auto-cc-to' would cover it...

> As far as I can tell, this series is trying to do two main things:
> 
>      (1) parse secrets up front instead of keeping raw "DHHC-1:..."
>      strings around in 'opts' and 'nvmet_host'; and
> 
>      (2) let userspace reference pre-loaded keys in a keyring so
>      cleartext secrets don't have to live in config files or
>      sysfs/configfs 'show' output.
> 
> (Patch 7's flush_work() change looks independent of the rest.)
> 
Correct.

> Neither of those requires replacing 'struct nvme_dhchap_key' with
> 'struct key' at runtime, or synthesizing random-UUID keys in ".nvme"
> when raw secrets are passed.  Doing that adds a lot of complexity and
> opportunity for bugs (as Sashiko's review already seems to show), for no
> real gain.  Note that 'user_key_payload' still lives in slab memory just
> like 'struct nvme_dhchap_key' does.
> 
> The semantics of the keyrings subsystem just don't match storage very
> well, and it's quite hard to integrate with correctly.  In fscrypt, I
> had to deal with a lot of bugs before moving away from the keyrings
> subsystem almost entirely, due to issues with per-process keyring
> scoping, delayed key destruction, locking, and LSM checks.
> 
Hmm.

> This series already runs into the first of these: patches 8-9 use
> request_key(), which only searches the caller's process keyrings and
> won't even find ".nvme".  And keys are no longer wiped synchronously
> with kfree_sensitive(), but rather whenever the last reference is
> dropped and the garbage collector gets around to it.
> 
But I sincerely would hope that the key subsystem will wipe them 
correctly eventually, right?

> Note that NVMe-TCP TLS isn't a relevant precedent here, either.  TLS
> handshakes run in userspace (tlshd), which needs to read the PSK via
> keyctl, whereas DH-HMAC-CHAP is done entirely in-kernel.
> 
> This series also gives the 'dhchap' key type a ->read() method, so even
> pre-populated keys remain readable from userspace via keyctl_read() (by
> default, by any possessor).
> 
Which is kinda the main idea. And it's no different from the current
behaviour, where the DH-CHAP keys remain visible via sysfs.

> And inserting raw secrets into ".nvme" with KEY_USR_READ makes them
> readable via keyctl_read() by any process running as uid 0, even without
> CAP_SYS_ADMIN and without access to sysfs or configfs.  Due to the
> KEY_USR_* permissions on ".nvme" and the keys, such processes can also
> invalidate or revoke in-use keys, breaking authentication.  (Separately,
> the existing nvmet dhchap_key and dhchap_ctrl_key configfs attributes
> are 0644 world-readable, which should be fixed regardless.)
> 
Again, one could argue that this was the intention.
The idea behind this patchset is to separate key provisioning from
key usage; the DH-CHAP key values have to be present whenever the
nvme subsystem is doing a reset, and the current way of providing
them via the nvme-cli command-line requires quite some instrumentation
to insert the correct settings.
It also makes integration with other entities providing external
DH-CHAP keys quite hard as these entities have to deal not only with
the kernel side (to trigger re-authentication), but also the whatever
tooling is there to generate the nvme-cli commandline.

Moving to a separate storage for DH-CHAP keys hence seemed appealing
to me, especially as we already have a keyring integration, so adding
another key type for DH-CHAP felt quite a natural step.
And it allows for an easy integration with external key providers,
as adding keys to the key store is a quite simple process and
doesn't require you to integrate with nvme-cli tooling.

> How about keeping 'struct nvme_dhchap_key' as the runtime
> representation, and just parsing into it up front in 'opts' and
> 'nvmet_host'?  The sysfs/configfs 'show' methods could re-encode the
> secret if really needed, though not exposing it at all would be better.
> 
It really feels naff to have this structure. We already have
a 'struct key', providing basically all the features we need.

> Then if keyring-based provisioning is still wanted so config files don't
> need raw secrets, it could work like "fscrypt-provisioning" keys: define
> a write-only key type (no ->read(), ->update(), or ->revoke()), look up
> the key by serial number with lookup_user_key() once when the
> option/attribute is written, copy the decoded key (and description, if
> needed for 'show') into 'struct nvme_dhchap_key', and immediately
> key_put() it.
> 
The main idea here is to allow for external provisioning of the keys,
which then can be looked up by nvme-cli tooling to assemble the
actual command-line.
The write-only key method would leave us with an abstract key serial,
which then will have to be passed between the key provisioning tooling
over to nvme-cli. Which really doesn't gain us anything.

> Raw secrets wouldn't touch keyrings at all, and the keyrings subsystem
> would stay out of the runtime path.
> 
Main issue here is to keep compability with previous versions.We 
currently have 'dhchap_secret' and 'dhchap_ctrl_secret' sysfs
attributes holding the encoded DH-CHAP keys.
And these values are written to the configuration file to be
able to re-establish the connection upon the next boot.
So whatever we do, we need to have 'something' in here allowing
us to identify the DH-CHAP key. So a key serial is out of question
here (we tried that with TLS, and failed miserably).

So really we just use the keystore to be able to lookup external
keys; I really want to get away from having to store the keys
as a file or in encoded from in the configuration file.

And what other method is there?
I still like the keystore somewhat, even if it's quite overblown
for in-kernel usage.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
