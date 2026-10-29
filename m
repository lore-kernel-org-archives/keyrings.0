Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252727;
	b=mlnWsuvxQpSu/qA480pxXmzXVh2aTdJEi7ndsi+mTAXkY7oX6/Rk/vP1S7Yo29ijX3N3
	 ocQqrKs5XLmpYn1cc36SqbhscNDGr7bYpv0ZrBBc/CupT2aNupvqKcZ+tkLX5KKH/SNVE
	 l7Yk919YOHmWqkxXcW9JaYIuixwM33AJVNbkCXvBzOZMvpIeg/mcoC3v3rqys19A5QH+T
	 u6N9M8qDsBjzRYJLbIPKNTGqN4VF7ACqFOP8YYG+NwwTDY4zqMKwISkxtx+Vs6y2mtZ2t
	 eBRGhaR4/1eq+MueQk/ps8mkCu6eeOQF8i9eKxiAXH4JjG3hgXujksCPjroJp4X0i/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=adSYFoYAePHJdbuRdaHU8dMgoKI+1ZI1I5xA5eoT1QA=;
	b=au6yo1lw6zYVPMyUJ8rcUWOpYQ7ufx3CtbE7YyxpgM+Z3OaSGxIIojl9QIpAqpwwWdHy
	 EBL4gvKuX20isg/t5G7R1308psm0EZO9xku3OF1IsIAUhr7bK0R1IIcsK6SIdeDG0WXoL
	 0uY61VIAh+7XX9ARoPGBE9dMnwL7p2tXvJlUEAMVAoedmYXQg2NtCJTYiUjBbBOfZQZbR
	 /UHNGlr8JHRMPPc1a/JJYy5K+3lfcpRC50KxYEhw7jOFeZO8nwuaMrqTI+0eD2WIBiVqo
	 CpnU6LokhhmU25gs/dnPEbA3dzzRLx1ZhndTAWg5MUuUlUWb9cYJrQKsbSaomT6oZpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Jg96Hof;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A88606A31D
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 05:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A88606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Jg96Hof
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35b2c599f43so3808480eec.0
        for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252726; x=1793857526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=adSYFoYAePHJdbuRdaHU8dMgoKI+1ZI1I5xA5eoT1QA=;
        b=0Jg96Hofm475on7M+bD3y2loejPit6r7Nm73lNMFr8CtE8Yx3nWrfC0xh6dhkIs5hU
         LKQwBIH/y4FLOj90dfz2buYbax+izjBJLxZ0iZmY0Iu6hpLYr/ELKHXlryxBGJXhKgYs
         zfoDgfSt0++gOk/BZJOk4p17ywb16bghajH3DiVauI0Rbs5cAIeDXtH06leTZbEBesqB
         fCXHdDm2v5VutKkOrA62H6R/uVPqkjgl0Cz5bhedxZLO89F6YHnoCLMhZQ5Qh2KGFkcC
         1q75Ow/s0DpKNzGVAVUpSrozSG4uWq/NSDLa9Zj2IELvT8oiznN1FH+/jRSU9j2FUkux
         k9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252726; x=1793857526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adSYFoYAePHJdbuRdaHU8dMgoKI+1ZI1I5xA5eoT1QA=;
        b=s6czXR8DZyTyRAxiNqp4pmTuj0WHdQ9oMvOYuSLRt/+aaVK+2j6wKyWpimGPcUi7GW
         4Rj7P65i+iig6NVeoDUxa6/MXVtdvILXx9O+aDn5vSQG4MqZiW1ugfMc0PTVzYzktIdK
         ntXIMhsI3+SoqX1jEmHgcmNt6v0wHfDIi7GrWdgrBMFAxgofIFYhgotlUqnnexJ4+tHU
         YwQfk71XE4thovPVAM68oJmS6VEonS+a7lisrqjcJjks9V5dtKh78kdQPR+xYAQTBz9L
         3c2z0Y7M5evUi7Jprtw6eJNPzjU0BtGX62hLONFKC1rc0yJKr0Dpsul+V3rl25AeUofu
         aG9A==
X-Forwarded-Encrypted: i=1; AKwUvBzBAeGWNP6YFLsMn3hlUo3r0C50StKOrCO8oLLSpC91981181u8wditvtCP6adsMZdcDkd7gJNY7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCB3MSBaRcUmZQ/Dp4e9jn+xUm9PhhFYgtkucvR03Y9jyqsoza
	nBG2w0k89246Fv2BJa/23I+f5xf5hQWi95bCdLTiiZl5hDu8rdE3vWPB
X-Gm-Gg: AYBFou2RfJMvPUReoPh0bLasaD+uRfEm7giSHRuhjF1+wddSgVs1/oXH14cNW4yX3dY
	dVG1QU/r/UkWeIcM6792NGQtkdZTmEb6GOx0M7b5UcAcJIZeg3olTSIhMzA6JNA2tdICV+2LHsB
	BYU4Q9onQG45Tg8LiMrDcOpTW+9GYyGEwHJbE8S2CCkD6WWk4SEqJ7IrTCgV9SeM8H59/7X1+c+
	WpR4FdPtDQw45JaU9NbfIdoM+RA6F6dbnVaKClTm8NLtgXWcRrY4hed3WEcBYXzsBLcUf0bZgb/
	LfwkZ1EOtZjYPfUnHx9FccvRPMt2VjI/dR5ExN7GhIps6SMhRGS7k7Un4frGmZF7KbSNxRh/gZN
	K1nPLWDb8bEsnzuQjygZbmggQDVFFc/GFpFGeg9GpRoMbLEq+wkndt9VkWpRvCdnG4cUeFmpOXC
	qOd5EftMFSJox2gV8+0/WcWnV4R6AzGtW100QfRRGJPBoik955/GjbXqdxqrqTRaJWuTqoDCigk
	OXgNzD8EsdMdA0iYNoFZ4WJGyl7hP83o8e3FyPJeNAGixGf4C/JEJt8zh8CbM2y3L9p+XuEqqs2
	GGWuy+7GMrsObEiZkz29i7bYew==
X-Received: by 2002:a05:693c:638e:20b0:369:9eea:cd25 with SMTP id 5a478bee46e88-36a204065cbmr6483826eec.7.1793252725624;
        Wed, 28 Oct 2026 22:45:25 -0700 (PDT)
Received: from lion.. ([166.1.190.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237bddb7sm12294142eec.3.2026.10.28.22.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 22:45:25 -0700 (PDT)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Cen Zhang <cenzhang@linux.microsoft.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	Tong Liu <lyutoon@gmail.com>,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] watch_queue: keep info_id separate from rcu_head
Date: Thu, 29 Oct 2026 01:41:36 -0400
Message-Id: <20261029054136.1174216-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct watch overlays info_id with rcu_head. A notification poster reads
info_id under rcu_read_lock(), but a concurrent final put can enqueue the
watch with call_rcu(). Enqueueing the callback writes rcu_head before the
grace period has elapsed, so it can corrupt info_id while the object
remains legally visible to the reader.

__post_watch_notification() then merges that value into the notification
info word without masking it. Pointer bits can corrupt WATCH_INFO_LENGTH
and make post_one_notification() copy beyond the posting task's stack
record.

Give info_id storage separate from rcu_head so RCU enqueueing cannot modify
it. Place it after the kref, which uses existing tail padding on x86-64.
Mask info_id with WATCH_INFO_ID at the point of use as an additional
invariant check.

An unprivileged shell and keyctl reproducer was run for 30 seconds in QEMU.
The vulnerable baseline produced malformed notification lengths, while this
change completed with 288631 key notifications and no malformed record.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/lkml/CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp9yPbjORWFXagA@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
 include/linux/watch_queue.h | 6 ++----
 kernel/watch_queue.c        | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 429c7b6afead..b87e1babb5f0 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -52,10 +52,7 @@ struct watch_queue {
  * Representation of a watch on an object.
  */
 struct watch {
-	union {
-		struct rcu_head	rcu;
-		u32		info_id;	/* ID to be OR'd in to info field */
-	};
+	struct rcu_head		rcu;
 	struct watch_queue __rcu *queue;	/* Queue to post events to */
 	struct hlist_node	queue_node;	/* Link in queue->watches */
 	struct watch_list __rcu	*watch_list;
@@ -64,6 +61,7 @@ struct watch {
 	void			*private;	/* Private data for the watched object */
 	u64			id;		/* Internal identifier */
 	struct kref		usage;		/* Object usage count */
+	u32			info_id;	/* ID to be OR'd in to info field */
 };
 
 /*
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 932a88ac1f39..453dcf613205 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -212,7 +212,7 @@ void __post_watch_notification(struct watch_list *wlist,
 		if (watch->id != id)
 			continue;
 		n->info &= ~WATCH_INFO_ID;
-		n->info |= watch->info_id;
+		n->info |= watch->info_id & WATCH_INFO_ID;
 
 		wqueue = rcu_dereference(watch->queue);
 		wf = rcu_dereference(wqueue->filter);
-- 
2.34.1

