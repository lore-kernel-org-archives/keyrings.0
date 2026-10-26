Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049774;
	b=OzpfQKzKPR463d664+/6Cd2IJNUds0e1Xlmc6PLKlSOnHfSGvM6hlBVPvVMnY6/7BZlS
	 AQROxqFpgIGqCgnfsSK+7tCYvAB184Y4oHM4Ro1QYn4Amnrc9qdOP6miClY4ezIRmzxdL
	 MQqXbpsJKGccvLyZ78bfJmW/M4COZlmGwKvKKn5SBo47hP6ILbe7q6Zn5WsTcTo94bpR6
	 W7Hi0wvpaOX7C+hxNqZ8m1X/7crJv0oltoKTOH8nqhE+0rfYbP/3+FmhFwJ7pORlXUqTM
	 isJL+Pxf1sglIgsIC4Z7hqE1XfFchxerrSuHqf6sArhC+w0+YW49jqACTBDV3lwiH+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fS8/uoshnZZDGgzB90NLw5MpRPNVe5NG8Fu2mwsIK5w=;
	b=HuhpdfgXrQ1PonNRW6ieXD+RnINm3sgpujSdXodxbn60ydhT0XVY0lB2vIg7OeWVdsIR
	 xmXxmSYPu9HXDxlzrYd4R2RRd+cqxQJmqZJeWWuuhST9W2piseOgwWjrJQZEUtXFbNsBi
	 b8IG/9jOroYEcl3kM7Dnxjr7D83kf4OkSGqNlkWRzildCE82BWhoKObtPbz868KRN3Ai4
	 4MVoBdWU1wWwC1W5il2TCQa9g0V0GCpNUX+kXC3DthL35GF1fnv9xiag0Y6y68x89AiaK
	 oVbwVYcOASIrif44n5oKIgrJOaRRysFXqRSIrWQImYHy4p6YhIvmted3FLG0Hd/8n/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKKKZl6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62683606A31A;
	Mon, 26 Oct 2026 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKKKZl6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD1D1F01825;
	Mon, 26 Oct 2026 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793049773;
	bh=fS8/uoshnZZDGgzB90NLw5MpRPNVe5NG8Fu2mwsIK5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nKKKZl6n731bqR2wGtvv9rme1ZYq4HCmdlD9fIRy4eKYI2ea91EyTPZFypN6AOQTq
	 kLpOlqRK2S/5vT11A/sGOsoRB57DuKvuH6gXZMfsCNuiNs5HHZsUvDntlOj104Mo5M
	 6SMW/OJoACGPgZFclRbaSB+3YKB4Fiq3eqEq//v9Gb9aWviE5zx8h7Kjok8aP1MI2e
	 kO9WmiLCrncwaIozG//vrsRzomd/m8CAMJIYuTf9l5wz5EHlOGDNHMgsb0g6kOY/ON
	 qNZAIMvEvR3BxEbOJS8f+rzc8n9gTTr0NVBnOHmbQuyWmgMbPoP0nEl9CmHpybqt90
	 +YjJDxxTlgYKw==
Message-ID: <sashiko-outbox-185749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, "Shuah
 Khan" <shuah@kernel.org>
In-Reply-To: <20261026-b4-setfcap-userns-v7-6-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
 <20261026-b4-setfcap-userns-v7-6-bf8a576f7259@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:22:52 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/namespaces: unclosed pipe ends and missing kill in set=
fcap_test
--

commit abaeb2bba300741f12e4c39c7c19c7dd2ce060b5
Author: Josef Bacik <josef@toxicpanda.com>

selftests/namespaces: test the CAP_SETFCAP rule for user namespaces

This commit adds kselftest coverage in tools/testing/selftests/namespaces/
for the CAP_SETFCAP rule governing user namespace UID mappings, file
capabilities, setns(), idmapped mounts, and ptrace attach checks.

> diff --git a/tools/testing/selftests/namespaces/setfcap_test.c b/tools/te=
sting/selftests/namespaces/setfcap_test.c
> new file mode 100644
> index 0000000000000..cfe82cb875620
> --- /dev/null
> +++ b/tools/testing/selftests/namespaces/setfcap_test.c

[ ... ]

> +static long x_nonzero_root(void *a)
> +{
> +	int s1[2], s2[2], res[2], pid;
> +	long r =3D SETUP_ERROR;
> +	char c;
> +
> +	if (pipe(s1) || pipe(s2) || pipe(res))
> +		return SETUP_ERROR;
> +	pid =3D fork();
> +	if (!pid) {
> +		restrict_root();
> +		if (unshare(CLONE_NEWUSER) || write(s1[1], "u", 1) !=3D 1 ||
> +		    read(s2[0], &c, 1) !=3D 1)
> +			_exit(1);
> +		if (unshare(CLONE_NEWUSER))
> +			r =3D SETUP_ERROR;
> +		else
> +			r =3D write_map(0, "0 1000 1\n");
> +		if (write(res[1], &r, sizeof(r)) !=3D sizeof(r))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	if (read(s1[0], &c, 1) !=3D 1 || map_both(pid, "1000 0 1\n") ||
> +	    write(s2[1], "g", 1) !=3D 1 || read(res[0], &r, sizeof(r)) !=3D siz=
eof(r))
> +		r =3D SETUP_ERROR;
> +	waitpid(pid, NULL, 0);
> +	return r;
> +}
> +
> +TEST_F(setfcap, map_ancestor_root_at_nonzero_uid)
> +{
> +	EXPECT_EQ(in_child(x_nonzero_root, NULL), -EPERM);
> +}
> +
> +/*
> + * R maps host uid 0 as uid 5 of its namespace and forks X, which gives =
up
> + * CAP_SETFCAP there and unshares again.  "5 5 1" then maps host uid 0 o=
ne
> + * level down, as uid 5.  X writes it itself, or R does from the parent =
and X
> + * writes a v3 xattr with rootid 5.
> + */
> +static long r_nests_x(void *a)
> +{
> +	int x_maps =3D *(int *)a;
> +	int s1[2], s2[2], res[2], pid;
> +	long r =3D SETUP_ERROR;
> +	char c;
> +
> +	if (unshare(CLONE_NEWUSER) || map_both(0, "5 0 1\n"))
> +		return SETUP_ERROR;
> +	if (pipe(s1) || pipe(s2) || pipe(res))
> +		return SETUP_ERROR;
> +	pid =3D fork();
> +	if (!pid) {
> +		restrict_root();
> +		if (unshare(CLONE_NEWUSER))
> +			r =3D SETUP_ERROR;
> +		else if (x_maps)
> +			r =3D write_map(0, "5 5 1\n");
> +		else if (write(s1[1], "u", 1) !=3D 1 || read(s2[0], &c, 1) !=3D 1)
> +			r =3D SETUP_ERROR;
> +		else
> +			r =3D set_fcap("/tmp/x", 5);
> +		if (write(res[1], &r, sizeof(r)) !=3D sizeof(r))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	if (!x_maps && (read(s1[0], &c, 1) !=3D 1 || map_both(pid, "5 5 1\n") ||
> +			write(s2[1], "g", 1) !=3D 1))
> +		r =3D SETUP_ERROR;
> +	else if (read(res[0], &r, sizeof(r)) !=3D sizeof(r))
> +		r =3D SETUP_ERROR;
> +	kill(pid, SIGKILL);
> +	waitpid(pid, NULL, 0);
> +	return r;
> +}

[ ... ]

> +static long dropped_writes_inherited_fd(void *a)
> +{
> +	int fd, pid, st;
> +	long r =3D SETUP_ERROR;
> +	int p[2];
> +
> +	if (unshare(CLONE_NEWUSER))
> +		return SETUP_ERROR;
> +	fd =3D open("/proc/self/uid_map", O_WRONLY);
> +	if (fd < 0 || pipe(p))
> +		return SETUP_ERROR;
> +	pid =3D fork();
> +	if (!pid) {
> +		drop_setfcap_keep_bset();
> +		r =3D wr(fd, "0 0 1\n");
> +		if (write(p[1], &r, sizeof(r)) !=3D sizeof(r))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	if (read(p[0], &r, sizeof(r)) !=3D sizeof(r))
> +		r =3D SETUP_ERROR;
> +	waitpid(pid, &st, 0);
> +	return r;
> +}

[ ... ]

> +static long x_unshares_r_maps(void *a)
> +{
> +	const struct parent_maps *m =3D a;
> +	int s1[2], s2[2], res[2], pid;
> +	long r =3D SETUP_ERROR;
> +	char c;
> +
> +	if (pipe(s1) || pipe(s2) || pipe(res))
> +		return SETUP_ERROR;
> +	pid =3D fork();
> +	if (!pid) {
> +		restrict_root();
> +		if (unshare(CLONE_NEWUSER) || write(s1[1], "u", 1) !=3D 1 ||
> +		    read(s2[0], &c, 1) !=3D 1)
> +			_exit(1);
> +		if (m->own_tmpfs) {
> +			if (unshare(CLONE_NEWNS) ||
> +			    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
> +			    mount("tmpfs", "/mnt", "tmpfs", 0, NULL) ||
> +			    new_file("/mnt/f", 0))
> +				r =3D SETUP_ERROR;
> +			else
> +				r =3D set_fcap("/mnt/f", m->rootid);
> +		} else {
> +			r =3D set_fcap("/tmp/x", m->rootid);
> +		}
> +		if (write(res[1], &r, sizeof(r)) !=3D sizeof(r))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	if (read(s1[0], &c, 1) !=3D 1 || map_both(pid, m->map) ||
> +	    write(s2[1], "g", 1) !=3D 1 || read(res[0], &r, sizeof(r)) !=3D siz=
eof(r))
> +		r =3D SETUP_ERROR;
> +	kill(pid, SIGKILL);
> +	waitpid(pid, NULL, 0);
> +	return r;
> +}

[ ... ]

> +TEST_F(setfcap, fcap_v2_without_uid0_from_parent)
> +{
> +	int ready[2], go[2], mapped[2], pid;
> +	struct holder h;
> +	char c;
> +
> +	ASSERT_EQ(pipe(ready), 0);
> +	ASSERT_EQ(pipe(go), 0);
> +	ASSERT_EQ(pipe(mapped), 0);
> +	pid =3D fork();
> +	ASSERT_GE(pid, 0);
> +	if (!pid) {
> +		/* host uid 0 is uid 1000 in here, nobody is uid 0 */
> +		if (unshare(CLONE_NEWUSER) || write(ready[1], "u", 1) !=3D 1 ||
> +		    read(mapped[0], &c, 1) !=3D 1 || unshare(CLONE_NEWNS) ||
> +		    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL) ||
> +		    mount("tmpfs", "/mnt", "tmpfs", 0, NULL) ||
> +		    new_file("/mnt/f", 1000) || write(ready[1], "m", 1) !=3D 1)
> +			_exit(1);
> +		if (read(go[0], &c, 1) < 0)
> +			_exit(1);
> +		_exit(0);
> +	}
> +	h.pid =3D pid;
> +	h.go =3D go[1];
> +	ASSERT_EQ(read(ready[0], &c, 1), 1);
> +	ASSERT_EQ(map_both(pid, "1000 0 1\n"), 0);
> +	ASSERT_EQ(write(mapped[1], "g", 1), 1);
> +	ASSERT_EQ(read(ready[0], &c, 1), 1);
> +	EXPECT_EQ(in_child(r_v2_without_uid0_from_parent, &h), -EINVAL);
> +	reap_holder(h);
> +}

[ ... ]

> +static int idmap_case(const struct idmap_case *c, long *r)
> +{
> +	struct holder ns, im;
> +	int pid, p[2], st;
> +
> +	ns =3D spawn_mapped(c->ns_kind, c->ns_map);
> +	if (ns.pid <=3D 0)
> +		return -1;
> +	im =3D c->idmap_map ? spawn_mapped(HOLDER_ROOT, c->idmap_map) : ns;
> +	if (im.pid <=3D 0 || new_file("/tmp/x", c->file_uid))
> +		return -1;
> +	if (idmap_tmp(im.pid)) {
> +		reap_holder(ns);
> +		if (c->idmap_map)
> +			reap_holder(im);
> +		return 1;
> +	}
> +	if (pipe(p))
> +		return -1;
> +	/* join from a child of the namespace's holder's sibling: pass the pid =
*/
> +	pid =3D fork();
> +	if (!pid) {
> +		long res;
> +
> +		if (c->restricted)
> +			restrict_root();
> +		res =3D join(ns.pid) ? SETUP_ERROR : set_fcap("/mnt/x", 0);
> +		if (write(p[1], &res, sizeof(res)) !=3D sizeof(res))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	if (read(p[0], r, sizeof(*r)) !=3D sizeof(*r))
> +		*r =3D SETUP_ERROR;
> +	waitpid(pid, &st, 0);
> +	umount2("/mnt", MNT_DETACH);
> +	reap_holder(ns);
> +	if (c->idmap_map)
> +		reap_holder(im);
> +	return 0;
> +}

[Severity: Medium]
Can these test helpers hang in read() or waitpid() and leak pipe file
descriptors when a setup step fails?

Unlike in_child() and spawn_holder(), the helpers x_nonzero_root(),
r_nests_x(), dropped_writes_inherited_fd(), x_unshares_r_maps(),
fcap_v2_without_uid0_from_parent, and idmap_case() do not close the unused
pipe ends in the parent and child after fork(), nor do they close the
remaining pipe descriptors before returning:

1. Because the parent keeps the write ends (s1[1], res[1], p[1], ready[1])
open in its own file descriptor table, if the child exits early on a setup
failure (such as in restrict_root(), drop_setfcap_keep_bset(),
unshare(CLONE_NEWUSER), mount(), or new_file()), the parent's blocking
read() on s1[0], res[0], p[0], or ready[0] never sees EOF and blocks until
the test runner times out instead of returning SETUP_ERROR.

2. In r_nests_x() when x_maps is 0, if unshare(CLONE_NEWUSER) fails in the
child, the child sets r =3D SETUP_ERROR, skips writing to s1[1], writes r to
res[1], and exits:

	if (!pid) {
		restrict_root();
		if (unshare(CLONE_NEWUSER))
			r =3D SETUP_ERROR;
		else if (x_maps)
			r =3D write_map(0, "5 5 1\n");
		else if (write(s1[1], "u", 1) !=3D 1 || read(s2[0], &c, 1) !=3D 1)
			r =3D SETUP_ERROR;

Meanwhile the parent is blocked on read(s1[0], &c, 1) with s1[1] still open
in the parent process.

3. In x_nonzero_root(), if map_both(pid, "1000 0 1\n") fails in the parent,
short-circuit evaluation skips write(s2[1], "g", 1) and calls
waitpid(pid, NULL, 0) without killing the child or closing s2[1] (unlike
r_nests_x() and x_unshares_r_maps() which call kill(pid, SIGKILL) before
waitpid()), leaving waitpid() blocked while the child waits on
read(s2[0], &c, 1).

4. In fcap_v2_without_uid0_from_parent, the child keeps mapped[1] and go[1]
open, so if a parent ASSERT_EQ() fails and exits before reap_holder(), the
child stays blocked on read(mapped[0], &c, 1) or read(go[0], &c, 1).

Should these helpers close the unused pipe ends after fork(), close the
remaining pipe descriptors before returning, and ensure x_nonzero_root()
kills the child before waitpid() on error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v7-0-bf8a576f7259@toxicpanda.com?part=3D6
