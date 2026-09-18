Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F64EDCC8
	for <keyrings@vger.kernel.org>; Fri, 18 Sep 2026 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752108; cv=none; b=PdVw6I0WgAuYH/2kde8EmTWAb4NVuS2KHnc7PUGrtt3rrage1317OTafsQsg2YxokAv+TmB+MykWO5wsAXul37QzNUiUurdoojZpul42WreBCEC1Q+2Qmg4I7nigW0QMRd1hP7Khm6lpIKNIaucRfhM7Ke4DCQUjr0urUGT2awM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752108; c=relaxed/simple;
	bh=de5x0Zxo6F6d2MB0yVScP1sFcZZJFeuVMt4yQvyoVlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gINIGw6fHhpyKuCMZU53o4W3q1+iN81Y6IY4CTXhznwFVwofyNA+ghCI6RDcpwH0K6nnKB1C3PnyqfiCVAnJ7AvvnZ2KIjT298NcaoRq1VFHfZPpKre44YeQedTqHkMVTY19n+kDF83vwxznzjTuIRavQL35cxVgUbO7H9f0ihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=aLVCpAYL; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="aLVCpAYL"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6bc475ffcf6so500009eaf.1
        for <keyrings@vger.kernel.org>; Fri, 18 Sep 2026 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1789752099; x=1790356899; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BBKlhw0dOEOei2lTcRYxlQw5MM/EKQhWFk5pNENBOIA=;
        b=aLVCpAYLsiWMtfVrSXcyzAKiRQIZD8WXF3wSqmprCpJtpl70Entfq7wa2yHy4+K6Uy
         tGrOa4LLvUp5X9YtZz8bhWCm6RF+LxSfIr6/+9FCWttMd10LbpJhMtuxIg1VvLmeRfcX
         WIz3tXF49p0uraQhpq5jfZhBhrOyAS13e7LmEmzTmq7OVDf79k90oQADr3CvVCWKUJQr
         pobHkxMoXRqWoGl3yEF7Huk+wTawViIXeRoFHryYGQdLpQgyQcraGu+oRg1wHVo30aB5
         vqy35MNNRxnLbRhTP+uZTRjmFly1sUTn1JbcyDYkqTH9E0wSRcJU3kTUcvRk9QqrKQqD
         iiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752099; x=1790356899;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BBKlhw0dOEOei2lTcRYxlQw5MM/EKQhWFk5pNENBOIA=;
        b=PVTDOGXZ6/vLVavGrhslssczEiVHXbm0h3kiMYHRnQY9tQRB9ykOyAl3LeOdvboZJ9
         klzHzjYALiKYVtZASXr+ZEDUKBN5cHCn+FOuZ8spqzdgQLKsvfiy8O3Kf0sd/FvpFR+q
         ULMQ9l6TF23SHywrTRFXqxf+AJ7gNLZQt18JbKEswNThf/6OwifqPCtPvZfS1hDPvgF/
         orNvpA3frEqQuOCSGhBXETRkzOL5GnJPt/rIhm+m5J+KLFKKzFFfnu2VsvbB20VQk8Cq
         mnH9gYD0dxF3copQ12N3sgs5ncJv/jyBNaOl/zR34i1h3AlI84V0HqfYdBEBaLDJXdhz
         Nl9g==
X-Forwarded-Encrypted: i=1; AKwUvBx43u9Nt19HbaPjPT1Eu4V0ag/D0FzdOWF6c+ChNtrTCNFCJJs5/xnZdoy8ZBslYIucl7vryP+uMw==@vger.kernel.org
X-Gm-Message-State: AFuF++lZfoHcqzeHgCDXTBYz6xBy53xZcS60uy7uAB0u2/ryp0nYWcWi
	GJ3yhTeLhlL1HZo1VoZrEgPBVN5EeZEz8694KSEiKYCTNG6z+5z8pQMEURzkwGGIN7Y=
X-Gm-Gg: AYBFou1aiJzZyPf68yk7uIuLmF6EMiyWEkIf/pQE6O7TqMk2JO3kz330XCVTfjR5dNc
	f6eHErjQfboZh0WbxVxrW3CPaRUlSnSFI/H6ZmdfGLslMMiWyshyfjVxv8UQeZMQZJ29yqCf0x2
	wSC6Pa+JYX/rqks4oX8saCgd9MuddSa+nx0aFu2naV/cOcPjaPuAL69STZrMeyftf4v5SXMk7LL
	7cxgBjHCp0dixU0+3y+qhqygH7VahPSikaiIeJMvCIIwAPW76hzbT6HeOBYEjQdZsAnpYnSkiWh
	KKbl8NNmecNZg4r9iV9fMoNlAxE2/Bl5xWfcp5eZvUCrhB6qAC7zMSwgqmmAPsuiHuvuIW8rob/
	EmxB7I5hss425CeTxBtbauiJCEw+VZpfGPn4ikIKtmAXZD2116ET/JZVVQutpuTCy28WawEgy3m
	KE7B6bIsvtMAELW4u5A8dYywdK+7/mv8CNOSAu11RKLWcXHqYkpWls8T63ekJBdYpgj+YBFCPAV
	yNnjXS1nTte3bwsAPg=
X-Received: by 2002:a05:6820:a284:20b0:6cd:3fdb:fa6a with SMTP id 006d021491bc7-6cd3fdbfe8dmr158239eaf.85.1789752099254;
        Fri, 18 Sep 2026 10:21:39 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48739852afasm1477855fac.7.2026.09.18.10.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:21:37 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org,
 keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] NFS: isolate mTLS client credentials by network
 namespace
Date: Fri, 18 Sep 2026 13:21:34 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2FBF57B6-FBB6-498F-A1F4-695D52EB89E9@hammerspace.com>
In-Reply-To: <20260918-nfs-mtls-identity-v1-0-197e568d78a7@kernel.org>
References: <20260918-nfs-mtls-identity-v1-0-197e568d78a7@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 18 Sep 2026, at 10:05, Chuck Lever wrote:

> An xprtsec=mtls mount names its client certificate and private key
> by keyring serial, and tlshd reads those keys with its own
> credentials. Each key therefore has to grant user read permission,
> and any tlshd on the host that learns a serial can read it. Nothing
> separates one network namespace's credentials from another's.
>
> This series makes the network namespace the isolation domain. The
> RFC thread asked whether the user or mount namespace is the better
> binding. tlshd services the handshake socket of one network
> namespace, so that is the namespace it already lives in.
>
>   https://lore.kernel.org/linux-nfs/20260602154740.49861-1-cel@kernel.org/
>
> The keyring is held in struct nfs_net rather than found by name,
> because /proc/keys is not namespace scoped. Its serial travels with
> each handshake instead (patches 3-4), and tlshd's possession of that
> keyring is what lets a provisioned key grant no user read permission
> at all. Both ends of the link exist today, in tls_handshake_accept()
> and in tlshd. The handshake genetlink ABI and the cert_serial= and
> privkey_serial= mount options do not change.
>
> Still open is how userspace names the kernel-held keyring. Patch 5
> prototypes a request_key type handled in the kernel and tagged
> KEY_TYPE_NET_DOMAIN. A keyctl modeled on KEYCTL_GET_PERSISTENT, or a
> read-only attribute on the netns-tagged nfs_client sysfs kobject,
> would do the same job if the keyrings maintainers prefer one. Keys
> that userspace adds are quota-charged by user namespace while the
> keyring lives in nfs_net. Confirmation that this is sane when the
> two boundaries differ would be welcome.
>
> nfstlskey, the provisioning tool that consumes the key type, is
> merged in https://github.com/oracle/ktls-utils/ .
>
> Tested on one Fedora VM acting as both NFS client and NFSD, with
> tlshd from ktls-utils 1.4.0: NFSv4.2 mounts with xprtsec=tls, with
> xprtsec=mtls using the identity in tlshd.conf, and with xprtsec=mtls
> using serials that nfstlskey provisioned.

I think this is the old upcall/namespace problem that's never been generally
solved (as far as I know).  Here's a shameless plug to potentially revive
the original "key agent" concept which solves this in a general way.

The idea is - user space processes (tlshd) register themselves as key-agents
that can satisfy request-key.  A key agent represents itself as a key-type,
and the appropriate key agent is consulted for request-key if the calling
process has that agent's key in its keyrings.

Otherwise, this solution looks good - but without a general solution to this
problem, other folks building on keyrings will keep trying to solve this
problem.

Ben

