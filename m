Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A437207D
	for <keyrings@vger.kernel.org>; Sat, 10 Oct 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661282; cv=pass; b=N2iCwoM3P10Xwv5CRRBKlbCzU4MZuuHUBq4peE/Cs9NDmDrSfQ/px3p84qNTS9MuRfdneC1lBmxnnQruO0CRGoSL8UgG3REUUU4R4gGMKUYMPiC81sZTOA1RMkEtQBhIj9ZSPtN2r3Kq5P5Wg6zKUd9TWHsjtU/ztB9W4G3tqeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661282; c=relaxed/simple;
	bh=dHf0ELKikduqoW6Nzgw6iD400nfVYlp9m51GcsaMiW4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=u+pDgPzaAQoBBVMp0RFMp44ujLsCLTudO9Cj+wPAwo98AcRrBYvYuXrep9t/V2pAzsCUfweo4bYzARuiSj7DZnVhjeqGvPlpihEaExBrh3TEhVIJ7OiDlT0EnzUQgjurGkSbvUihUK2v9U4gcd8WpXtiPYNiX5bGnoRW3x/Bumo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIPQAccn; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIPQAccn"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b190cdc9feso555207b6e.0
        for <keyrings@vger.kernel.org>; Sat, 10 Oct 2026 12:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791661279; cv=none;
        d=google.com; s=arc-20260327;
        b=KzSBbd/CM+EFXJBSpCWKzHBsmVdJoVHLk1CCJ75wszRaN3qkQDJmJdC3C/s7sgOKDM
         uJ58C4dFJgV92byGBJxPwURdX6I8qMGdwgp5vX0cqJ7DvAXiQhDCPRTmitn2BunTp4NH
         yJbRwhl50FIo0HsnS5/0mgx3dIo3A2PxISLPUO92Id6xIafM/tTw3qfAq3LO2YFXU6Qk
         601F/PyMW+wt2YuWLfY7x5vIizp7nSghO9RUqhUOskghy0jMNT5P1m8oz16uqOohaGUN
         yZFV4o/qz1vOGkgvye5dOaRE3P3EV5mtBE/CpVYXoqXGMuAdEIQ9Xn8Nr6rYZU5jgjLf
         PTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dHf0ELKikduqoW6Nzgw6iD400nfVYlp9m51GcsaMiW4=;
        fh=ET9nHdd0o2BnRkKPCi/w7xADqScaqmpsGqs1X767lLo=;
        b=LiMPioH2ZRYQ0Coft2CniHwFDvy0kpX/vZ6d3mMGqY2E11ZlAR3UQ8CizjA+JvpyIt
         hjwlNYqUFGczQV9CCfeEr+Gv+gxn2kwhyjNSX+WyzpRfWbtd2QNwL4nZf1aIwQhYYGMe
         htJ4If6vUiTVVPtiJG42np0sj6wBIXRirPuMxv6rBusNNiyqj7vl2sVHgyNpZ2VSZQx6
         UpnlCgvLJUbEd8Bu5/KTV5AJ11HVP8VcBgg4Yv6jtD4M5kHo1qVBIYWWHsQyvvzOh0+1
         sYx35tnrEckI7ylDI3/b+SnxIBJWcUM0u+DmGtBWd7G++p8H/J0TiU59iJ117Eqzh6Nv
         Nvvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791661279; x=1792266079; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dHf0ELKikduqoW6Nzgw6iD400nfVYlp9m51GcsaMiW4=;
        b=bIPQAccnMp6uYvHbPAQnaMvC5vQmbkCE45AqwU23iYAB+DUqXwiQ3FXB1IepN6dCMi
         aEG3kMC9lb1kueXiTuMMQ0ntj2dy1B5+G5JV/pAt26azNHACtS8xVIWbhXzCxnlESnPb
         ZKGUFRxZPwX2h/8D/o+Bgcmz5ulSwPqyS/6ud92EA0KzMAqKwP+pEo/K5yMuVbTceIZy
         VeMzkANJuRVgewPd21+WbQahN12TH2KOX88QhPKs5kyL7ydsBCZAsA8yvG6HdDhJFPqk
         KpIILw8C3mFuJqXZqNGukwXEM/eSmI39BYzR3ANWxypTuesQsFBZbHvU4nFUMoAgjJp4
         r8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791661279; x=1792266079;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dHf0ELKikduqoW6Nzgw6iD400nfVYlp9m51GcsaMiW4=;
        b=YYLh6YtiYToEMTKBNrc0EFOVdLIqPSQF4In12onrPJZwLVQT02wgDGIJcaL2n2KrtO
         W7kKj+rJpdSoyU7Xxjkw9d9aoPv+wu2m7P1EmJtAafVfNMpVKaQGz2JFbgDWNLcLSaWL
         SzXJ5DLmJuuIfpNwjpH5SJvIbw4NgyBRISguQn9GQqEZZzPb9ojYPtYgGhzFiiB5UDVM
         84FBekQsWt5sJrKojKIMTVqfZsWj83IIZyCjz/pXaE8FyvKyTai5alkSTfCSDth/82IY
         TnNI6b0LRMspeIbrTL85vAN5FJCFP8NupJG+S622UYkSkUVGIuDySDSmMXN+vvNLrZJN
         zRGA==
X-Gm-Message-State: AFq9FYLZ9ei13UO683FbFh8L6v1lR8MjLWG2Zskc8s6Upm5d3vNRj0x0
	3I5e4+nLlyi3ejnL+UhB76kg2xFoCxtB49M/IQLgmApfWQ6oPWZkWu/CUmtXmpslEUHW1vwLezJ
	Va6u8vhMivlextRxCA4oxb96M8G23ikhaQyRk
X-Gm-Gg: AYBFou02LmCRfYPrycO72/1ZFLYOYd5/WxmPAdZ1+h6fgCM2rkjUgv0mMeOhubgvfJ+
	zCGZD6ev5vkzulM2x6Ybmxz188dWiJMNWpzJ2o6M2LOP1FLW3/JKtPYuRfGrjUbT7yOcvjPv7od
	BmyYR70qlWhXT+Le6OhvDOQC8EDCUKFMd9tHZXP9wsgt4eQiuvwt1S85tr3nnEh7ab322l3e7j3
	WpLMUSfzgHPcyfCFBni0BwXVhVq8XfCa7+rYgT6TQthZ5sdYdgOqQyI1Ym+WOlgtBkKjUeHiEYf
	2S4v8v3S4lfWK6jNLcdHmAFCBYDN4Xf7lJkT44avu7QZa78ECpjDaFBtVx1Ews3KMuWn6H2YYWR
	PX0MFZaD/OFdrH51pJbIshFj+noIRkiUH9D3bCUcvsvuNauBuakMVFEep
X-Received: by 2002:a05:6808:11d1:b0:4cb:f21b:6f91 with SMTP id
 5614622812f47-50c56de8b9fmr4532544b6e.36.1791661278808; Sat, 10 Oct 2026
 12:41:18 -0700 (PDT)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Oct 2026 15:41:18 -0400
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Oct 2026 15:41:18 -0400
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Martinez Garcia <adrimg3196@gmail.com>
Date: Sat, 10 Oct 2026 15:41:18 -0400
X-Gm-Features: AclHuK9KLAgXYigWpqwSDnOkL9Of7FZudu43DQLaGPU6WgrHPvJW0lbzlzVz2nY
Message-ID: <CACO1+RRVFymxKqrcYpR-hUMuHNsK2s4qGkJBn8Dffaw_pQd7mA@mail.gmail.com>
Subject: [PATCH] trusted-keys: fix heap OOB read in tpm2_load_cmd
To: keyrings@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000014edd5065d81a6f1"

--00000000000014edd5065d81a6f1
Content-Type: text/plain; charset="UTF-8"

Hi,

In tpm2_load_cmd() (security/keys/trusted-keys/trusted_tpm2.c),
get_unaligned_be32(pub + 4) is called without verifying public_len >= 8.
A crafted ASN.1 blob with 2-byte OCTET STRINGs passes all existing checks
but triggers a 4-byte out-of-bounds read.

This adds the missing length check.

Fixes: 114f00d738f1
Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>

I used Claude Code to help with the audit.

--00000000000014edd5065d81a6f1
Content-Type: application/octet-stream; name="tpm2-load-cmd-oob-read.patch"
Content-Disposition: attachment; filename="tpm2-load-cmd-oob-read.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 631fce909f08a1d9_0.1

RnJvbTogQWRyaWFuIE1hcnRpbmV6IDxhZHJpbWczMTk2QGdtYWlsLmNvbT4KU3ViamVjdDogW1BB
VENIXSBLRVlTOiB0cnVzdGVkOiBGaXggT09CIHJlYWQgaW4gdHBtMl9sb2FkX2NtZCgpIHdoZW4g
cHVibGljIGFyZWEgaXMgdG9vIHNtYWxsCkRhdGU6IFNhdCwgMTAgT2N0IDIwMjYgMTk6MzA6MDAg
KzAwMDAKCnRwbTJfbG9hZF9jbWQoKSByZWFkcyB0aGUga2V5IGF0dHJpYnV0ZXMgd2l0aApnZXRf
dW5hbGlnbmVkX2JlMzIocHViICsgNCkgd2l0aG91dCB2ZXJpZnlpbmcgdGhhdCB0aGUgcHVibGlj
IGFyZWEgaXMKbGFyZ2UgZW5vdWdoIHRvIGNvbnRhaW4gdGhlbS4gIFRoZSBvYmplY3RBdHRyaWJ1
dGVzIGZpZWxkIG9mIGEKVFBNVF9QVUJMSUMgc2l0cyBhdCBvZmZzZXQgNCBhbmQgaXMgNCBieXRl
cyB3aWRlLCBzbyBhdCBsZWFzdCA4IGJ5dGVzCm9mIHB1YmxpYyBhcmVhIGFyZSByZXF1aXJlZC4K
CkEgY3JhZnRlZCBUUE0yIGtleSBibG9iICh2aWEgdGhlICJsb2FkIiB0cnVzdGVkLWtleSBvcHRp
b24pIGNhbiBwYXNzCkFTTi4xIGRlY29kaW5nIHdpdGggdGlueSBwcml2L3B1YiBPQ1RFVCBTVFJJ
TkdzIHdoaWxlIGNhcnJ5aW5nCmF0dGFja2VyLWNvbnRyb2xsZWQgYmUxNiBwcml2YXRlX2xlbi9w
dWJsaWNfbGVuIHZhbHVlcyBvZiAwLiAgVGhlCmV4aXN0aW5nIGNoZWNrcyBvbmx5IGVuc3VyZSB0
aGUgdHdvIGxlbmd0aCBmaWVsZHMgdGhlbXNlbHZlcyBmaXQ6CgogICAgYmxvYl9sZW4gPSA0ICgy
LWJ5dGUgcHJpdiArIDItYnl0ZSBwdWIsIGJvdGggemVyb2VkKQogICAgcHJpdmF0ZV9sZW4gPSAw
LCBwdWJsaWNfbGVuID0gMAogICAgY2hlY2tzOiAwKzIrMiA8PSA0IGFuZCAwKzIrMCsyIDw9IDQg
IC0+IGJvdGggcGFzcwogICAgcHViID0gYmxvYiArIDQKICAgIGF0dHJzID0gZ2V0X3VuYWxpZ25l
ZF9iZTMyKHB1YiArIDQpICAgLy8gcmVhZHMgYmxvYls4Li4xMV0KClRoZSBkZWNvZGVkIGJsb2Ig
aXMgYWxsb2NhdGVkIGFzIGttYWxsb2MocHJpdl9sZW4gKyBwdWJfbGVuICsgNCksIHNvCnRoaXMg
aXMgYSA0LWJ5dGUgaGVhcCBvdXQtb2YtYm91bmRzIHJlYWQgcGFzdCB0aGUgYWxsb2NhdGlvbiwg
ZmxhZ2dlZApieSBLQVNBTiBhcyBzbGFiLW91dC1vZi1ib3VuZHMuICBUaGUgdmFsdWUgb25seSBm
ZWVkcyB0aGUgbWlncmF0YWJsZQpiaXQgdGVzdCwgc28gdGhlIGRpcmVjdCBpbXBhY3QgaXMgbGlt
aXRlZCwgYnV0IGl0IGlzIGEgZ2VudWluZQpvdXQtb2YtYm91bmRzIHJlYWQgb24gYXR0YWNrZXIt
Y29udHJvbGxlZCBpbnB1dC4KCkZpeCBieSByZWplY3RpbmcgYmxvYnMgd2hvc2UgcHVibGljIGFy
ZWEgaXMgc21hbGxlciB0aGFuIHRoZSA4IGJ5dGVzCm5lZWRlZCBmb3IgdGhlIGF0dHJpYnV0ZXMg
ZmllbGQsIGJlZm9yZSB0aGUgcmVhZC4KCkZpeGVzOiAxMTRmMDBkNzM4ZjEgKCJLRVlTOiB0cnVz
dGVkOiBGaXggdHBtMl9sb2FkX2NtZCgpIGJvdW5kYXJ5IGNoZWNrIikKU2lnbmVkLW9mZi1ieTog
QWRyaWFuIE1hcnRpbmV6IDxhZHJpbWczMTk2QGdtYWlsLmNvbT4KLS0tCgogc2VjdXJpdHkva2V5
cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90cG0yLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90
cnVzdGVkX3RwbTIuYyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfdHBtMi5j
CmluZGV4IDAxZjE4YmIzNy4uZTY5ZGUyOWJiIDEwMDY0NAotLS0gYS9zZWN1cml0eS9rZXlzL3Ry
dXN0ZWQta2V5cy90cnVzdGVkX3RwbTIuYworKysgYi9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5
cy90cnVzdGVkX3RwbTIuYwpAQCAtNDE2LDYgKzQxNiwxMCBAQCBzdGF0aWMgaW50IHRwbTJfbG9h
ZF9jbWQoc3RydWN0IHRwbV9jaGlwICpjaGlwLAogCWlmIChwcml2YXRlX2xlbiArIDIgKyBwdWJs
aWNfbGVuICsgMiA+IGJsb2JfbGVuKQogCQlyZXR1cm4gLUUyQklHOwogCiAJcHViID0gYmxvYiAr
IDIgKyBwcml2YXRlX2xlbiArIDI7CisJLyogb2JqZWN0QXR0cmlidXRlcyBzaXRzIGF0IG9mZnNl
dCA0IGluIFRQTVRfUFVCTElDIGFuZCBpcyA0IGJ5dGVzOworCSAqIHRoZSBwdWJsaWMgYXJlYSBt
dXN0IGJlIGJpZyBlbm91Z2ggdG8gaG9sZCBpdCAqLworCWlmIChwdWJsaWNfbGVuIDwgOCkKKwkJ
cmV0dXJuIC1FMkJJRzsKIAkvKiBrZXkgYXR0cmlidXRlcyBhcmUgYWx3YXlzIGF0IG9mZnNldCA0
ICovCiAJYXR0cnMgPSBnZXRfdW5hbGlnbmVkX2JlMzIocHViICsgNCk7CiAK
--00000000000014edd5065d81a6f1--
