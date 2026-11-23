Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468868;
	b=Wo40W56qrHg++kbcZeR5OcwOOxfcdLzyu2LKiKnhh1u4xQsbd/e97Fs8jux7dNK9YLPs
	 OPvTJMg1OTMBde9psuQdr3Hzpw2V7+CRU9DA8aDRn+Pg7lw9bj3/FIlQxTZ/4qstI+4n0
	 hgeu5tK9NoVNQ7ILE2rVxZki1pCgVomB0g62NJ4B1LhwmyEwTs/Xiv0L6jbxdHPKJIZ4r
	 omFdjJNLKvTQov16cMkLGuXDY5f8xVQ1EucW1YWg5iKMD1grM21ch11Ka5dGyIIRD4/x/
	 SSSuW1OTIQD74MADyW0eXtC5Naq7rJSdqqMepsXVBSPzCWlZo3t5RCfuBCsdk0hNI0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468868;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oK69RON+lsCt00ViP4o69fvdYWZ6O8Adv4O6ypLAgdk=;
	b=lABq96HKZW2ujy4Xd2BQdD+AF7CdtiUqLi7iNyNJ2A6ykfUuV3zbCKjdOasXkkykLB//
	 EAiwLwiU/M86wVy/8Touk4R1EEPVa2jjYxuF4vclLGf49KvwLW8ulDPY85qNjFdtnRZDM
	 LAXQGsnogKoCFrqhQVvjHhMa8YZ/cniOWjznTT47P8dqyCHZtnHWCxYhP7lqPuho6lSRU
	 Kb9+/pfNLCwjcms0M2kZjnXVX3BXvJ5dDySONAY9VGglmlLUj5PMqbkAW3pBA6EUe8rVh
	 elkERidE4rFsWCkrml5mTTw+x2hUiQ5oq43y5RM2Z4C/focm6LBL3e4C4n5f6E+fwGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7v5HFrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E359606A31E;
	Mon, 23 Nov 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7v5HFrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A1E1F000C0;
	Mon, 23 Nov 2026 21:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468867;
	bh=oK69RON+lsCt00ViP4o69fvdYWZ6O8Adv4O6ypLAgdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7v5HFrdX453GUoX1AkV9s3bworAQ4Z9Vz8MM83NcgW9jAZyG2cPfzrke4f65hOjr
	 nMXfvS8nwJiRG7/buZ5j4im7v4vHTk2K77zB6brcTxvdaI+gnyj+c7GQd7zMRINk6H
	 F8pZX0S+0I2pmcsiMsTd7s+Nw7Dc6iZjUZAaXBrmIXYMmQHdAN4Ru+ybK1pM/l3Am3
	 VpBqNmU996R7gqDAvBdo5M0qTYVDe9GMVXfYPAugt5QsvIj3S6EryKXE1jGJsBt+B6
	 jCobdoJsrc27tfktCHbxurRDhXcieLMgp/xlukYErj7DqFIPf1/PvWzT5crlZ6i2kl
	 eeolWwu2pFrfg==
Date: Mon, 23 Nov 2026 21:21:05 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <20261123212105.GA18468@google.com>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>

[ +Cc keyrings@vger.kernel.org ]

On Mon, Nov 23, 2026 at 06:10:00PM +0100, Hannes Reinecke wrote:
> Hey all,
> 
> the current NVMe authentication code is using a hand-crafted key
> structure; idea was to have the initial implementation with a minimal
> set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the
> nvme-cli commandline, which is far from ideal from a security standpoint.
> 
> So this patchset switches the authentication code over to use the
> kernel keyring. User-facing interface (namely argument to 'nvme
> connect') remain the same, but the key data is converted into keys
> which are stored as a new key type 'dhchap' with a random UUID as
> description in the kernel keyring.
> 
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface) _or_ a key description referring to a pre-populated dhchap
> key in the kernel keyring. This allows for easier provisioning of keys
> and avoids the security risk from having to specify the key data on
> the kernel commandline.
[...]
>  16 files changed, 1140 insertions(+), 386 deletions(-)

This should have been Cc'ed to the keyrings mailing list.  I found it
via lore search.

As far as I can tell, this series is trying to do two main things:

    (1) parse secrets up front instead of keeping raw "DHHC-1:..."
    strings around in 'opts' and 'nvmet_host'; and

    (2) let userspace reference pre-loaded keys in a keyring so
    cleartext secrets don't have to live in config files or
    sysfs/configfs 'show' output.

(Patch 7's flush_work() change looks independent of the rest.)

Neither of those requires replacing 'struct nvme_dhchap_key' with
'struct key' at runtime, or synthesizing random-UUID keys in ".nvme"
when raw secrets are passed.  Doing that adds a lot of complexity and
opportunity for bugs (as Sashiko's review already seems to show), for no
real gain.  Note that 'user_key_payload' still lives in slab memory just
like 'struct nvme_dhchap_key' does.

The semantics of the keyrings subsystem just don't match storage very
well, and it's quite hard to integrate with correctly.  In fscrypt, I
had to deal with a lot of bugs before moving away from the keyrings
subsystem almost entirely, due to issues with per-process keyring
scoping, delayed key destruction, locking, and LSM checks.

This series already runs into the first of these: patches 8-9 use
request_key(), which only searches the caller's process keyrings and
won't even find ".nvme".  And keys are no longer wiped synchronously
with kfree_sensitive(), but rather whenever the last reference is
dropped and the garbage collector gets around to it.

Note that NVMe-TCP TLS isn't a relevant precedent here, either.  TLS
handshakes run in userspace (tlshd), which needs to read the PSK via
keyctl, whereas DH-HMAC-CHAP is done entirely in-kernel.

This series also gives the 'dhchap' key type a ->read() method, so even
pre-populated keys remain readable from userspace via keyctl_read() (by
default, by any possessor).

And inserting raw secrets into ".nvme" with KEY_USR_READ makes them
readable via keyctl_read() by any process running as uid 0, even without
CAP_SYS_ADMIN and without access to sysfs or configfs.  Due to the
KEY_USR_* permissions on ".nvme" and the keys, such processes can also
invalidate or revoke in-use keys, breaking authentication.  (Separately,
the existing nvmet dhchap_key and dhchap_ctrl_key configfs attributes
are 0644 world-readable, which should be fixed regardless.)

How about keeping 'struct nvme_dhchap_key' as the runtime
representation, and just parsing into it up front in 'opts' and
'nvmet_host'?  The sysfs/configfs 'show' methods could re-encode the
secret if really needed, though not exposing it at all would be better.

Then if keyring-based provisioning is still wanted so config files don't
need raw secrets, it could work like "fscrypt-provisioning" keys: define
a write-only key type (no ->read(), ->update(), or ->revoke()), look up
the key by serial number with lookup_user_key() once when the
option/attribute is written, copy the decoded key (and description, if
needed for 'show') into 'struct nvme_dhchap_key', and immediately
key_put() it.

Raw secrets wouldn't touch keyrings at all, and the keyrings subsystem
would stay out of the runtime path.

- Eric
