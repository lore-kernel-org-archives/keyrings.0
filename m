Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792637633;
	b=tvX4KG0wuiI97OOSlR6VO1QUcqr30tOyvY/NgJBmGPHZzKbzdc5mkwpk5ptTvt6iOWcP
	 UwNYj2vzszBlobfA9TLXDXpQ8S81x+84BdSqUzJKghTOWr3VWVgv9bNZCwXNUeI7Nby60
	 fvS+W2+W5KN/UJUgfuaaPkiDDoEWTXNqca8q5uyaU2qXSGTyZvACEg4mejLVcMQq+Qode
	 y+B91G2t5yVSbTYG6HWbrfaynBm3/VpFURoPpqzhNj0qW3nlRAhp15fk75lgzApOLQ0Fo
	 I3RHUltEgfouMG8c20Vt64g6IT9lMXaaRcFG/LCjGZqHpqrj6vxB/LbyEOyzQZDk71w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
	b=w0go6EgCe6xufqGevsoyhpVthrcT90O4R/hSODFapLTNZm73s4T4XUlk++VCgRcB25JD
	 B0R53y5hvwO12Rw9skjsKMYMoNG02QNTxHXj7bH9+SGbaPd8yM7MYzof15AhZP9ift99+
	 ZWy40z9ZDHimphrET+5SZD3fuW+yASafPODe7Mcz++BmErlsdtshEjzmrly8wBPgZ1Cqh
	 Dba5BU6LIHqpbl3OC2w3sC3DwDTZVsuTK0OutIVPIKWnQPHLUVwP8IlxC14TbgRm4tvj3
	 7Tvwdo5brQJWgUQZtbUiwtfhzGkNFmiQWwh0BQjwhSNDFc4XwttUtPmT88CwhUKxFcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DTOI/Pek";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB29606A325
	for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FB29606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DTOI/Pek
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4395d31228so195847066b.1
        for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 19:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792637631; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMHNGOkpkqS9RpeBLs6XDh6JL7KYW4KjoG3I/N0J7Dwlm1MgysFgHS6QLjitncV4BP
         /ZEPjhtQywaPiIGt3bmVMb/30Q/jlAKkcaKVrgh3yjLsGQWtlg6YkSEv8/Bgml6KpuY9
         5Gq5nM+3vEEQec0nE5r2IXklhXIcj2nxiAxfgTB4C+4MooUk36yk4EupaTMQFjc99FGy
         yJEjsAS8Q8pGJjVqyxG28SzB2mUB6hTar1YcFyATTOqzsJBoH8mZ3hHWsL8Afryaudf3
         laCBPESzo0y1rtB6SsS9ZxhyIZhSdiTuZauTQS6csn5Oq/rT3Ce9+UCYQTxYJt5NEZ2P
         YzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        fh=97fgc6huG1mfOx4Fe/d9XOXoal1ClPqeqzCgi9MejgI=;
        b=NVBRc8OxPJgt3JID1HzzkzuhWj7hFh4dHO5RqBjlV5MbL6UNFtx15TR7/+KQXoO2bX
         P5EzPa1NsauHaKBvd6bd/TMxm7sSDtUL/8EgcEKOFdNiGmYahGbJoSelVaMOeaJFpPkA
         y8VzR/4FibyxPFyY8vJT/0f40sTQAS5Kph5lDriSI94DiZHzoj4G1E+Iag/YetvGPGhO
         wLS2AHzeSDaiPHR0xSAMT1BfRTqrWdvuBLzk4Bag65s+/7dXwQgbJceB3kstGyZljIMH
         XTJbljE5cAip32iTmmbvT1h3JZPq2YaGr6MEldmWcO1HFqEHAt8tVJHww0Ymdf9n4bPN
         vBcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637631; x=1793242431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=DTOI/PekpHCFwbCxS6btLnjWQNCiYVc9jJXCEYwAmPekEK8t/PxBNEKZNgCm5yMo5O
         ZHRqWqq6Sa4prnp5961iu97eKvO2fCe1P/oDhQUuXQyhe3en4gFePLH+ndAycKrOkdLY
         ZBtVPzCtW837QZIUsvIlXqXaajHAOKuqlnaym36x90uyaZGBsQGk0lDoH47TKDdTDSv/
         +bNghojo2jLNQuKI4CGPrg7pLnnWdQfj43K8C91aQyr5qb1zEo8L/J/KSRypGRSRs42E
         gu3hUif099K3NIyvd05k0+GuTWcbFOAPWaSRNh9N1gfC8G9MuampVJBqQHApn7d+PZp0
         CiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637631; x=1793242431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnU6rs3hrQM9btLPDOKgfodkMRYa3+dqaWM6BzIydXs=;
        b=vHMw6u+0euH9YIuVbsdBJT5fY6VqppxBiUpnL9rcZVp+irBk6XC84tZRCl1e+MqJP2
         s44Vl1EZYwWKPyRj1eLIjVd3NsgtiBXr4xdImx+LLJm73lwvp8JvXqAWJWZH2m+r7lPX
         mSnSSu27E46Ul4n3sU8X4RWlbejx9836FLKdBUsb8d/Hy5iWwx7JA2OPWp+ZbnoGfHZX
         vsBi5Njmt9++/WSvMkYbIacTq8pJLMrRsAPZGJaPxaCxlkalTCoF5iXT+XSrYerN0aWI
         alv9ob9Q10wotl5kSdCL1Ezbnw6XKqmgsVeKWSnNXIpfjKLEFBfxR1gLuu6URk/x5Dpy
         nzEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7MsDYBAN1hwM26oudawxMNS5HOHx8uF8+u/pJu67NFDgwn5OU4I3/DBSI0xDtLpLeEN4GwqIG6g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLLDA+TOCMsghTWxRVKiMJVLiUw/hBXzf/yn/RyMubDN/JY18+d
	0W3uzaGPzRLd9iMjcqnCY/WrhBSKDCNO6/Gtwbw0L+HBSEK10ooYhCtUkthClko8X8kXveVzUYy
	HGeEZ2mmZPLzf2pDrE96/bq02KAN244VP9twBvRBJdQ==
X-Gm-Gg: AYBFou1P4XINCIaX11t7JYHDEIUsyXk+liWcKxmJ7T9rHSMuCMtONrmpYWZj7T6J+Ik
	74kj/gEKJZLWWDC1RvItAzt+LMHaM/drgOgIdtw9bnsteUjDBrCb94QC7fPR4hTBAFYMfiLQj8L
	21Ep3D7qXresIqa64xHUlZNEHDoLCXRHIT8G1dBvOZQwcCnoBuloNWk/TZLeDHY0QumUyrtCA7t
	kdSyQ6pnmc190SvgpUsHUE0BhOguQehyS7uD9BO9GnMCP4sx54HqO3y8ywdo69q0q+T1a5ey0xB
	1dY1wp9dKVKAIu0hcisRtGN/zqD1E8RokLCqyfp6KR0HY581+uPIoQx5Q1OejRxQyL0DeH+KEuo
	iIGzUn83FV8ymhqbEwKoNq4j8GkqLHhBfWyf4zDvXYPt22m6qbeaZV2kZ4g==
X-Received: by 2002:a17:906:ba84:b0:c41:8e21:4d60 with SMTP id
 a640c23a62f3a-c46791326c1mr341731966b.1.1792637630664; Wed, 21 Oct 2026
 19:53:50 -0700 (PDT)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de> <f444dffc8e6bf98bf44c02456adc2de40e4ecd95.1792552161.git.jan.koester@tuxist.de>
 <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
In-Reply-To: <fd20b840-350e-469c-9fd2-008fa0ded62a@slotpi15m67>
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Thu, 22 Oct 2026 04:52:00 +0200
X-Gm-Features: AclHuK8zMCY_XzKvgZWVeEW29rK2WIKSmZA1a7YbTdfyZ3EtSnPZJ1CNUxd7pQ8
Message-ID: <CALWcw=FYKcDNXeArpsabHiQOAL+cWkF=L3stL6MB0OvVaHei1g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 40/41] nfsd, nfs: carry UUID and GUID owners as
 their text form
To: Chuck Lever <cel@kernel.org>
Cc: Jan Koester <jan.koester@tuxist.de>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:44=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 10/20/26 11:16 PM, Jan Koester wrote:
> > Encode such an id as its text form -- "xxxxxxxx-xxxx-xxxx-xxxx-
> > xxxxxxxxxxxx" for a UUID, the same in braces for a GUID -- in both
> > directions on the server and the client, and take such a string (it
> > has no '@', so it can't be a user@domain name) as that id again.
>
> A bare UUID in an owner, owner_group, or ACE 'who' string is a new
> owner-string syntax for NFSv4, one that only Linux would recognize.
> Thus it isn't interoperable with other NFSv4 stacks as proposed
> here.
>
> RFC 8881 Section 5.9 says a string without an '@' that is not a
> decimal number means no translation was available and the receiver
> "should not use that string as a basis for translation into its
> own internal format." RFC 8000 Section 6.1 forbids bare numeric
> ids in multi-domain deployments because they collide; the same
> applies to bare UUIDs, and more so to GUIDs.
>
> If you are serious about pursuing this, you'll have to start by
> raising the proposed wire format on nfsv4@ietf.org before the
> Linux kernel's NFS stack commits to it.

I recall rumors of MS wanting to stick Windows SID in text form into
the NFSv4 protocol.

THIS proposal is even worse, in every imaginable way:
Stuff an unreadable 128bit blob everywhere. I am sure people having to
debug that in the kernel will LOVE the idea (compare blob a with blob
b as human,YAY!), and admins facing the 128bit hexdump will send
marriage proposals to the author, for making their lives even more
heartless and miserable.

NAK, -1, for the whole patch series.
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
