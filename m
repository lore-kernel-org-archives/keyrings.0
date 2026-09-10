Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EF3DA7EE
	for <keyrings@vger.kernel.org>; Thu, 10 Sep 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026777; cv=none; b=A2bXkdNttDLTR/pwj2KACLVObSRruHi56knjH1TjZDAXNJA0hmMdtLXhcVjhRLMZKZ2SQQE1VAHUD/TGibBoAnxdvSFhvQoa+1Y2NLSt684V7toStHvQLyobmOycq4Ov9DSn5Licv4ZHWl9N2ufMUW9pdurmdzn1Su7yGnrr5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026777; c=relaxed/simple;
	bh=CsLIGHHO8YWAldmY8Naazy7NOx7PZIBpEJmR+iBDvqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2bSUgyupZymnCDSYu5UZ312jsOUeuSAVbS+x36Jf5f+oDELr+t6tigvlNtKTY35q05aDd3Ll7GN2Fjq42hwkC538iimUdOnIm8v50QxS2xPMIBtVE2+mKzML9adW3wLeFBJMWY5YKPLoKRV5h9XUzAljq1pz8kRb21tq+8BX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj7oyrmZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=toPLaIA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj7oyrmZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="toPLaIA3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789026774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
	b=Bj7oyrmZVR9i5l09nENsd3Ehvh1j3A2xi86XHNxDhT2mXfcs28L+dK0JMaxFshMm+uMCQc
	fz6AHrQiwN9Xhrs5sCE+zujaXCYbysPtvW7J6lc57gJpca2oQK99xiD0i0ePdB2B0WUr1N
	tsTj5H6qdt7jIgjOS1H8BnCmJLCX6h8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-1kNKm2RANHSyP-1PdP0q2Q-1; Thu, 10 Sep 2026 03:52:52 -0400
X-MC-Unique: 1kNKm2RANHSyP-1PdP0q2Q-1
X-Mimecast-MFC-AGG-ID: 1kNKm2RANHSyP-1PdP0q2Q_1789026772
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b8c651ac0so99219465e9.2
        for <keyrings@vger.kernel.org>; Thu, 10 Sep 2026 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789026771; x=1789631571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
        b=toPLaIA3jsNbXzTuVdTBeQXvfJAK+C+naJI31B7GoKEINHLc1qcPkHJoPt06NO6ieh
         8vasG/2Cz9uC4DD5+4gHbQXU5uCl6K5UJAk/24JH2B7yS6D8CHOQtCD4qPw78DBdYmls
         BqXwhdDyPj5YgPo0/qjHVeDaMeKCT7nTwJJmnyX7o5RyC4JMIquA3b87Y+zCUGcA/W45
         eNZzgBf1+4kEgCRj/YrXpjf26hl9YzurO+4RMh2GttUe3aYKQ6NniD3dUgqip6N6S3Uk
         DNOqWcKlGNWv5LEXbjha6iUsEVdft4gjrlGI8gvkD7WI6SYTbojc/2G+CeT5JntJGi/Q
         G1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789026771; x=1789631571;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zdat3lb+JFaceCjEvZhP3kP5xpKa4RbvpVHW8sS2v0=;
        b=PRYRIjJW0ZITcHQNUx6GQKsPM3lOoHQbFFR7l39bJquBL1yt9XDO6/V7lVMXLQScqo
         Uten2wVzPKtw3gPK0LhdafyWCIsAbcfUFkEUyWZ/g6Mf8fQnwNuWO78TR42464mZ+OBI
         87JpT56hGMMq7Y8lc9HIGnXTN0tB5e61GFvmiWivJUwAd/LWPCx7ETp10BwKnjx8dpjg
         4kxUYMdJHwiYbdMMwIoLqfVa2gQcTYSUfGNp96RfTF9ECvlBbKFM55yAQbJWeXqe9BqQ
         c6HSLvOoDd9aRYQDAGCoO95DSZz5UNdcnn/OVBqMA2w9OoRLGDerbrKOUwYIV8vvel07
         /03Q==
X-Forwarded-Encrypted: i=1; AKwUvBy2dDbuwL7ik5pvGLTYBlzVpsxYQ0FaKQ+HjWCA6/5yNIzOd8GupAL7zmYvzF2XBtcE/FaMw1FSUQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n0/EXPq6wn2NSXOrfQXral2QgBISO6cfj6Q627rUnMMiUQknrY
	xtm1a39mgc2l2ZKww036ZKNIcdv/0E32m5oS6fyPG65hb79XlRwCgdMHjS99YNcmxdoQimSDiSD
	JhvVnYoN1ujzdlAFQlBUxXynXhyU7qw29U8QlP+9DCMReIU7T1z62QsBVpyZE
X-Gm-Gg: AYBFou1+Jdxp4i0kq02fSbdbgcYwJj4IufDkiHwfy3UyGVwDrogeH56815CADUUF0pT
	H2/0S3fgznO2PL9zF4jnlZHfuYyPRfVPeWPpMgYVVNvx2uS0Kfy57VGugI3JweqXg43IIuZdXX/
	4Op8NnXbCi4fwy8j4VOcKwOwyc2p5Jra7APQcrflG2KT5yBOmU+bEPopRhu+SxkZ4RZjKlAdonv
	qLCvD7Y99BIpFQDt9xME4forAHuj+AMS5TrSj32jbV7BhtBM5/W00oXBo1KwJNG4E1mHH3+HfAp
	rmUzho1CmWqVIF3Kmp1vXXpZTEnlEbbOo7AGIPDGYGucZ0KI1NEAxSg1g9mfwrpquuGljvMPTez
	aO/2Xlk9sf9msLUuxmOyljrFfmmAYKkeSr5vI0pJKFCowxw==
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr150578195e9.14.1789026771626;
        Thu, 10 Sep 2026 00:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1991:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49d1842f00dmr150577875e9.14.1789026771102;
        Thu, 10 Sep 2026 00:52:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm48847267f8f.21.2026.09.10.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:52:50 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:52:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, 
	co+6a581c4284f721d4@bugs.sh, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan McDowell <noodles@meta.com>, 
	Ross Philipson <ross.philipson@gmail.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
Message-ID: <aqJhkjPdib-MQTCT@sgarzare-redhat>
References: <20260901205809.2028454-1-jarkko@kernel.org>
 <apfoKo-BdwaLXtkT@sgarzare-redhat>
 <aqHIwoKcEWeI_yjs@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aqHIwoKcEWeI_yjs@kernel.org>

On Wed, Sep 09, 2026 at 11:59:46PM +0300, Jarkko Sakkinen wrote:
>On Wed, Sep 02, 2026 at 11:24:16AM +0200, Stefano Garzarella wrote:
>> On Tue, Sep 01, 2026 at 11:58:06PM +0300, Jarkko Sakkinen wrote:
>> > tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
>> > payload->blob_len. Address this by passing the decoded blob size to
>> > tpm2_load_cmd(), and use it for the boundary checks.
>> >
>> > Cc: stable@vger.kernel.org # v5.13+
>> > Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
>> > Reported-by: co+6a581c4284f721d4@bugs.sh
>> > Closes: https://bugs.sh/b/6a581c4284f721d4/
>> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > ---
>> > security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
>> > 1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> > index 67225dd562a9..01f18bb37047 100644
>> > --- a/security/keys/trusted-keys/trusted_tpm2.c
>> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> > @@ -99,7 +99,7 @@ struct tpm2_key_context {
>> >
>> > static int tpm2_key_decode(struct trusted_key_payload *payload,
>> > 			   struct trusted_key_options *options,
>> > -			   u8 **buf)
>> > +			   u8 **buf, unsigned int *blob_len)
>> > {
>> > 	int ret;
>> > 	struct tpm2_key_context ctx;
>> > @@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>>
>> 	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
>>
>> Pre-existing, but is `+ 4` here useless?
>
>I checked this through in detail.
>
>It should not be like that given that callbacks tpm2_key_{pub,priv}
>provide the length of TPM2B_PUBLIC and TPM2B_PRIVATE.
>
>Thus, it is a bug introduced by f2219745250f ("security: keys: trusted:
>use ASN.1 TPM2 key format for the blobs")

Yep, agree. Do you want me to send a fix?

Thanks,
Stefano

