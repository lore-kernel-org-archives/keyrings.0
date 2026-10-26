Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030439;
	b=dq1yJVXLYDBwx74EhUP3SrERKr8IzWvF85XkpJ3tYu+FfCdyjsnrb8dERAzCNP+NQvxO
	 OEIbkHqbt6cGjsznj0xb512pqs2qDxDDuehni6phCxHKoXRQeu3du5Yuwmxgnc54QnsiI
	 +fUECf8Ax/Q3RaH4/7IL89RKTuw3HHJQWW90wPkV27t+mpxdGoB2OJ56W/ABLYSYOydUB
	 /o5kpm2IdF3SXlEU2Wja9FJH08Fe86DkywyWBQOJ3TTmew/q3eUQVICsRBtu8h2sQ3u/l
	 t5qRyOSlulRmCFz9kJD3TD7QSykSizsHrJ9g+PRrDi5UzAfF2ZoBp9J44I6e7/AMxwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=84283VdjY8rCfQShYjCinfUd+VokocOkMTFgSBOg0J4=;
	b=Ao4j3l+P++jwMq5rd5Wk3HXtjA4epA+mdQHWPDrHSAiYevFaCFx5GM7yd6Jvw86Ivv2C
	 XZf9UAKv784UolWKP/Q8FDak7bwc7nxgStizLTY672LvOgba9FsPywqv47jc/Gb7Rye20
	 lho1gqNIFpm2TD1Q4TpZKuWb6WmLCradr1rUahdMh1uzsGFk/z8KMnBFgr039qePp6JOF
	 IcJo27zDL26/MVSa/n1+3Mrtlh3XO4LSzMuWnSzHj5FsTH13HkBSRURS6QMNTCc4GuVEq
	 rr3pD1S1HYECjMVl3MHQqp4q0JnGNZeccy2PcvDbHlI8b/AWekUDsxtqbN8V5UVS3xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V96rtNfT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3D606A31A;
	Mon, 26 Oct 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V96rtNfT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE31F01825;
	Mon, 26 Oct 2026 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030439;
	bh=84283VdjY8rCfQShYjCinfUd+VokocOkMTFgSBOg0J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V96rtNfTMpWwpWH7iBTAgHS1lQcc4l3RCg4l3TcyXAulo/eTtzWDoCVUDc6lqswHN
	 i/vkOPbXD47tfzzVTtzWX269ermOxXMZ8mjPM618JXJKVievnc15ERrQijmNpXtwFm
	 aMdGQyWEmfuJ2n/pX/R1NGu6kF+YLRBS/UrT20O3zyd81/WJ3GBl+yN6n2HX97We76
	 rzsIU3cimx1hBOv7qE37FbUDwKrFs0vLdJdVF0plUyekZK7v69bZaZrbQta4Q4V6AR
	 D8ScwE7O4H4GKWEtFs2U+9ya+PCL6YObfGNvzBY3VAO37SmMCyBPeKIfIospof2Kwd
	 r/eHxNL2kTkSg==
Message-ID: <sashiko-outbox-185477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] selftests/namespaces: test the CAP_SETFCAP rule
 for user namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>, "Serge Hallyn" <serge@hallyn.com>, "Paul
 Moore" <paul@paul-moore.com>, "Christian Brauner" <brauner@kernel.org>
Cc: "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, "Serge
 Hallyn" <sergeh@kernel.org>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, "Shuah
 Khan" <shuah@kernel.org>
In-Reply-To: <20261026-b4-setfcap-userns-v6-6-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
 <20261026-b4-setfcap-userns-v6-6-25f10b7ca497@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:00:38 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests/namespaces: unreachable set_fcap() and write_map() in =
setfcap_test
- [Medium] selftests/namespaces: fail instead of skip on ENOSYS in session_=
to_parent()
- [Medium] selftests/namespaces: missing parent session keyring join in r_n=
ew_session_keyring_maps()
--

commit ef6b694dab9e316eaa07835cf40f4ad86e6267ac
Author: Josef Bacik <josef@toxicpanda.com>

selftests/namespaces: test the CAP_SETFCAP rule for user namespaces

This commit adds the setfcap_test selftest to verify the CAP_SETFCAP rules =
for
mapping ancestor root users, writing file capabilities in user namespaces a=
nd
idmapped mounts, joining namespaces via setns(), and attaching via ptrace().

> diff --git a/tools/testing/selftests/namespaces/setfcap_test.c b/tools/te=
sting/selftests/namespaces/setfcap_test.c
> new file mode 100644
> index 0000000000000..0a82b239b3685
> --- /dev/null
> +++ b/tools/testing/selftests/namespaces/setfcap_test.c

[ ... ]

> +static long x_joins_unshares_maps(void *a)
> +{
> +	long r;
> +
> +	restrict_root();
> +	r =3D join(PID(a));
> +	if (r)
> +		return r;
> +	if (unshare(CLONE_NEWUSER))
> +		return SETUP_ERROR;
> +	return write_map(0, "0 0 1\n");
> +}
> +
> +TEST_F(setfcap, map_after_setns_and_unshare)
> +{
> +	struct holder h;
> +
> +	h =3D spawn_mapped(HOLDER_ROOT, "0 0 1\n");
> +	ASSERT_GT(h.pid, 0);
> +	EXPECT_EQ(in_child(x_joins_unshares_maps, &h), -EPERM);
> +	reap_holder(h);
> +}

[ ... ]

> +static long session_to_parent(void *a)
> +{
> +	if (syscall(SYS_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL) < 0 ||
> +	    syscall(SYS_keyctl, KEYCTL_SESSION_TO_PARENT) < 0)
> +		return SETUP_ERROR;
> +	return 0;
> +}
> +
> +/* a cred replaced by key_change_session_keyring() keeps what it had */
> +static long r_new_session_keyring_maps(void *a)
> +{
> +	if (unshare(CLONE_NEWUSER))
> +		return SETUP_ERROR;
> +	if (in_child(session_to_parent, NULL))
> +		return SETUP_ERROR;
> +	return write_map(0, "0 0 1\n");
> +}
> +
> +TEST_F(setfcap, map_after_session_to_parent)
> +{
> +	EXPECT_EQ(in_child(r_new_session_keyring_maps, NULL), 0);
> +}

[Severity: Medium]
If the running kernel is built without CONFIG_KEYS, syscall(SYS_keyctl, ...)
in session_to_parent() fails with ENOSYS (or EOPNOTSUPP), which
r_new_session_keyring_maps() translates into SETUP_ERROR and causes
map_after_session_to_parent to fail EXPECT_EQ(..., 0).

Should map_after_session_to_parent check for ENOSYS / EOPNOTSUPP and call
SKIP() with a reason message when keyctl is not supported by the kernel?

[Severity: Medium]
Can KEYCTL_SESSION_TO_PARENT in session_to_parent() also fail with EPERM wh=
en
the test binary is invoked via sudo or su from an unprivileged login sessio=
n?

In security/keys/keyctl.c:keyctl_session_to_parent(), the kernel requires t=
he
parent's existing session keyring UID to match the child's effective UID:

	/* the keyrings must have the same UID */
	if ((pcred->session_keyring &&
	     !uid_eq(pcred->session_keyring->uid, mycred->euid)) ||
	    !uid_eq(mycred->session_keyring->uid, mycred->euid))
		goto unlock;

If the parent process in r_new_session_keyring_maps() inherited a session
keyring created for a non-zero UID before elevating privileges,
pcred->session_keyring->uid will not match mycred->euid (0), causing
KEYCTL_SESSION_TO_PARENT to fail and return SETUP_ERROR.

Should r_new_session_keyring_maps() call
syscall(SYS_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL) in the parent before
spawning session_to_parent() so the parent's session keyring is owned by
UID 0?

> +
> +/* ---------------------------------------------------------------------=
- */
> +/* File capabilities that are honoured in an ancestor                   =
   */
> +
> +static long x_joins_sets_fcap(void *a)
> +{
> +	long r;
> +
> +	restrict_root();
> +	r =3D join(PID(a));
> +	if (r)
> +		return r;
> +	return set_fcap("/tmp/x", -1);
> +}
> +
> +TEST_F(setfcap, fcap_after_setns)
> +{
> +	struct holder h;
> +
> +	h =3D spawn_mapped(HOLDER_ROOT, "0 0 1\n");
> +	ASSERT_GT(h.pid, 0);
> +	EXPECT_EQ(in_child(x_joins_sets_fcap, &h), -EPERM);
> +	reap_holder(h);
> +	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
> +}
> +
> +static long x_joins_sets_fcap_rootid5(void *a)
> +{
> +	long r;
> +
> +	restrict_root();
> +	r =3D join(PID(a));
> +	if (r)
> +		return r;
> +	return set_fcap("/tmp/x", 5);
> +}
> +
> +/* a v3 xattr can name the root user by any uid it has in the namespace =
*/
> +TEST_F(setfcap, fcap_after_setns_v3_rootid)
> +{
> +	struct holder h;
> +
> +	h =3D spawn_mapped(HOLDER_ROOT, "5 0 1\n");
> +	ASSERT_GT(h.pid, 0);
> +	EXPECT_EQ(in_child(x_joins_sets_fcap_rootid5, &h), -EPERM);
> +	reap_holder(h);
> +	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
> +}

[ ... ]

> +/* R maps "5 0 1", gives up CAP_SETFCAP, unshares again */
> +static long r_drops_then_nests(void *a)
> +{
> +	if (unshare(CLONE_NEWUSER) || map_both(0, "5 0 1\n"))
> +		return SETUP_ERROR;
> +	restrict_root();
> +	if (set_fcap("/tmp/x", 5) !=3D -EPERM)
> +		return SETUP_ERROR;
> +	if (unshare(CLONE_NEWUSER))
> +		return SETUP_ERROR;
> +	if (write_map(0, "5 5 1\n"))
> +		return -EPERM;
> +	write_file(0, "setgroups", "deny");
> +	write_file(0, "gid_map", "5 5 1\n");
> +	return set_fcap("/tmp/x", 5);
> +}
> +
> +TEST_F(setfcap, fcap_after_dropping_setfcap_and_nesting)
> +{
> +	EXPECT_EQ(in_child(r_drops_then_nests, NULL), -EPERM);
> +	EXPECT_FALSE(user_gets_sys_admin("/tmp/x"));
> +}

[ ... ]

> +/* returns 1 to skip: no idmapped mounts on tmpfs */
> +static int idmap_case(const struct idmap_case *c, long *r)
> +{
> +	struct holder ns, im;
> +	int pid, p[2], st;
> +
> +	ns =3D spawn_mapped(HOLDER_ROOT, c->ns_map);
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
> +		res =3D join(ns.pid);
> +		if (!res)
> +			res =3D set_fcap("/mnt/x", 0);
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
> +
> +FIXTURE(idmap) {};
> +
> +FIXTURE_VARIANT(idmap) {
> +	struct idmap_case c;
> +	long expect;
> +};
> +
> +/* X can't join a namespace that maps host uid 0 to get at the mount */
> +FIXTURE_VARIANT_ADD(idmap, reverse_mapping) {
> +	.c =3D { "0 0 1\n", "100000 0 1\n", 100000, 1 },
> +	.expect =3D -EPERM,
> +};

[Severity: Medium]
Are the set_fcap() and nested write_map() calls in several of these negative
tests reachable?

1. In map_after_setns_and_unshare (x_joins_unshares_maps()), fcap_after_set=
ns
(x_joins_sets_fcap()), and fcap_after_setns_v3_rootid
(x_joins_sets_fcap_rootid5()), the target namespace h is created with
HOLDER_ROOT and maps host UID 0 (at UID 0 or UID 5). When the restricted ch=
ild
calls join(PID(a)), setns() is rejected in userns_install() ->
cred_may_setfcap_userns() with -EPERM. Because those helpers immediately
return r when join() fails, the subsequent unshare(CLONE_NEWUSER) /
write_map() in x_joins_unshares_maps() and set_fcap() in x_joins_sets_fcap()
and x_joins_sets_fcap_rootid5() are never executed.

2. In fcap_after_dropping_setfcap_and_nesting (r_drops_then_nests()), after
mapping "5 0 1\n" in the first namespace, calling restrict_root(), and call=
ing
unshare(CLONE_NEWUSER) a second time, write_map(0, "5 5 1\n") always fails
with -EPERM in verify_root_map() because UID 5 in the parent namespace maps
host UID 0. The check:

	if (write_map(0, "5 5 1\n"))
		return -EPERM;

always returns at that point (and also masks any non-EPERM error from
write_map()), leaving the rest of the function:

	write_file(0, "setgroups", "deny");
	write_file(0, "gid_map", "5 5 1\n");
	return set_fcap("/tmp/x", 5);

unreachable. As a result, neither fcap_after_setns_v3_rootid nor
fcap_after_dropping_setfcap_and_nesting reaches cap_convert_nscap() with a
non-zero v3 rootid (5) from a task that holds CAP_SETFCAP in its own user
namespace.

3. Similarly, in idmap_case() for the reverse_mapping variant, im is set up
with "100000 0 1\n" and mounted idmapped at /mnt, while ns is spawned with
HOLDER_ROOT and "0 0 1\n". When c->restricted is set, join(ns.pid) fails wi=
th
-EPERM in setns(), so set_fcap("/mnt/x", 0) is never called against the
idmapped mount. Because idmap_case() always spawns ns with HOLDER_ROOT,
cap_convert_nscap() is never exercised on an idmapped mount by a task in a
user namespace created without CAP_SETFCAP (such as one spawned with
HOLDER_RESTRICTED where parent root mapped the UIDs).

Should these tests spawn or enter aHOLDER_RESTRICTED namespace mapped by the
parent (or assert that setup steps like join() and write_map() succeed) so
that set_fcap() and the nested operations are actually reached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v6-0-25f10b7ca497@toxicpanda.com?part=3D6
