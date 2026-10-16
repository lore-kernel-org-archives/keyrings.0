Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54222D7A1
	for <keyrings@vger.kernel.org>; Fri, 16 Oct 2026 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111095; cv=none; b=NMyH/VlMxBGiSzwyiie25AyhsXlo2stPR0X3VrwHAlWr42yCZhjKfggeScZuc18IcgIfVl5UwNDAqtxdMs9Do3gbUggfpw//gBgdd0hA618/zRzZaCJd/kp2W/P8hsjq+suvXLK12ndqx2TCsYvbruQJJWCP5F7BIIiejJrFYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111095; c=relaxed/simple;
	bh=wJv6Oy02ZyVpQIEV4S+JLl2ZMXIUTlylj7/wOCMhJJY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=JyT9NNJp04fXgsteNWen4vbJIq4xqjjY4RVKaIreVEXLWm3D/zZUF9uO3+pB7VwKx9sEpihrvaxm2q9jSw4rKmEHR6L0lKbVRH1Cj7E+zx0wL6Kv1qZ4vN+g3unEJLzMSoow4vaBd1k15oXfNOuUXqjJ1U6Bg6fiZpZFtXGVQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3bkIh7E; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3bkIh7E"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3233532a91.0
        for <keyrings@vger.kernel.org>; Thu, 15 Oct 2026 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792111094; x=1792715894; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJv6Oy02ZyVpQIEV4S+JLl2ZMXIUTlylj7/wOCMhJJY=;
        b=a3bkIh7Ee8Kg3CriNDEwX8oGdI8Qdq5fV8e7jXfgg0J1TidIHQ4ixKF3GGM/J9uPaU
         e9p3Qhm0hYO6htG8BQo38S6WoWM17XaFGJgXz52hh0QoGrW0FDwdFx014NgxccrzmPDu
         tgbpiLo9zoTQFGvOXV/dtf2i06sLTA0NjLV7QioPqD/w0Lj9OfYijzAFuzNuiRYVAi6d
         N0MAhUGZZgq6jxOVaP4SUrgfmC9X+wf0hf06uCR2fckrgo66IiFyfvGxl1JjLyDrCPO/
         S/vw5NXyrspYxKUnw5D8+EHgJ2a0J83wCznPI/OO3Clz8nc6Gz2YW1YzxBTBClAAqsCa
         L4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792111094; x=1792715894;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJv6Oy02ZyVpQIEV4S+JLl2ZMXIUTlylj7/wOCMhJJY=;
        b=LXCzGklzJz6oimVYXDrQzquIx9dtWDFF6KHvxxIU7Ffi1nelrT+R6ZO0N5sdsBjsRB
         VzDksZFz2aOM54FxRTFeJxgonqZTd/md+a9cFZibOS/NNv9zX9MYHhbcPluTPfFo6fa9
         zAWhW5IyrQJZlQItdYAcfBHSoWDMfDOx+MeHoVBRn9OQFqVEzZp1j+bW11+1PnkMSTao
         Lsxv6lQx16nEqgsx56Joc7j4vOvvcbxZgBSeL1urCByMgKqoaknJfwqyV7EEixuemfAK
         nUOAE79QtIuEJZvsQgd/PHVDuMMS92HvyXYLNG9RRZgzX0To/HwsGZ8GKryihfxPrkMY
         6bQA==
X-Forwarded-Encrypted: i=1; AKwUvByzX8v0zO9iBQ+Wo0+jb0Rlsqs56yiNd4QOp/mxdTppX4uIEyBNmjC8JQGXavNMiGPvmp4SZPuDCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL7NmNNmonc85krhzfD1S7wPQ0ioazwRjF5qQETintOnEEDGPYc
	F85dsbbU329/RD5gUkI9T3E6uGe8DC4+tbK9tju5iHzGtC06OSPVDHgf
X-Gm-Gg: AYBFou3Rwv8dHWD3IgR7Y7ubZeSyiw4drxf9CjWmFeTllGbqPOGF2HTseNxEVGRmopW
	W6EF5PlS76a3QAvr0TCvmWU1M1OMjtu++8DZrGvVeKszajKMB/amj7mMS/jgjGbZM5Z7tCg/MVv
	L1V59kS2qlEkjGqs5aG3lYpXPuRy6i73XDedRX2MzrKC8Nm4ARIxiIfpgaB4DBVCuEgjiJL8bpz
	cpO3EH8Q+PW+et/3y0iKSxXB9X1vxDDtbgn72fETFAXkizgg9HJjfV32sQaFu0NFDr1KjU033AD
	MTsW8frofSsvJqG3OKldXH9HE97lD7/J6LxUsS2hHo6rJZasXWK+7CUf5uSvy7ob+tSgu42o+cr
	86voFJi9ewlnW+Gpa3xRyFulXULxWQVHFhGdkLZ55HTvlRvBI2YVMk8ioQ5UFx3xELFwzT147s/
	AfEqPOYq+oaw9FJSuMdha9jF5URRnWVCeYVEJORXCV99q9UOjdCPsZKA3aojwrKJpnzBvwN67M9
	f8LSmOZxl8U7Tq/AiGzMp1drSagouWazvFhTj3VGskCoke4PakfqF+OUuUhZz3Tz9FdELS9a9Sd
	/MI=
X-Received: by 2002:a17:90b:1d4f:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3ab3a94ffa7mr15824328a91.16.1792111093664;
        Thu, 15 Oct 2026 17:38:13 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947dfa00sm6462107a91.17.2026.10.15.17.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 17:38:12 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 00:38:11 +0000
Message-Id: <DM5UD20248FG.3BXPS76LK06F5@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] keys: Add well known IDs for
 fs-verity/dm-verity keys
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Alasdair
 Kergon" <agk@redhat.com>, "Mike Snitzer" <snitzer@kernel.org>, "Mikulas
 Patocka" <mpatocka@redhat.com>, "Benjamin Marzinski" <bmarzins@redhat.com>,
 "David Howells" <dhowells@redhat.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Andrew Halaney" <andrew@amutable.com>
Cc: <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <bpf@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-doc@vger.kernel.org>
In-Reply-To: <20261012-broschen-inanspruchnahme-gebilde-d72cf2b99cda@brauner>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com> <20261012-broschen-inanspruchnahme-gebilde-d72cf2b99cda@brauner>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Oct 12, 2026 at 12:38 PM Christian Brauner <brauner@kernel.org> wrote:
> Applied to the vfs-7.4.keyring branch of the vfs/vfs.git tree.
> Patches in the vfs-7.4.keyring branch should appear in linux-next soon.

What is this branch based on ?
v2 was sent against bpf-next, because
commit 264d8fd2794f ("bpf, keys: Add a bpf keyring for program signature validation")
is only there.
All hunks in keyctl.h, key.h and process_keys.c have its lines as
context, so the patches don't apply to -rc as-is.
And patch 3 documents KEY_SPEC_BPF_KEYRING.

I'm confused.

