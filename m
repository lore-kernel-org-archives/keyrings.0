Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922903;
	b=lvaNbJJWzHyOWCIenFLY1ZnoF7o9c9MZ7LPfzgtn9tFV6xf65TU9fBnqpD4Fi/uYMHO8
	 I28oIlp/KDN6WzI/nDkvw60zK5uB5yjxnC4DBov8+GYVkhyMepgeexP5DIKt/58n2sraj
	 EidvbYOE+RvRkkEBKpMC106M88ULhoxLn792oQElPFmwBUosvLWlHaTnBJrDXJeCzwEjE
	 vTJmw5CD1J8YDK28QE3ptnzvaqoYNr/uTLBVVZK3XXLXkJlg1avt5fvKVcbHxAB6n84W0
	 t7TdJuiCm0HLDdCkThnnwAMYusHKZCxFRgo8Jw+fBmlDD8dCNzKug26wCwo4iHMIRww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Type:MIME-Version:Content-Transfer-Encoding;
	bh=gd8u4DpC4RvoE8YtPPq8fqDhjw3LSFLAZrCNVq9YjRA=;
	b=z+b/5jFT3ER/z2VPY6zhZANNfYcujmwIuJFYJcdAadwGktR4beHeE/aIYcdFawhTMNpu
	 RKLeFoa5MlAaGKkhmbIr8UCD3D/ox3ABy9Di06SGHshNUttTseKT9jS2DHy6b5MDpc3Vs
	 76Sbr+Stbh3wEtS9fKgYmMuTRWXUxSLv9/XLRaVsQsn8m6dj0OQqBz7axuXADoGL6bPNP
	 IDzaWHp7m4SJB3rF+8fwRHOY76eL7Y7fK76VnSa2jvUJ7Nq9Fu1jYeQdpa9cQWBcMyJ5W
	 /+V/Qg6WVR7Bl1lFRTH6CeEg8s0D3wTbwsJJH/oLaTpsWix0sybvqDpcBjJgM7Sj3pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLC5e5FW;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD03606A32A
	for <keyrings@vger.kernel.org>; Tue, 17 Nov 2026 13:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD03606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zLC5e5FW
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso2403495a91.2
        for <keyrings@vger.kernel.org>; Tue, 17 Nov 2026 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794922903; x=1795527703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gd8u4DpC4RvoE8YtPPq8fqDhjw3LSFLAZrCNVq9YjRA=;
        b=zLC5e5FWJQnWBfqCiXxfmNT4RaBsCPwYnuWmu2EilziawZZN81B6/Nd8aDR1/DRhHY
         1mLyu0jYEBSWcX/m2AElZpCRy3TG2DFrjzG7s9yLnY4410xW5iA6S20bj7JaC3bQ/aEo
         pd8kdeqYDEzONrnsXTJqVneDGKse1WqREIZSrqulPUQcHmv7khVEZpa3yo+BcMz0Ck+s
         1HfTiM0M1eNV3nuJvg0Rl8Vw+cZp3XY9rP0fabymH0wGRa/8MuqH/abSs4c8NhNDfV3Z
         7a6W8suBktJsXclq7WnV8hYoAQWY09B4FxwgZ7qwJ9jShtwKbJnBQbC7GiQIPO6tCzaj
         c04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794922903; x=1795527703;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gd8u4DpC4RvoE8YtPPq8fqDhjw3LSFLAZrCNVq9YjRA=;
        b=vrrBa7aKBZUjSOLFbYzDgnbCpBHg7SrlvWXmIUvm0l1JRzWIbTX9NWuYMVrZo1wQ8c
         VJkLZZ9HgajqoZLjFyODQbmPMGrnpmNW7QYfKUU/htTX8AeHpBTCA3v1i7zbsCDTL2L+
         4N+fNc9JLGxC8ty0mr19jrCeZisji6Yk3VMldaDGgawkG5DsiSZoF53O6HiW/qv/nA6j
         ldr9aktkrI74OhhiZ0VLpOUkejroIY1af0J+zdlftgArtL7p+XIiB/JrwulIyFyAv3Ln
         07tcNAavyrOGVe/LMPH9nv/PO+q2MzXsxVb760A4T3EuuTJ6Zb0mKtoP4eBaRYpQg41q
         HLdA==
X-Forwarded-Encrypted: i=1; AL+hErEas6NKxOI9gfsIc7gOu1vLL3fCjMGR7IZyrRFvfOh6jVFutwyqVx0PuS9h0wgkunkXNM8imYzTsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hUbglLLr3HTpt3L6nzZ8ZKYNDxPiyeipErCWGcoILn4aTVMFs
	6SxYNFO5+6dN77nNZVzHU8YqlFNjJUC4TsbSRTT2Jvm3uEEmiQ8Hr/gAHZBWbg==
X-Gm-Gg: AZFdTZcEcIwaMts01cFCXEmNYQn6V+onlUfzUyEPjYnNA6ulWkeMwJcUpF8ykgFNZVL
	cwtRCBvXf62cCkObDjr6GAdFH4VhrgbfIP3KeIzd6XIQaVbFtz+NHOfTELJM6Zy+SoMH7KAVx5V
	sprzvK8qJHjT5O8ivnzVUTNDk0BURc1YLI0PnrwyuLxE862Xl6plrnuaXs0ZbLQTmk9P9IwjdzM
	JgUTf/BLyFSO1BZvA5FO1MPrmwf/qZac1JfFhCrPluj/daQiJq7trCgrz9iTPXR+IhF/0NFpfwV
	btVKCyHBvGW2oOdvnyxHDT3jLoVVJkR4Z6KT4x2AxpwnMvxQxpYIiKATpb7RyxlXfeIQt1tF5TV
	Yq0+O3yOcRK3L0gsUV9GahbfS55kArboGXGVh5wstqRij+EwnLSUtU/iGGJDA7MzOobjmlTo5iX
	VvJhMt/zzWeUhQcbYTpColKMxYx6/bu1GyU8vAIfzvz+QEFdXfgoDBrv4+eZPN2bdrlzh/uTdK1
	E5b8aZSrp32HEP1nm2IDypCWJu9XCUi4mPMd/sHEMcsNzBVMcllanpuH5snCg1HfOoWcPxy2IVn
	CZix4DDY0eyCcvsKlnw+G9KUeNLnVwrTtu2zHwDXSA==
X-Received: by 2002:a17:90b:2e47:b0:3b0:9317:5849 with SMTP id 98e67ed59e1d1-3b1b07e9b25mr10928260a91.1.1794922902805;
        Tue, 17 Nov 2026 05:41:42 -0800 (PST)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac2cca15sm4158773a91.11.2026.11.17.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:41:42 -0800 (PST)
From: Daehyeon Ko <4ncienth@gmail.com>
To: akpm@linux-foundation.org,
	dhowells@redhat.com
Cc: jarkko@kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] assoc_array: discard shortcut when collapsing a leaf-only node
Date: Tue, 17 Nov 2026 22:41:20 +0900
Message-ID: <179492189322.898945.11218563093551350188.assoc-array-status@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925080548.2505640-1-4ncienth@gmail.com>
References: <20260925080548.2505640-1-4ncienth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
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

Hi,

A status update for this thread:

This patch was posted on September 25, reviewed by Jarkko, and is now
commit 37ff457ec467 ("assoc_array: discard shortcut when collapsing a
leaf-only node") at the tip of mm-hotfixes-stable.  It has also been
carried in linux-next.

Mainline commit 48691075b0ad ("assoc_array: don't chain a new shortcut
onto an existing one") has since been merged through 666539eecdf4 and
backported to the stable kernels.  As I understand it, the two patches
address the same consecutive-shortcut topology at different points:
37ff457ec467 removes the preceding shortcut during deletion collapse,
while 48691075b0ad replaces that shortcut when insertion would otherwise
put a new shortcut behind it.

The recent linux-next conflict with 1dbbde3bc4b8 ("lib: Remove
assoc_array") prompted me to record the relationship here.  This message
is not requesting a code change; it is only intended to connect the
public histories.  Please let me know if I have misunderstood the
relationship between the fixes.

Regards,
Daehyeon
