Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555944;
	b=I4ji+UpHeRWmoq1r8QotN4xq1OdIweZW0TTl7tU6ssJcqhL3r83U4fpMj0asQqDjl4f/
	 6Eu41JQHavFZUJ70yKwcyBy0erNQalJ3hW+1Tjzrq1Ipow1EE3yTpbM8MugLckdBghr3Y
	 tIdyhb12PlusIXP4gEpqTcW73MIA9N/6WxGxuxy+17NzkZ9DS539ahux79EYZ8/CeaTpK
	 XjZpBcxNG9gYQZNHXzcU/XpaZqnflEIDGZSSs+yxIQKlVsh165EkWQ4XhpKJsa4OBekCj
	 dCmjfmeseIe7HwY1lRqFCeRu7ZxhJzuH1HVJBdSSwhNy/lqoWyqSnYR35p3Jxx9DY7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pxCVoM8sZVyMKnjJ/b022SiYasxrgvXvq5CHraLjb1M=;
	b=3zYmVyiwp1Gcch/VvKQ8nIncjJTQTL+3ECHnGwwJWphkyOIcY9ziq90BNVFNK8EbSauG
	 yoN+OLyIMoidAP3jlX1ujUhBDzXHQWBkDmTfFGt2Nu9HfpiCQ7OKS/4PmKmCRwTUopSGc
	 H4lrZPyg04k6Cx32YVs+lOMg8MhpDiEDP/39P4cSOffr1pxMYJNyt6NbeZaEz8syEjhSr
	 5r1a3sCx9AyEOs5hj9XXYiwxEuIFqhwfJwNE2DbgoL7KrzQw+qDmHpvP4W7Upc/99qSri
	 WVtfEIpzdY7rh1HcPD1q7mw8D1yvgqhAZ+h4DqsOVvQ6GKzQBba1kTHrcupLu2sCy2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oQjn/bus";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCA606A333;
	Tue, 24 Nov 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQjn/bus
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E81F000C6;
	Tue, 24 Nov 2026 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795555943;
	bh=pxCVoM8sZVyMKnjJ/b022SiYasxrgvXvq5CHraLjb1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oQjn/buspK+FsKyIqdVIEeQgGWGRa+2OaMKzQCzkGixU0KkDDN+dSgXo8I2DXx8i1
	 K4ve8D76M7hbTnWb1QJpojstKh0C+zhHT/21Gak4Lvlh/vkcoYG+IGfnbTmO0fXq6Q
	 6emK9uqekBpNHhNsJr6vlcVQdu4+pAbEHLLuGT6cZu/RekuvB0l0pUv1KqBz1CiHQR
	 9UouIwYolzuRBLbd0yim8GAXYi7FntbMnTo+FcXEYv2rYVc9oN7b0UT8VutWS6Z8at
	 ksWuNE4XoCltAvJ0XAJpfTSBdcLHVYn3sMx67Kg/Kk0CH0nFMcWgoYge+2vdQwN08z
	 Upj6oC2vty6Iw==
Date: Tue, 24 Nov 2026 21:32:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Martin Belanger <martin.nvme.dev@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <20261124213222.GD2227373@google.com>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
 <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
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
In-Reply-To: <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>

On Tue, Nov 24, 2026 at 03:50:14PM -0500, Martin Belanger wrote:
> On 11/24/26 15:11, Eric Biggers wrote:
> > Keys not being readable from userspace is one of the usual reasons
> > people think they want to use the keyrings.  The cover letter should say
> > what this series is actually trying to accomplish.  Currently, it only
> > mentions making it so that keys no longer need to be specified on the
> > command line.  But when stated like that, it's a userspace issue: if the
> > nvme program doesn't accept keys on stdin like keyctl does, that's an
> > issue in the nvme program, not the kernel.
> 
> The goal from the user side is that no DH-HMAC-CHAP secret appears on a
> command line, in a connect string or in a configuration file. These end
> up in shell scripts, config files and logs, where unprivileged users can
> read them. With the keyring, the configuration only names the key.
> nvme-keysd (in nvme-cli) imports the secrets into the keyring from
> systemd credentials or from a KMS, and the connection passes only the
> key description.

That is a userspace issue though, unless you also need the key to be
kept out of the /dev/nvme-fabrics connect string or sysfs/configfs show
output.  Note that this patchset also keeps the keyring keys readable by
userspace still.

> > It sounds like the idea is that the kernel would look up the 'struct
> > key' by description again at runtime, such as on reset?  But this series
> > doesn't actually do that.  The lookup just happens once, when the option
> > or sysfs/configfs attribute is written to.  The key is not updatable
> > either, so an external provider that rotates the key has to write to the
> > attribute.  So there's no benefit to keeping the 'struct key' around
> > after that write.
> 
> That is the part that does not work for a key provider. The secret
> behind a key description can change at any time, and the new secret
> must be used at the next authentication. This includes a controller
> that is in a reconnect loop, which can last for a long time.
> 
> v6 looks up the key by description once, when the connect options are
> parsed, and keeps it in opts->dhchap_key for the lifetime of the
> controller. Every reconnect uses that same key. When nvme-keysd
> replaces the key with add_key(), the controller keeps the old secret.
> When the old key is revoked instead, the reconnect fails with -ENOKEY.
> 
> The same happens when an admin changes the secret on the storage
> system. The host must use the new secret at the next reconnect,
> otherwise every reconnect fails until someone writes the new secret to
> the sysfs attribute or connects the controller again.
> 
> Copying the secret into 'struct nvme_dhchap_key' once has the same
> problem. What the provider needs is a lookup by description at each
> authentication, the way NVMe/TCP TLS without a pinned key already
> works: nvme_tcp_alloc_admin_queue() calls nvme_tls_psk_default() at
> each reconnect. That lookup runs in a kernel worker, which has no
> process keyrings, so it also needs a fixed keyring: '.nvme', or the one
> given with the 'keyring' option.

Even if you actually need runtime key rotation without touching
configfs/sysfs (why, when nvme-keysd could just write those files
itself?), this series doesn't actually implement that.

- Eric
