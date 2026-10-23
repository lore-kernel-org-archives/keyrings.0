Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756773;
	b=s7c4kdtFll7pfOmogi2q4BkBS1CZCbriwxFas5TVr373vEfUPV2KcY5YM9tIuEtzduoG
	 4qOSSKjZDxgHHon7kTEgkgElj5el8zJVkRxCjLvJ3J3SvSGim0zuKMeItWCWfpsslaOya
	 wNoDtxJ3VIowU+2r/GKLHtRFsHOSllbfG2BJvTQk8+lifsPPdlHaZ+Dus4SR0h7e3Jnwp
	 vJh7Jkv+Wh6iGwos3VmYVpMvlGi9cYx9Tb8DGQ5u1JER5YKoW2kxLm+71sNKTIqTrCWZ4
	 0LsLI4NllLn5wwT4y57VePYAtInEbqteHN46kfOzjvGRjr2FtSa3+RBHQiyvoRQk8QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=5K0OBWvP6XN4AJpcqKwEAeoGjToHWAl6P5TGp/mreF4=;
	b=pLt2KPW6l8AHF++E9e8/gZbMK9KRsns3Uwuu6m1DJDCscVRC8IXhG1YM034ArUNg/7zq
	 QRSKpTNFrrGSpS3swcSPv52SuAmRmiVtsJJubeRsPoaqPPebPnfXwXD8pz9fCcUL8IviW
	 2n6RPkJ1n7l59hwheSAI5i7QfFZfwCvX4vTRDZHnEtOqPkLnXfknviCrKQOw72rICpL81
	 ffUZPapSAJsOxfS/ia5F7+EXaEe6JQmstLa3z+9DnVUAe29IQ6pHM0mtzDTmbHtD4ikwC
	 sDIO+EdJCjpqrQOFQyiDT9E/x8sy0oL4a61VGbO8sRUoqYk66dNFpH+1u+o3PC2/4WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZ4Z3epe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F4606A330;
	Fri, 23 Oct 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZ4Z3epe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0331F031E1;
	Fri, 23 Oct 2026 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792756772;
	bh=5K0OBWvP6XN4AJpcqKwEAeoGjToHWAl6P5TGp/mreF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZ4Z3epeXYXwpZ3tWg9wJXUibCizeqWhBcTTOJbFSLHdglyRZwgQqYZHJblL/YKQ4
	 +bsZRTZUd9IePtONjuD4nlWZMN+AD8tZSZwhk8EXpwGi0kVkUNDxIil2kubIkYd5o1
	 5fwniwoaauxkMuCt6zbBWE4hVAxxfq6alQ5kAyUXSByAGGXhpyuPE3j+FTjmbDLcHe
	 Ve5D7JPGvipVQavc2VvLKXnkZtZaA1pNhn9k9rgXnpbc6FAXEc59VJevmUeVRw1FPG
	 Ifcx//PW8liiNViGTcjjvtWjMSvGDJkHQKdXqoaGVBZ9HC99nbWERAllbMdLGT4IPE
	 Y5uHX9GvZdniw==
From: Christian Brauner <brauner@kernel.org>
To: Fan Wu <wufan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Manuel Huber <manuelh@nvidia.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Halaney <andrew@amutable.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
Date: Fri, 23 Oct 2026 13:59:14 +0200
Message-ID: <20261023-kettenglied-vorsorge-beharrlich-d4aeb08f69ca@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKtyLkF3mVu8AXWybMGr3+=0F4OMndcV=M-2m-PGz5afE4H1cw@mail.gmail.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com> <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com> <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <DM4PR12MB61369D00ED2FCFEDAE0E4597DE652@DM4PR12MB6136.namprd12.prod.outlook.com> <CAKtyLkF3mVu8AXWybMGr3+=0F4OMndcV=M-2m-PGz5afE4H1cw@mail.gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=brauner@kernel.org; h=from:subject:message-id; bh=odpJiAcrzQlZy6uyTsV28Y4dhy5i8t2c+Ng1Hl1sjjI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd9pHWqvWTUbFbtl+D08P7wNJZJyuzpGxPsV6TFd9ff +kL502BjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8tGP4zXo9ZFdblNzEgAub /lk/FwpeYNyembB/gvktYa6Gsw6TXjP8070qzdVjk6FzVsny3bkzGRwPTUPDfz+f3TM9N/2pvFY bCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 01:25:36PM -0700, Fan Wu wrote:
> Also, one thing I missed earlier: before the policy verification call,
> please also check:
>
> ipe_keyring->restrict_link->check == restrict_link_reject
>
> so we make sure the restriction function is the right one.

I would advise against this. I'll explain why. Which restriction goes
onto the keyring is intentionally userspace's policy. The two supported
ones are:

    keyctl restrict_keyring $id

seals the keyring for good. Nothing can ever be added again. And

    keyctl restrict_keyring $id asymmetric key_or_keyring:0:chain

only allows certificates that are signed by a key that is already in
the keyring.

This allows userspace to enroll a vendor CA during boot and let
per-image certificates that chain to it be added later after the trusted
phase.

systemd-keyring-setup uses that second form for .dm-verity, .fs-verity
and .bpf and then drops KEY_USR_SETATTR, so neither the restriction nor
the permission mask can be changed anymore while root keeps write
permission to enroll chained certificates.

Both are proper seals. A restriction can only be set once as afterwards
keyring_restrict() returns -EEXIST. So there is no way to remove it.

So whoever restricts the keyring is the provisioner and whatever they
pick is the policy. A random root process after the seal can't extend
the set of trust anchors either way. With the chain restriction it needs
a signature from a key that is already trusted.

That's why .dm-verity and .bpf only test that restrict_link is set.
"Restricted" is the state the kernel knows about. The policy belongs to
userspace.

So it would be really nice if we could've the same behavior for all
these keyrings. I think that this is a really nice model and allows
userspace to have a kernel enforced policy.

Christian
