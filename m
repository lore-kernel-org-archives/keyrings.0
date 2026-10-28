Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202108;
	b=aMY2QWov75jwtaCVqN+uZjdODIqcotSKBm2tSKsuMgflFmA4cFlIuCT/qDvMC3faL3Ai
	 pd4LsvYmuUm6LC8Of3WWAin6R0jgp4rIgcFlR85xlv0wngsjMR+RQW5KTxeaOPUADRbjq
	 9TG22QC6WmdEZMsMQM/PC+ItM/8+VBokfKXg/vDmSHfnKYrJTlDCyYsPIXg0QVkxJieyj
	 nd8Tui2ziWlTXSp+/rFP4kgkWsKmkYxXLd+GinTCTM7lGbbfx0Unqgj1PlFR94EKlxQfh
	 EBN40ySUoKbC0OU1CB18EofQ4FD4atbP5j+DpUK8/H0gUzRr3sVkJlp/6W6qEyLFQlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=tjrlHX/0kdwAUKf7ZIYHTYFr6AhUQSO4XSQL32E0SVU=;
	b=iAouYburYIzzhx304xAH4h3SkfRIpBWIqRfoVTrmH/ozeHPwmfKuQh5+T5rkuUzx7jDn
	 YtEqtCOjMoL66jZgr9dSWeYGqR/4ZZruvcmDfvhVnUq6ramsDHhebnfZCqul9HoEJTNoc
	 hgI2CNPQGAg1RYNDLKHH3ZplLqGyWloyJWicbLwEt3NPXAx4xWk/Y638UwFDdIGoRRcbJ
	 RixMcsRD/Z+Ce/NDsWIwL+yCa+4GxMYvQQwPwBkm9wnHHSN1pD8lW6u13c932PsltRkmC
	 NHpLyaAp33tpuuTtpuShcufQaofm7sXjzk/5MmK4FEglCRLW20ERZhvh8I68ttATVSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c2+pBuBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8B606A322
	for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 15:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B8B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c2+pBuBK
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-490d838b425so619641fac.3
        for <keyrings@vger.kernel.org>; Wed, 28 Oct 2026 08:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793202107; cv=none;
        d=google.com; s=arc-20260327;
        b=DBqkOyfjHcK/y8DZ57c8Fvdf3Tk6Tj/3aoijQALuvFJ7MB2da/0H3gN3B0ZLuNxke2
         2lFv3nQRelGP3VCPjS2vAN5CVOmdIB7kOjmewaHG6scLVaR+5IGsl4W6uss5/4oEQDJZ
         7Mgr6CDwgItOSvPHBPkUsWSwJh58ZEi1Mr1rZ++07EXXU+LWV+x9B9tiUqamVTm2b8D1
         StDn5mXbE0LuD97Vei+nXplQUrpb6cAULTSjKTtLAVjkGp74w3RZiR2BDyNfSxiBKmNN
         acrIKUddIhIv3+lykSc/Nxeydj8f7wn13DnBMNB6iff2fU1X20tfSam2/S80CMlYSzwX
         B6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tjrlHX/0kdwAUKf7ZIYHTYFr6AhUQSO4XSQL32E0SVU=;
        fh=Yeu30P0kDRmHg9zewWwCgIrDkTmqA+zcLUPwSGMlAY0=;
        b=TLsh0HGtR0rLxyvE9FRE1Eu1OTZhavDG/w9DC0ATPxmoLbwhJIQYP81NkwXL1fpgv6
         YvH16pizEQpo5GOq3MXjyuLaSYtimzvJzIg6AI5aA1o/PgwzkOAfawZ6vpE/o2vlQfpf
         xByMgMuduviwiVdyRf3fVMjM+Gv3BDp0kTIjQL7SAMV5WL6mDZD41wAUxRD3Q6LyJJbC
         oBS6w77aE7BYN6q6hfKCSWtacH8zV4Ci22jZMZm7KxmxSkV6wwx72PvqfcLzTE/cPsWf
         GFzwM0LaZiXwH7hSJtN72/7p7L7KWIqVOAMz0yt9jxlbO1LIcl1e36oHtAb0+M4iqgyz
         1KfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202107; x=1793806907; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjrlHX/0kdwAUKf7ZIYHTYFr6AhUQSO4XSQL32E0SVU=;
        b=c2+pBuBKpMrcTM4Fj/aKEJXXW8NZq1OG+IQlwwJuYHFBMsAQsldJEvNdTSzKmgXHpF
         z9z4jr6dfOZ4k2/JHLFshAOO5/lrmz5iY0AqIVoTFaCSxne3pBAWJN8qF6PZqpaTxf6l
         fdPto5dhQH4pnfOPP3lthbkCatmfWBExe4bdZzlBKRigUa3SZxs1FLsKACvU0xNpUV01
         EgtXWQsIK09V3CeswiMcfiEXC6RYjHOO8dn9X9NSn5FAnZK4xTxkapcerl6L/gwDBeeL
         +dl/MTVpnPGmbbM3gQaJBxBhMVhTu4GWTfAyzDrySavI2JuKXSAXtKkyumFYKYdxbgcg
         15Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202107; x=1793806907;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tjrlHX/0kdwAUKf7ZIYHTYFr6AhUQSO4XSQL32E0SVU=;
        b=FdSympYKE5PwaTpENfzyuku90+NTs1i/xDFXuIpvxYpPWNErctlZSdcYY+OX31aJmm
         Skhj4qQp01w/m3z9hLWJB0QaY2L8JRuY5vCKa7d3M5rNSlAW0L0FBY5MeMwUDX8P8Zcl
         BA3kQ5jbdV7OJmiPblhnX+A/259gRtlTHJA0fUTxcZ7oA8oPrA8ShyH1Cq0DiSg8VQ0l
         gFeJjuzZLHCVzTre7H+U/zKgEIVnuI/wLtMP3WiAyPmX1qNGmJQ3s350oO6h5QPLZnGQ
         oZv6d0CRGYkQJCltZwgM2/XbpQzLvLFRAJa2iLGaVgpiGN/nEOOgchGOIiN6tRF6wl1T
         Tr3Q==
X-Forwarded-Encrypted: i=1; AKwUvByRIsis2KSd2qdpeZyJnaogHdMzzr6bzmWDXG1Du2ihfILFKFRVZYO/cxkYvrvv3WdWnvUy7eWPcQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYId8nIHD4xLGLw0iGntTlU4nkaSU31cB1pyBC6rVR9dBwdn1edS
	xuJNPGBwQy5O1k4K6moU21qwFjrIIDdf6ewwEysTD0u4gUfaQohg3LZ7UAa4mcuxZqqGTROgsAJ
	9xYUrkY6oGE1hzKUU/e7Q6pcYL/1RHzg=
X-Gm-Gg: AYBFou2KJzomz5bNTOvZKOP8bsNsFn7I3oGwkZBsl57ATTVmNo6jP3hq+r21DjZmaQ+
	TOZE/eyQexi5RE5DQKOCSTBtQmI2p0g7u1iJNOG0fGuKyPMJVBwFOrfcHalknW/XfXZjwRF5MJh
	hIpzosegLSfnYa1eW8yWJpH2jVr3YXz3kKdG85S40JKb4X2kofJY9x42AOQlNBfT1tETrBGBT2g
	hxSZHWhJEWu1p1Waiy0+ZUVM5PI8+7yqKvBinbnBFAy1SQ7EfdF7x4ITmU0oD/HMfijvgaTnzVZ
	g/+0n9ojPkQIw22zOvXmIbCJ9lYfUETzGL2Oc+rPzNabP+JadxHNoLHuYjPi9nwhy24YUb/Dhfa
	u6CftNyTsrgDFT6n83Vb18emDZXduMG+94UgW
X-Received: by 2002:a05:6871:7516:b0:49b:ef98:3f62 with SMTP id
 586e51a60fabf-4a8bbc2726amr2070793fac.35.1793202106382; Wed, 28 Oct 2026
 08:41:46 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Wed, 28 Oct 2026 23:41:35 +0800
X-Gm-Features: AclHuK8sIaut7YlkPpWH227XFVgQSL3JAg2wQtfEBeRe1A60FwEilkx8nA8Jty4
Message-ID: <CALf2hKveij_sHgANY9Aktm1dPa4wfKjKNkHyp9yPbjORWFXagA@mail.gmail.com>
Subject: [BUG] watch_queue: RCU/info_id overlap leaks kernel stack
To: brauner@kernel.org, dhowells@redhat.com, jarkko@kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, 
	edumazet@kernel.org, ncardwell@google.com
Cc: lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Linux Kernel Developers and Maintainers,

We found a race in watch_queue that lets an unprivileged process over-read the
kernel stack of the task posting a key notification. On x86-64 the disclosure
contains that task's stack canary, kernel-stack and task_struct pointers, and
two return addresses that reveal the KASLR slide.

The bug was introduced by c73be61cede5882f9605a852414db559c0ebedfd
("pipe: Add general notification queue support") and is present in current
mainline d135ab453a7400a34930bdda1ef4bdc8acfac80e. We reproduced it there as
an ordinary user. CONFIG_WATCH_QUEUE and CONFIG_KEY_NOTIFICATIONS are
required.

Root cause:

struct watch overlays u32 info_id with struct rcu_head. A notification poster
reads info_id under rcu_read_lock(), but a concurrent final put can enqueue the
watch with call_rcu(). Enqueueing the callback writes rcu_head before the
grace period ends, replacing info_id while the object remains visible to the
reader.

__post_watch_notification() then merges the corrupted value into the
notification info word without masking it. Pointer bits can enter
WATCH_INFO_LENGTH, causing post_one_notification() to copy beyond the 16-byte
notification record from the posting task's live stack into the
attacker-readable pipe.

This disclosure is independently security-relevant. It is also the canary
and KASLR bypass for the TCP stack overwrite reported in:

https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/T/#u

We demonstrated uid 65534 to root by composing the two issues in the same
unprivileged thread.

Reproduction and fix:

We have a short source reproducer, exact config and QEMU results. In
accordance with the kernel policy, we are not posting the reproducer publicly.
We can provide it privately if a maintainer requests it. On the vulnerable
baseline it normally reports the canary, stack/task pointers and two agreeing
KASLR anchors within a few seconds.

Our tested fix gives info_id storage separate from rcu_head and masks it with
WATCH_INFO_ID before merging it into a notification. On x86-64, placing
info_id after the kref consumes existing tail padding and does not change the
size of struct watch. We will post the mergeable patch separately and link
that thread here.

AI-agent tooling assisted in identifying and analyzing the issue, developing
the reproducer, and preparing the initial fix. The reporters reviewed the
affected paths and reproduced the issue and the fixed result in QEMU.

Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>

Best regards,
Zhiyu Zhang
