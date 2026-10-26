Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051906;
	b=VqKtzFwm4smAEYWdTQuaoedoDhDR8DypHU77FVoTENY66laiGOLXxuZ3BlHjJ6ZamgJC
	 DSvoc3SErFY8ESv6ibsrI+YDqTtDRMaCqo+xz7WK6kos8vG2SgYGEe7EZ6Agyw1RW543G
	 TuW9qKD/4jIWYXNZ1cGrrRj5Nlracm05pqbSf9v8yQUfIVCvvrs/YY5QqUsYQwvgTuOee
	 Sg5NnwW0pReMBTTvcwWrDphJaLqE5yJkn+WUjssx6ZKhbRKIANgYcKXjPVty3TkoWHesV
	 a42myDuM2/o0+Eaylj/Jl8qlWVeB0NLuhaQmwMZXuKPq3sYqxYX88aXgEclevXCJ0Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051906;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ItVTvdIep7IAfB5nagCC/njxIQmU6rUKtEVGu3hqs+U=;
	b=M8PHB8d8OSjukWBPyoiUe45Cz7tDYa+hdWwZNoP1tV9XL8upsnn4HAuQiecLdlwB1N5T
	 Ku48u5R9505ozDLLDGulgRGcz089P4cazYBa+Nh28J6/Ze4BrE0a9fukM01pBUWdO3eFT
	 jo1rF9eNolhLLA6/kanKofbOdpfC8ADd12KmNpCIv/+FLIgaSmkTiK03DC9ZJgQFBLG59
	 AeMv9Cc9/6dC52QYBEl4bfnQdNnrZVkv+ztekgC5qRZXb4L8RoR4OJIdK5C7NGVQ7oKLT
	 J9w5B7mxQbXbfcoGfIxVtkSJ0L/5H5Ow08G1HHINgKSxo7I9zV+Vx2y9IC9l93FdjGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cnQTn/gl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 22C5E606A31A;
	Mon, 26 Oct 2026 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnQTn/gl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3323D1F01825;
	Mon, 26 Oct 2026 21:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793051905;
	bh=ItVTvdIep7IAfB5nagCC/njxIQmU6rUKtEVGu3hqs+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cnQTn/glRQOrBDUFb18cXGq16CAgeZHDi4/4jfHNSlECOK4mIg8Vjk2caWWyaYBPi
	 N348P3WuGVkVYtm6o7JZFaXHsU59GXXAiAj/sYOSr2I5TtvcqdrrzVhmC2EEwF+BP7
	 7Pi8d/SWfIjY1ZeCJhUjyjMkY/BSr1n3vUxhaR/7a5CI6iEh1a0iDDhgDcWzNMREGK
	 A9DCfiDwFFLdRJCuq960yxrYxqEUlfZo+pbrmWCA49PyLRy99vSeLxqtBAZXnDal5h
	 nY0BlbM+4WIdQ3vs2jprGvxq0nzFjkc55UfHEz2MbJO8pZz4eKEjQLJLbhYSITgxcp
	 rEtdji1/XnpUQ==
Date: Mon, 26 Oct 2026 23:58:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Message-ID: <at_M_XU4Og3fmV01@kernel.org>
References: <20261026031219.2627968-1-jarkko@kernel.org>
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
In-Reply-To: <20261026031219.2627968-1-jarkko@kernel.org>

On Mon, Oct 26, 2026 at 05:12:18AM +0200, Jarkko Sakkinen wrote:
> schedule_work() dispatches key_gc_work on the per-CPU system_wq, which can
> choke the queue:
> 
> BUG: workqueue lockup - pool cpus=0 node=0 flags=0x2 nice=0 stuck for 30s!
> 
> Queue the work on system_dfl_long_wq instead, which is an unbounded wq for
> long-running tasks i.e., it has the WQ_BOUND flag set and thus cannot hog
> the CPU core.
> 
> Link: https://lore.kernel.org/keyrings/20261024042944.52493-1-hackerowskiy@gmail.com/
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6ad35b60.7952420f.283480.0360.GAE@google.com/T/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> I sanity checked with perf that scheduler latency improved clearly as it
> should, and used large keyrings that I expired, as the test payload.

Based on the feedback, rather than arguing about irrelevant stuff, I'll
focus on formalizing AB test for this.

I have couple of additional ideas to try out but without AB test fixing
this is really just shooting in the wind.

Br, Jarkko
