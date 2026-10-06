Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8049C4DB
	for <keyrings@vger.kernel.org>; Tue,  6 Oct 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301486; cv=none; b=N0Rk86mr/rC0ow1USe92zcuzQjFxE1jJq4mpbgaI2iPClCbDFjmpv0OEr0VyHc5vmvb6wCJkuyuZQ8x47SiXbvjMlimFM43HkHTduZf6zgIDIDL5rUGwZnO6/uXdOBNLoT2PEpNDqv1LZ4qE4o4TNcwYyUK+jE68IYkWuhp3J+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301486; c=relaxed/simple;
	bh=OqvqQY/IhC7NWo4o7gGhk0MEeJ2Xat8IfeE3dy9I0P8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S3Y4N0Fjsk+KVRDibx1gIvE0DcGK39YYhOnfckfCH3rbrWu4VtA0dCtXwCwnTOv9Qrwp5hkJsrDnfgYLCjS+3wO+eqm9TeeRogSVVEFOtEboRrw/+FB8k5g7NutTDaaK2g27kuvIYlBZrpVZIeu67nfUNdjz2sdoAzOepjfG/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ELlfynIt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ELlfynIt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53519e20d7bso26498981cf.0
        for <keyrings@vger.kernel.org>; Tue, 06 Oct 2026 08:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791301482; x=1791906282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IU49nZZhlVu2qJsiPTHVpkbTUnb5Udm3WFaqPCSBC1s=;
        b=ELlfynItz72JPceAe9hntvezZXR2T2hVu0YMz5K07CIqgUSeLKOKX3ARovmUYllYl5
         yYlhH5TqWT0Lm6/2wu4Fpa1wPiflj+ujFshqoJI6w83lxe4CQxkiVydPfuTIrpFNNwtN
         /kE3qyJnGqTwT6bdRhsv/3AnJJdkNSwt3HrDb1igGrLi4CxEHEKMi5w4BZOjBxStGtnq
         WuDsBB2RZ0GSqu1amqZYgNm+KtfF3lej78g3JVp66qHXeD4At/qEJU31gYMFXzc9Im/D
         o9V0DbXxuFc8khY9+w0gwrc4uZPIfIcpPw9AoJLhabmZ9Plnm0jbA/DujfXmk2PzMKOc
         fTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301482; x=1791906282;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IU49nZZhlVu2qJsiPTHVpkbTUnb5Udm3WFaqPCSBC1s=;
        b=Bv61arTkidJ5ah9ehw7segiuTTKDgt49T0e/scsx21/5ND/I5VOd19wvtfNXtSP1S0
         ZE/bNXcnA5uRbXPAN4oetBd7XAnwkdXXAqSOdKXoY4R8sZHQR1SZA070qUS16R6yfqnx
         OS9ssLHgcbTR1xJJdFBoGOFsxfURY0vU5HsSjH2gN7F30VIF+5qinYPWXGqRzDgjpLXb
         tEqWb+sd7RkhPQuKcfrQmXLY1v6rcaTt22Wdv9Cqab3L8WUD1/LYK543+Wps0y8AL4CI
         TdbqLRdxCgAPWNedjy5u57KJMh8BgDlecG+4Kf4WnNMPD0lutyRIdqForzJg/9/uUbIY
         bJ7g==
X-Forwarded-Encrypted: i=1; AKwUvBz+6Xqt25pzoAwjFGDfxXNA6s6M7ve9vefxg5/bokk2c+gdwXaDQ3eKxzMTVCJTkJlJaDzXoVkCFg==@vger.kernel.org
X-Gm-Message-State: AFuF++mlJ0lxUqDc3poVPIhRyDt47YBX80d/V1X7bU7/wnvrNogVSAye
	M/wOGMKdLUiAg2qRkLFW0s24if3re19yJzb7+nR3LpRQ2PhOFYBBSrnbx2sSETDwhiX+umiuVUi
	jxF+B
X-Gm-Gg: AYBFou3kWXHmeAVYhgEdnFTt7E1HEp62byGdJej0lCb5d0XdHWP0kKota1EbdpGoJWg
	UsSi6efFvHwLJofQjUhBB/IWuLZhydLYanbv7+Fh8jNZKWrejDqkuGfVdfShuttmUCKOlUR6Os/
	HzgoOI/0isxBV2e4cqynIk9/ObxL0kF9BqpLUMmArce/HWh/J04sDxQMDDJAmvBgm2nzInJ0jEX
	82rdgnWvudC1Mi+Tgrf8RrqW5tUxaEHMkVD5T0T79zuF6TCtIBXnXxFdnyFT2BhfPajUHE3PN91
	ck8TGWlPYSKjMUoTzNEQsHEyVE67pUgipa925KBnNRMQjNw5rW10UHmgNiyhOgrmNpTdYfBbXDM
	71lNL73a44aUEJchgERqZXnmfLNYjCz9/z3LYukSxRnmRtXT8wgmD39kURl0aqdR/UklHuFKscf
	f4MrTstb9gPSnGzgPpju5oYGZ06HhJyeVoi63OEUGWznMiZ1Mtj4waeATSFTiSWmHmwXwPTs/tf
	4OgYhjZjZjt+lYKO93dL51bcg==
X-Received: by 2002:a05:622a:1f13:b0:535:1e6a:1f0e with SMTP id d75a77b69052e-53566d8e3cbmr25469741cf.27.1791301481707;
        Tue, 06 Oct 2026 08:44:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5339883034csm124897031cf.3.2026.10.06.08.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:44:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Tue, 06 Oct 2026 15:44:16 +0000
Message-Id: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEXxWoC/1WMQQ6CMBBFr0Jm7YSWYmO8imHRDoPUmNp0wJgQ7
 m6LK5fv57+3gXAOLHBtNsj8DhJesYA+NUCzi3fGMBaGTnVWK2XR9yi8TOQSrsWNgqM1+nJ2RhM
 bKF7KPIXP0bwNP5bVP5iWGqoP74TRZxdprtMztb5vj/E/Dfv+BR+OVX2hAAAA
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791301477; l=3293;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=OqvqQY/IhC7NWo4o7gGhk0MEeJ2Xat8IfeE3dy9I0P8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFGH3nAizFspoz6WknfBOIRo2rktqxme/IK9Mf9Wqf0+sIV0rpomF8WzQ+ZmgB8jxmltOol3zy3
 G5R34oa49qgk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Hello,

Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
stops a root task that has given up CAP_SETFCAP from creating a user
namespace that maps uid 0 and then writing file capabilities in it that
the initial namespace honours.  The check only looks at the task that
creates the namespace, so if somebody who did have CAP_SETFCAP created
one, there are still several ways around it:

- setns() into their namespace and write uid_map from inside (patch 2)
- write "0 0 1" through a uid_map fd that they opened (patch 3)
- setns() into a namespace of theirs that already maps uid 0 and set
  security.capability there, no map write needed (patch 4)
- ptrace one of their tasks and have it do any of the above (patch 5)

On an unmodified kernel we took a uid 0 task with CAP_SETFCAP dropped
from its permitted, effective and bounding sets and, through each of
these, ended up with a file that a uid 1000 user execs with
CAP_SYS_ADMIN in its effective set.

Patch 1 adds cred->setfcap_level, which records how far up the
namespace tree a task's CAP_SETFCAP reached when it entered its
namespace, and patches 2-5 check it.  Patch 4 is the check that closes
the class, the map patches make the uid 0 map rule mean what
db2e718a4798 meant it to, and patch 5 keeps ptrace from borrowing what
the target is entitled to.

This does change behaviour.  Everything new is -EPERM:

- a task that entered a namespace without CAP_SETFCAP outside can't map
  uid 0 of the outside or write fscaps for that root user anymore
- a uid_map fd opened by a task with CAP_SETFCAP can't be used by a
  task without it to map uid 0
- if a privileged task maps "0 0 1" from the parent for a namespace
  created by a task without CAP_SETFCAP, that namespace can no longer
  write fscaps honoured outside
- PTRACE_ATTACH and PTRACE_TRACEME fail when the tracer gave up
  CAP_SETFCAP and CAP_SYS_PTRACE, the target didn't, and they share a
  root user

Rootless containers, privileged runtimes writing the map from the
parent, nested unprivileged namespaces and containers that don't map
host uid 0 aren't affected.  The ptrace check is one compare for
targets in the initial namespace and in namespaces entered without
the capability.

Testing: a set of flows run on the base and patched kernels, every
bypass route above gets -EPERM with the series and the 16 legitimate
flows behave the same.  The capabilities, namespaces, ptrace, pidfd and
proc selftests give the same results before and after. Thanks,

Josef

---
Josef Bacik (5):
      cred: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend the right to map uid 0
      userns: check the writer too before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP

 include/linux/capability.h   |   4 ++
 include/linux/cred.h         |   1 +
 kernel/user_namespace.c      |  40 +++++++++++----
 security/commoncap.c         | 119 +++++++++++++++++++++++++++++++++++++++++--
 security/keys/process_keys.c |   1 +
 5 files changed, 150 insertions(+), 15 deletions(-)
---
base-commit: 7909a3e30a05e40bbc8bfb7f5629ed642abeaab8
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

