Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4313E49F4
	for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813562; cv=pass; b=AE8djL14dXiMcy2bcmBwOZ7vzrlOo9twm+Cfu3La9m0GcKHmIOWOIF63S7Z5535yq68BjlfcDj8ibff20Fhyb0MzUKyhIvPkpWiCGrS7B9J04lvcq/JFYhDx/ZssDW1TNw1s85+pxGIBOkKbcy+Ih40opIxemctst/xgifUVG1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813562; c=relaxed/simple;
	bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWUiFS/ElE11AVrjX0dQjwzo+v1epY2GkDXPz9BFSeaTsq3DJmdPxL7Y764HrE7FEEdXvaS91YjzpP9OyG+JfQ1aYP2ErS6R1kXIe4Mcjcda2wBsfrdTb/NlxJ5TKeOb7qStWh7Mql97Ushjq4e0OrMK5JPkDSwz5Y5MyYW5P5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l59ictqP; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l59ictqP"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6756a01fa01so1660044d50.0
        for <keyrings@vger.kernel.org>; Mon, 12 Oct 2026 06:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813560; cv=none;
        d=google.com; s=arc-20260327;
        b=Uvp0cdgsEZ98wZCeMzSQLsl6+Bi9DSjVufSi8XTCO+HwElZdlXKj4vGFesKrJYsYfz
         g0Zlsj/s7TEu9Fnj36Crps+8OyfrocTPq8FAq7HiH5R7lBfVFxjiq+8YbJuSo/cWXu1o
         iaIPIbGsNX90zHwUh5Fjm8ld82We60IwsIegTBxN5YhHr1LUJR38FIzhc9htbIzDZfGD
         Nhojz3Un7cs7cOBZwYmfyEfgoOm4S6uWpZRP/9HBLrFymWbhz4hVH2UwH4GIiLTIF2uJ
         3sAI87n1B2DN26uOFnuhxNbZWC6eIIZzAZcgcEDmud5oTceUXOFh3JKIQjU7y5b5oukR
         RtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
        fh=qMH7XCd8+MM6Z5cAsVoj0qQAZ9Kd1dHDlkIUo+PhfTY=;
        b=P7+SskNxfeu1Zh/6CQ7wdz2/mglRTBrgQvcDW+UFHUAkt/Y/TUTID80mscT/6ecYN/
         D1dHTR9UdBvCJBq7kkucANwN8yH2JvnMsz/nX0z5OSWdQM5Xc8HmxNSVA8XaOJV75vc/
         HOF/q+Ao0Si4KLVca125QzGw7xHKxqcGt87QRrkuDGY8lsbsdUrOki7ZFXXyuu2wPAMF
         O594SPf01vwF4dt+iSfjBRjJ7bhdobK5zjMfvJ13xxxDxXDcemNh3CuwyzO0q8PVgNZs
         zICSHlBz83dp1CM45OxiZGriQAKSV/KksgAGHcgpYNJ4Np2WDq8tU4qgjTcmYWaljNuT
         0f1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791813560; x=1792418360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
        b=l59ictqPvgtSdXxtxQityvioB3NKtTTy1otYtzB3WjkLh3dOWALB1x5GdqX4it6MNl
         4+Oi9gs7LgfRIBPGHP1kg/D2HSW1OfPsQ5jR8arpqYn2rpTptOPR4UuHhYycFFF8ICTX
         opUk0g0/pCRuHzS3atuvN8UWp5X9/7VD9OtSUc9VtqdBlujlncAaY2SHRMkH3Q5LXpkZ
         dpGrKeABWrefOeZs7Z16WBcfapLnlh4LTGAcAICSOjsMENWO5a+uFhJfsKnUGAse20D1
         RGOx5qHzOH+fDHDquWyESnHWVy9R7s4BUm9iFhh7Hkm1ep1Mo4tQVldW3IC9W1FI3J/4
         I1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791813560; x=1792418360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+FqPZlbKzDBVAJi5KEqpaoN9YJA+O6TweFmTWZcY/g=;
        b=bGMHvmRkZtnd98LQVrYO561ZVG4uDeXm03feqRmqBSOswdqTdNEfuuTqmKpPkc+UYu
         6bkkJ/wQ5gYGw+wUMCA17YA/N2ib4+pzkFiUpSH1B0Lp3taq3kYWY9RjciVObfcnsZHw
         sU/itE0orCiFkt+gsMrurHorX2Q6O1hqU/yp/m7HlgHZKV5DvIMYFHTOl6sBNpKLNMwG
         EwJIoU6nDUTVd62kJ0/ycWMA/A6Psb1e5cmlO7pLVnyTmn0s19MvzuwHIBwWUq+l7z1V
         NVWIKQ6IGQ/4vNClmteagFMsnDf0fn8zR8YrX7b+ZySt8QQf8JFmbLEDA4FWuDroypyU
         5/LA==
X-Forwarded-Encrypted: i=1; AKwUvByyuqKZmgGisekiKnNHNlFNVRHe2gYseIgofTociia8LXacU4BliD8aFWLI1hyq20D2wDfMxDiqCw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6reMbUKxc+fQ9qmsb/oOBLzy7+SXWdUBebft0yBp1CdvGugel
	IL+RmU0ZN0/VUDkbY/t1Dbpz7iZZroZcbogqolzUInwgqbNSHkS8A4QwW8OI6Jm2Vx1M8ChIDUy
	+YTR52st84TIHCT/CtE+3Gdoc0BsanMY=
X-Gm-Gg: AYBFou2IZHrCXhsBe/9jLTcHZ09eO4Hy10S1lGU5BPmgknLXcmfEIGyXjRZmTxFZ6ZS
	iQdrDcfJ7LKL0pLlfKKnCPpjU+D9iTJ54vEueeYEMVjO9tqVuL23ud3Qb5RfOpPu2CD7Dt4VCzi
	nXG8JKxGpu/rtoFuOesji+XYMJQ/A9i77zRMCoxSvEaixM6sSJ+0PhTJ90FzXRzHQRdDZFaXnUF
	EdOn+hx/FxrCMaFPOwpFM/pt69YZdlyr83HJfQ+FNe8pd8gIw0KCxMgosMIMODtkXeua8DfWqjq
	CFmoMMfwuybUgCzjo4OXMRgb5OkrP+mGEpYK6Sjej8u75eMmPmSLLZqmPA==
X-Received: by 2002:a53:ac90:0:b0:675:3c10:28a7 with SMTP id
 956f58d0204a3-67936acfd88mr2947207d50.94.1791813559834; Mon, 12 Oct 2026
 06:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org>
 <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com> <aszlg2R3E7zqR75r@kernel.org>
In-Reply-To: <aszlg2R3E7zqR75r@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 12 Oct 2026 21:59:09 +0800
X-Gm-Features: AclHuK_Z8o-xqZg0jqZI76nVd64T9lr82nl3wJ3vcrRD5bolIQP_kt4ypa7iRSI
Message-ID: <CAFRLqsW7HEn1=BjHsVNpvqT+Uf8hnxaY=ktsx+5S151KM7mKsw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 21:49=E5=86=99=E9=81=93=EF=BC=9A
>
> While AI assistance is allowed, if this happens as a pattern, it is
> misuse and eager way to credit without due. I.e., you've done 50%
> of the work but ignored the human part.
>
> I.e., you also must understand without AI assistance what
> the patch does. If you do, it should not a problem to write
> a commit message tht simply describes what it does.
>
> To summarize:
>
> 1. Actual mistakes are fine and then patch just needs to be iterated.
> 2. Skipping work is not mistake and it is not cool.
>
> Hope this clears things up.
>

Thanks for the guidance. I=E2=80=99ll keep it in mind.

Best regards,
Cen
