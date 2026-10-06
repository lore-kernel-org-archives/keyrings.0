Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BE34BA50;
	Tue,  6 Oct 2026 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312769; cv=none; b=Ua3ZKw63W/3Oy8l6z/h347uVgBb2Fw6+YkSvol803tEmNEABHzsYKARwX71qVU3s0Ga5CKWJTwkxsVCSQt+dzvpuBir4icQ6oVXIpNoewMQk5rg9uwjflMev45twWGBltW0w90xBTt2rKULOVFAb/raMpcp1OC6hxkvY0xPr1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312769; c=relaxed/simple;
	bh=KKQ1fbtU3N86W04XE5siPWHhfu/CcVXGjb4Yz9DYxBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQvB6bpyzwDApSXKn+pXpR1OnHTiIStLde6Ng7mGKCwysjv1DEiOHhU0m3ww+Vll6gaf2hcIPqAeLeQoncFXj1H4mB2Ah2MqTTnJvE8TPkCZPg+3NC6LXBWVWFg+9e3gu2z2NSYs2KK+osl+lDl0LLiIi2k6V4Fta20VurzVs6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvETp639; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvETp639"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE38A1F0089C;
	Tue,  6 Oct 2026 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312768;
	bh=Kqj+LkSqTE46gg48G05HRGpBBbOI+UHLY5Mj5w0+Xy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mvETp639CKTu31sqcsspSe+jvTQWLcfZSaq95ZZoazQOiTgOYdovIqOOlAivU1779
	 3xnCbtD930tVq0C57x9VkOlYFhhQ7AfaPoiCBqMXM8Y1lSEr2mXbQBAh53amSmplWY
	 jT8A/BgJ2zb9YUC/3rxOADCAVjsKLyoLwc00Wlbtd3YgIfCFXuiLn3yBWnpX8iAnyC
	 QJ/Xq48V9XzlnDWSYzqhfySC0EMJoFy5Drv5aLxlanz4UjhSaMK5m9uVMe52C5QnAQ
	 3MLt+UEExp98x74y/hws87FMcxIjgeihDYrQYgxoluJLXWAARExtS+ML0NM9amUPi6
	 zAzA16EjUVlaw==
Date: Tue, 6 Oct 2026 13:52:28 -0500
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Message-ID: <asVDbPtyCNy210-R@shallyn-amd>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <asKSvjz2YLZhFI4t@kernel.org>
 <asOhhCION3dwTAo+@hallyn.com>
 <asPwkdi7ZdO4YoRu@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asPwkdi7ZdO4YoRu@kernel.org>

On Mon, Oct 05, 2026 at 09:46:41PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 05, 2026 at 08:09:24AM -0500, Serge E. Hallyn wrote:
> > On Sun, Oct 04, 2026 at 08:54:06PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Sep 24, 2026 at 08:55:16AM +0300, Jarkko Sakkinen wrote:
> > > > The main objective in these patches is to remove to unneeded mutability
> > > > from key look ups. It does harm and brings no value so it is pretty obvious
> > > > to me that addressing this harmful behaviour is what we should do.
> > > > 
> > > > I based the first patch on what Jann suggested in [1]. Nothing too clever here
> > > > and I'm ofc open for further suggestions.
> > > > 
> > > > [1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> > > > 
> > > > Jarkko Sakkinen (2):
> > > >   keys: Return user session keyring on lookup
> > > >   keys: Reject keyring creation with overridden credentials
> > > > 
> > > >  Documentation/security/keys/core.rst |  7 ++-
> > > >  security/keys/process_keys.c         | 65 +++++++++++++++-------------
> > > >  2 files changed, 40 insertions(+), 32 deletions(-)
> > > > 
> > > > --
> > > > 2.47.3
> > > > 
> > > 
> > > So.. should I move forward to with non-RFC v2?
> > 
> > Patch 2 absolutely makes sense, "doc, it hurts when I do this", "don't do
> > that then."
> > 
> > Regarding patch 1, that seems like quite a change in behavior, right?  I
> > don't see any docs or comments that promise the current behavior, but
> > has any userspace or subsystem come to depend on it?  I guess that, if so,
> > then it just has to create a link to the user session keyring like pam
> > (according to what I've read) does?
> 
> Thanks a lot of responding.
> 
> I fully agree with you but I'd need help for evaluating things further.
> 
> 1/2 based on Jann's email about the topic and my interpretation of the
> suggestion. I neither used brains nor AI for this and consider the patch
> merely as a conversation starter (and what a great success it was on doing
> that) :-)

 :)

> All feedback is good feedback at this point. I need supporting code to
> remember/recall later on so at least this serves that purpose.
> 
> Br, Jarkko

I've been staring at the before and after code for a bit now.
It does even more than I was thinking :)  But I was trying to
detail the changed behavior (from userspace's pov), and after
several attempts, it seems maybe there actually isn't any.

Q: is there any path whereby the 

```
        else if (test_bit(KEY_FLAG_UID_KEYRING,
                                    &ctx.cred->session_keyring->flags) &&
                           lflags & KEY_LOOKUP_CREATE) {
```

case can still happen?  Or was this the only place where we installed
the user_session keyring as session keyring, so that we can drop this
branch?
