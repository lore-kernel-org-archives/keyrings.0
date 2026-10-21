Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570808;
	b=hUvJASxqs/GZ17Td4s+FZKI/Qe4m9k6U4XjsXEBatonxgZMTOpc8XO2iRq0QtC3AhRs4
	 qgqluLv4lgCUKR1Y0Qlgs+4NfG2pB6hSYxkxhBdab4jcNPF6rT8bEZBYV5in1AA8IVEaq
	 Hi0ltBzc5Sk958CKH8GtFho4iEnntpBiXJZouzNwTEyOaBy31mXeYbsqnRQ434ZlmzBYW
	 QQvs+a2WHwL6K1C6TtDDTRNE1kJdmRt7tIGQGyDx7I41o44zUl4yatyn1UQtIFDA0L6/z
	 nzHxyogAmMNokmyqKJ47dpJ4aJp1wa6BNlArB7BT1BWg/KP/j9Hz5uAJLLzru0eXlkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570808;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=yL8VqZDmmjINC1gZOAnpKGJOnANABO0NARhyENP7IpY=;
	b=h6obmUhXN6Px3Z4rEwh5TZ3mgUXfxCpdYPy/AZqOmYcTsJiUddxSJSC9XWbaXNgIfmWl
	 IXSDX1kskkCYeVInIl6CBUYmh5TQfDqjOkegy8TrFRhvesCdkppjb8fSiSgwQYZA1fNkn
	 IOk5r3Dhb5YradJNr4T24v2a08mFjXRIQbCsF5tMwa8Y+/5ui3Ts6NaP2HSk9v3NRXQ+4
	 54+dfxEV47wm7xQgoDvDELb+iO2SPuTT66sp38F6eyXq1aROOy3W1LlwQP/BSZkt2kOzi
	 dcwTxTqNUP5yYjexIrAJRgwDJM5RvpDX6l/7+WUuYonLlzgK/uE24mKwggndnNSS72g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB86606A31A
	for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 08:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4519ef1babeso660205fac.2
        for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 01:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792570807; x=1793175607;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yL8VqZDmmjINC1gZOAnpKGJOnANABO0NARhyENP7IpY=;
        b=wOgAZQ1pBHfVID++aXp2hX6javgJ4KZU3bsJy7fGDIe6p/b78MWveIEUn2PyL9ebgx
         m3jrTFvX6vKbYJsorG3toXJP82tZaLoc5dgs0Q3RsTZJhrsz01HhIhZFH+WmhlWEUMUx
         cWFAZp5RWuE3aIaz0bo5S7wYUfinL7JUZqyE9Iv0Hh4NalO3wj0jbKzOBAg3XsygbrOr
         DzgaR5yFZ0MXdvVE/ntvsreZR99TZ+/RBH83SpCzsaJovN1UQ+Ykz/1MWr5pYiuQdgbG
         6NxvPL7ToEQsnm7CUb98BRZp6/7GlhVFIMKMCKWh80WQen7pzqewRItRKsekDA5POmQ5
         w7CA==
X-Forwarded-Encrypted: i=1; AKwUvBy6PrQjXUW4fvz99g8VgkkdutMAwTC9E2CuDvtyicifHGnIQeqJoPedQ4DXxvKBeIPR/N05KYbdaw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4G2HzbB7hlT2DwbFcKrGVyUAelku8uaTrQP9VZbU59z4IkVuo
	73aV02AV3r2m7rJ2M8U/ZjvmvXriHPeyW2UwdCMdi0vOTGTU7AQfqnyuYY4u/zdUyzTbaYm25IV
	Zk1Vka3Fg9q4Gn4yKI5DaOHR+1kZKA5RXuG7B5h//heCuL/XCwfmh1gfJy/M=
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1818:b0:4d6:90f3:74ae with SMTP id
 5614622812f47-5535a773ee7mr837497b6e.46.1792570806989; Wed, 21 Oct 2026
 01:20:06 -0700 (PDT)
Date: Wed, 21 Oct 2026 01:20:06 -0700
In-Reply-To: <20261019145624.309790-1-jarkko@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad875b6.e74039fe.1cb511.0000.GAE@google.com>
Subject: [syzbot ci] Re: KEYS: Return user session keyring on lookup
From: syzbot ci <syzbot+ci05eb01a9f28bbd7c@syzkaller.appspotmail.com>
To: corbet@lwn.net, dhowells@redhat.com, ebiggers@kernel.org, jannh@google.com, 
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	rdunlap@infradead.org, serge@hallyn.com, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] KEYS: Return user session keyring on lookup
https://lore.kernel.org/all/20261019145624.309790-1-jarkko@kernel.org
* [PATCH v2 1/2] KEYS: Return user session keyring on lookup
* [PATCH v2 2/2] KEYS: Reject keyring creation with overridden credentials

and found the following issue:
general protection fault in keyctl_session_to_parent

Full report is available here:
https://ci.syzbot.org/series/7566814a-52ba-4f0b-b506-d7adf67fda29

***

general protection fault in keyctl_session_to_parent

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      17a7501b9612a52b38bc57e33c7b64636d438bc0
arch:      amd64
compiler:  Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/eee373c7-f447-49cf-a350-83830580c7b2/config

Oops: general protection fault, probably for non-canonical address 0xdffffc000000001b: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
CPU: 0 UID: 0 PID: 5730 Comm: syz.0.6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:keyctl_session_to_parent+0x825/0xa30
Code: 35 3b fd e9 fe fa ff ff e8 38 35 3b fd e9 f4 fa ff ff e8 2e 35 3b fd 48 8b 54 24 20 48 81 c2 d8 00 00 00 48 89 d0 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 b2 01 00 00 8b 2a 89 ef 8b 5c 24 1c 89 de
RSP: 0018:ffffc9000621fc70 EFLAGS: 00010006
RAX: 000000000000001b RBX: dffffc0000000000 RCX: ffff88810b603c00
RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000c43f7c R12: ffff88811a010000
R13: 0000000000000000 R14: ffff88810c2631a8 R15: 0000000000000000
FS:  00007f7f2068b6c0(0000) GS:ffff88818c4bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f2068aff8 CR3: 000000010cae8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __se_sys_keyctl+0x780/0x9d0
 do_syscall_64+0x166/0x520
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f1f79f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f2068b028 EFLAGS: 00000246 ORIG_RAX: 00000000000000fa
RAX: ffffffffffffffda RBX: 00007f7f1fa26270 RCX: 00007f7f1f79f559
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000012
RBP: 00007f7f1f836b20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7f1fa26308 R14: 00007f7f1fa26270 R15: 00007ffe789f59b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:keyctl_session_to_parent+0x825/0xa30
Code: 35 3b fd e9 fe fa ff ff e8 38 35 3b fd e9 f4 fa ff ff e8 2e 35 3b fd 48 8b 54 24 20 48 81 c2 d8 00 00 00 48 89 d0 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 b2 01 00 00 8b 2a 89 ef 8b 5c 24 1c 89 de
RSP: 0018:ffffc9000621fc70 EFLAGS: 00010006
RAX: 000000000000001b RBX: dffffc0000000000 RCX: ffff88810b603c00
RDX: 00000000000000d8 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000c43f7c R12: ffff88811a010000
R13: 0000000000000000 R14: ffff88810c2631a8 R15: 0000000000000000
FS:  00007f7f2068b6c0(0000) GS:ffff88818c4bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7f2068aff8 CR3: 000000010cae8000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.
