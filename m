Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664343;
	b=jxaY4NZt4a7lD1LJixt3SipbaIWuomiItm9XUzIvMyt1FxqII1Dbv8ga8YD7r8K7+IlP
	 33nWJqRSIfPLL05FhU0eLkweLdsCE3pK/14euWGXdTOlI9afAbKEeTAyGK9/dswItBW+u
	 negxNIdav4PNXq2vMXQZDeyx26aqtN+Srl/+pwcPr41MCbKlwlAmnMYAlP7Z42DBkWGE4
	 Ky+HOn3onD9EFoDZxiziHtuwvFULdP1ZzJ6EGjgxqUqvkJCt7doIC7aTJCqZZTDTLbZZ6
	 GUzcwD8sBX/v58QuKt8Q23jIi/7A8+b9Uv+k3qUF4BZrx6PCyLbf3f5pueRrIxSpfeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664343;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 X-Developer-Signature:X-Developer-Key:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Z7CjTsmoRi+0w+ZhFFRXXTz8JLrTIF6dRBCGuBaLV2M=;
	b=bmZ+YAlzORec4yf5UFA16az2GRrc8yhnlc1OiFdQjD0uiA+8TTcej10zYjNS2rpNO/SM
	 AtfGAq/fsa3t34GBNf5w1CRzYs/TMtlQt+npsSeD2mXlG/0I9gHvQ9MkLi8IvS0K0u6UV
	 csnh+34Zg9djjfGsRS2IJfEFLqU5dIGzT6QK9/2k53N3icbu8YG1S+13I5ebP6UUqg//D
	 7kkzmWoPiM04uGIlZTcqNwKoMfNG/dbiAVMgSbVzol0v59OY3/lUiuyRYDxzb2YKDBENO
	 Z5/3QBpViK+n0buqX5mPR3faaQ/YfyZCHFp5e9WW/devSyJuZ4cPeWSOAYNAiq+3WPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ8QgVKJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0463606A319;
	Thu, 22 Oct 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ8QgVKJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD461F000C6;
	Thu, 22 Oct 2026 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664343;
	bh=Z7CjTsmoRi+0w+ZhFFRXXTz8JLrTIF6dRBCGuBaLV2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PJ8QgVKJZLMn1J0ApZiCJ5Tz/bA/4eJpuTqvjc+kfrI3kSPJCRNLwNBWFUD61FXT4
	 rKvp/VXRfO6gQk5hL+Efc5LHGOFWXM7RSd/nq7CWkynoSKrcIUbY15rNQX/C/dSNTG
	 LTNlXlnL9E505zYjLJKrr2MU3iVebUKmoNdH+zxcojkrmBWjNCpAx9FK2wUGinCowb
	 qZzMpJgec4hhSHXurkaKqhQFauAvHacXh+4HkdQ921rnQUsck2wCOQ60yN7y/bOkyu
	 Zct/BNdh5sNExojRmzQO8PYFpCAwQUElk6cla29I5RzU11SzU8pdo6ExOgTRDkABj2
	 N+zk51yg79kPQ==
Date: Thu, 22 Oct 2026 12:18:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
Message-ID: <20261022-hausbank-dozent-hurtig-9443f3777475@brauner>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6420; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Gz2q9noNMRTVpIenqHmgVL/IPY7t7BAHJ6uIbpyczwI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdfKDtd2F1yYYNN6SUVj4LiYsPtuiujX+RO2cLQ/mZA
 wZcWUvKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZicIvhfyxLpY/ue92q7Zvk
 LlXfSci/eEvy5FS/htmTfqyQTrv29Qsjw+ac534R/dOCGdzCbqUW57/kDlVpdOyY9e3chPjjajr
 tnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org>
 <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>

On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
> Just a quick point of clarification, you're using the pattern you
> described for other keyrings, not necessarily a dedicated IPE keyring
> described in this patchset, correct?

Correct. The .dm-verity keyring and the .bpf keyring both work like
this: sealed empty by default, opened for a single boot via a kernel
parameter, and only ever consulted once the keyring is non-empty and
restricted. Manuel modeled the .ipe keyring on them after talking to
Fan.

> I know you/Lennart/systemd made the decision to implement your own
> version of IPE instead of working with Fan to augment the existing
> implementation to meet your needs, so I'm not sure if you've also done
> something with an out-of-tree patch, BPF, etc. to implement your own
> keyring.

There is no out-of-tree anything and there is no keyring of our own.

RestrictFileSystemAccess= is a BPF LSM program that PID 1 loads. It
denies exec, executable mappings and W^X transitions for anything that
isn't on a signed dm-verity device or the initramfs. That's it. It
uses the hooks BPF LSM exposes.

> As far as I'm concerned the decision of how IPE uses an IPE keyring is
> up to Fan.

This is really not an argument. Manuel posted an RFC that follows two
existing in-tree keyrings to the letter. Fan asked to deviate from them.
I explained what that costs.

> Of course, fitting in with existing norms is important,
> but if it causes IPE or existing IPE uses a lot of pain, that can a
> good reason to diverge from those solutions.

Which pain? The keyring is dead unless the kernel command line opens
it, and it is only consulted after the system keyrings have already
rejected the signature. Existing IPE users see no change whatsoever.

Fan's reasons were that it "looks kind of awkward" and that fs-verity
does it differently. I haven't yet heard a single technical reason to
deviate. The properties we get and the other model loses are:

(1) Fail closed by default. Without the boot parameter the keyring is
    sealed empty for the whole boot and can never be provisioned. With
    the fs-verity model the keyring is open on every kernel that has
    it and stays open until someone remembers to restrict it. If
    nobody does, root in the "untrusted" phase enrolls its own cert
    and loads its own policy.

(2) The opt-in is per boot and lives on the kernel command line, i.e.
    in the measured/signed boot chain. A Kconfig knob can't express
    "this boot", only "this kernel", and a distro kernel with the
    option on is simply open everywhere.

(3) Activation is tied to restriction. The keyring is only consulted
    once it can't be extended anymore, so there is never a window
    where a half-provisioned keyring is a trust anchor. With the
    fs-verity model it is a trust anchor from the first key on and
    extensible until sealed.

(4) That's what gives Manuel's Kata case the throwaway key: generate
    an ephemeral key pair, enroll the cert, restrict, sign the policy,
    load it, destroy the private key. After that nothing can be added
    to the keyring and nothing new can be signed. With the fs-verity
    model the same sequence leaves the keyring extensible unless the
    agent also seals, and the kernel doesn't care whether it did.

Note that IPE's own CI already does padd followed by restrict_keyring
on .fs-verity in the initrd (anchor-fsverity.service). So IPE relies
on exactly this sequence today. The pattern just has the kernel
enforce it instead of hoping that userspace gets it right.

So what does IPE gain from a keyring that is open by default and
consulted before it's sealed?

> These days everyone is
> going to implement whatever they please, but if you have
> needs/requirements about how you want things to behave in LSM land, I
> think it would be helpful to engage with us before you make a decision
> and then start pleading with the LSM folks to adopt your approach.

I'm not pleading with anyone. And the engagement you're asking for
happened. You just didn't engage:

- You read Daniel's bpf keyring series yourself in August, Cc'd the
  keyring folks "for obvious reasons", and had nothing to say about
  the model. The cover letter spelled out in detail that systemd would
  provision that keyring the same way as .dm-verity.

- On 2026-10-11 Manuel announced in the KEY_SPEC thread that he'd
  propose a .ipe keyring "modeled after the .dm-verity keyring" after
  "initial discussions with Fan Wu". You and linux-security-module
  were on Cc.

As for "everyone is going to implement whatever they please"... In May
you told the bpf folks that "we just need to be willing to accept that
we have different needs and show a willingness to accept different
solutions as a result" [1]. I don't see why that shouldn't apply to
systemd using BPF LSM.

Frankly, I couldn't care less whether IPE chooses to model the keyring
the same way. It just means it can't give equivalent security
guarantees. I'm confused why you have to speak for Fu and why you're so
defensive about this.

[1]: https://lore.kernel.org/all/CAHC9VhQ-cq-nD7uq3kv=SFSJyzO_CEgwzFeMcdbznTmPWJoy6g@mail.gmail.com
