Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="XbtIvT0V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFUY0LZF"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042418E
	for <keyrings@vger.kernel.org>; Wed, 22 Nov 2023 11:51:19 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 694BE5C00E7;
	Wed, 22 Nov 2023 14:51:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Nov 2023 14:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700682679; x=
	1700769079; bh=PmsbO17EpDJPIKBqSJCwENxvkyCFjWrYwHTTrYaRFA4=; b=X
	btIvT0V1vdJvuQ1atXp5FVxJi9HkpfjdQmvma5GdQ9OPQ1RdnrKBs+X0jqxJnADo
	kjNIArhwlWwYwRhGXMZmDbnGkd/nzhcDOFFKmrVPhy3ABW+Wa2t6vKtx3m/49Lyr
	uDsBhjbgg9eud+6DFoawl6eynX/5wHgXUFEfSl7Rwtmmz2O5pM+h0PN2ITIxM8Kc
	sbkyaVMHGNnHrp0qSRLhUBtgKI0hVKN+QlG+6XUS7xAoJmVZ7aD0qjxTkCuzFJxI
	HXH61j7YmVRzmY1HpqQaHzanCDJINu0JzCE0oJCTWOnVGLZLtWZvyh3/vqS4HyBB
	a/Vq82ErFQ1kbIcpVFfyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700682679; x=1700769079; bh=PmsbO17EpDJPI
	KBqSJCwENxvkyCFjWrYwHTTrYaRFA4=; b=SFUY0LZFSKYWjo0mg0hmJv0CTltOz
	JYosCDJwSr56WpYys5IgWI7NgMHf39Rm/g3fko0PlYn5VjEwkHFzpo4qTk6Md1Tc
	kIE70+IgkIajCdcZtF0tOTvoQ+BblFRrERtdC95gvdr2YOyLjzPX0v/JyuFh6KoP
	DT4F22SoecjMMpsV22YCXGO60BYbeP8HXwQEW0UracVEM2wmS1+sYW8dUprhvMzO
	IhVSsCOisJoliHBaX9AcHVilq1N1DxWNLS2CF/KR39K31rFwr2CPDZGx0a85gbW9
	zVYOuUPy6W9fLI0eXBrDXMhbfdys20vvEN7dyrKc2sstxg50vKDKmA9JA==
X-ME-Sender: <xms:t1teZYmTNXfZi5V4NK5gvixRSQryhNrPcmt8iIwKc6tJZ9XOIocI4A>
    <xme:t1teZX0Dn_ywgUGt1SizZ9xXSxyXNnPoPg1_34nAyCbbLZO166zn4VMKqKV0D7lAL
    SyJJ6yb_vrv3oGBYzo>
X-ME-Received: <xmr:t1teZWoicwEGVBg6pvJm9GXuODhOjaJmwRjNk__Oxp8pHQgAx9RQ4rynWk81ibDwk_LS13QTQal3eKTHn6HGSj7T4z6QdC_a7EGz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeefhfelvddthedujeegjedvveffueeuhfdvleeuheeuheefveekudduvddv
    geefffenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgv
    th
X-ME-Proxy: <xmx:t1teZUlPjPngcan6e-13Bzy_RsM-4xhHhB0Avrpj-pxYN6zvqoVOKQ>
    <xmx:t1teZW0cifEDxISj5t1biTt9xdaaSu6i6LzqcwFizDd8b2ay-EG3-A>
    <xmx:t1teZbukTUIsrPkL0xzsiSt2yED8SqQi257wDbXGj8US5W3Bv1tIzw>
    <xmx:t1teZb-aODhZXvHxl9VDGT8a6qh3ucnxq-iFthJwmwOSpu6o0j8V6Q>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 14:51:18 -0500 (EST)
Date: Wed, 22 Nov 2023 14:51:15 -0500
From: Ben Boeckel <me@benboeckel.net>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: GitLab repo for keyrings
Message-ID: <ZV5bs6azAPM2UIMq@farprobe>
References: <268530.1700676155@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <268530.1700676155@warthog.procyon.org.uk>
User-Agent: Mutt/2.2.9 (2022-11-12)

On Wed, Nov 22, 2023 at 18:02:35 +0000, David Howells wrote:
> I'm intending to move keyrings to GitLab for its upstream repo:
> 
> 	https://gitlab.com/linux-afs/keyutils

Thanks for the notice. Is the patch submission workflow going to add
merge requests via the GitLab instance? If so, will the list be notified
of activity on them?

Thanks,

--Ben
