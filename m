Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C014028E4
	for <keyrings@vger.kernel.org>; Tue, 19 May 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201881; cv=none; b=chRDUaMXK5vYAxtqA+NKxcfbjEclxgKHHV/iCqg0VjhjOjV8h7FoOnxbVf2rhGUsziMg7La5ZuC/EI7rfMgP5sVFdUVjRFOWrTbpLdBTg2THrgjr91ug3yxWrBZLmvbgkWNX378MJCyP+VBwmF3WWOal+yNb3t8nb8jju9Bgeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201881; c=relaxed/simple;
	bh=mwiEUl6i8qzKyhgvrXCmm8xKF60p0orj3WXB0AZY4AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nc3cW+oURf043yor1WXH1CqnojRNDfJyJFHqeXSNN9xVekPbHJt6PFBSnOu2BEXA4R1bO7zMM8TZO0EMK/aKIv2dj4B1WkU7rSTB+UN58uQESBRcjrlLfHUcbpaE0qsq8asxvc8fu/djYpkjheca1DYRAbrmHNpj1GAlVB+sz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3spdfcX; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3spdfcX"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1353c2f35cfso12389813c88.1
        for <keyrings@vger.kernel.org>; Tue, 19 May 2026 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779201861; x=1779806661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Seai4fWqb4mwDhLXDN1f51FodXQt4GGEE1K9qVn4MNo=;
        b=s3spdfcXlGF5UYUVsQgY6pxGGTc0bC+D+uuP2ZPM/qi39+sQcCmC7qd2m8D+fqyVEv
         LmqEh5jfhQbsO4Ysv5cUmsZam/+e4qG1k+yeCc/PjiyY2Ruegm/R7x+M5DXuqv+ioXlf
         hgX9He+tq2yv7Q/K2lgrA1HDCvb8kN2F+U1ZPZGPhu16e9cNhKp2z6Bref0i724LBxk3
         1EwOEjMEwRC/Tl0fYByXSVNeh/l3HkR5pfS9V1NseozJksO0kVWmJxBOr0/Dd9GPof4N
         HBpeH4oxuG725Zbyq2t3LxKSlwrXSrUE4u4+eE2fCW3nNJ/sfCQBdB6zJK0VmCb0V989
         RtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201861; x=1779806661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Seai4fWqb4mwDhLXDN1f51FodXQt4GGEE1K9qVn4MNo=;
        b=G/S103kZOw031bPJaERZPMZZrbeacUhiiIUo64ASqsFDzkc7MrVt5v2LASKeKt5nwf
         z7nEP2kFw8vKmb5umqmfNRLFnuoz9yZUV0rLzE82OdxUSzZz0zpLsNsV3TTnO+UzHYHD
         E1K32E49VpIIcVSxT00qsLosDqj0lFBznxMSgrqatJZDBysdLBWBfom796/EAu+ggV+c
         8mU0/mh94gD9QidxsUF2McFZK0H7ZAjFahiMNvqhgGuwdlTSMTnNvjkssYpruvwlYCwF
         SxWKl/x82e7XFGPH7RlGLw3OelkO7o5+BGXeKbe0chIhmmTJuN2uSMELwe/GWPvs2ZW5
         GLLw==
X-Gm-Message-State: AOJu0Yxn0oYHkbgJ05swYwL6u2IAjUJaYvbIAOZRNeTlaV4jELhYZh2L
	z7o3cWhc0JofKW0tSgNXnzC6snivJDtXsAmNX7fM4vt2YsyJsNl+IOlXt7e2+Wiwk77ewg==
X-Gm-Gg: Acq92OFyIjIbQpk8NOFUzs2rT43CJcKk3SFCijkC0i/VXbekDqm8IAp/+8IQvXfkZlR
	XFYH3tJPkRQ+I8DwkkitV43DyEaG5mQ0ygBm7YjbtM90E3wq4vFlF2JRiLro15AHHBHk+vPrvin
	FRrwnSPkC3xK/qKnKMnBmhuMA+51W+FDcAliXdwLbupgBF8oW5bcHQU3ect4F2p7FCUfOeamSEL
	SvE0jEWprf1+Y7ydKwsPX3VJk/HLq8oHZzahpUGDzNM1Bw2ER7PSsx+L7RRvcwJ8esoJpLbALBD
	1eCM4R+eKJ258aTC+Y7zJ+JTE+orhw0/lrmGVlPNa567AwqA+JV+H2nyo8xioTxK8W7RwvCSAxR
	TFGJWtav/1Nmhn5DJptnv5fqkIDOyc9z9vE9sCNuMi8MsHjx6xlL1yDZoIJqBiyy/pK3/tahg88
	rQBkdPHeRJiz4mLOoEIzG59R3JPTfStDwIVTyU3Nv+MepbJA8x
X-Received: by 2002:a05:7022:7a2:b0:132:2486:acb with SMTP id a92af1059eb24-13504415962mr8368979c88.12.1779201860844;
        Tue, 19 May 2026 07:44:20 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm1276868c88.14.2026.05.19.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:44:20 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [bug report] keys: request_key_auth payload use-after-free in keyctl_instantiate_key_common()
Date: Tue, 19 May 2026 22:44:03 +0800
Message-ID: <20260519144403.436694-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

keyctl_instantiate_key_common() can use a stale request_key_auth payload after
the current request-key authorisation key has been revoked.

The relevant code pattern is:

	rka = instkey->payload.data[0];
	...
	copy_from_iter_full(payload, plen, from);   /* can fault and sleep */
	...
	get_instantiation_keyring(ringid, rka, &dest_keyring);
	key_instantiate_and_link(rka->target_key, payload, plen,
				 dest_keyring, instkey);

keyctl_instantiate_key_common() does not hold authkey->sem, an RCU read-side
critical section, or a reference to the request_key_auth payload across the
sleeping copy and later rka dereferences.

One race sequence is:

	Task A: request-key helper child        Task B: original request_key path
	-------------------------------        ---------------------------------
	assume request-key authority
	enter KEYCTL_INSTANTIATE_IOV
	rka = instkey->payload.data[0]
	block in copy_from_iter_full()
	                                      helper parent instantiates target key
	                                      helper returns to kernel
	                                      complete_request_key(authkey, 0)
	                                      key_revoke(authkey)
	                                      request_key_auth_revoke(authkey)
	                                      rcu_assign_keypointer(authkey, NULL)
	                                      call_rcu(&rka->rcu, ...)
	                                      request_key_auth_rcu_disposal()
	                                      free_request_key_auth(rka)
	resume from copy_from_iter_full()
	get_instantiation_keyring(..., rka, ...)
	key_instantiate_and_link(rka->target_key, ...)

I reproduced this on a current upstream v7.1-rc3 based tree,
HEAD ab5fce87a778c, with KASAN enabled:

	BUG: KASAN: slab-use-after-free in keyctl_instantiate_key_common+0x1dc/0x2a0
	Read of size 8
	Allocated by task:
	  request_key_auth_new+0xe0/0x4d0
	Freed by task:
	  key_revoke+0x62/0xc0
	  call_sbin_request_key+0x6cb/0x740

The reproducer uses a request-key helper that forks a second process with the
request-key authority.  The second process enters KEYCTL_INSTANTIATE_IOV and
blocks in copy_from_iter_full() on a user fault after rka has been loaded.  The
original helper then instantiates the target key and returns, which revokes the
auth key and queues the request_key_auth payload for RCU freeing.  When the
blocked instantiate path resumes, it dereferences the stale rka pointer.

I can provide the reproducer and a candidate patch.

Regards,
Shaomin Chen
