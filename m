Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274849;
	b=M8ttUT/LjkkqwJdznJY/h1SZg4xY7FkWEHTp5FMKbYfH+yoXwiQ77z2oPVNUpd3uJsQT
	 OVSLKm7VUzw0tzaGHY4+KQyYDkGeg8UHQTqZ0KlfhC+b0pfDZx+COkecyAUEMKCz18rH5
	 tUwhf0wkAd66vOzyUJfd3Pr/QV1DozH6AR2yX7vvvzgyCcn0wk0INEXEOcInp8AQScHJs
	 f8nQLsW6VzlnumFVBXD2Tv504R4HUDVvoVkT92CjDw5NQdhPjlFadbiUI2AJWRjzk51Ty
	 8mcRO4bhWBfMVDxzMx3hqISCLhjvyRLs+BBLq+I9OcyLLejG43K3qCK/2YbHpeCFuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274849;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eJDyqgU9FOsXJcH6m0AcGWyo+0VHAJgC1XncPyxjCcw=;
	b=CjO1PfbFKspa5Kt3Ne+Dkp4OPYg8UGILdMrFkLEC3GQ/WWEVLr9RQ8hfDgCBrNy7ZZrJ
	 Ogo5/gIK+C5dK3sbTYpk7zMj4uoWrl0HvkIqd+OK0+Zooqjo9zP+hcWKZPbtota5i3e+1
	 Q6GfyUlEP10QyH/JsVMOauspedVMeCl9WT3JUeDeK+NCiiJfRxULLSVclUM6f30eNj5FV
	 BGUWQd7BdER/7VlFirk2yt8v1j/t+BEFgUhvIj7dtyQkbFPXLPQVukJx699JIFnJkNzUP
	 C6dwpyRn12KA7qAM/jWsWt1fFF1aMbsYChY9Z54l9jQvbM1TlZOu1KWIKupdrNt/dlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=AN8EVe5N;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b="uIEu7m/w";
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65869606A31C;
	Thu, 29 Oct 2026 11:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65869606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=AN8EVe5N;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=uIEu7m/w
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793274845; bh=eJDyqgU9FOsXJcH6m0AcGWy
	o+0VHAJgC1XncPyxjCcw=; b=AN8EVe5NPQN7vQpsrS5yN7cxtD1l5eBZ8a3+PGsfyP0KqYQFLo
	g991kAC9h5B2gRgZ8LvLGVxq5GZhJMcpi8peAg/1kBdq8sRJTGCJ+urC/2DpZXyr63jhDUwZRul
	zfW1j3YjpAYHh2UvXbgn9wM5ZbHWyJbZPsVx6M25Fd89RC6cXS7QCa8hG6dUH54u9FiFSY+EokQ
	IQYRTjgyZCIQ4jS9dqMAVdLn9cinBDd3DZDhtomqoCJWyiuZ7tENPpJDC3sLCmtGXqrSlEMJJHa
	6lLavuZrjdTV40OUQKIkW8n4HrAqL4TuhFyYjFEEqbqLYKdqzWUZyff3S9YtB2uBKwA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793274845; bh=eJDyqgU9FOsXJcH6m0AcGWy
	o+0VHAJgC1XncPyxjCcw=; b=uIEu7m/wZjWxEVNzMmW1Qv4BU2EnwCRWe1Y21b/cONryQZXwvV
	KRz7W9qiGb6mbrDmdKLPiSkrdOEQfV22TRCw==;
Date: Thu, 29 Oct 2026 11:54:05 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Christian Brauner <brauner@kernel.org>
CC: David Howells <dhowells@redhat.com>, Cen Zhang <cenzhang@linux.microsoft.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, Tong Liu <lyutoon@gmail.com>,
 Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH] watch_queue: keep info_id separate from rcu_head
In-Reply-To: <20261029054136.1174216-1-zhiyuzhang999@gmail.com>
References: <20261029054136.1174216-1-zhiyuzhang999@gmail.com>
Message-ID: <ED50AF35-3C50-4298-BC99-6DC06A7E14E0@mainlining.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 29 October 2026 05:41:36 GMT, Zhiyu Zhang <zhiyuzhang999@gmail.com>
wrote:
>struct watch overlays info_id with rcu_head. A notification poster reads
>info_id under rcu_read_lock(), but a concurrent final put can enqueue the
>watch with call_rcu(). Enqueueing the callback writes rcu_head before the
>grace period has elapsed, so it can corrupt info_id while the object
>remains legally visible to the reader.
>
>__post_watch_notification() then merges that value into the notification
>info word without masking it. Pointer bits can corrupt WATCH_INFO_LENGTH
>and make post_one_notification() copy beyond the posting task's stack
>record.
>
>Give info_id storage separate from rcu_head so RCU enqueueing cannot
>modify
>it. Place it after the kref, which uses existing tail padding on x86-64.
>Mask info_id with WATCH_INFO_ID at the point of use as an additional
>invariant check.
>
>An unprivileged shell and keyctl reproducer was run for 30 seconds in
>QEMU.
>The vulnerable baseline produced malformed notification lengths, while
>this
>change completed with 288631 key notifications and no malformed record.
>
>Fixes: c73be61cede5 ("pipe: Add general notification queue support")
>Reported-by: Tong Liu <lyutoon@gmail.com>
>Reported-by: Qi Tang <tpluszz77@gmail.com>

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>Closes: https://lore.kernel.org/lkml/CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp9yPbjORWFXagA@mail.gmail.com/
>Link: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
>Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
>---
> include/linux/watch_queue.h | 6 ++----
> kernel/watch_queue.c        | 2 +-
> 2 files changed, 3 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
>index 429c7b6afead..b87e1babb5f0 100644
>--- a/include/linux/watch_queue.h
>+++ b/include/linux/watch_queue.h
>@@ -52,10 +52,7 @@ struct watch_queue {
>  * Representation of a watch on an object.
>  */
> struct watch {
>-	union {
>-		struct rcu_head	rcu;
>-		u32		info_id;	/* ID to be OR'd in to info field */
>-	};
>+	struct rcu_head		rcu;
> 	struct watch_queue __rcu *queue;	/* Queue to post events to */
> 	struct hlist_node	queue_node;	/* Link in queue->watches */
> 	struct watch_list __rcu	*watch_list;
>@@ -64,6 +61,7 @@ struct watch {
> 	void			*private;	/* Private data for the watched object */
> 	u64			id;		/* Internal identifier */
> 	struct kref		usage;		/* Object usage count */
>+	u32			info_id;	/* ID to be OR'd in to info field */
> };
> 
> /*
>diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
>index 932a88ac1f39..453dcf613205 100644
>--- a/kernel/watch_queue.c
>+++ b/kernel/watch_queue.c
>@@ -212,7 +212,7 @@ void __post_watch_notification(struct watch_list *wlist,
> 		if (watch->id != id)
> 			continue;
> 		n->info &= ~WATCH_INFO_ID;
>-		n->info |= watch->info_id;
>+		n->info |= watch->info_id & WATCH_INFO_ID;
> 
> 		wqueue = rcu_dereference(watch->queue);
> 		wf = rcu_dereference(wqueue->filter);
>


--- Thanks!
