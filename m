Received: from mail-oa2-f13.google.com (mail-oa2-f13.google.com [74.125.231.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A7484239
	for <keyrings@vger.kernel.org>; Mon, 21 Sep 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989437; cv=none; b=ALYCdW8WsyaXob1QcNwg/nmOtTrYfYABWrZd1n3Eky1bs0WyMNui2NaZm0UF4HbM3vBY5mT9lGEOs6KFh1prFmiaQIiJCvA+497Xl9z1ljMx1fHrm3bxX05eDy+ipjfDo03kkScbSFDBmH9y9XbbL8yp7qMHlLgWZWsy5+sn6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989437; c=relaxed/simple;
	bh=ynnB93uRRMFm5MeLrvG8YOly/C5erKJyFzwadvMCU78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJTF4oMDwTQ/JnD41J6uJ+DPUzzXGxoAw02UGxc+XT+3blFbkzr/iDpHulFMq3YKdkKSacRemFRBjeoBUkKCcA4HnunKpUVMogPeYVEX+LCsrbpfXROI4jZADe/JSl6NJKkuKYraxks1BjSUMTJ8Ob3Uss4FiVsWLXO4IIJsP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=OeVHCE/4; arc=none smtp.client-ip=74.125.231.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="OeVHCE/4"
Received: by mail-oa2-f13.google.com with SMTP id 586e51a60fabf-466ccdd7695so933046fac.1
        for <keyrings@vger.kernel.org>; Mon, 21 Sep 2026 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1789989434; x=1790594234; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFZAXGGRVdUcw8Z+HbfAgS1Po8zavpuqYE8I7GH9OYY=;
        b=OeVHCE/44f64CBJemBAiL6V0NXnT+2k2G6FuqpPJ2NvL3jn/OzHBy3zmigLebeF3ws
         VTKWnS5+dt/JPdWDYy94Jr5K5lI5I8dQ/RewOkjcGsh6JziE6HLvcii9zeJbsxNeNwOu
         A6a2IDjYJvlmArYTS/aJ9gRC7R8DHHKV3fEwHggvZfrIQkEzKFeMdaXWcBKO+Ez0CEd2
         zslOObRQPygzT3dIyYFfy1Vt9rqFaGA5RdcQHK7t/UhHN8E0guQvyT0tUCrCbDXRveuu
         1pj9lJAah1Bz1tAFGqlxe/DNU3s41rLTkNkreqkC6u97XBqBCFjZlevHfgMKx7oOrV6t
         TkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989434; x=1790594234;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFZAXGGRVdUcw8Z+HbfAgS1Po8zavpuqYE8I7GH9OYY=;
        b=Xx4Xs72VgGEZO2k/A/OzPnNaX6jLkkXq+g3Tahj17uK+FPL/3xyNbVnvwuAdlk+U2u
         HPt8v/FMBHHnjUADDYxgxsLeSN1g7mqmKwFmbXoj/kwxHxL4+J0aOSHpIjTaAJV0m73g
         MhCbDCL65RvaqpMyeBjNC6apgAdm3guU7X8IMbnWNzWbMUKIe3tArRneL0Hm1NgRZGwW
         2hXNB5bC7BiJRfWB92FHoBWGKRyn1b2kU6epB1ufIiJ5YgIyFl3qDxcNeMRIhwg5yg8X
         wZdvVDec/bNf5u+3Ud/NCTLErzMIz/bx7JJ/1Js/ML6k3tngJ+4H9Isa6IglQ9AcYPq3
         9JTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMh6pOAQ6vdqLgAf6BZghW1OmnE2+Lxrtyu7iJzoyjlHt5MJ0RD12Th+7N5huh/QAltrabkHEfwA==@vger.kernel.org
X-Gm-Message-State: AFuF++mEC5Ae6L2xnCCMw0p8Pwa7im18IXkrk+KOfLq/hkGW0GfJR+mO
	azeimbNUnHMjsx8nyxXx63wZrwt2oQfghyR+hHsENxFfSOPGuPz2igQBqUFz/BKJ3f4=
X-Gm-Gg: AYBFou1XwJk0G/Xi3hI66C4h8e5d0DextBLEULQJN7+vbid6DOc/xuuimrDIzIK5nU6
	KsW/hTY6riJMUVERZ+NDwv9wQl09s6FUxJ/mRLJhjbRjagUHsZWeNwAhdsM55EcX8Q09Ry1vBS/
	FnMip8Df2Sj0s50xZ0Ah7yj5WTRN5rJElvlbWQUTnK5DQ2oWmSNJf4PiJk7DU/kV4TD9ZzIlRn4
	ujhOIEoNt1UC3M+sacmyGRutp7Q8CpRKKlhsPkjC2qRUQyFEtjLbOCZup4cpvlFOJQIeECTHaQb
	dgFtE3fyohyTcE+x0R0kzI3vaCioX6lNs+IOgtBLQ7C2IppLIFLSE4YIXrUi+xKun6w63oK53x/
	8GDIO5KAjH6nzwqF17UQicSpv7fbJ1gEr58opeCT8bUcQqN+NxArrSQQhkBTrpeQX9n27b3QmBE
	XrLRaciqv+3KD+GD/9VB2QwwItmvrSp8pml5AygZqXAxcNS2lfRByg3E5+uOYkug60A3qPZHkqL
	1ftrq8y4427bRXtFg==
X-Received: by 2002:a05:6871:64a:b0:465:fdf:bd44 with SMTP id 586e51a60fabf-486e574f446mr8866000fac.14.1789989434138;
        Mon, 21 Sep 2026 04:17:14 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48820f30ce7sm7756232fac.3.2026.09.21.04.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:17:13 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Chuck Lever <cel@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nfs@vger.kernel.org, keyrings@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] NFS: isolate mTLS client credentials by network
 namespace
Date: Mon, 21 Sep 2026 07:17:10 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <FF0D8D15-2520-4B42-AED4-4FAB4D461D70@hammerspace.com>
In-Reply-To: <5a7830fd-7823-476b-84aa-3b01ca81ccdf@suse.de>
References: <20260918-nfs-mtls-identity-v1-0-197e568d78a7@kernel.org>
 <2FBF57B6-FBB6-498F-A1F4-695D52EB89E9@hammerspace.com>
 <5a7830fd-7823-476b-84aa-3b01ca81ccdf@suse.de>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21 Sep 2026, at 4:45, Hannes Reinecke wrote:

> On 9/18/26 7:21 PM, Benjamin Coddington wrote:
>> On 18 Sep 2026, at 10:05, Chuck Lever wrote:
>>
>>> An xprtsec=mtls mount names its client certificate and private key
>>> by keyring serial, and tlshd reads those keys with its own
>>> credentials. Each key therefore has to grant user read permission,
>>> and any tlshd on the host that learns a serial can read it. Nothing
>>> separates one network namespace's credentials from another's.
>>>
>>> This series makes the network namespace the isolation domain. The
>>> RFC thread asked whether the user or mount namespace is the better
>>> binding. tlshd services the handshake socket of one network
>>> namespace, so that is the namespace it already lives in.
>>>
>>>    https://lore.kernel.org/linux-nfs/20260602154740.49861-1-cel@kernel.org/
>>>
>>> The keyring is held in struct nfs_net rather than found by name,
>>> because /proc/keys is not namespace scoped. Its serial travels with
>>> each handshake instead (patches 3-4), and tlshd's possession of that
>>> keyring is what lets a provisioned key grant no user read permission
>>> at all. Both ends of the link exist today, in tls_handshake_accept()
>>> and in tlshd. The handshake genetlink ABI and the cert_serial= and
>>> privkey_serial= mount options do not change.
>>>
>>> Still open is how userspace names the kernel-held keyring. Patch 5
>>> prototypes a request_key type handled in the kernel and tagged
>>> KEY_TYPE_NET_DOMAIN. A keyctl modeled on KEYCTL_GET_PERSISTENT, or a
>>> read-only attribute on the netns-tagged nfs_client sysfs kobject,
>>> would do the same job if the keyrings maintainers prefer one. Keys
>>> that userspace adds are quota-charged by user namespace while the
>>> keyring lives in nfs_net. Confirmation that this is sane when the
>>> two boundaries differ would be welcome.
>>>
>>> nfstlskey, the provisioning tool that consumes the key type, is
>>> merged in https://github.com/oracle/ktls-utils/ .
>>>
>>> Tested on one Fedora VM acting as both NFS client and NFSD, with
>>> tlshd from ktls-utils 1.4.0: NFSv4.2 mounts with xprtsec=tls, with
>>> xprtsec=mtls using the identity in tlshd.conf, and with xprtsec=mtls
>>> using serials that nfstlskey provisioned.
>>
>> I think this is the old upcall/namespace problem that's never been generally
>> solved (as far as I know).  Here's a shameless plug to potentially revive
>> the original "key agent" concept which solves this in a general way.
>>
>> The idea is - user space processes (tlshd) register themselves as key-agents
>> that can satisfy request-key.  A key agent represents itself as a key-type,
>> and the appropriate key agent is consulted for request-key if the calling
>> process has that agent's key in its keyrings.
>>
>> Otherwise, this solution looks good - but without a general solution to this
>> problem, other folks building on keyrings will keep trying to solve this
>> problem.
>>
> Not sure. Basic problem with the 'upcall' mechanism is that it needs to
> execute a userspace program by the time of the upcall.
> And that (trivially) requires
> a) a usable userspace to be present
> and
> b) the correct program to be be available

Yes..

The key agent worked similarly to tlshd - it wasn't the old request-key
upcall mech.  In fact, tlshd and its netlink interface could easily be
adapted into this key-agent-as-a-key.

Its a trade-off that allows you to route the upcall via how keys are
linked in the calling process, rather than by some defined-in-code domain
like "same network namespace".

Ben
