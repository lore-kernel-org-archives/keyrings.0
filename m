Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890955;
	b=m34+gGafBnqEouAVTquIgYeXi8Io8i1iFmxSooBm6tOgXou+URyJ77etBmQK52FU3428
	 z+VEj891NP4h/UOtuu4J8XfHOe44NfRwLwpUbL46dKxt4ebhZjbBRe16WAzSbc8Ya73Is
	 +VgLZuldM1aNQ3ap6kn/DfRgckqGbZvwvgT0QYidM3ngXt4B943szfP0KQBCuNrFpsfud
	 1DbyBWcenJU03ZNaqo5eV0FjuPXslLKVnVOau/Rinlab1dWnLFAT1pF/erwESqKEwGQY1
	 ZY+VHa0y4POpEqrevONeLGlZDqvkHoa4/pGWCaNY43BXzyZrVaq/1aB3rtnpUfYnQyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BijGUrhWAz7YeOSjm07Qc0dkFEPjuiY9ZeSrOc4vdSw=;
	b=ruz+uBH/nSddo74tltmPZ14pOXMz+KFBEbxbKaVR3+IX9Z1Jr4gUVyczJo9ngeQYYCjD
	 rqylIrWCK1a0Q6K2QSJOYAOKe7YwfmOtzCEe7YkXwL5YhBsdu8zu4PM6TU2pgE8I+XZa4
	 bUPura7uNCSNMHejMJ9h3q7XEoa6XIZUpLgVcEoP8nVYZM8loYDXACaL1Cnf0EH9eUQNb
	 G79BgTwsMXa7AsMZhDz0s+OcZPskv4PSNj3v9HyOit91i6lBVuYWMjQhFl1HPQWSsswCh
	 z6Xz80YP8otiW17pt+L1YNhzVxitsVxLrewZU0RDKW2yXD8agJFP/Q/KPtujdSkTRfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJaFWfJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894B606EEAB;
	Thu,  5 Nov 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJaFWfJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245931F0093A;
	Thu,  5 Nov 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890954;
	bh=BijGUrhWAz7YeOSjm07Qc0dkFEPjuiY9ZeSrOc4vdSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJaFWfJe0YZf/ylFd2INgrxQ1VlPcWuEAmBYKGy4MQ6ADNgOLrjRBeg3oVn9sfYNZ
	 k1EaHLQN6NBjfmagWl/EO4nZyjr447HIFZpw9Md/wOaehgvUBS1ORl9bI9NV+obgB6
	 g+FhwieCJB8p+dqVsw9hbJ7vh0LttQN+/CPGkuYEhkPeNc80tTrIxbIp+wKFRv/qLN
	 pcICvws3PXO1rEmCwDENS12qL2MCU9mGA/PBdPkjfe9V04qMw7FjCtDrBXJDv+6z8h
	 GiBxrVTqnqleBulXpgM40eRna6y2H7Oyi7dtWft+LUAodM+dGYG5IgS6xn4099kqgs
	 8M/XBerqTx4yQ==
Message-ID: <sashiko-outbox-199284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] pseries/plpks/wrapkey: expose PKWM wrapping key
 management to userspace via sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srish Srinivasan" <ssrish@linux.ibm.com>, keyrings@vger.kernel.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com, jarkko@kernel.org, zohar@linux.ibm.com, linux-security-module@vger.kernel.org, nayna@linux.ibm.com, rnsastry@linux.ibm.com
In-Reply-To: <20261105144320.357260-10-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-10-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:02:33 +0000
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
- [Medium] pseries/plpks: label truncation and undocumented format in list_=
key_labels()
- [Medium] pseries/plpks: TOCTOU race between delete_store() and unrevoke_s=
tore()
- [Low] pseries/plpks: duplicated sysfs store/show logic in plpks-wrapkey-s=
ysfs.c
--

commit 58203a02dbc210e21378df2545831a7ea49bbca4
Author: Srish Srinivasan <ssrish@linux.ibm.com>

pseries/plpks/wrapkey: expose PKWM wrapping key management to userspace via=
 sysfs

This commit adds a sysfs interface under /sys/firmware/plpks/wrapkey to all=
ow
userspace to create, revoke, unrevoke, delete, and list PKWM wrapping keys.

> diff --git a/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c b/arch/=
powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
> new file mode 100644
> index 0000000000000..c293196cc9adf
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
[ ... ]
> +static ssize_t list_key_labels(char *buf, u8 *obj_labels_buf,
> +			       u64 obj_labels_count, int revoked)
> +{
> +	struct plpks_var var =3D { 0 };
> +	u8 *obj_labels_buf_ptr, *comp_prefix;
> +	u8 *key_label_ptr;
> +	u16 obj_label_len;
> +	int len =3D 0;
> +	int is_revoked;
> +	u64 i;
> +
> +	var.os =3D PLPKS_VAR_LINUX;
> +	var.component =3D PLPKS_WRAPKEY_COMPONENT;
> +	obj_labels_buf_ptr =3D obj_labels_buf;
> +
> +	for (i =3D 0; i < obj_labels_count; ++i) {
> +		obj_label_len =3D get_unaligned_be16(obj_labels_buf_ptr);
> +		comp_prefix =3D obj_labels_buf_ptr +
> +			      PLPKS_OBJLABEL_LEN_FIELD_SIZE;
> +
> +		var.namelen =3D obj_label_len - PLPKS_MAX_LABEL_ATTR_SIZE;
> +		var.name =3D kzalloc(var.namelen + 1, GFP_KERNEL);
> +
> +		if (!var.name)
> +			return -ENOMEM;
> +
> +		key_label_ptr =3D comp_prefix + PLPKS_MAX_LABEL_ATTR_SIZE;
> +		memcpy(var.name, key_label_ptr, var.namelen);
> +
> +		is_revoked =3D plpks_is_wrapping_key_revoked(&var);
> +		if (is_revoked =3D=3D revoked)
> +			len +=3D sysfs_emit_at(buf, len, "<%s>\n",
> +					     (char *)var.name);

[Severity: Medium]
Can list_key_labels() silently truncate wrapping key labels when reading
/sys/firmware/plpks/wrapkey/list_active or list_revoked?

plpks_get_object_labels() can retrieve labels across multiple 4KB buffers v=
ia
H_CONTINUE, and each label can be up to PLPKS_MAX_NAME_SIZE (239) bytes.
However, a standard kobj_attribute show buffer is limited to PAGE_SIZE - 1
bytes. Once len reaches PAGE_SIZE - 1, sysfs_emit_at() returns 0 and any
remaining wrapping key labels are silently omitted without any error or
indication to userspace.

Also, list_key_labels() formats each label wrapped in angle brackets
("<%s>\n"), whereas Documentation/ABI/testing/sysfs-firmware-plpks does not
mention the angle-bracket format for list_active and list_revoked. Should t=
he
output format and buffer limit be addressed or documented?

> +		else if (is_revoked < 0)
> +			pr_warn("Failed to get revocation status for <%s>\n",
> +				(char *)var.name);
> +
> +		kfree(var.name);
> +		obj_labels_buf_ptr =3D key_label_ptr + var.namelen;
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t list_active_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	u8 *obj_labels_buf =3D NULL;
> +	u64 obj_labels_count =3D 0;
> +	int rc;
> +
> +	rc =3D plpks_get_object_labels(&obj_labels_buf, &obj_labels_count,
> +				     PLPKS_WRAPKEY_COMPONENT);
> +	if (rc) {
> +		pr_err("Retrieving object labels failed. rc=3D%d\n", rc);
> +		goto out;
> +	}
> +
> +	rc =3D list_key_labels(buf, obj_labels_buf, obj_labels_count,
> +			     PLPKS_WRAPKEY_UNREVOKED);
> +
> +out:
> +	kfree(obj_labels_buf);
> +	return rc;
> +}
> +
> +static ssize_t list_revoked_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	u8 *obj_labels_buf =3D NULL;
> +	u64 obj_labels_count =3D 0;
> +	int rc;
> +
> +	rc =3D plpks_get_object_labels(&obj_labels_buf, &obj_labels_count,
> +				     PLPKS_WRAPKEY_COMPONENT);
> +	if (rc) {
> +		pr_err("Retrieving object labels failed. rc=3D%d\n", rc);
> +		goto out;
> +	}
> +
> +	rc =3D list_key_labels(buf, obj_labels_buf, obj_labels_count,
> +			     PLPKS_WRAPKEY_REVOKED);
> +
> +out:
> +	kfree(obj_labels_buf);
> +	return rc;
> +}
> +
> +static ssize_t create_store(struct kobject *kobj, struct kobj_attribute =
*attr,
> +			    const char *buf, size_t count)
> +{
[ ... ]
> +static ssize_t unrevoke_store(struct kobject *kobj, struct kobj_attribut=
e *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct plpks_var var =3D { 0 };
> +	int rc;
> +
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		rc =3D -EPERM;
> +		goto out;
> +	}
> +
> +	if (!count) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (count > PLPKS_MAX_NAME_SIZE) {
> +		rc =3D -ENAMETOOLONG;
> +		goto out;
> +	}
> +
> +	if (!strcmp(buf, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!is_wrapkey_label_alnum(buf, count)) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	var.name =3D kstrndup(buf, count, GFP_KERNEL);
> +	if (!var.name) {
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	var.namelen =3D count;
> +	var.os =3D PLPKS_VAR_LINUX;
> +	var.component =3D PLPKS_WRAPKEY_COMPONENT;
> +
> +	rc =3D plpks_unrevoke_wrapping_key(&var);
> +
> +	if (rc) {
> +		pr_err("un-revocation of wrapping key <%s> failed. rc =3D %d\n",
> +		       (char *)var.name, rc);
> +		goto out;
> +	}
> +
> +	rc =3D count;
> +out:
> +	kfree(var.name);
> +	return rc;
> +}

[Severity: Low]
This isn't a bug, but create_store(), revoke_store(), unrevoke_store(), and
delete_store() all duplicate the same CAP_SYS_ADMIN check, count validation,
PLPKS_DEFAULT_WRAPKEY_LABEL check, is_wrapkey_label_alnum() validation,
kstrndup() allocation, and struct plpks_var initialization (with
unrevoke_store() returning -EINVAL instead of -EPERM for
PLPKS_DEFAULT_WRAPKEY_LABEL).

Similarly, list_active_show() and list_revoked_show() duplicate the
plpks_get_object_labels() call and cleanup, differing only in passing
PLPKS_WRAPKEY_UNREVOKED vs PLPKS_WRAPKEY_REVOKED to list_key_labels().

Could the shared store validation/setup and show label retrieval logic be
factored into common helpers?

> +
> +static ssize_t delete_store(struct kobject *kobj, struct kobj_attribute =
*attr,
> +			    const char *buf, size_t count)
> +{
[ ... ]
> +	rc =3D plpks_del_wrapping_key(&var);

[Severity: Medium]
What prevents a TOCTOU race if delete_store() and unrevoke_store() are call=
ed
concurrently on the same revoked wrapping key?

In arch/powerpc/platforms/pseries/plpks.c, plpks_del_wrapping_key() enforces
that a key is revoked before deletion across two separate hypercalls without
any lock:

plpks_del_wrapping_key()
    rc =3D plpks_is_wrapping_key_revoked(var);
    if (rc =3D=3D 1) {
        ...
        rc =3D plpks_remove_var(PLPKS_WRAPKEY_COMPONENT, var->os, vname);

Because delete and unrevoke are separate sysfs attributes, kernfs only holds
its per-open-file mutex separately for each attribute. If CPU 0 enters
delete_store() -> plpks_del_wrapping_key() and sees
plpks_is_wrapping_key_revoked() =3D=3D 1, and CPU 1 concurrently runs
unrevoke_store() -> plpks_unrevoke_wrapping_key() (H_PKS_UNREVOKE_OBJECT)
before CPU 0 calls plpks_remove_var() (H_PKS_REMOVE_OBJECT), won't CPU 0
delete the now-active wrapping key?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D9
