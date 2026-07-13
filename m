Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33E035E1A3;
	Mon, 13 Jul 2026 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978187; cv=none; b=etGZzfN8eSD/P/32ON1SqhvXNL/TN385aWXGRKLcgAubadzX5CWLRmQVVJ4bzsaZGHEHllqc+i5wMRJdUqtHLNakpUpDmyXem/GEXAibl3gFXxLq635cpFspN/O1vARkRxtTKnw3r+zRuuYXhfqkyzYCxjJgjABGCGw7sY/8Q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978187; c=relaxed/simple;
	bh=riXZKB+wdpFkvAXkrUsMvOdoSkn9egwykd4ShYNkDnA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nzk268HqVriqT+kN3yQe8HPRUCGDbJw1k8/ZfP7Gr1BM7RJkh9pKBCvNGjlHgthBjVmkX+O9aCUpSFOoc07mMmKXBAclX73OcZX52AAxLPEqCSyM5Qc23Z/0JYCfUBkv8mV/8wbUttuKpcUlXjiY1AXkBRKeOCNQRVrcFN/uptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8qvbRU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8qvbRU8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 061411F000E9;
	Mon, 13 Jul 2026 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783978186;
	bh=riXZKB+wdpFkvAXkrUsMvOdoSkn9egwykd4ShYNkDnA=;
	h=Date:From:To:Subject;
	b=F8qvbRU800cl+hCTiRtIH5Bq2hqyQNuvlPb0VDu3GEoytMXxSdjupMhaNSmHdqzJ5
	 +59jFPMuN/TNlB+8K8PC3NenyAYpC8zQru5VQWH0WfSi7cG7ZISlXnkkeC5ou/LDw3
	 DmxBoVA76REruF0Vv3gcLMXKQX+XA+xecWwoURo8Coc7i5ucJpureyWz5YZLA7GaPa
	 vwq5qJ5FCt2nYBOx2jpeyylomQU3P+Wy53qccJ8MetjZNHbhZtuBInBlQFTf62B/ag
	 ciD79ZPXfITVfF44oem56s0H8PBXyYpjXYDyULM/KOA+xZXye6dNqDLgX5LlfvD2+S
	 hkhmYUps3d5Hg==
Date: Tue, 14 Jul 2026 00:29:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: AI assisted patches and credits where it is due
Message-ID: <alVYxv8esyv2SKpt@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sometimes get patches, which are literally just LLM output dumps.

Even finding out if there is a bug symptom/bug has been delegated to
me.

I'm thinking of followning process when this happens next time:

1. Do all the real work.
2. Retain whatever model was used as co-author.
3. Downgrade submitted from author to reporter.

I've seen also reasonable AI assisted patches and this type of behavior
just downplays them.

Any better ideas? I'm open.

BR, Jarkko
