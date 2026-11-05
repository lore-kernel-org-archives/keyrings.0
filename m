Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849320;
	b=LjekwJAGQ6Xwk6XvBl6fFC6Q3rVjWeZHFC+izooafEEDl3hmL9mCOMNHRe3NO8qNMR3a
	 hj4BteWgmG6R7C9DEV+i/QjMaxUBM5sbG2WMDZ0SFSr3MsogNZHKShOn5PzZUIysnLRCv
	 t8V32WHXoyGXb+nO8sU9qhqgvuG5kMiRiUYL/mnLyikW//mycP+NcqsDNeQJuMXZvY/I0
	 geCn5syQnSXcn7zUG4QeSpeu5ccRdvYIxbJF1InL8WJ7YgDbaKTkPJNAIqQo/17wkbQzz
	 s68v5Np2spQIusb4VGKAZI69UptWyanzeFKt31G5AlLEOhKGCSO4sT9VdDj69fU7KVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849320;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Slq3nCIgWvg52knBPAht2HhQdN2TpYWWaSMjNbdLLdM=;
	b=TOqln+L+HieMC+IqGAYXplDUypeaRyahCFYkqycPjPIOl6QQcjTGgAXBYm5HFSyrac3l
	 uGJxq5LfTj+tC008N/5RX/OzB+vF3Zud8idagNMxs2YCm3iSKcVItkL3MAeZ4P/L0QgN+
	 jvcqATJESl70hGTul2/exe1anvSl0T9CgJdEzKYwJ7xJPpoe5m8KUftbNzCXNBFUR4Hri
	 OaROQJuP0Yqsjhs3F1oe8jSyFlMf+e1c3owiUfxWnUlUPkVvDwbIfoW+aHTrORpUgJeVY
	 S4HLaXhCVh+Mub1IkggLt8K1Xd1thbXvZhiq8pARlDjLd6DZGa1q+IuxTNY1kDpKtTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHLdonWW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 40AF9606A32F;
	Thu,  5 Nov 2026 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHLdonWW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4D2BC1F00A17;
	Thu,  5 Nov 2026 03:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793849319;
	bh=Slq3nCIgWvg52knBPAht2HhQdN2TpYWWaSMjNbdLLdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GHLdonWWeHvdgBTcIBAtLiJZyeJCrEBvV6SWm/0DYfbAvL6AABgdp6jR+x8JM9MQA
	 D0vNtFCUzjnKPhlILZNi7w0MGtHjcgrtrjJY9EVaTcLTiAS0e2xGpAjikgSpbM8gcG
	 TzNR5M6CicyYxvQp3u4uHu9KOE9tLXkyN9hEMb1xYwzkrL8/wupROgbSgnqxmH3dN/
	 7f+cBJgn1l6iPZpgXCquRYCAX87c3uxPKZohrUDE/u8y+lWNLx3AvnNtlPaDytUVTB
	 gNzwQI1JoHzS6+sbqv6Pg7JZvgccKL0s7QMcJqycAOnwn00RJDa9bUcmXiFvSukKGw
	 CBxNsNny9jv0Q==
Date: Thu, 5 Nov 2026 05:28:36 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: Protect pkey method checks against type removal
Message-ID: <auv35Ljgz1OA1zUZ@kernel.org>
References: <aun7J2NGn57RGS5J@kernel.org>
 <20261104021414.50696-1-0xbeac@gmail.com>
 <auvG1wGifSsoCuaQ@kernel.org>
 <20261105022439.11846-1-0xbeac@gmail.com>
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
In-Reply-To: <20261105022439.11846-1-0xbeac@gmail.com>

On Thu, Nov 05, 2026 at 10:24:39AM +0800, Yuansheng Yang wrote:
> > >  	if (copy_to_user(_res, &res, sizeof(res)) == 0 &&
> > >  	    clear_user(_res->__spare, sizeof(_res->__spare)) == 0)
> > >  		ret = 0;
> >
> > Why up_read is not here?
> 
> To avoid holding key->sem across user memory faults. After asym_query(),
> res is a local copy. Copying it out no longer needs the lock.

Hmm... OK, thank makes sense.

I'll think I'll hold for +1 version and see how this organizes and
provide feedback what might still need to be addressed.

I think the timing is good for the patch exactly because it can
land before turning this over so in that regard this is all fine.

Br, jarkko
