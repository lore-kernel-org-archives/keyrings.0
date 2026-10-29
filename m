Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284390;
	b=rYwjf+LxOBO4lgWyb6HJqK2HmrECyUTC3TAPeo3036G5uWhKe3V4SEMy9T5XMTVOSIRj
	 9wTI4iJiC71Rf34h9BUM+6BhqEkYKK/TwNmg5ix+WwAE5n8chJGald+t2Mg32eHpNdxEH
	 yvxa/Cby6K+kHVAuWAM80RNiVvyV1s79V2rOKjMvOfG6vBgC8nfdRB8i0lsAzUExEXboq
	 0rqKuPSj3+F3noGtejBrqF/RIUjcoQGfJVXK9Yk81h/NIgROu7W6K9rYiOo8cHwBCUMpI
	 uN41eqRR0D/PQOPc4QUpkRkleMkKFBx/AgtrnPTvFWDZYpg6qVPRvbNPNJWz7PVcTGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PI6XV6wRBKnwx25utlIFilIARw4g6CWAbZMbWDcIpcQ=;
	b=G5OvUlr9JSTGKjO6O0W4JOHlPsYIZn71RF/QUx5FAEuYTHnxP1aG31qDqiGMhFIJHu45
	 bYjhQFqz3MXEwhObbqqjujWAMFSE4uDdI/fpBRw5F84qu39RSvQYVZM5itfbKDkGck1VH
	 6W+KIx72Zb46VQHzDZyr9uCPsOVS2yy3u/Lmu60Iu/dHU+4gAxp5BjtdKF36CdB4w0v2k
	 xU5K3z9hhbQEsaQIXjbno1Wd2GsCPHO0+/GLb5nzmPQynNUZHKjpt/5H+nRg5D4PP42Xf
	 GmJZSkOyaMPNe+MIO+4kXhzKqk+kNS3V4GV8/M3lTCwGQe2Z1lr4xO8MUyWimt7d/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYNGdT+r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 20680606A31A;
	Thu, 29 Oct 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYNGdT+r
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2ED241F01825;
	Thu, 29 Oct 2026 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284389;
	bh=PI6XV6wRBKnwx25utlIFilIARw4g6CWAbZMbWDcIpcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WYNGdT+rZn4iYkTdtrdt3yuFvlGqH5uylT98HcZQ3aJNXPlAvgkHO1ioTcugnRfIy
	 XmIrucKme8qfrUAL7hzh2Q54kdl6bciwVvpW6aM9ObAgOvrd8tN1ovtGCyslVsk30H
	 Yk0FQtK/OLbXZFW/feOMlCAijzixxNn8zpUnO6NHpzHD843UAlgZOMHvtqbCsdePtz
	 RFoqmX3AJWuBGJatHpNa9ArDNmDRK4uF5IRckWsthtwAaXt89x5Hie04fUvL7oiGec
	 H0GJEicq/SXsLHQlsB7ttycEVWzf9by0RKBotVPwPomh+6oqtkGeOgA1KwRBTWwPZv
	 wiNYp+4z03TPA==
Date: Thu, 29 Oct 2026 16:33:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v4] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auNZIm0meBH7zHQX@kernel.org>
References: <20261029140707.2010100-1-jarkko@kernel.org>
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
In-Reply-To: <20261029140707.2010100-1-jarkko@kernel.org>

On Thu, Oct 29, 2026 at 04:07:05PM +0200, Jarkko Sakkinen wrote:
> keygcbench results without the patch:
> 
> unused:   min=3016.754 avg=11859.097 max=28667.645 var=141391574.712
> expired:  min=0.015 avg=12758.165 max=21516.237 var=85158284.646
> combined: min=0.015 avg=12308.631 max=28667.645 var=113477010.596
> 
> keygcbench results with the patch:
> 
> unused:   min=0.225 avg=13.991 max=853.100 var=858.700
> expired:  min=0.016 avg=30.442 max=2791.695 var=14187.539
> combined: min=0.016 avg=19.249 max=2791.695 var=5177.436

I personally would optimize all-in for variance because:

1. It is insignificant drawback for any practical keyring workload
   if the total time increases slightly.
2. Latency peaks are a signifiant drawback for any possible latency
   sensitive workload running in the system.

What I'm doing now is to find sweet spot chunk size below 1024 where
variances reaches its lowest value.

The latency part makes this change more valuable than focusing on
only on the regression itself.

Br, Jarkko
