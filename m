Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354778;
	b=MQL5yGnmUjoCPN2BTAFFoacvpXOcVEMUnBODeLvquqTP1OHnS6zDfBHeFc9Nle+QqVGn
	 lxVcXl8T7RrA8B6BcdSvoUUdUEdsDpjjPJ1UDJ1ceQiKxC2cCd0vaVRKiAlTjykyDRNRA
	 XSPlHN3h22dpU007fqSZHJ+qHIVqu+jYlZtHqbPaUWKUrunhOBu3eWHZwNYvCTUD+XGU/
	 L+9m6bCEeTzjbvaclDB7uemL8y+J1liabpZDI9kGCkwH2nxNksrt4Ryn8AiA8S7F0l49H
	 evmUeYFfQ4RfCJQb/2nkN4wLm0xHihAnDbfraTNYwxWo7WY4xAp5E85VsHakZMgSRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HoG9is9sVaNrexmB6oJ68fL5RKwI/mjHmSlJNyQJLe4=;
	b=sFD6AF320GK+5eDm6yBw6LQHAUd8LOK7K+jQdpofsMdKvPHWy7wgRWg6eYAlTqQJCOHX
	 HiF/EKuchgallPGjgfcicZHqyWPTa4jcS6wyuPH+FEZhJlBy+F+U3EHvacIvXfFJxJFmg
	 OsEYTED4g3jmjlK3wo5JDg80gjBra0IXZCsNFRXIbiZQsqVM4Oy9Juo5jIJKwU9amf+k5
	 Rn+qpKazXUgRiE1WTczoXic2VlcRBYjnTP1zr23SeiBv3AegY3yJu3WEXrLLA4C/R4zga
	 dQtvcyw2kNjd+taXflTn2Uld8OZl0DJdrHOZ/gQGwJy9TDG70mOXMxY8m6OvGb7aJ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0VNsPS+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAD606A320;
	Tue, 10 Nov 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0VNsPS+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27A91F0093C;
	Tue, 10 Nov 2026 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354778;
	bh=HoG9is9sVaNrexmB6oJ68fL5RKwI/mjHmSlJNyQJLe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0VNsPS+ZhcGGjSFNMxdyGE9pqCUBXXHhAXY7FpMXDNq95vJF7NsIvt/cTxSnl5gS
	 7QXh07K/D3Y8JMm2YMP/lksTqAul598mdAqjtHeVo6z57pTnOkEi/l8TsCG/VacxDM
	 7dJ3cTjnX8xI+CGOH6gVBWvocKFwE3JV4zHQN6DAydv1xzHTTxgfWDoNMIdarY2nCE
	 UErEI+0dhh2ljCKZcxjOTctFxbh3aDOBbJgmM5h9pTUOaYAs1p8khnDjkeXi5Q5uN1
	 wcq1j0MjrdaWZTAU7T9t3g4Wx3QA/Z/FX72R3AsuveIuJjv6rnAsTHWw0BP6bxo690
	 NkLxtoPTtk9sQ==
Message-ID: <sashiko-outbox-207958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, "Shuah
 Khan" <shuah@kernel.org>, "Bradley Morgan" <brads@mainlining.org>
In-Reply-To: <20261109-b4-setfcap-userns-v9-3-0d3f00976ce2@toxicpanda.com>
References: <20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com>
 <20261109-b4-setfcap-userns-v9-3-0d3f00976ce2@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:52:57 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/namespaces: host /mnt creation and false skip in
  idmap_tmp()
- [Low] selftests/namespaces: add setfcap_test to .gitignore
--

commit 38eae5440ed3d06c4f6383c08c8a0e11e61d724f
Author: Josef Bacik <josef@toxicpanda.com>

selftests/namespaces: test the CAP_SETFCAP rule for user namespaces

This commit adds kselftests verifying that a uid 0 task without CAP_SETFCAP
cannot regain the ability to set root file capabilities via setns() or
ptrace into a user namespace, while preserving valid namespace mappings,
idmapped mounts, and file capability operations.

> diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/=
selftests/namespaces/Makefile
> index 9b22d12708e1a..0455b6544869d 100644
> --- a/tools/testing/selftests/namespaces/Makefile
> +++ b/tools/testing/selftests/namespaces/Makefile
> @@ -14,7 +14,8 @@ TEST_GEN_PROGS :=3D nsid_test \
>  		  stress_test \
>  		  listns_pagination_bug \
>  		  regression_pidfd_setns_test \
> -		  uid_map_range_test
> +		  uid_map_range_test \
> +		  setfcap_test
> =20
>  include ../lib.mk
> =20

[Severity: Low]
Should setfcap_test also be added to
tools/testing/selftests/namespaces/.gitignore so in-tree builds do not leave
an untracked binary?

> diff --git a/tools/testing/selftests/namespaces/setfcap_test.c b/tools/te=
sting/selftests/namespaces/setfcap_test.c
> new file mode 100644
> index 0000000000000..aee0b1d6f329a
> --- /dev/null
> +++ b/tools/testing/selftests/namespaces/setfcap_test.c

[ ... ]

> +/* /tmp idmapped with the user namespace of pid, at /mnt */
> +static int idmap_tmp(int pid)
> +{
> +	struct mount_attr attr =3D { .attr_set =3D MOUNT_ATTR_IDMAP };
> +	char path[64];
> +	int tfd, nsfd;
> +
> +	mkdir("/mnt", 0755);
> +	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
> +	nsfd =3D open(path, O_RDONLY);
> +	tfd =3D syscall(__NR_open_tree, AT_FDCWD, "/tmp",
> +		      OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
> +	if (nsfd < 0 || tfd < 0)
> +		return -1;
> +	attr.userns_fd =3D nsfd;
> +	if (syscall(__NR_mount_setattr, tfd, "", AT_EMPTY_PATH, &attr,
> +		    sizeof(attr)))
> +		return -1;
> +	if (syscall(__NR_move_mount, tfd, "", AT_FDCWD, "/mnt",
> +		    MOVE_MOUNT_F_EMPTY_PATH))
> +		return -1;
> +	close(tfd);
> +	close(nsfd);
> +	return 0;
> +}
> +
> +/* Each test: private mounts, a tmpfs on /tmp with copies of this progra=
m */
> +static void prepare(struct __test_metadata *_metadata)
> +{
> +	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
> +	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
> +	ASSERT_EQ(mount("tmpfs", "/tmp", "tmpfs", 0, "mode=3D1777"), 0);
> +	ASSERT_EQ(new_file("/tmp/x", 0), 0);
> +	ASSERT_EQ(new_file("/tmp/u", 1000), 0);
> +	mkdir("/mnt", 0755);
> +}

[ ... ]

> +/* returns 1 to skip: no idmapped mounts on tmpfs */
> +static int idmap_case(const struct idmap_case *c, long *r)
> +{
> +	struct holder ns, im =3D { -1, -1 };
> +	struct idmap_join j;
> +	int ret =3D -1;
> +
> +	ns =3D spawn_mapped(HOLDER_ROOT, c->ns_map);
> +	if (ns.pid <=3D 0)
> +		return -1;
> +	if (c->idmap_map) {
> +		im =3D spawn_mapped(HOLDER_ROOT, c->idmap_map);
> +		if (im.pid <=3D 0)
> +			goto out;
> +	}
> +	if (new_file("/tmp/x", c->file_uid))
> +		goto out;
> +	if (idmap_tmp(c->idmap_map ? im.pid : ns.pid)) {
> +		ret =3D 1;
> +		goto out;
> +	}

[Severity: Medium]
Should prepare() and idmap_tmp() place the mountpoint inside the private
/tmp tmpfs instead of at /mnt, and should idmap_tmp() distinguish
mount_setattr() failures from other setup errors?

prepare() only mounts a tmpfs on /tmp, so mkdir("/mnt", 0755) creates /mnt
on the host root filesystem, or fails on a read-only root filesystem where
/mnt does not exist.  In addition, idmap_case() treats any error from
idmap_tmp() as ret =3D 1, causing TEST_F(idmap, fcap) to report a skip ("no
idmapped mounts on tmpfs") when open(), open_tree(), or move_mount() fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-b4-setfcap=
-userns-v9-0-0d3f00976ce2@toxicpanda.com?part=3D3
