Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615080;
	b=yzyMi6YaoIR1mako0CV8iV0DAqdImWISYvZZP9HJYmq7Nkv5jbKkxthPre8+wcb9bG5r
	 pT9/xP0lkLCtS7IECUIU3nHnc7GSP9AvaFrlVZEZ1evsGenHqnLobCvZCfWtftdYNbQpt
	 o2e8POkL0Hf7rmB1COu06pcmGl7iq3mk57QKHydfICh8U/eGHMo87GHXcrnbYi6S/wuqT
	 Wh887l5GGLC7xlDw3jMGmN/CX/kuv2uE7L+dG3/awhPzMbXzMez98JmFKL0K9z21bXbMk
	 1Y1DPC2I8Q0MEr+FtZhip+87MLaNQFo46hd1pGkvRyvUERm4N6IdBWZyg+uirrmwHBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=w8r5S5TfbVKxJBCsITNfOxJTwKsk3ZajonF1pgsHV7c=;
	b=0VNhDIrMFA0zsmWepFm6o1sDui2btHHzKfdu2VyDGj1YMjC0e89yRV6xVQxeoYtk8yY9
	 E/36qQMZPr72EfA9el2kBlD8EPNx8y8nGIHCpLtuc0pt5jMKk722CRpI14+JbEAiTZASz
	 qXXTcbTdnLjX4aHEwnbWzNXE5kFWcMyGOH7VPVryQcnQdzq/kAxUMAsbyuvPltdYIQgNR
	 T+T4nBWPb6ngOcgqdb7r70Aq9rtUFj3UCHrRcwBMU/iQOmNIVhKr3YukYbV5PUa9iJyZZ
	 Wvfy35NMfqfHvBRvY7/X131p7TRul1By0GdrAkX9vgJ9UMnnnYwlhLZQ2Hm6jBdeljQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TJJB0lK0;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B260A260A
	for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 20:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49B260A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=TJJB0lK0
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso9620466d6.1
        for <keyrings@vger.kernel.org>; Wed, 21 Oct 2026 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792615067; x=1793219867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8r5S5TfbVKxJBCsITNfOxJTwKsk3ZajonF1pgsHV7c=;
        b=TJJB0lK0ppJLS7oR3UyWcCtGx90PdBJLK7d8BmBxFSaqwOSCKUu0WT+qgbBwBxinVM
         uq5Hj8rd51/hfGI3h12FWRMbVseZFui8W0rsIavs8AGgjXACyFzyGmK/vaWoZ1bDI1JJ
         k5NvQ4DK+HUFtQJqrtz/RznhGuG1wwlM79AVUt/07u750lmOa9nC14nyZGa/+RMPeH4F
         d5uANnP6SpoPhx39VaFC8u0yXG5kK/BRG9c8Jqtodx9g2wP6tOWM3m1s0cvck8Z88dz2
         J0iIB4DjCkwHFCaNxDsvhLaUNRZb44NCqs2GnrojXxFWkbCkLlzLJcz0Xt8a7sWtvh9O
         a6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792615067; x=1793219867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8r5S5TfbVKxJBCsITNfOxJTwKsk3ZajonF1pgsHV7c=;
        b=JB65wMAodXCsMxEUokKe+aM3T3OUYPJ3jAxvFSaNuTz9j6rHkktUysG51T4Y5YxZw2
         pZ8R82pe5JcbwRI6obqyPDJq0aKbVZLgA42jSAVUYt480jgs/c/BC7819gGPNx9O9AZI
         jXfkMYGz4zpeFqqd3osJ7ssuDtd4lRDuoAvmUUZk1YrzU1jnJtxY2b3qdtUCIIBdsq/k
         VHC3kQSl55mjjhezmp84czt3tgVn8oXXYIDgkXQOH9XY5mw4Y/hN61kS6v6fug3ILmyU
         2x5/yl2mVPP1PN6XjA/FxxgUn94gBMVp6mzdgZQ55spxBHvn4SksZCrqaoWdQMryIg7r
         Sh6A==
X-Forwarded-Encrypted: i=1; AKwUvBzjjFqv8/XgTFvYDtCHo7cr2yCsGkcncg0eQI2a9RRAQvAoPagSAy1jWcIOfMYSd8XvLAsRaUuNQw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIT1KmEnzpTprkgWiSdZPPV/hV5KHg+PPQ5mgNryVCwx0hkVwTq
	wi2ybKFW8L7I6HSZ2fZjfjoYx/GmJoZsZU5DSjM0IPp7vwvYdgYIONqRgq5UjrkFU0Q=
X-Gm-Gg: AYBFou2vZGTYJLVwvH+KrRUytIscfXg/kP08SxbNiIs9nyuSD0/m2+TS1jZoRG6W+I0
	v+sFVn6cTpMlfHD86xVmIWI5AVPyIjMPILPbw5Y1iqMzX9t2+tROqhr5hDHEpYK/s8EbdgueJp0
	cyC64o/86sQpfoXm82m+33wdT/9HTWpVoKQFAaM3otFVyFkS0p5dPelgyGelDuIbVej9YmRM5PW
	nG2aViLz7tCde06X0lznw1e8pPtdFIpbzO0LI+emjwYURVgc3Hlw6uRItqQG06Uk5IbW8mV5hEt
	k7/ealTWjGWGWGeF5+ysh5MJ/tONi/PfsHXjXGP+assL0nM62+LQduSdsfikRC6lwAxOkmVaiKi
	56IT5InBzgkRBgkrbIqrfRGQ4obZ/TRc/wQ0s3jBk+H+rZWcxTM8y6atEXaNQzEosXHJazxnuP4
	dGuj7La/uTicmmqlX5P2ZFcvbS2TAq8hMqPUMhg4JgAW5x/Tz1ziq1LEbukrc60Ccpq6KKpyWxe
	ciPLkHnhsZhLLHVi0TEwUs+jhsnAFgdF1Xo90hpO7oMF70W1o0xizqePj8BysnIlSsqWeZ3
X-Received: by 2002:a05:620a:1b9b:b0:93e:d854:4b83 with SMTP id af79cd13be357-93f57f20218mr702292685a.22.1792615066863;
        Wed, 21 Oct 2026 13:37:46 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c70057sm343030785a.5.2026.10.21.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:37:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 20:37:28 +0000
Subject: [PATCH v3 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-setfcap-userns-v3-4-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
In-Reply-To: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792615055; l=3016;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wRQfv+uQ2WPQh0CvfROACNKqd38goOF6LfQfEeyNoYQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA9EV/aZhjYX1t/oD79Yrsmszo2Y5fuSKVDRBIawa5XczpeHTSI83HjDgeu7Sa82cWNmCFmv/S5
 iT9jEBLsoqQ8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
keeps a root process without CAP_SETFCAP from creating a user namespace
that maps uid 0, in which it could attach capabilities to a file that
are then honoured outside.  But the map doesn't have to be written by
that process.  A privileged task can write it from the parent, and the
file capabilities are not checked against the outside at all:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
                                    unshare(CLONE_NEWUSER)
                                      ns->setfcap_level = 1
  write "0 0 1" to B's uid_map, gid_map
    A has CAP_SETFCAP -> allowed
                                    setxattr(file, "security.capability")
                                      rootid = kuid 0
  uid 1000 in the initial namespace:
  execve(file)
    file capabilities apply

The map doesn't even have to show uid 0 of the parent as uid 0, since a
v3 xattr can name any mapped uid as the root user.

Check at the place where it matters, in cap_convert_nscap().  On an
idmapped mount the root user named in the xattr has two identities: the
kuid seen through this mount, and the kuid that is stored and seen
through every other mount of the filesystem.  If either of them is the
root user of an ancestor of the caller's namespace too, CAP_SETFCAP has
to reach up to there, which ns->setfcap_level tells.

Tasks in the initial namespace, tasks in namespaces created by a task
with CAP_SETFCAP, and file capabilities for a root user that only exists
in namespaces within reach are not affected.  That includes everything
an unprivileged user does in its own namespaces.  The rest gets -EPERM.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/commoncap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index b06914223039..1a419a4a872c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -703,10 +703,24 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
+	/*
+	 * The root user may be the root user of ancestors of our namespace as
+	 * well.  CAP_SETFCAP that we got for entering it doesn't cover those.
+	 * On an idmapped mount the root user is vfsrootid as seen through
+	 * this mount and rootid as seen through every other mount of the
+	 * filesystem, so both have to stay within reach.
+	 */
+	if (cap_root_level(vfsuid_into_kuid(vfsrootid), task_ns) <
+	    task_ns->setfcap_level)
+		return -EPERM;
+
 	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
+	if (cap_root_level(rootid, task_ns) < task_ns->setfcap_level)
+		return -EPERM;
+
 	nsrootid = from_kuid(fs_ns, rootid);
 	if (nsrootid == -1)
 		return -EINVAL;

-- 
2.55.0

