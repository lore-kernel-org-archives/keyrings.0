Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44075650F4;
	Wed,  9 Sep 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967858; cv=none; b=aXwRhRFSxxa4I3pTf1Nox7wwn3ER83qVJl663aqOjRp0k8mGMQ2xefvvDBo3eTAb/267REti032sDH/XuuZFtmJeiot9UllcDzbrtVze5w3EXP7lHQkXLMrL3JaHh7FkdAAZO7DkeGD726EQ6Nf6ARYlKawxk0SaYFnNTsSFaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967858; c=relaxed/simple;
	bh=Xv7eeAykvmt32wxIiWTboD9W4gMckrkTtY+onFUhf3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srFVevdbd0zFIyUwNi1S/+6cPNdk0TkcnmR5rjJvN/AfyxJLt6lDKUymTgeFdtLPpwXVG8HxMCLUZNwizrWlAC3z0UCkoGz+GDEuXwVW3qpdHvFm9g5NA7XsmxPnAl2EfRFLy0rX+VZr8sV9S8ao92wGSPBCzj2SXjrK3p2rv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cNeKP4bV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cNeKP4bV"
Received: from localhost.localdomain (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3792820B7135;
	Wed,  9 Sep 2026 08:30:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3792820B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788967816;
	bh=Xv7eeAykvmt32wxIiWTboD9W4gMckrkTtY+onFUhf3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNeKP4bVyrue/ljPnhxmPPjmv6so3GBOFW3UcBtmKWT3Ys01Gy1wMUR0ZAU4CUERe
	 +pqP06zw06io4m2aLS8eNnVALakBoU2r1XyF8QXj70TQt5s1MfCOY0yF7d4PoPS1KP
	 THl6d3VQAqwoQEaQ8If0PX3zOxvX6z8fzVmTZIuo=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: jarkko@kernel.org
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	cenzhang@microsoft.com,
	dhowells@redhat.com,
	francis@akrites.dev,
	gregkh@linuxfoundation.org,
	jmorris@namei.org,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	roberto.sassu@polito.it,
	safford@watson.ibm.com,
	serge@hallyn.com,
	sirt@akrites.dev,
	zohar@linux.ibm.com
Subject: Re: [PATCH v2] KEYS: encrypted: fix integer overflow of datablob_len
Date: Wed,  9 Sep 2026 11:30:32 -0400
Message-ID: <20260909153032.82355-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apDrfyDB883Nl5Sd@kernel.org>
References: <apDrfyDB883Nl5Sd@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jarkko,

Thanks for the review. I'll simplify the description using u16 and
U16_MAX, remove the organization names and the off-list note, and send
v3 shortly.

Thanks,
Cen
