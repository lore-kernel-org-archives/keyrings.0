Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299B2F7F0F;
	Mon, 15 Jun 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524404; cv=none; b=bChDbfeQ0URYeXXTw4doYtzaHdJjwBJumyscw5HbJdtoJdhyQrH8m8bfgC1pUuWcD5twPv1kvEeUPbbexKTAnlNs+xPEbqLRFvQLmXZYPh4StxttCRv7lMaHi3q2EIQSJ6xafLJCFLL/ModdMKpaVaFf/Wt5bXvs/vve67sLAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524404; c=relaxed/simple;
	bh=bqCaRyTL20A5vmQrlzhrQRBwE6HdyTh6+sx6fNV8CjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfC8w/Cr/ZdBnrim1gavfPccCB+eLBR9IjDKc5rQxvC3GA7qvmAfJoYorbLbGOa8A+RIpkyvdaCKgLWXVIwTFW0F9oPt2Jt7s7YbFxMot1ScgTLzVWC94A7Q9MnjgnuB1xmhnY6+ZHWcyDqYWdxFPCq1/StzXRtRpLNZLJEBK8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I12f+1Vz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I12f+1Vz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8EEB71F000E9;
	Mon, 15 Jun 2026 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524402;
	bh=BfuDFYAxZc1A/W62NtTTt9xi+n1CrT/DZaep7ntG/hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I12f+1VzGw6NPCPymduE6EBULlyS8yyBv7BHzj6Kmajdy93qtjWQGepyrRYS9MK/C
	 KD43L5YOi4PDfNIqTZ20Mo0WKVdi3diItM0/v0GocsBaJf+9dHj+zxFyRqVbqEdome
	 fI6rXP6+Og5s91cYaOLB7xKShfa7MfbBXbqbWFLAmXCb3KjBmn/kJhxiW6Z1pYWNFJ
	 rxJonp29YgmtInMMBBg5LKjKkVMpc9lsGUSl+qYGfVi5oFhT++3p+J1sHAJKUFuDth
	 at+mARa/TrGRAZHa8pIyxIz4UaqRxJLETfutzUC5P6Hj6WDu46+CC3JZEsZzQHNHt9
	 0pPsh38zQPn+A==
Date: Mon, 15 Jun 2026 14:53:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: eee sss <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <ai_nrljps_jE3Gzb@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <aiYxqTyfHwrDOTCs@kernel.org>
 <aiYynOxFk3LuK4LA@kernel.org>
 <aiZTIzGg_peDVo1M@kernel.org>
 <aiZWPSJZyFq4nmxf@kernel.org>
 <aik5YaJhjRuOKE7I@kernel.org>
 <CA+TOyfjifw5yiZwUmd3y7t227cTMpXxT_JNe0FSO-NYzhqE75Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+TOyfjifw5yiZwUmd3y7t227cTMpXxT_JNe0FSO-NYzhqE75Q@mail.gmail.com>

Awesome, no worries, great to hear, and thank you for responding.

And great collaboration :-)

BR, Jarkko

On Wed, Jun 10, 2026 at 10:21:13AM -0500, eee sss wrote:
> Thanks, Jarkko. Sorry for the delayed response.
> 
> I checked the commit in for-next-keys. The updated commit message and the
> cleanup look good to me.
> 
> Best,
> Shaomin
> 
> On Wed, 10 Jun 2026 13:16:01 +0300, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Mon, Jun 08, 2026 at 08:42:21AM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Jun 08, 2026 at 08:29:11AM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Jun 08, 2026 at 06:10:23AM +0300, Jarkko Sakkinen wrote:
> > > > > On Mon, Jun 08, 2026 at 06:06:21AM +0300, Jarkko Sakkinen wrote:
> > > > > > On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> > > > > > > keyctl_instantiate_key_common() reads request_key_auth from the assumed
> > > > > > > auth key before copying an instantiation payload from userspace. The copy
> > > > > > > can fault and sleep. If the request completes and revokes the auth key in
> > > > > > > that window, the auth payload can be detached and freed before the
> > > > > > > instantiate path uses it again.
> > > > > > >
> > > > > > > A request-key helper reproducer can trigger this race. One helper child
> > > > > > > blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> > > > > > > requested key and returns. KASAN then reports a use-after-free from the
> > > > > > > stale request_key_auth payload in keyctl_instantiate_key_common().
> > > > > > >
> > > > > > > Give request_key_auth payloads a refcount. Take a payload reference while
> > > > > >
> > > > > > Please, name concrete things accurately. I.e. 'usage' in this case. If
> > > > > > you have a name, use it instead of obfuscating generalizations.
> > > > > >
> > > > > > > authkey->sem stabilizes the payload and revocation state. Hold that
> > > > > > > reference across the instantiate and reject paths. Drop the auth key
> > > > > > > owning reference from revoke and destroy.
> > > > > > >
> > > > > > > Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > > > > Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> > > > > > > Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > > > > ---
> > > > > > > include/keys/request_key_auth-type.h | 2 ++
> > > > > > > security/keys/internal.h | 2 ++
> > > > > > > security/keys/keyctl.c | 24 +++++++++++++++-----
> > > > > > > security/keys/request_key_auth.c | 33 ++++++++++++++++++++++++++--
> > > > > > > 4 files changed, 53 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > So first, couple of things.
> > > > > >
> > > > > > I'm not going to test not that well documented involving OOT driver.
> > > > >
> > > > > Oops, sorry typo. "not that well documented reproducer" :-)
> > > > >
> > > > > But it is cool we just then need to draw the picture.
> > > >
> > > > I think I got this:
> > > >
> > > > A: request_key() B: KEYCTL_INSTANTIATE_IOV
> > > > ---------------- -------------------------
> > > > create auth key
> > > > store rka in auth key
> > > > wait for helper
> > > > get auth key
> > > > load rka from auth key
> > > > copy user payload
> > > > sleep on #PF
> > > > helper completed
> > > > detach and free rka
> > > > destroy auth key
> > > > wake up
> > > > use rka->target_key
> > > > **USE-AFTER-FREE**
> > > >
> > > > So nothing really complicated here, is there?
> > >
> > > Send v2 with the code changes that I proposed as we want to the change
> > > as ergonomic as possible.
> > >
> > > Use this as the commit message:
> > >
> > > keys: Pin request_key_auth payload in instantiate paths
> > >
> > > A: request_key() B: KEYCTL_INSTANTIATE_IOV
> > > ---------------- -------------------------
> > > create auth key
> > > store rka in auth key
> > > wait for helper
> > > get auth key
> > > load rka from auth key
> > > copy user payload
> > > sleep on #PF
> > >
> > > helper completed
> > > detach and free rka
> > > destroy auth key
> > > wake up
> > > use rka->target_key
> > > **USE-AFTER-FREE**
> > >
> > > Give request_key_auth payloads a refcount. Take a payload reference while
> > > authkey->sem stabilizes the payload and revocation state. Hold that
> > > reference across the instantiate and reject paths. Drop the auth key
> > > owning reference from revoke and destroy.
> > >
> > > [jarkko: Replaced the first two paragraphs of text with a concurrency scenario.]
> > >
> > > And it includes also the remark at the end.
> > >
> > > BR, Jarkko
> >
> > Nothing heard so I pushed:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=for-next-keys&id=9feb0bb3468e863b2b82a2eabfaeec4c7c44b90c
> >
> > It has the commit message change.
> >
> > BR, Jarkko
