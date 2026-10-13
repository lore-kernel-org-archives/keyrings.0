Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F27549382
	for <keyrings@vger.kernel.org>; Tue, 13 Oct 2026 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923344; cv=none; b=FUT+BQKpwqJ84+9n/oTQqI1QGPIZQevfGE+q4htzdn3chYB3vqxCgCA1uBiXR0pSbWk05YW/sMmUR06clnzk5gaz+q118Gs8B0uESc/Cmrj+8bsv5ZUznpFgmQ0tFD/xkKFDce3C27t2RB+B/EMdiOPnwexGtt8ZwGnNtqctGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923344; c=relaxed/simple;
	bh=6WLrdQptrJArGJMGv3NltYtuEpee2CJJc5BKqgZAghM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9ohWaOxrsIahJLCjtS4H8FdaQH3BhyGlHEehLSLQdPASXTA9PriJzRKfJqqBUcr70UfqY5kXSh7r1edGQklpqxLLU7Gc29MfKpCrQ3XfEk1e0iPkt0U1eXbvwQz1tErK3HUMZ8Y2dhtuGBBOW0fskRDnWWxTaV1W31EbIhph1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=cmRYMx/f; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="cmRYMx/f"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e76469b93so193942985a.0
        for <keyrings@vger.kernel.org>; Tue, 13 Oct 2026 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791923342; x=1792528142; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dohylkge6OeGVizhzGCANBuwwSEz+KJDIqf/mQitXs8=;
        b=cmRYMx/fpjMfMXv6/wVBv5oJhiN9q86aQTYmBqJNN2bqq9f8vRJ6Me6D1TNxiDuGV2
         uLugf+im0ZLsNj+QbBXArtP+LzFQWF4jZ2LGPKQ7SLnoPe6h3WiDfCNEKIopiAGgIZhq
         HXPtp3e5T6cFlPk9TL+L20YnSwzOPiTI6GVPn1AWROOEIsP90oR9sQUn1gEFaRQvHJ+Y
         88EikCqPg54See2CAppPtIAHRQJ9bGaFRBlxrcN3IXfrZVxuZUm/McyRPWOKB8cUebOf
         ZeJqdH5iryIlamTZTkpqvpvSckOfqeOkghpROSKiKipi1hn+/jk0a6v5HVf1aOKM8cLU
         lTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923342; x=1792528142;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dohylkge6OeGVizhzGCANBuwwSEz+KJDIqf/mQitXs8=;
        b=bgeSTm75KhXF2FOc7bVJT2HczH30KrNDkK5DHEG3+4MN/5EI8Cur9QYEhJN3zgO7Xh
         Xh/VEzMA7COyEdFzpek3uI+z0r82aO2YFdSA43Rc76+jQus17iNTcq1N49p9KlWGdLDV
         KDKp3lsc4b8Vedpuin+RCNpfJ2uidzweEspCLFiZ1RcNxV9S+0oivJaKymGSLHw0wVxU
         R5b571OfDG4oKKVBWzX4hikF2NgFJMCxetcKoTPkMncKjmw9NML/CkOm3wtffKG9jPky
         9/DVpRjz5iwJ4SScCewxymg9T7/D7+7ikpFqb75fEWyJUet8xEWUMIRTw4HbXvjJRHQT
         7x4Q==
X-Forwarded-Encrypted: i=1; AKwUvByo/A4fYNTaCMT97Af5p88YyveeEJwn8G02Et9xjT/IKtxCGEWhTCzOlrNE5r1eiBJual1VZRFtFA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKp/Q/AnpuwVhaujfh14WouWA2B/Ogeb0GBHvr4qhwaP3ZRmECg
	r/A8FtVxVmb5T/jPAMnDGjkJxNCB2pxe0uxUZsYY/d3Fnkgu/dhkld4ABl5Q12VOvAQ=
X-Gm-Gg: AYBFou0DX/2nEeoBdd0IrcoyJp6QahMszf9GJKG3vw70K6KDKKY+4XdMFNroG10iEv4
	oHbAwmXz03VCyTX9vUyCAw/ilW8HbUZH8KkPIicmd7fNvkwVBiBB7HhEq3y+/IQaEXjfGgejiWS
	LwPnJl2eIvTzvLDQzQZvmtf5xZG2aUfnl4I7Le/vPVdfZbkhyvI6mPF0zsb6BfZv2AzXrzKk9Bp
	ZUmRY4G59Jw1vmXRaigzIEpmtyQZt7ToKLhnqvRgbuEl1DHv6AMxY/dVlBBkUq+X5OGl5XrpyU6
	On8QAzK414N2uPn5eTvHKcr6n7Kh3rMN528skGmqVBz9PMwvrjB0/Jjp50gEiVUniltnRri4zxu
	z8RWtzJ2E+rTfgt7nTBpS5s528HpXYu5UNId4wPa1/cLZCw6EcapA/L5c0GknsR5AWx1gKKvq7c
	9M8FqqIBo0yRrBb/lKQxwlGVmVi3Dyz//1/nYC96LuV8kHncdhi2TD7soc0zwuilBNvyMgfhvBw
	SKyLYv6VKabtgQ=
X-Received: by 2002:a05:620a:2591:b0:93b:d7a3:45d4 with SMTP id af79cd13be357-93ebd29c0bcmr2207495885a.61.1791923341761;
        Tue, 13 Oct 2026 13:29:01 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5028051sm321623085a.18.2026.10.13.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:29:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>,
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Tue, 13 Oct 2026 19:32:13 +0000
Message-ID: <179191993398.6.7035194670175996999@toxicpanda.com>
In-Reply-To: <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <asehZEWAwsJcbqvM@hallyn.com>
 <179147397027.4.15064782992163283819@toxicpanda.com>
 <asfBRYy597qvzdCW@hallyn.com>
 <20261009-aussicht-wortbruch-bohnenkraut-9e7a1cfd7580@brauner>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 09:41:59AM +0200, Christian Brauner wrote:
> On Thu, Oct 08, 2026 at 11:13:57AM -0500, Serge Hallyn wrote:
> > Yeah, that's what I was thinking.  Or even stricter: ensure that to join
> > any user namespace, a process must have a superset of the namespace
> > creator's capabilities.
>
> I think both are fine and I like this proposal.

One correction to what I wrote: the weaker version isn't enough.  A
namespace that maps "0 100000 1000" doesn't map the parent's uid 0, so
it passes that check.  But with an idmapped mount that maps fs 0 to
100000, a task that joined it can write fscaps that are stored with
rootid 0 and honoured by the host.  We test that flow.  So it has to be
Serge's stricter version.

> I think that this is an acceptable restriction. Mapping uid 0 to 0 and
> dropping caps is borderline useless.

That makes the restriction wider than the 0 to 0 case.  A root task
without CAP_SETFCAP couldn't join an ordinary "0 100000" container
either.

setns() also only covers the routes that go through it.  These don't,
and need their own checks either way:

- writing through a uid_map fd opened by a task with CAP_SETFCAP
- ptrace and pidfd_getfd of an entitled task from outside
- a task without CAP_SETFCAP creating its own namespace, which a
  privileged task then maps "0 0 1" for

So v2 would be a level on the namespace computed at create time, the
strict setns() check, and the checks at the map write, setxattr and
ptrace reading the namespace's level instead of the cred's.  If that
sounds right I'll put it together.

Thanks,
Josef
