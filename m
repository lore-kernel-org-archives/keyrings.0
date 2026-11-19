Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115996;
	b=dCapaNJICnpvTyibhhwZRmaXWlQNFyXA9aj11evpsL21mcYc4ma4rsgnUfRXFBS9GokG
	 9FbF4Db+fuVbWWpNOTeMYQQGxr2UMqrpv6pGFMpDcz00r5YKFY3/FKcOhItaLgmDBVtgC
	 9Z+hoV/UxFu0YgZgHaHXi+vgiX4LotEO4jueSbL0V3tbiUFrYcRC3WDTR5hgVZrmCF/tk
	 PvQb0cQrO5Rpw7WZHDLIFuIisWg7h/DiGrI6T5glccsHXR35bVw/wDtPT9REWraDZUD3f
	 clSysAhvIo8c7RXwrM/WagpPxqQ2p48tiQN5hu26m32VKjAX1HdGoPKNL1KX18iA96w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=B3fPYwtnhJtRTzUId1FsxU5BbcK59iDRRgRTHG4g8TM=;
	b=2fsSdxwSsu/3Xe430L1Fzuvl5S2NoOnwT3dR0t24ea1y4OmS8zJ+f/5C4xiMNZXKYp5Q
	 pV1CJeEbh0BnX5M/EF6DjXinlZFdYk1ss7BC3IkALo5QVQjnzklkfkAC28vx42GOwbsik
	 JGZWslOJQ2vS76hXpQKq0Hau5cPAY++YY6CbK1cEgs6kYh22AUzgt1mu/i4U7+dDl8soV
	 xb1Z3nomt1JMM+2mitfNy9YXHmhCLXlmQxWtotsq30OPprpsihHQKak8tf9BQrppiDIhr
	 ISC58sE0cq4s2v2J5AaoijE92VE3SB/C8PbiTdCZNXPblk+Jyd7XYMf5yETR8wHkBCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e6cswkqt;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB56606A333
	for <keyrings@vger.kernel.org>; Thu, 19 Nov 2026 19:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB56606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e6cswkqt
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4d4d318759so2795866b.2
        for <keyrings@vger.kernel.org>; Thu, 19 Nov 2026 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795115995; x=1795720795; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3fPYwtnhJtRTzUId1FsxU5BbcK59iDRRgRTHG4g8TM=;
        b=e6cswkqtbr5gIXT7zPqwbxbqDazMSGSQh5brqg3woxMXmbrKcsjWeeblJDpIszQpxv
         TGd/0ALnpNpnRp60nZIXkRb+MGUi4YpzELfsgyKbr4pDwt9UXKuQxAM8wTMa71F87J3J
         YYQ7BIp9fnmNRMjQDqTpqrghxE77fiw7x7nGb+4Wy9iKCcQm8Xc//n2/a/t+2OZIFVuz
         vY5oy9BS16JZ7A7CoPwlDpw7vJHOvZMFy7JAayuM8duhreLgQWZdUtjMkjojacGMmAPo
         XWy8bVfUa3GEHukBLrYA+VA8kAgfdKRZvXiR9bpIv8Lbshi6/T1qWH0+rQhWll7dwZeB
         FMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115995; x=1795720795;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B3fPYwtnhJtRTzUId1FsxU5BbcK59iDRRgRTHG4g8TM=;
        b=VehGW11oCSc7Zluueb0ogeC9tMa4cFkXHZ8vm+TCKDk3MlONvvk6HhYiTdc5WDoyhr
         myi7ZPI/6tN4tn4mNWOkynZfPAenZBVSmeESmLWZY9lZa4KA64og76I5f60tgwZG20lR
         6qaps/y/CqxxrSEOSd859vJvXzT4N1JX+YwJ0ZSbiKVE8U3kXs1qL0qI/uZtZ99HFanb
         jLgNOGiD/5+rc0jdNEmdyoIjRdMJAD8NI4VgnK2ZzEWP8ZRYOrcaWc801wuuDZckTMD7
         OY7/YaTw4u1cwKMRId2FLMQ1b7OluAqb4Eirk6pV5qE9clOaYcegVKrdL1FZK04Qw9D3
         lO4A==
X-Forwarded-Encrypted: i=1; AL+hErFBiEN4j8nuKqCXdLqKdlKRkxugYg4I3ONRC7m6+/NS+da3EXbjzdFlAecmthkH6EfzTi0nZBlPzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ylNnGgDxJ/kMHASDWZY2it2WnxB4hX38uCrsKbAuWCrOHHEkT
	lZitS1DPHD2vg1KvPNV41kzWjQFGjsgkBJdHDnZC4POM+tPcVBVTj7cJF5+2jyrWKeGXBG7mxg=
	=
X-Received: from ejbgt15.prod.google.com ([2002:a17:906:f20f:b0:c2e:1bc5:6c6c])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:9fd0:b0:c50:a2f1:f200
 with SMTP id a640c23a62f3a-c513a5da8e7mr99034666b.16.1795115994327; Thu, 19
 Nov 2026 11:19:54 -0800 (PST)
Date: Thu, 19 Nov 2026 19:19:53 +0000
In-Reply-To: <av8QNiFcnGWocORy@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <av8QNiFcnGWocORy@kernel.org>
Message-ID: <av9L2ez51erKkQNo@google.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 19, 2026 at 05:05:26PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 19, 2026 at 10:42:05AM +0000, Hallgrimur H. Gunnarsson wrote:
> >  static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
> 
> I read the diff through but this led me to dead end. Cannot find this
> function from anywhere. I look the changes again once this is sorted
> out becaus this is interesting.
> 
> I wanted to look at the call site to understand how cap_bset gets set,
> which is not now possible but I do get the gist and agree with it.

Thanks for taking a look. The series is based on v7.4-rc1 and
set_cred_user_ns() lives in kernel/user_namespace.c, where it is called
from create_user_ns() and userns_install(). ns->cap_bset itself is
initialized in create_user_ns() right before calling set_cred_user_ns().

> I'd figure getting this relates to my rootns patches (perhas). One key
> mechanism for me resolving the unprivileged in my use case is
> MOVE_MOUNT_T_MNTNS [1], which is orthogonal but just pointing out
> the problem space.

From a quick look, they appear complementary. Being able to do more
setup operations from the outside generally aligns with bounding
capabilities inside the user namespace.

> I read through https://lwn.net/Articles/978846/ to understand the topic
> overall. Just mentionining as a possible addition to the cover letter
> (not a priority/necessity).

That LWN article is actually linked in the cover letter as [2].

> Hope these help and can be kept in the loop :-)

Will do, I'll keep you CC'd on future revisions.
