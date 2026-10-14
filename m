Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49736DA15;
	Wed, 14 Oct 2026 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011323; cv=none; b=jufbtxCrrT/XxQ3/xGvDV0HLFur0q3D+I37MowMVF39dAuF+qnK3mgxGKVG4MJbJhn8DabZsZXqfAZHj+UahFjvr+kj3c6327q0+SWLgv0eyzo411Up79EpAld5ufjVR+G2xs82uiU+UjgYA96ktoJyP18ithpB4uRe2bXGiQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011323; c=relaxed/simple;
	bh=/a0vFGKNS8J55f5tp59ZAWCFIZEuIQGkM8zl71WLuIw=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=bMzn/7AGbBarydTUr582eiQOajOsb6ZNYVxhNZH7cT3XaMxYNdKgAlvAtSPHuOrEn0insEYiLZUK3NetOWL1+z8wF/Gh0CfNV3Mud0yL75yYzKVox5x/CWDYpFKj0Ts0lGIohX4ba+/11zTQm/Z+N3IwycqfiEQWW8Kkqzfun48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=XlRJRFmK; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=R2nAz+Zz; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XlRJRFmK";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="R2nAz+Zz"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792011295; bh=Vmet7sb9fWP6o2etjgcSmBf
	dmj2UrsHmMtshOnUh8h4=; b=XlRJRFmKhdOBVTd2nw0aF3uBlo6plsAe0nwEHtYPba0F46djfG
	u3iZWXO3R1biE5N9+cSXlANBefWfMAb71VZOb3ZxsdqiPbOchbeokq7wRC8TInqbxLqvODfsOj7
	MQxF24PzCqJmU9AD59jQB/XedLDTdB5DwowIdZNYLXv4yQDF9mkdMKmXvxh3QPWI3sMFis3QRjD
	jPMETVBuYj872ydNOGkPuc9ZtEnJfKvR18iPu9WqhUIPDZaLnh3jGMKy/slHFanq35t87v+spqq
	gWFU+Fe6EvcF8uYI3tSMzVCvFT2iG50qy1GzOCC2KPNeZ0Fy2tjxeFkVH0ge1XchFGA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792011295; bh=Vmet7sb9fWP6o2etjgcSmBf
	dmj2UrsHmMtshOnUh8h4=; b=R2nAz+ZzOZaugmEHzvxjyHdBx1A8ydUJ3gSWj4aHsxsKWt7XWc
	ML0qUzngs2s8oCj6GtKkDCyPIdxOnF6CyICg==;
Date: Wed, 14 Oct 2026 21:54:56 +0100
From: Bradley Morgan <brads@mainlining.org>
To: josef@toxicpanda.com
CC: brauner@kernel.org, dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
 keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 morgan@kernel.org, paul@paul-moore.com, serge@hallyn.com, sergeh@kernel.org
Subject: Re: [PATCH v2 2/5] userns: don't let setns() lend CAP_SETFCAP
In-Reply-To: <20261014-b4-setfcap-userns-v2-2-fac4d19281d7@toxicpanda.com>
Message-ID: <259B1F19-C945-4855-9B72-06F6AB63649C@mainlining.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 14 October 2026 21:47:47 BST, Josef Bacik <josef@toxicpanda.com> wrote:
>Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
>because a task in such a namespace can write file capabilities that are
>honoured in the parent.  A task that is already in the namespace has a
>full capability set there and can't be asked any more, so
>verify_root_map() goes by what the creator had, now ns->setfcap_level.
>
>But setns() lets other tasks in, and they get the full set as well:
>
>  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>  unshare(CLONE_NEWUSER)
>                                    setns(A's user ns)
>                                      allowed, euid == ns->owner
>                                    write "0 0 1" to /proc/self/uid_map
>                                      ns->setfcap_level is A's -> allowed
>
>or, if A's namespace maps uid 0 already, B sets security.capability on a
>file.  Either way B ends up with file capabilities that are honoured in
>the initial namespace, which it could not have written there, nor in a
>namespace it created itself.
>
>Refuse setns() into a user namespace unless the joiner's CAP_SETFCAP
>reaches at least as far up as the namespace's setfcap_level.  Then every
>task in a namespace is entitled to what its setfcap_level says, and the
>checks on the way to file capabilities can go by the namespace.  This
>has to apply to every user namespace, also to those that don't map the
>parent's uid 0: through an idmapped mount, a root user that only exists
>in the namespace can be stored as the parent's.
>
>The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
>when it tries to setns() into a user namespace created by a task that
>had it, such as a root-created container.  Tasks with CAP_SETFCAP, and
>unprivileged users joining their own namespaces, are not affected.

Gnarly.

>
>Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
>Assisted-by: LLM

Ok.

>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>---
> kernel/user_namespace.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>index a5a94367600d..330085a7d7d4 100644
>--- a/kernel/user_namespace.c
>+++ b/kernel/user_namespace.c
>@@ -1390,6 +1390,13 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
> 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
> 		return -EPERM;
> 
>+	/* Everybody in the namespace gets CAP_SETFCAP that reaches as far up
>+	 * as its setfcap_level, so only let in tasks whose own reaches as far.
>+	 */

Wow!

>+	if (cap_setfcap_level(current_cred(), user_ns->parent) >
>+	    user_ns->setfcap_level)
>+		return -EPERM;
>+

Clean! Please add 

Reviewed-by: Bradley Morgan <brads@mainlining.org>

> 	cred = nsset_cred(nsset);
> 	if (!cred)
> 		return -EINVAL;
>
>


--- Thanks!
"I'm not a very positive person" - Linus torvalds
