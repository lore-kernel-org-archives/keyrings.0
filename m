Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065C42C4F5;
	Mon, 10 Aug 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380615; cv=none; b=Lsu12KDiTIPpGHPAMi9mDL8DN5tczxjgdSDjinFel/KV12vmJPPSp0PbfRxl9qMdpZ97lRC8tywKiI2oiHD07bDK+zRq2Z6Msb/Ydi8UHPssTAHIh7T6gYFxBO9TQrOHjkrLUbE4p4+NDmnzpTBDJNTg1PnWqFFZfJIv8gJYt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380615; c=relaxed/simple;
	bh=ofImNQ/bBS7l/ykaciyF5yAoq+HZmuR9c38HaYC8tAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUvWBDUZyOaBkHyZoexXh//1NeJ9o2g6B8e7SbF9w0KNPIeDQSKyLwr0SXE5epEe31LQ6Gmdtu524zJz0CsF/xDd7/gsBH/4udqiQaNdCvK+SAKACWmnUrTKjKeVd/YeGW6PhFgJKTyZ12ppURssHoSpmu0H0ArvKJNj8kJMnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aNxYwP48; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aNxYwP48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1786380612;
	bh=ofImNQ/bBS7l/ykaciyF5yAoq+HZmuR9c38HaYC8tAs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aNxYwP48AQNIpO+yXVNGdSq0JaUIEXr4njnAzk4Ryt5ojXuZOfvg7dSiPfobeJHhH
	 rKmZwaHGR65uG6NdZgRLtjfvlJ2sJmGHaRwr/Jhgi3kHtZdeKvnrSgYkeSuzxtku68
	 jUWZ0h9t9h5JISxaWjByoIvoLcn6BcB7K3KMgLcE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d341::8309])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 42F9A1C0138;
	Mon, 10 Aug 2026 12:50:12 -0400 (EDT)
Message-ID: <8a5ac8ef55346825f57f8d3966b312f3d1152c2d.camel@HansenPartnership.com>
Subject: Re: keys: request_key_auth shows a global pid in /proc/keys across
 pid namespaces
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, David Howells <dhowells@redhat.com>,
  Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E . Hallyn"
	 <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 10 Aug 2026 12:50:11 -0400
In-Reply-To: <20260809110202.2180410-1-maoyixie.tju@gmail.com>
References: <20260809110202.2180410-1-maoyixie.tju@gmail.com>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 keydata=mQENBE58FlABCADPM714lRLxGmba4JFjkocqpj1/6/Cx+IXezcS22azZetzCXDpm2MfNE
 lecY3qkFjfnoffQiw5rrOO0/oRSATOh8+2fmJ6el7naRbDuh+i8lVESfdlkoqX57H5R8h/UTIp6gn
 1mpNlxjQv6QSZbl551zQ1nmkSVRbA5TbEp4br5GZeJ58esmYDCBwxuFTsSsdzbOBNthLcudWpJZHU
 RfMc0ew24By1nldL9F37AktNcCipKpC2U0NtGlJjYPNSVXrCd1izxKmO7te7BLP+7B4DNj1VRnaf8
 X9+VIApCi/l4Kdx+ZR3aLTqSuNsIMmXUJ3T8JRl+ag7kby/KBp+0OpotABEBAAG0N0phbWVzIEJvd
 HRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT6JAVgEEwEIAEICGw
 MGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAml2ZBI
 FCS3GUMIACgkQgUrkfCFIVNZKjQf/deRzlXZClKxTC/Ee2yEPqqS7mm/INUA49KdQQ5oIhSxkUBy0
 9J4qjMIo5F8ZFkFTqikBqeL35LKu7O7rn8WETfX8Bxvos3HUsl3jHo34DES4MUFIpoQPgtiLRGwLb
 K0cVCAArR2u2qj4ABmTRrs1I1kvdjEw6gatOuXtEe/j5O2fvfzTq9GBr0Q3n2IAsFXi4hLlx6VPE8
 tyWUZ8BWJKtih3JAeUiXFvASL3McV0rV9RnU0VbjEQEhSE7PMYhWpnDC9AyBb0lXJllQRvC3NSkUB
 8KVQgNNxRPss0WE/nBoZ4dFA42jTyzTz8lNylxZoAWV7WJb3QxVg4oCodRVrxxrQhSmFtZXMgQm90
 dG9tbGV5IDxqZWpiQGtlcm5lbC5vcmc+iQFVBBMBCAA/AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeA
 QIXgBYhBNVgbnPItGJxvq2a34FK5HwhSFTWBQJgS5mYBQkbNYS9AAoJEIFK5HwhSFTWBpwIAL5Bk3
 5FB34U6iHmDzzgdCbxLTs43T/YQyJpcGIvopBvnI/fDY8oSG6Df64/O6B+1R+A8TDp6ZG5ysUWnCC
 6GuIaEHemBYkitMPglR6+sGCMQY7O0mlsPvdssvKK1KI9Bno4VU6ogaF2qVzefSqg1Djmf/DcsxWP
 rI/jdJ8FB5AYR2rjIdDFc+zRdAJuavo1/anyY2wgpFh/3R8IOYAEfWV9nGgYkf9+tA4EIn1sxE0I3
 L5oW2N3mbyRrkzuBwO8ztMCwqEPk7moWzhokcZqMXiAIahaZdkashJC+s2X2RZSGCy+g+pvY5NN4B
 BVG5XwLgVBqbHMTcxE0fbmPqz+q6O0LEphbWVzIEJvdHRvbWxleSA8amVqYkBoYW5zZW5wYXJ0bmV
 yc2hpcC5jb20+iQFXBBMBCABBFiEE1WBuc8i0YnG+rZrfgUrkfCFIVNYFAmODZ5ACGwMFCRs1hL0F
 CwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQgUrkfCFIVNZu0Af/TzvL2/NdgAcw9uN3x60H8
 jc4QUq14VpxcFEFEMpcj1morkX/G93V+56HBBaXZj+yK8PhxIA/SIz+sU7C/0YvKuvzakP8ZX/7WJ
 e32SOUtjfr/VTaqjIBzNj6OxLvZpmNbBw7s6DwhhNpHOWqJ/1ml+PtDRDV71IB58yVqQjp1xlNKVl
 ZppcJ5908EJzsFnRIVjiQiDSKoppqB2BCibBbrWcln7CiWMyOC/cco6SIn6twH+f7+aivJ3xGcOE2
 a9gBKF5rNi9TBoX9oyPmshv/TDmnohsVrH7AYXlGYfZTk15SWEiROh1QX8/uD9wl/gcIv5EDUpT/F
 L2jzOsA5663bw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-09 at 19:02 +0800, Maoyi Xie wrote:
> Hi all,
>=20
> I think request_key_auth leaks a global pid into /proc/keys. I would
> appreciate it if you could take a look.
>=20
> request_key_auth_describe() prints the requestor's pid:
>=20
> 	if (key_is_positive(key))
> 		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka-
> >callout_len);
>=20
> rka->pid is current->pid, captured in request_key_auth_new() when the
> auth key is made. It is a raw pid_t in the init pid namespace. But
> /proc/keys is read by whoever opens it, and their pid namespace can
> differ. The uid and gid on that line already go through
> seq_user_ns(m).
> The pid does not. So a reader in another pid namespace gets a number
> that means nothing there, or worse lands on a different task.
>=20
> Not everyone can read the line. The owner uid must map into the
> reader's
> user namespace, and the reader needs VIEW on the key. The auth key
> gives
> VIEW to the requestor's own uid and to a possessor. So the reader has
> to
> be the requestor's uid, in a different pid namespace. That fits a
> sandbox at the same uid, made with unshare, systemd-nspawn or
> bubblewrap. A default Docker container does not hit it, since it
> hides
> /proc/keys.
>=20
> I found this with a static check for ids that reach userspace with no
> namespace translation. I reproduced it in a qemu VM on 7.1-rc1 as a
> normal user, no hardware or kernel changes needed. The reproducer
> calls
> request_key, then reads /proc/keys from a sibling pid namespace.
> Before
> the patch it reads the requestor's global pid, which does not exist
> in
> that namespace. After the patch it reads pid 0, since the requestor
> has
> no pid there. There is no keyrings selftest in the tree, so this is
> the
> only test.
>=20
> I am happy to send a patch. The raw pid_t cannot be translated later.
> So
> I stored a struct pid and print it with pid_nr_ns, the way the uid is
> already scoped.
>=20
> Thanks,
> Maoyi
> https://maoyixie.com/
>=20
> ---
>=20
> diff --git a/include/keys/request_key_auth-type.h
> b/include/keys/request_key_auth-type.h
> index 01e42ee5f4099..464636278c4f8 100644
> --- a/include/keys/request_key_auth-type.h
> +++ b/include/keys/request_key_auth-type.h
> @@ -22,7 +22,7 @@ struct request_key_auth {
> =C2=A0	const struct cred	*cred;
> =C2=A0	void			*callout_info;
> =C2=A0	size_t			callout_len;
> -	pid_t			pid;
> +	struct pid		*pid;
> =C2=A0	char			op[8];
> =C2=A0} __randomize_layout;
> =C2=A0
> diff --git a/security/keys/request_key_auth.c
> b/security/keys/request_key_auth.c
> index 282e09d8fa46c..e8d1037526b19 100644
> --- a/security/keys/request_key_auth.c
> +++ b/security/keys/request_key_auth.c
> @@ -13,6 +13,8 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0#include "internal.h"
> +#include <linux/pid_namespace.h>
> +#include <linux/proc_fs.h>
> =C2=A0#include <keys/request_key_auth-type.h>
> =C2=A0
> =C2=A0static int request_key_auth_preparse(struct key_preparsed_payload
> *);
> @@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct
> key *key,
> =C2=A0	seq_puts(m, "key:");
> =C2=A0	seq_puts(m, key->description);
> =C2=A0	if (key_is_positive(key))
> -		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka-
> >callout_len);
> +		seq_printf(m, " pid:%d ci:%zu",
> +			=C2=A0=C2=A0 pid_nr_ns(rka->pid,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 proc_pid_ns(file_inode(m-
> >file)->i_sb)),
> +			=C2=A0=C2=A0 rka->callout_len);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -113,6 +118,7 @@ static void free_request_key_auth(struct
> request_key_auth *rka)
> =C2=A0	if (rka->cred)
> =C2=A0		put_cred(rka->cred);
> =C2=A0	kfree(rka->callout_info);
> +	put_pid(rka->pid);
> =C2=A0	kfree(rka);
> =C2=A0}
> =C2=A0
> @@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key
> *target, const char *op,
> =C2=A0
> =C2=A0		irka =3D cred->request_key_auth->payload.data[0];
> =C2=A0		rka->cred =3D get_cred(irka->cred);
> -		rka->pid =3D irka->pid;
> +		rka->pid =3D get_pid(irka->pid);
> =C2=A0
> =C2=A0		up_read(&cred->request_key_auth->sem);
> =C2=A0	}
> =C2=A0	else {
> =C2=A0		/* it isn't - use this process as the context */
> =C2=A0		rka->cred =3D get_cred(cred);
> -		rka->pid =3D current->pid;
> +		rka->pid =3D get_pid(task_pid(current));

I'm afraid this get_pid/put_pid doesn't look right because what it will
do is pin the pid in the creator pid namespace.  Unfortunately, some
keys and keyrings aren't bound to a pid namespace, so if I create a key
in my user keyring and then enter a new pid namespace, with this change
it will still show up as the pid number of the init namespace (pinning
the struct pid there) and vice versa, which still sounds like the wrong
behaviour.

I think if you really want to fix this, you have to keep the pid as is,
but make sure it always records the pid in the init_pid_ns (i.e. always
translate back to init_ns) and then translate to the current pid_ns in
the output generator of /proc/keys.

Regards,

James

