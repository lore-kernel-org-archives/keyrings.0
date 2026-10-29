Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295629;
	b=ctorHxew9ahSf/8/6gSKDtUvdUA0mdTRWCRnGAR0dL+wfMg569xIDzqHhi3dgsdzrZCv
	 RufxvlBoFCXXh7s7N/jcWHG/TDlU65hiEKmzbv7BNrE1TI+qXTo1s6oLwPr7BHKnx0UqA
	 XBmBmu5LYZrD1MSbW1p2VvCNllZqxzYbzCal6WC+K5UwYziQas9T09UPxMIeX9s9IzUMc
	 C44sXv5orvzjoTyFnWjEMptSiX3uz+0avAxaJ9Gem79zg606b6SGJdaR9WQDqaIJ1FrQ2
	 C5/pLWUtQ7GcBXwpI4DAonf/FYc+g2qwecyKdd+COWbRDw6g4tH4qGrvCyg6+xxdYbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SIEIl0NkTaZsAFVEdmdd/DZGOMSpXvKdV9i5TP/bIIU=;
	b=xvkop9k+Fumgm7jaVylUJniwSeMuk/mM0vClWZQjiwxcrbZPHkYHXSyDWegmvSjK/dfZ
	 WJwp6pWKjH2/RdjwuMfqiCTCAQRGJx0EkIlhSgOwrW8yTN+chPUuC6kE6/jj8+8CpjWz+
	 p5Vn2/x7Y9zbK5n/xalgG/W9KwWcdlT/fg4j6ZyrnM7s1LNMSkndTuophNXbQyLoo8jA1
	 Dsrz+A3u2ZSyUiLFEjhIO1HkfhYRAM9kAayRWS1F3VsQRg5WWC5+DcRexH/miArn5rrDg
	 Wu/N2Twx0oseY8tadAJn1eESnXt+N9GJlhJwAsFM+nJkUG3T6Q6SR2/HSigIif6c/Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoHSCzzR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 40D9F606A31C;
	Thu, 29 Oct 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoHSCzzR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5F83B1F01816;
	Thu, 29 Oct 2026 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793295628;
	bh=SIEIl0NkTaZsAFVEdmdd/DZGOMSpXvKdV9i5TP/bIIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DoHSCzzRY8i/s7GJDgYwYAsBPy0Y8wvAGqtZQnhTejMYUEVqmngKY67eMNDVJQAKQ
	 Jeh+BpytqiFm27SEl5gmdUk1MJIoITvtyhZ/Zr7c1QFQAjgXFFmeBkNhiGGuq4hAWe
	 ILPcPFZSH8ngFRoWqK3FhgZqylxe5oH75P4PqvT2lpimWFqWKgQFWUGzJUhApv/WZw
	 tBaR/xbwhAapao9AQs3clKPHcGhk/pkiJgYFt+wlsqAzQVaUutfXYFPUxVfs1SrTb8
	 szrRu+BLXh5DEUXZAKgsdUa56YT8OJlA/Xa9itYi0aWwac0FG3xoF48msq8EsArWBh
	 ToSRGv97XicDg==
Date: Thu, 29 Oct 2026 19:40:25 +0200
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
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auOFCYZw2WwXH6D8@kernel.org>
References: <20261029172918.2118600-1-jarkko@kernel.org>
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
In-Reply-To: <20261029172918.2118600-1-jarkko@kernel.org>

On Thu, Oct 29, 2026 at 07:29:17PM +0200, Jarkko Sakkinen wrote:
> - 93% drop in the combined variance.
> - 2.2% increase in the total task time.

Testing in a wide range of chunk sizes (and multiple repetitions) was
also done in order to make sure that the bench itself is working
correctly.

These figure are crazy good IMHO :-)

Br, Jarkko
