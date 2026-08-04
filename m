Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB932468C3A
	for <keyrings@vger.kernel.org>; Tue,  4 Aug 2026 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858385; cv=none; b=nkrVkFpJsJeYNRctqJ9XyUFTDh+KXx4H50ESIsKmKNEKfJobAY+HIuP6WD2bQZT2IWfsp/BXPYWeIO/gU/Ts23fFza4ndD7VRHQSIhaTWNLo9T71uxxKmLRB1kt6/X8reYLCDs6wPBEgVareX5hOOoHv/R9aJs9OJcvjTJ0Iids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858385; c=relaxed/simple;
	bh=q+kjQZGeNYkDUQaCl5pvpzjrayG8WHyTuYoZD3SgIHw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BHHfsICUNRXpdBLFQPfaMxsnr+uqe3zP6nL/y5n5BQ5xAkY8HC2jy95W2O45MBBStGkLQ69yOZSIIN9Xn/Vj9cXm3XoeRygc68bMaueAOtOaFQWKeq/DInFXmUi4eyinlqGpd/L/FGgIqiWShU1g144m3TlAafEPUYGdXDrTOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX4Pgm5V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX4Pgm5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785858381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+kjQZGeNYkDUQaCl5pvpzjrayG8WHyTuYoZD3SgIHw=;
	b=aX4Pgm5VYTKCYBPDjuQverFjPJQNMJ3JessiDQEQfviGiWFY0/xrHhuqZbNDU1b0fl53Nu
	yuhzNk0c2fpj+mjrpogPMy8QXw/GC2qumcKtV8TpyEfmhLh4MpPiLB+rK39A/uCFMMxhn/
	sJhVo6y5x3sI552ZuWYv0l4zG1ZS6pc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-7wP6TBZjPEOmoPUmdjIsNg-1; Tue,
 04 Aug 2026 11:46:17 -0400
X-MC-Unique: 7wP6TBZjPEOmoPUmdjIsNg-1
X-Mimecast-MFC-AGG-ID: 7wP6TBZjPEOmoPUmdjIsNg_1785858375
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BA31800364;
	Tue,  4 Aug 2026 15:46:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E9E61800480;
	Tue,  4 Aug 2026 15:46:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260803160627.GL51943@horms.kernel.org>
References: <20260803160627.GL51943@horms.kernel.org> <20260729160108.2031453-1-dhowells@redhat.com> <20260729160108.2031453-8-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Jeffrey Altman <jaltman@auristor.com>,
    Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
    stable@kernel.org
Subject: Re: [PATCH net v5 07/10] afs: Create a server appdata key
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2804995.1785858368.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 16:46:08 +0100
Message-ID: <2804996.1785858368@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Simon Horman <horms@kernel.org> wrote:

> [Severity: Critical]
> This is a pre-existing issue, but is it safe to cast and dereference pee=
r_data
> here?
> =

> When a network CHALLENGE packet arrives and is processed in the OOB queu=
e in
> afs_respond_to_challenge(), it reads peer_data and casts it to an afs_se=
rver
> pointer.
> =

> Since the code dereferences this pointer without holding rcu_read_lock()=
 or
> taking a reference on the server object, what happens if the server is
> concurrently destroyed or updated?
> =

> If peer_data is set to 0, this causes a direct NULL dereference. If the
> server memory is freed, could this result in a use-after-free triggered =
by a
> remote attacker?

Note that the OOB code is removed by these patches.

The other two issues here need addressing, though for one of them, the fix
will need to go via the vfs tree.

David

