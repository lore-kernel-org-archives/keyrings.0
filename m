Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAB83905EB;
	Sat, 17 Oct 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254512; cv=none; b=BuAHRpco0XHrzKLyPSVff54thC3UrqG6Tic184L5y7/uldHVIgmnQ9ZgogWNijIqvS/4P8/QJOht7yA0fdonskwl8IfBiUroS6aZ/wSXNn8tqoxjzPO2Ccv4/deAneOb5W/Ke6IgMthOOsfj0JkkqrjZZ3FVjO0DXph4jWoTk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254512; c=relaxed/simple;
	bh=hmGthl7ROQ+2Sazw8Qsd1owdcWc1sNDH/NYg99prN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVM1rJiqB2zqnYQ+bzB228qJV26JG4Nd9qIy9HRIVEdYc/BguMYkNiF/x86UgBCz+F7DKetp654FY6ZLLv1RzPFMw4hWRQPv66GcPLpH9Wz0+jGHetBvfdpVrGfrA9NlGxLygxVJ3w4l/WtIGpijWHvDrRpaUV36g/h7UEHaRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDksJQEk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDksJQEk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875891F000C5;
	Sat, 17 Oct 2026 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792254511;
	bh=UXDBNwbs40Wmge81zYEpg8X4LKn6+JBx9zEjbE6db04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aDksJQEkC7scLwX0FZnKHamiS9wFsMPBBzLTRBnFNEZbTTTu9omrwnXsEPLyLraRV
	 fDbBYToxqnsf5/TEL+px0fhVLyrYFpGtQXE1qIQzMAFSBTyVuWgB+c3ifK+GRMl4cA
	 tsnRh+GZxJG1KeBql65pjMnYQhUeCFM26nLYB2/8vN8yeColuB9efPuGtCIhhy7Nzk
	 12frXcTBLyQ90aHCZwoQbAVPOLNKeD9EY+FAMsHwL1ONfIBPGHop4tN9aWEVSkB2y6
	 EO9BOQhPDjo2Y0u9BvWCwpEtC2lHgXxvG+ZrkwEajPWqG20JbmxuZx5XPaXsag/LKZ
	 oIa0dhb2QMJhw==
Date: Sat, 17 Oct 2026 19:28:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, dhowells@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	sergeh@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH v2] keys: Avoid the owner account dereference in named
 keyring lookup
Message-ID: <atOiKzlHKH47SMNt@kernel.org>
References: <pm-key-management-objects-candidate-0002-v3-2baa8cad2bb554364e10@gmail.com>
 <20261017035156.GA29318@sol>
 <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFRLqsWcV=0MKituMQqALy_2rS3kOPPFpMHxn7yRxoyxOHp6hg@mail.gmail.com>

On Sat, Oct 17, 2026 at 03:47:32PM +0800, Cen Zhang wrote:
> Hi Eric,
> 
> Eric Biggers <ebiggers@kernel.org> 于2026年10月17日周六 11:51写道：
> >
> > Don't key_serial_next() and find_ge_key() (used when reading from
> > /proc/keys) have the same bug?
> >
> > - Eric
> 
> Thansk a lot for the reivew. You're right — key_serial_next() and
> find_ge_key() have
> the same issue.
> 
> I'll send a follow-up patch to fix those as well.
> 
> Thanks for the catch again.
> 
> Best regards,
> Cen Zhang

Yeah, please do.

You put so much effort to scenario and you are nailing the bug
that way, and I do appreciate that, so here's what you should do
with the commit messages:

1. Do the first half like you always do. That's great. And I've
   also said that.
2. Think just a moment. If you get anxiety from that something
   that should be mentioned e.g., something that you did not get
   immediately yourself at first, write remarks those down. I'm
   100% sure you know when it might be good tip on something
   non-obvious.
3. Send that. If we feel it is lacking some info needed, let's
   iterate that. It's not a big deal.

I'm just underlining this because so little would have to be
improved to make this right :-)

Br, Jarkko
