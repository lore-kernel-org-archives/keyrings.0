Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325885;
	b=slmfOqYr1oRAech+/iu/7OEFvXKXVktURbKpaaDO3vcGec/LHLNlzZ1mVzT6xJJRT2lA
	 +FDYtPq6x1cGg2fquiWUHV8Lt9LA/ad7+vLvTQU3/X0rz318Da9uSEqUOLyUXFMmg+jix
	 6AyfdXBHzhNPGe5Sulnk0RN9C1heYCtTvU7L91SGBXeVRzZVQ6/HVyFzOIxPX594uIxqy
	 R8G6DBAmrrNXrXF/snR2KVXjUrY7alUevI8zSTRdHDk91q0tlsEUuO0SCqLtP/C7xtsT0
	 ODj/CvfN2uGx8w/oXLfib3fhU0g+NKoO+WrMq4cq65zVZZq4zPJ+qd0lCgdb89slnMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325885;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S+yaxY1IOkbr2hblsylEbiBouEaLkWRredpFXFNGEPs=;
	b=MJxgZI/AvYzrgVY3E2EfyjPXdL3LkDAiPzsI93mu+Uz4aqKbiAOtauPRtBlRmuSf+po0
	 ZOagbvL9naN1+Q3dJ/WL4GJd1wRL7m1fsCrNSlk6FDulLn22BhWIcth0ACQrV+TmCOZpl
	 kHuM60zzs17zhYZjrtVC4LzJP+zw03RWCwp99ZCqCWgrSr4h7MIX5U2Qxg42U5XSUWs2W
	 G58Okk+uJH44Fr4A+jNhAp8IFohTiPlfRhb9PBdyzQq2nYUHTbTqsovKW86A4CcLLBPFW
	 nVye5kb3SWXfv8hAeX4SEIPIy/FAepePFeiXqnDUFE9TxlP+yyS4v85evZD5xawnFzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rld116DC;
	arc=none smtp.remote-ip=91.218.175.114
Received: from mta0.migadu.com (out-114.mta0.migadu.com [91.218.175.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856C606A320
	for <keyrings@vger.kernel.org>; Tue, 10 Nov 2026 15:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5856C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rld116DC
X-Envelope-To: keyrings@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ekUbTVzeA1JNlzfG7xd+5633WBpvGDfH+mmSDR5DYLM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794325882; v=1; x=1794930682;
 b=rld116DCyefpF4HY6HzebCbZOPxDgtBgxSsjhBvC1bllJIxpyyrQhJq+P+PzvTn4OLH4t74n
 Mc9IMqMWy0YdoXmgUVTTIjmZC8DOoFaUD6ZduG7QNFZskXgOx/QcJ0nYRCt6F/hu0SpO1Vr+WNN
 IOz/Hc+sRP6qee1SHukxIaG4=
X-Envelope-To: keyrings@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ef20ab98b7ec7150;
	Tue, 10 Nov 2026 15:51:22 +0000
X-Mizu-Trace-ID: ef20ab98b7ec7150
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 15:51:18 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: mic@digikod.net
CC: brads@mainlining.org, brauner@kernel.org, dhowells@redhat.com,
 jarkko@kernel.org, jmorris@namei.org, josef@toxicpanda.com,
 keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 morgan@kernel.org, paul@paul-moore.com, serge@hallyn.com, sergeh@kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_userns=3A_Let_LSMs_deny_the_?=
 =?US-ASCII?Q?CAP=5FSETFCAP_snapshot_for_mapping_uid_0?=
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
Message-ID: <80A558D7-7DC3-4780-91F5-990E4917E8A4@linux.dev>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 November 2026 14:42:04 GMT, "Mickaël Salaün" <mic@digikod.net> wrote:
>Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
>records in parent_could_setfcap whether the creator of a user namespace
>had CAP_SETFCAP, because a creator writing its own uid_map only has
>capabilities in the new namespace.  The snapshot uses cap_raised(), so a
>task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
>namespace it creates.
>
>Use security_capable() against the parent namespace instead: the
>creator's credentials still belong to it at this point, so commoncap
>returns the same result, and only LSM denials are added.
>
>Do not audit this check: creating a user namespace does not use
>CAP_SETFCAP, and most namespaces never map uid 0.  The uid_map write
>that later fails has no LSM audit record.
>
>Checking CAP_SETFCAP when the map is written would not work: the
>writer's credentials then belong to the new namespace, where commoncap
>grants the creator all capabilities.
>
>Cc: Christian Brauner <brauner@kernel.org>
>Cc: Josef Bacik <josef@toxicpanda.com>
>Cc: Paul Moore <paul@paul-moore.com>
>Cc: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

I'm logging out of mainlining.org (sigh) anything meant to be cc'ing me,
e.g: get maintainers should cc the linux.dev email instead, annoying brr.

>Cc: stable@vger.kernel.org
>Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
>Signed-off-by: Mickaël Salaün <mic@digikod.net>
>---
>
>This is independent from Josef Bacik's series, which reworks this code
>to close other ways around the CAP_SETFCAP rule:
>https://patch.msgid.link/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com
>
>That series still computes the creator's CAP_SETFCAP with cap_capable()
>and cap_raised() in cap_setfcap_level(), so it would need the same
>change.
>---
> include/linux/user_namespace.h | 5 +++--
> kernel/user_namespace.c        | 8 +++++++-
> 2 files changed, 10 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
>index 91232053775d..370961fde45f 100644
>--- a/include/linux/user_namespace.h
>+++ b/include/linux/user_namespace.h
>@@ -86,8 +86,9 @@ struct user_namespace {
> 	kgid_t			group;
> 	struct ns_common	ns;
> 	unsigned long		flags;
>-	/* parent_could_setfcap: true if the creator if this ns had CAP_SETFCAP
>-	 * in its effective capability set at the child ns creation time. */
>+	/* parent_could_setfcap: true if the creator of this ns could use
>+	 * CAP_SETFCAP in the parent ns at the child ns creation time.
>+	 */
> 	bool			parent_could_setfcap;
> 
> #ifdef CONFIG_KEYS
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index cd748e1cbace..57b7f10be74e 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -128,7 +128,13 @@ int create_user_ns(struct cred *new)
> 	if (!ns)
> 		goto fail_dec;
> 
>-	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
>+	/*
>+	 * verify_root_map() relies on this once the creator only has
>+	 * capabilities in the new namespace.  Let LSMs deny it, but do not
>+	 * audit: the creator may never map uid 0.
>+	 */
>+	ns->parent_could_setfcap =
>+		!security_capable(new, parent_ns, CAP_SETFCAP, CAP_OPT_NOAUDIT);
> 
> 	ret = ns_common_init(ns);
> 	if (ret)
>

--- Thanks!
