Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146801;
	b=VYQ//91krVYCLu5S2bbiD8ZGgU/WckJ6A6hsmj2g+Q2oHNhMoaq+EGfEgDjulfjYDVI+
	 5+/fbIRHiV7zb3RBGyt+yzlApXlsLprswMmyMI2UyO/UuLFSJJEL+2I7mFSLJ/p6fBxOa
	 oBOXYOnuK6kqWJkqIodHOzr9I1ZHu6U/F/rXHhua3SdFlkb5ZJVhfoM8DtW6A0XNvRS80
	 y6ileZCx0SJuxayfLhontGlz/Br3mSOQsPe57TAtt7VTsqDqwboWvDKKRfYWwBIo3xR/r
	 UmLx8FgIFTb3ySWkK8QcUwTsjOAoFI1SzWvsPARz2ebv9zsBMkqSoX0Cg6K0tdN+YEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146801;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID;
	bh=7hT58o+4gmhdRju3R7Zzor1WNb/1Kh9cQCOkUUz9Uek=;
	b=iVUpP/IH1O55sLpCBJJB4LRHkxi4vy7fS3jDIayRGzNipxKdaKQl6Plh2NFnH/XtA9sl
	 bKpVOSoEAPdhPsg1rWLZ1kl3SxSddVDNikG+w4YHgIGM9NY1oUrGKa2IZZ3DAYxy5izJd
	 cJhMMhl5Ta+CbTwhYJM5LV6TMu9KLFFuF4nemElnIl8yTdwYDg1b8/+3YCeJ2cYGi/YYT
	 Y42xwHncq6g9luK1vKJcIfZ85JSnwfYLkP+ScRwr1eNnCmI/cq9MbxlKCKxyL3yvrN0GP
	 dBr684iyyMSqMjjUK2Aj94cFnOUDTI39uPF5uq+2bD9rGiEMpE4yWGSNge4pDZFz8Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=(null) smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=VVzVD4zv;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB244606A31C;
	Sun,  8 Nov 2026 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB244606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=VVzVD4zv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794146790; bh=7hT58o+4gmhdRju3R7Zzor1WNb/1Kh9cQCOkUUz9Uek=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VVzVD4zvHZf5/hd2vzbniEpd5oRzlxNKhMF400GpI/QIuH9nDgp+TO9df1vs3vmOK
	 rsZBOyb4syo4GV92U2btfiLiLlvy0Ccn4Ib23rIL+KDiyddOTOxR+PsZhoaefoq0j4
	 BEUwKC6+6KTOaZWGrKvX16OUGBejjxmH+nbe253OFWf84ozZCqk8Hy7PdZ6imkvlML
	 PUTf/QdeMrpWYa6oocqL8agbIe16MrnBLbGVC7k5aOvuuPdU/TWBP2KI7DH1j3sEiN
	 SHptc8hv0g7/iUjuyMF5PN2NIzGLS6jqoZqo5OAfsIsiyLNe/63XGjuM/SH5by7qH+
	 jTvNn11SY/2mA==
Received: from dummy.faircode.eu (unknown [172.56.94.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id DDCC3822;
	Sun,  8 Nov 2026 08:06:26 -0600 (CST)
Date: Sun, 8 Nov 2026 08:06:11 -0600
From: Serge Hallyn <serge@hallyn.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"Andrew G. Morgan" <morgan@kernel.org>,
	Serge Hallyn <sergeh@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Message-ID: <fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com>
In-Reply-To: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
Subject: Re: [PATCH v8 0/6] capabilities: close the ways around the
 CAP_SETFCAP rule for uid 0
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <fd159e68-c613-4c7d-bfba-8af0a3f3a96e@hallyn.com>

Oct 27, 2026 09:23:17 Josef Bacik <josef@toxicpanda.com>:

> v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66=
072@toxicpanda.com/
> v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d1928=
1d7@toxicpanda.com/
> v3: https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e4=
3e1@toxicpanda.com/
> v4: https://lore.kernel.org/all/20261022-b4-setfcap-userns-v4-0-88aa0ffaa=
08f@toxicpanda.com/
> v5: https://lore.kernel.org/all/20261023-b4-setfcap-userns-v5-0-0620223be=
951@toxicpanda.com/
> v6: https://lore.kernel.org/all/20261026-b4-setfcap-userns-v6-0-25f10b7ca=
497@toxicpanda.com/
> v7: https://lore.kernel.org/all/20261026-b4-setfcap-userns-v7-0-bf8a576f7=
259@toxicpanda.com/
>
> v7->v8:
> - 6/6 only, 1-5 are unchanged.=C2=A0 A case whose setup failed in a child
> =C2=A0 waited for the harness timeout, because the parent kept its own co=
py
> =C2=A0 of the pipe end it read from.=C2=A0 The cases where a privileged t=
ask maps
> =C2=A0 for one that gave up CAP_SETFCAP now share one helper that talks t=
o
> =C2=A0 it over a socket pair, and the others close the ends they don't us=
e,
> =C2=A0 so a failed step ends the case with a setup error at once (Sashiko=
).
>
> v6->v7:
> - 6/6 only, 1-5 are unchanged.=C2=A0 Every case now reaches the step it i=
s
> =C2=A0 named for, and a setup step that fails is an error rather than a
> =C2=A0 refusal.=C2=A0 Cases that stopped at setns() are setns() cases now=
: a task
> =C2=A0 that joins has CAP_SETFCAP wherever the creator had it, so nothing
> =C2=A0 after setns() checks it.=C2=A0 In the v3 rootid, nesting after dro=
pping
> =C2=A0 CAP_SETFCAP and reverse idmapped mount cases a privileged task map=
s a
> =C2=A0 namespace created without CAP_SETFCAP, so the xattr gets written.
> =C2=A0 pidfd_getfd() is a ptrace case of its own.=C2=A0 The session keyri=
ng case
> =C2=A0 joins a keyring of its own first, so it works under su, and skips
> =C2=A0 without keyrings (Sashiko).
>
> v5->v6:
> - New 6/6: a kselftest with every case the series has been through,
> =C2=A0 48 of them.=C2=A0 Without the series 22 fail, with v5 the 4 below =
fail.
> - 3/5: a task inside the namespace that is being mapped also has to
> =C2=A0 hold CAP_SETFCAP there to open or write a uid_map that maps an
> =C2=A0 ancestor's root user.=C2=A0 Before, a task that gave up CAP_SETFCA=
P could
> =C2=A0 write "0 0 1" and get it back from execve() (Sashiko).
> - 4/5: a v2 xattr on a filesystem whose namespace has no uid 0 is
> =C2=A0 refused with -EINVAL instead of stored unconverted, where it was
> =C2=A0 honoured nowhere.=C2=A0 Falling through to the conversion would no=
t do:
> =C2=A0 for a writer outside that namespace it names the writer's root use=
r
> =C2=A0 instead (Sashiko).
>
> v4->v5:
> - 3/5: the uid_map check only looked for an extent at the parent's uid
> =C2=A0 0.=C2=A0 The root user of an ancestor can sit at any uid in the pa=
rent, so
> =C2=A0 a task without CAP_SETFCAP could map "0 1000 1" under a "1000 0 1"
> =C2=A0 and get host uid 0 as its uid 0 unchecked.=C2=A0 It now finds ever=
y
> =C2=A0 ancestor root user the map contains.=C2=A0 4/5 already refused the=
 file
> =C2=A0 capabilities after such a map, so this is the map rule itself
> =C2=A0 (Sashiko).=C2=A0 Dropped Bradley's Reviewed-by on 3/5, which chang=
ed.
>
> v3->v4:
> - 4/5: a v2 security.capability xattr skipped the new checks, it was
> =C2=A0 written as is whenever the writer had CAP_SETFCAP over the
> =C2=A0 filesystem's namespace.=C2=A0 It now only does that when the files=
ystem's
> =C2=A0 root user is within reach, and goes through the v3 conversion and =
its
> =C2=A0 checks otherwise (Sashiko).
>
> v2->v3:
> - The setns() check in 2/5 and the ptrace check in 5/5 only apply to
> =C2=A0 namespaces that map the root user of an ancestor within the creato=
r's
> =C2=A0 CAP_SETFCAP, or that have no uid_map yet.=C2=A0 Root users stored =
through
> =C2=A0 an idmapped mount are left to whoever sets up the mount, so a root
> =C2=A0 task without CAP_SETFCAP can join an ordinary "0 100000" container
> =C2=A0 again (Serge, Christian).
> - 2/5 adds cred_may_setfcap_userns() for those two checks and
> =C2=A0 cred_setfcap_reaches() for the uid_map check; nothing outside
> =C2=A0 create_user_ns() calls cap_setfcap_level() directly (Serge).
> - Fixed the cap_setfcap_level() kernel-doc, @ns doesn't have to be the
> =C2=A0 cred's namespace or below; cap_capable() is compared with !=3D 0
> =C2=A0 (Serge).
> - Picked up Bradley's Reviewed-by on 1/5 and 3/5, not on 2/5, which
> =C2=A0 changed.
> - Rebased onto current vfs.all.
>
> v1->v2:
> - The state lives on the user namespace now: ns->setfcap_level replaces
> =C2=A0 ns->parent_could_setfcap, and cred->setfcap_level is gone (Serge,
> =C2=A0 Christian).
> - New 2/5: setns() refuses a task whose CAP_SETFCAP doesn't reach as far
> =C2=A0 up as the namespace's setfcap_level.=C2=A0 It applies to every use=
r
> =C2=A0 namespace, not only to those that map the parent's uid 0, because =
of
> =C2=A0 idmapped mounts (Serge, Christian).
> - 5/5 asks a tracer for what setns() asks for, also when the namespace
> =C2=A0 doesn't map an ancestor's root user, again because of idmapped mou=
nts.
> - Dropped "userns: don't let setns() lend the right to map uid 0", the
> =C2=A0 setns() check covers it.=C2=A0 Its nested case moved into 3/5, whi=
ch checks
> =C2=A0 the opener and the writer.
> - set_cred_user_ns() isn't touched anymore, so the put-before-use in
> =C2=A0 userns_install() is gone (Sashiko).
> - Rebased onto current vfs.all.
>
> What it does now:
>
> Every user namespace gets a setfcap_level when it's created, which is
> how far up the creator's CAP_SETFCAP counted.=C2=A0 If its tasks can writ=
e
> file capabilities for the root user of an ancestor, because the
> namespace maps that root user or can still map it, setns() only lets in
> tasks whose own CAP_SETFCAP reaches that far, and PTRACE_ATTACH asks the
> tracer for the same.=C2=A0 The checks on the way to file capabilities the=
n go
> by the namespace instead of the cred: a uid_map write that maps the
> parent's uid 0 (opener and writer), and setting security.capability.
>
> The visible difference from v1 is the setns() restriction.=C2=A0 A task
> without CAP_SETFCAP can't join, or attach to tasks in, a namespace that
> maps the root user of an ancestor, such as host uid 0, and was created
> by a task that had it.=C2=A0 A task that joins takes on the namespace's
> reach.=C2=A0 Containers that don't map host uid 0, unprivileged users and
> anything with CAP_SETFCAP aren't affected.
>
> Testing: 6/6 runs every case on its own, 48 in all, as root in private
> mount namespaces.=C2=A0 On vfs.all without the series 22 of them fail: th=
e
> ways around the rule, and the two v2 xattrs without a root user that are
> now refused; with the series all pass, including the idmapped mount
> ones.=C2=A0 The pidfd, namespaces, mount_setattr and ptrace selftests giv=
e
> identical results with and without.=C2=A0 The TLA+ model, which has no
> idmapped mounts, no v2 xattrs and maps only uid 0 of the parent, finds
> no violation with the narrower setns() and ptrace checks, and still
> finds the setns() bypass when the check is taken out.
>
> --- Original email (v1) ---
>
> Hello,
>
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> stops a root task that has given up CAP_SETFCAP from creating a user
> namespace that maps uid 0 and then writing file capabilities in it that
> the initial namespace honours.=C2=A0 The check only looks at the task tha=
t
> creates the namespace, so if somebody who did have CAP_SETFCAP created
> one, there are still several ways around it:
>
> - setns() into their namespace and write uid_map from inside (patch 2)
> - write "0 0 1" through a uid_map fd that they opened (patch 3)
> - setns() into a namespace of theirs that already maps uid 0 and set
> =C2=A0 security.capability there, no map write needed (patch 4)
> - ptrace one of their tasks and have it do any of the above (patch 5)
>
> On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
> from its permitted, effective and bounding sets and, through each of
> these, ended up with a file that a uid 1000 user execs with
> CAP_SYS_ADMIN in its effective set.
>
> Patch 1 adds cred->setfcap_level, which records how far up the
> namespace tree a task's CAP_SETFCAP reached when it entered its
> namespace, and patches 2-5 check it.=C2=A0 Patch 4 is the check that clos=
es
> the class, the map patches make the uid 0 map rule mean what
> db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
> the target is entitled to.
>
> This does change behaviour.=C2=A0 Everything new is -EPERM:
>
> - a task that entered a namespace without CAP_SETFCAP outside can't map
> =C2=A0 uid 0 of the outside or write fscaps for that root user anymore
> - a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
> =C2=A0 task without it to map uid 0
> - if a privileged task maps "0 0 1" from the parent for a namespace
> =C2=A0 created by a task without CAP_SETFCAP, that namespace can no longe=
r
> =C2=A0 write fscaps honoured outside
> - PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
> =C2=A0 CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share =
a
> =C2=A0 root user
>
> Rootless containers, privileged runtimes writing the map from the
> parent, nested unprivileged namespaces and containers that don't map
> host uid 0 aren't affected.=C2=A0 The ptrace check is one compare for
> targets in the initial namespace and in namespaces entered without
> the capability.
>
> Testing: a set of flows run on the base and patched kernels, every
> bypass route above gets -EPERM with the series and the 16 legitimate
> flows behave the same.=C2=A0 The capabilities, namespaces, ptrace, pidfd =
and
> proc selftests give the same results before and after. Thanks,
>
> Josef
>
> ---
> Changes in v8:
> - Link to v7: https://patch.msgid.link/20261026-b4-setfcap-userns-v7-0-bf=
8a576f7259@toxicpanda.com
>
> Changes in v7:
> - Link to v6: https://patch.msgid.link/20261026-b4-setfcap-userns-v6-0-25=
f10b7ca497@toxicpanda.com
>
> Changes in v6:
> - Link to v5: https://patch.msgid.link/20261023-b4-setfcap-userns-v5-0-06=
20223be951@toxicpanda.com
>
> Changes in v5:
> - Link to v4: https://patch.msgid.link/20261022-b4-setfcap-userns-v4-0-88=
aa0ffaa08f@toxicpanda.com
>
> Changes in v4:
> - Link to v3: https://patch.msgid.link/20261021-b4-setfcap-userns-v3-0-97=
c7ed4e43e1@toxicpanda.com
>
> Changes in v3:
> - Link to v2: https://patch.msgid.link/20261014-b4-setfcap-userns-v2-0-fa=
c4d19281d7@toxicpanda.com
>
> Changes in v2:
> - Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f4=
7e7ed66072@toxicpanda.com
>
> ---
> Josef Bacik (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 userns: record how far up CAP_SETFCAP reac=
hes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 userns: don't let setns() lend CAP_SETFCAP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 userns: check the opener and the writer be=
fore mapping uid 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capabilities: limit fscaps to where CAP_SE=
TFCAP reaches
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capabilities: don't let ptrace borrow CAP_=
SETFCAP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selftests/namespaces: test the CAP_SETFCAP=
 rule for user namespaces

The cancern addressed by pach 3 requires collusion by a task which can do i=
t all on its own (or a confused deputy). I don't think that's something we =
should protect against. Same is true for 4.

For setns and ptrace, i find the level metric too disconnected from the pro=
blem and hard to reason about, and worry about future maintenance. Can we j=
ust compare the lower root kuids? So for ptrace, we can use explicitly chec=
k that the caller is uid 0 without setfcap, and target has setfcap. Analogo=
us for setns.

Alternatively,=C2=A0 for ptrace, we could update the docs and man-pages to =
recommend always dropping ptrace along with setfcap. After all, the task ca=
n just ptrace any other task in same userns, right?

> include/linux/capability.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
> include/linux/user_namespace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 7 +-
> kernel/user_namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 95 +-
> security/commoncap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 184 ++-
> tools/testing/selftests/namespaces/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +-
> tools/testing/selftests/namespaces/config=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> tools/testing/selftests/namespaces/setfcap_test.c | 1368 ++++++++++++++++=
+++++
> 7 files changed, 1632 insertions(+), 34 deletions(-)
> ---
> base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
> change-id: 20261006-b4-setfcap-userns-d63185a31ce3

