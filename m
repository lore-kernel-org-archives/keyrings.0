Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090869;
	b=xXrD+C20gdgO/orxiEVYHA4ehkrkxEJdzPPviQdZ2nFzLNRbqAM1sdZn7KgEifs5fFV8
	 QIxclIdHssrmu75iolXQBM7g0v2Q+xb26NffFjBdf774uWVHiX1cdty7iTIWS8o91PNLG
	 +ESfvZrxnmikqwuMxi2mdipb8BAWjZCeyfh2rnxupbqXW+ghg+0XGCDN30Q1F1bOijJPu
	 yV44xEW4AQLGKn1ByH4wTFQD3q9dwObjMOYhHGPOOxM6VNyCZpVl4JqQ7lgq6ww9JVpdT
	 Yyuxf8loTGa05ETNywXmT2cB76gJs+SyTLSCfGUQvNuX1/fnj+fsEhQd3ppPetfX4yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090869;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=wR5HXTh16ddUXMlLaMHcCDUi43szIAAM9f7TTgkHzr4=;
	b=nbzGgdHZIcBmOFxriBymE3sOrmhN3vmD+LGu5tYItp9Lac6qDs+omzxMQv38YnJzzFtW
	 vzctpwdda7S/+CajuOeWfxtrVjkf3M8qHqYSzo/hKeoUlwm6Ws8jdsZUqk+oepbUHtONx
	 kxVsTAJa/CCkdpfVGKBxftWUzPriTjCreUHxSnNozzJv1LzDteRSdHtKA0ve/UOlX8l+k
	 2qF6qzz9WpEPbVMbFUVu1r3hAL1L6kTxlvdTWuAdTAzou/7t7vIUX9Yi7YVc8gofrSTia
	 GOS2P//PIwnS5PEAX1FXdOaNhLzU6azIJGxHQbhW7XABhJl0JQNduzFmdoYvDzxrprw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gompa.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE3606A32E
	for <keyrings@vger.kernel.org>; Sat,  7 Nov 2026 22:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5BE3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5430f70c827so964031cf.2
        for <keyrings@vger.kernel.org>; Sat, 07 Nov 2026 14:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794090867; x=1794695667;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wR5HXTh16ddUXMlLaMHcCDUi43szIAAM9f7TTgkHzr4=;
        b=O6zRF+ByYTilcVEqCNkVQcH8rYPmITDovZYL5T8sQGj21k6vbfKIyuFoT3y7G4hGbp
         QVB9WoZa611m7yv0SGBd6eO5dzpnL+nF0slU8dgiBt40ZQN1JCTJWJ8wtOhZdPf0KTPX
         GtKykW0bqXcZcENzCkTG2u/ajhm5JwNR6mlCjpsTRvsPwMV7xsUh4pcD/Sav18uYZDBG
         JS9yBrTadhiZ2I4Dqg6qVssSBRY0Ui558tDGrPZ3dg1Whb2I7SqRfiGvOlO6FIbgZuVR
         We36YHKbFnidOq35aQhLATTrOskTuAUDNMdlOx8qIk20qSMyu6lZnuFr8raH7z5rw1Re
         Kjpg==
X-Gm-Message-State: APuU4Z+eLRa/DzfZGRv6KVrKQsLPcD5NmV2sNGG8xDBI7Etv0VlH0n+x
	8Wh3s50dHNpiMI8EEtNo7wilCNuOs9D+Ap7k+p5FE5tYGMpnoZhcJKGl
X-Gm-Gg: AYBFou30PfqCyQbDJ9/yGTneuELokl1IgdFFKew+w/hpT3mTbwGBkVCmsVnXFWDATQk
	ogD9x1oXrCQronhSir85oIJ9N4YFhu4YLq27Ajp96VChr5TYCY+YA2oKzBEkABuvLOOWiH6t1px
	TFeEIFtA1onIoynuJ/wae7DCctud5lVN8M4BPlL/ys/Tg564dX9Q1ifvjHVKbgMjBDZv3TpSkiy
	qL+zqEOykyz8j6AjPuXL7Z5/K3z9EMp7oa8uLRZsiqyhNXyQr8zLkA/IMWPOwOv9p+IGmKK/0gS
	oD53JFZ3yvTUNz9I1O0QpT/Hff/uwCm9wWY+XLGtncE7eh6fxaHwD1QnEEOJF4xFP5bczYR5JUT
	s3kAkgjAhr9+WScCAUagCtvtSekaKSMzoORSDuAgVSYkF0zIaG4Fyd2IvREGkUF4V23I9V7tXNh
	uc67yftoExYZQICmYBy5qvSw1+MjZenWKMQstW2JQNPm4iSpYP3UwKEPSj5cRp6kkEhN/K9BawL
	ijmltXupWk1vGj16Iuuh5AksnUvGtfNT5M1kTmzZaAI1UUPJV9fYSJ52Rc8eG0GkJsnrlwz8to8
	51UPNwMNMUFljLZwXcGKgeoTfibpPL38a7Qbef2xN2uWFzMVAuCHw5pfws0OmYIlWXfhAEJUCHs
	zQOtISOfZcFxLZ42U/3Knn5HrTVji7ipB21KOKuZ2KN+YP4fkSAoEF36Xo4S51le7UrYvAqguH8
	6O
X-Received: by 2002:a05:622a:494:b0:533:8900:4eb2 with SMTP id d75a77b69052e-54e14e77819mr102542781cf.58.1794090867395;
        Sat, 07 Nov 2026 14:34:27 -0800 (PST)
Received: from skuld-framework.localnet ([32.221.37.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5526454c1e2sm3581101cf.22.2026.11.07.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 14:34:26 -0800 (PST)
From: Neal Gompa <neal@gompa.dev>
To: mjg59@srcf.ucam.org, Matthew Garrett <matthewg@nvidia.com>
Cc: keyrings@vger.kernel.org, James.Bottomley@hansenpartnership.com,
 linux-integrity@vger.kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-efi@vger.kernel.org
Subject: Re: [RFC] Make hibernation work with lockdown
Date: Sat, 07 Nov 2026 17:34:25 -0500
Message-ID: <Qc3eI7EOR8ep1b77lr0gsw@gompa.dev>
In-Reply-To: <20261008132532.1155166-1-matthewg@nvidia.com>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, October 8, 2026 9:20:16=E2=80=AFAM Eastern Standard Time Matth=
ew Garrett=20
wrote:
> Hibernation writes out the full system state to disk in an unencrypted
> and unauthenticated manner. Resuming from hibernate reads that data and
> throws it directly into RAM, then jumps into it. This is effectively an
> entirely unauthenticated mechanism for putting whatever you want into
> kernel space. This violates the assumptions around lockdown (root can
> write whatever they want to the swap partition and then trigger a
> resume), and as such lockdown blocks hibernate.
>=20
> This has made many people unhappy.
>=20
> This patchset seeks to solve this problem. In order for hibernation to
> be trustworthy we need to be able to prove that the image was generated
> by the kernel and not modified after that. This is not an easy task, and
> requires some infrastructural framework. To that end, this patchset does
> the following:
>=20
> 1) Co-opts a TPM NV index for the kernel's sole use. This is currently a
> placeholder and we should register one explicitly from an appropriate
> range in order to ensure that we don't conflict with userland.
>=20
> 2) Does something horrifying with PCR 5 in order to prove that a given
> kernel supports (1). We need to extend and cap a PCR before userland is
> running in order to prove that the kernel has support for this feature,
> but since we don't currently cap any PCRs there's nothing stopping
> userland from doing the same and so achieving the same state. The way
> around this is to rely on a feature of PCR 5 - it is extended as a
> result of ExitBootServices being called, and since the boot stub can
> execute code before that happens we can perform the proof extension
> there and then have it implicitly capped by the firmware's extension.
>=20
> 3) Adds support for audited TPM sessions in the kernel, allowing us to
> generate signed digests of the commands that were executed in that
> session and their results
>=20
> 4) Adds support for generating a predictable AK that can be used to sign
> digests from those audit sessions
>=20
> 5) Adds support for generating a TPM signing key in such a session, and
> using the signed digest to prove that the session took place in the
> kernel
>=20
> 6) Signs the hibernation image with such a key
>=20
> An old kernel that doesn't implement (1) won't be able to mimic the same
> PCR 5 value. Userland won't be able to mimic the NV index value because
> the kernel will block it. This means that the only way that key could
> have been created is by the kernel, and so we can trust that the image
> was generated by the kernel.
>=20
> QUESTIONS:
>=20
> 1) I haven't tried to make the key management generic, since this isn't
> intended to ever be exposed to userland in any way. Should it be
> integrated into the trusted keys layer anyway?
>=20
> 2) Filtering TPM commands from userland isn't ideal - anyone able to
> poke commands into the TPM directly is in a position to violate the
> assumptions here. Is there any way we can get a secret into the kernel
> that can be used as an auth value? It would need to be impossible to
> obtain from userland and it would need to be consistent over platform
> reboots.

Looking over the patch set, it seems like this should be okay with swap fil=
es=20
being used for hibernation, right? I don't see a reason it wouldn't work, b=
ut=20
I figure it would be worth directly asking.

The reason I am asking is because I am looking at integrating KDE's dynamic-
hibernate[1][2] to allow Fedora Linux to dynamically generate files specifi=
cally=20
for hibernation.

Obviously, this works fine in non-SB environments since lockdown doesn't=20
negatively impact power management there, but if this manages to make it ov=
er=20
the finish line in some form, I would like to be sure the approach is=20
compatible or can be made compatible.

[1]: https://invent.kde.org/tduck/dynamic-hibernate
[2]: https://src.fedoraproject.org/rpms/dynamic-hibernate



=2D-=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


