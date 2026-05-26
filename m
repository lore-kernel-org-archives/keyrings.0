Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4532F764
	for <keyrings@vger.kernel.org>; Tue, 26 May 2026 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763902; cv=none; b=T18IM2uVPuQQWogqQmKJniJJsS9gG0BZaTDHDOWb+4AFUvNEi9ziuNV2jI7/s0eyrV2Hhl2Q0/ZcaIBrzcbmI4saOkZYX1DPyWndeStlAEy+g4ANeLimy8T3LOZyJVc0icZ28Nfnc8LadWkNiQ/9SPq1VvInAUOoRmneWapSx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763902; c=relaxed/simple;
	bh=8vhr9Wg7uUxJbvzDz90EdzM/Ds0msmcqnAGHXjP3YZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5YpuYPCxei+5D2Y1jX4i/mAN6PlM0eMY09JXmias8HhDcvKqTFMNh9OturnYj9uPtAfp5VyxbSuc7mbJMekLnsuxLSJGqZzICmeSS4oLX4b7OLxLbPqf87mVCU/2sWMxSuaYsiOe32e765n3xTVZsansO1+6TqllhVi4gZxPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxPPFb59; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxPPFb59"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1370417c01cso1148097c88.1
        for <keyrings@vger.kernel.org>; Mon, 25 May 2026 19:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779763900; x=1780368700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vhr9Wg7uUxJbvzDz90EdzM/Ds0msmcqnAGHXjP3YZQ=;
        b=VxPPFb59pkjKpHyN3HrbOV3n2J0o8rhTK1OP5gELEswEOcXfsBXAt7O2aP+NfbYkeP
         Ri3NP6A7ZXEAs6gPP3eah2pHoLBtpiZDScvKEoVuJ3UHPBLGxGieTT1mflX2aZwuahkv
         oqQIQ5u1bZOIBKuNJ9/b4o4+asf6KoAxwMJ/Qm+eY0Zx9Ro7wcPIiPcPvvgrsHtCQUBb
         Po4r5exJ0viYHVE+Zz6fW841iKsXCx6ABigoVV22YRifpQN2nJ1ItE2JgZPxS+T39oC3
         hSqM5Tek1gPwf19wBsh/UIJaCtrPgh7DQei33XMBPey/U59Fv9MrmIoyRrAGukfproi+
         kpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779763900; x=1780368700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vhr9Wg7uUxJbvzDz90EdzM/Ds0msmcqnAGHXjP3YZQ=;
        b=lQowL+W0IvqL/0S2XJiaccSwWDEmcExgNQWCA9NrlZMtt4VhHWPl/blcmpCHRsPXi8
         mfpvbefztSo2HSUD2Ago7JXQqYLGtHK6XvjsPuH8uUe5Z0IiC+Ny/WMhKrJpLtCEpCP9
         pEB3dj/D/aw2qRExkxcFA4QUVFBo4vliZj4a2+/nufYLEIfyaXHpsnjZM9i1lQO+m5fM
         J6N7YCbPOdzp709CQDbjNExrocm3ThopRolhvX2F89Yp/MRveGFhB047IgZE3QipM+SL
         ws0LxEAFB4iR14rcFquEVxrfsBLUYzr4FPP9/F71r85FFhCPPnOwMo4i5d3X53VHJkbD
         BJNw==
X-Gm-Message-State: AOJu0YzPFnDCgEPlCdCovuLpKOLtiZgYxFspPmyL7jEJcGYM5AjOlHVr
	m07/u3orQjPVdKbJJreu4Z8wO1xPmZi9WVepArCRVfnEk9bMEfWT+mwJ
X-Gm-Gg: Acq92OHLBlzxjN3VxibajDB9GINOboo9vHaZlDtIK3bs/PVODrlkJ+Iyveuq+jY8rWX
	0TOGS9EbzpYgqxGcRAIQo5HzgjTCvv5xcelNxrHprHe10aF3gAs8lzW83TctRas2Tl/qQ8pTr4H
	F6r6ttE/dlelvKMVEBG6KV/7d115bhgW78Fka7qvhFsEzhuXoACXnCR0zoQgo8CJZ5XpC92w+WR
	Ysc9xBHLWF1pctInzmyA1ZODY79byrZ2p3yNYNw8BMFf00JlusYlIiUMBtfGlzx0+q5AqAUml9V
	fKStAlJ3uyyuMU30JjzHV6R6rjBbzwAEmR853SJaNXJ9RwVkuPHB1Ce+xi9VjrXgZUewqeYaARn
	VvIUQyWFhrfhHBcewLplu8bUxShtBt0s5mwmiaJX1CHTq9+ILjJRvbIssPPSP+wUooka+1we2oV
	ulFzvR7BpUb+mzsDPmRHDL13RDl/4HqmUALL0J/w==
X-Received: by 2002:a05:7301:678c:b0:2dd:6937:79cb with SMTP id 5a478bee46e88-30448f91fbdmr7196485eec.12.1779763899632;
        Mon, 25 May 2026 19:51:39 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30481ad4cd3sm5592363eec.27.2026.05.25.19.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:51:39 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [bug report] keys: request_key_auth payload use-after-free in keyctl_instantiate_key_common()
Date: Tue, 26 May 2026 10:50:50 +0800
Message-ID: <20260526025050.3369044-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519144403.436694-1-eeesssooo020@gmail.com>
References: <20260519144403.436694-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I sent a candidate patch here:

https://lore.kernel.org/r/20260526024838.3368409-1-eeesssooo020@gmail.com

Shaomin
