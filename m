Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410041A792
	for <keyrings@vger.kernel.org>; Tue, 11 Aug 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437280; cv=pass; b=N5VFqWuoREBeqs910fEkUXx8FRNPRexIUCgckQFvqsG0MwhZMKEged+V8IYMIvdF9kZQtc4MYmxKTROxvASaALorTULXqgNCVqG114jbhPIiyHCNFMjK2ybm1WSsE51wYQ2pmQCSrv2EIqntH1D5DKRKsuw6TKC/a124j9gjGp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437280; c=relaxed/simple;
	bh=HkedlUJRK2NaoVVLLEdjZGUCeAs/seI8pDMStai3ezQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs6rwgSzhwMbyz6MI8oMUZQTV5+SmdNZ+m1q5pJJvtmZXfhoEYqO3Mq8CBhGoySXvFsTdBLMzMXv2O5fmcTmkfdUYjOQ6f6xDR+l3IYg8NtjZKP/beAjYgriA/c9cqlvW2gk+sjU5vIKqa+Vj2GEF4msgmxd0QPcS8SEQJQusqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hstl9w6X; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hstl9w6X"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so1245838f8f.1
        for <keyrings@vger.kernel.org>; Tue, 11 Aug 2026 01:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786437277; cv=none;
        d=google.com; s=arc-20260327;
        b=BdFOhuYfF9eXzEjcKgHNfB7TqMGCSASstmKnNvvikJw7Ramo+zP5uuItWltoqyPIyt
         hMJ0LW+MZt6/MTrejhFRQgIrbbWGVTzmz0RlHLo0R1EdVdK15FRYlmUUawesT889t3sn
         QyUV+AsazMG+5GytsCLno869FXvhucL2mVfmXGI2vfzHf6ecco8xAAlzyvI/nADzGZ2L
         6W++RfP5cN49g9N6Qz6eUQXuvMX99EsP8eJEB24o9uIcvdP7WOy/M4wBTO6wiF1bacYv
         x1HwnojlgWfmEbPv5Fm84dWYBtxM7UHqBb33dYBG7ZF31XdWK88gT2f31Y8XQvq8d/o7
         AT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=npLC6PjTwERUQHslojU0dg0CwSTAkb6KsuLFcLO1PDE=;
        fh=cbqjNuM6xdlyi6AXL/Pq16Hauutpk0Ouft0serBouKU=;
        b=QQOsDz70PxzyhFzZemwRRlQv4D6ZsGQN9uBeJW0dUxXTnTwLulyD9GqK0lQTri0rRg
         ZEiAGyBNNAQX3OZb5KHRgIc8W9XlPbxa9P/YnyjnQCLsiZVyN2LJex+Dl/aYGRQnf88a
         vNWR7vxFGvQlkzg82JEGfNvm49E3PvU5khu5IfcHFmHiK9XOF0l7vJP0XG8722MMxroQ
         q+gzKPZdHyoV1TR7+UhGQrUPHKAO2NNSg0gTFM8Ndue1g0pPXWmbf2nbAS+mmk3g1uuV
         fb05gfElbM5AQvPw5pCtlp9TRRHS/epSI9KDni5XQrX2DD0DV4TaN3HbfWnGGur1pyUr
         XsGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437277; x=1787042077; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npLC6PjTwERUQHslojU0dg0CwSTAkb6KsuLFcLO1PDE=;
        b=Hstl9w6Xm0qG5qDSnjakvnW3JqKL1hFLRQ3+DJbSJE9oX/0PcDS3tQ/GoW0q5qhJaM
         f6qY0bVyImZa9aVKXAIfEZonkocpnVtE/siyKBcOnClP179m3o72ooufbaZKJlw9h9XR
         h6r9qnCoEOyuZWRcO1/t7KJnCWB4TIuhWrWyNS7cDxBV0txQWVqFxun4ZMGhkp9sFrbZ
         FxTWXvFWxKvL6O6lnaZuBwcn888S1q/CilAPWXgBv8bmf6KXa03EjWStux30/z2Z4TGr
         ukfvFvc5mzv4v+ae12RlqI9cWjadr174ZFHEwVOboz62zJ4jYIA+UuPIIWtTNwE51QRd
         OR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437277; x=1787042077;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=npLC6PjTwERUQHslojU0dg0CwSTAkb6KsuLFcLO1PDE=;
        b=Q06svskQM2h5tmEt2DYZggSytMpyRQGKLjEoa8znPiLVbTxAIIP6WupaqLKKmeLQ5s
         o+b9cIXX9Uf/3JrdrOCmAvjsgYBcSpRDdp94fAvGLa7G1sYK/aemGUtXfWeazBB+deoW
         p2mouRiGijde39BzJZ/y9a1x9x7J75x1806lcnG/uIY/PzXSh4lNI7Q+u//R7GOtjz72
         s1jZZJP16VaRWa1QEpwEEYkkw30P6yMRJAavgdV2/OPF+cNx1x5pDw710hFSmC4q3aAW
         ipMVGyZX6dZ0d1xKNpM6vE5zjFdXBlKcPWIyreXgw03qleFu3pHCHzvqXIZQ67d0QYFZ
         YRHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCriUVM/4M0YHJxNINBer5kwcH2Xyge/Ge1i6iTUIkiIeNwS1mL50bycKR+KikSdIsNn0BC4Qvsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywjL3YEFzlG3ws0NMZRaLEhXLYrRyxzl7IdQNcmfsfXxIb8/Rx
	BkYu+6thj3P8ONdcOcWi/Ru95eHTizCSHn652Xy89/6dF91ScwPqLdtDoqnW/xCvC/NU0diMotT
	3WpUgUTrKg0RekUJohHRWVpleY6wgu24=
X-Gm-Gg: AR+sD101tRVGn8dYiH8EQQM4+kO6oCG+qjbvmuX4QTJ8J5Vpv7aMW8jwoD9/f+2CUDW
	+JCtdUx+Uaz3MjOHsUIu9mET3Mv8NP+0oH9vFEZ4s/hp2gNxSslRBpaEtyjN5hwoP/GHcNCYKOm
	0Lh0xJrdicU9wbzdj73LEaDkx0WVWIhBDGlYckeSqHa+Zt61rP7dKkMjOrBIm6440fN1k0l2lEZ
	uX7b2gpXQlx73dIUAopj/yrQx5dr8mAWQ7t7k/hWxIMV6BPdLu4j+fkFoz54EDmUqPdyWleOZjo
	H6U1heD8VWGvXR5gvAhHT8G1JZe9G4QJgivaoQ7FAUfx
X-Received: by 2002:a05:600c:1990:b0:499:78b3:7b34 with SMTP id
 5b1f17b1804b1-49978b37c3amr18300885e9.2.1786437277106; Tue, 11 Aug 2026
 01:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809110202.2180410-1-maoyixie.tju@gmail.com> <8a5ac8ef55346825f57f8d3966b312f3d1152c2d.camel@HansenPartnership.com>
In-Reply-To: <8a5ac8ef55346825f57f8d3966b312f3d1152c2d.camel@HansenPartnership.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 11 Aug 2026 16:34:25 +0800
X-Gm-Features: AUfX_mzXGj3FLueDWlUGBha_pzgfc6RrUlO-FB7YwO7ed2qZJbTFdwmCoTfa_lE
Message-ID: <CAHPEe=FJCf9Br7jFqd-89bFZt+aDRwdmj-N2i1-0-+ypFxnsLQ@mail.gmail.com>
Subject: Re: keys: request_key_auth shows a global pid in /proc/keys across
 pid namespaces
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 11, 2026 at 12:50 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> I'm afraid this get_pid/put_pid doesn't look right because what it will
> do is pin the pid in the creator pid namespace.  Unfortunately, some
> keys and keyrings aren't bound to a pid namespace, so if I create a key
> in my user keyring and then enter a new pid namespace, with this change
> it will still show up as the pid number of the init namespace (pinning
> the struct pid there) and vice versa, which still sounds like the wrong
> behaviour.

You're right that get_pid() keeps the creator's pid_namespace alive for the
auth key's lifetime. But the pin does not change the printed number. describe()
renders through the reader's proc pid_ns with pid_nr_ns(). That returns 0 when
the task is not visible there. A key made in init_ns and read from a child
pid_ns shows 0, not the init number. It never shows a foreign pid. In your
example the pin only holds init_pid_ns, which is permanent, so it changes
nothing. Auth keys are short-lived, so a container-created key holds that pin
only until request_key finishes.

> I think if you really want to fix this, you have to keep the pid as is,
> but make sure it always records the pid in the init_pid_ns (i.e. always
> translate back to init_ns) and then translate to the current pid_ns in
> the output generator of /proc/keys.

current->pid is already the init_pid_ns number. Keeping a struct pid lets
pid_nr_ns translate it for each reader, the way pidfd_show_fdinfo() already
does. A raw pid_t would instead need a find_pid_ns() lookup at read time. That
can land on a reused number.

Thanks,
Maoyi
