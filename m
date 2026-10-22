Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694197;
	b=HrXfIXhlp9BjlfU1zySBy3SUbGV1YWkoMMxL7s6z/3edKk85aPouUJ/nB5uoC37hIXdx
	 dyUsLJbs+3SQgmt0XCvkWQ5xP5gvN356ASe9ql4kLvobfo6tgpbpgckCxjd7HPDLCOUkE
	 +YVH5ieI4nKqlwhhkHc0Gsh30swxeVikL2QQ4BxbYD8YuESJhtCaRR6JGYiTdl9c4TEew
	 J34NO0h06ExklRPBqVChLdeCJ2NmJOuu+fzRFCpqkmB28tv1MzvU//VV6Y+bMo9LlGkQu
	 sXV5JUCHlkj3u9yMLNj+Ybavh2lcXvmP5C4a2pJxqlITkTi3+XEc7KgkfVapDaiXoKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hMJO7okefCo16JBnjmJNL1CUuu6f5S3gnSgt1A1bKKw=;
	b=YFKKu5q2s6pTQxWiHBDTUqv/5p+FZB2ex3GD80A8vsOx6R6O6scmzj2o7Hi37+sucHtS
	 BbPzZ8yUwYTUZs+UVCO9QJNNzomX2u0TO/YsY7y+AaBSgwLW0oSqXJP7T6hHRWzvLm5br
	 QDU0R1xuOJaiQ5rQusAL70txHAEo3UMsj40/gNUoq/PxI0xetQ7aZOa5p5K+dR0YSF5Ge
	 iKFC9RdjQWTCkrqDR2pUigxVqjL/IgPDTyj5Py2OmcBeO/dSPIAdQsDT4VO8FNGvhhIiU
	 11mF1mRqh5xUHYDd8MGvuhpOomwdjrjfoEYvX0OjOlqdz+oSFk/C9zqHmp0At9SGujg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JmaP09OS;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F35606A31F
	for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 18:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F35606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JmaP09OS
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e515769d3so4974085a.3
        for <keyrings@vger.kernel.org>; Thu, 22 Oct 2026 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792694196; x=1793298996; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hMJO7okefCo16JBnjmJNL1CUuu6f5S3gnSgt1A1bKKw=;
        b=JmaP09OSsKmcspZYEx0c54x/72P25RZFz9cFO86XuF95EqPCjXHktx4TDzm1hyIXe1
         5ImvA30PcO83zFsyz8g/Vhz8UGM+Zixt1UiDy2OEVMnz7hGHKiaOPMv9SiOTq//4c1KK
         dfsJHt0zlJ/LTyyFF518cZV6ztNeydYWhbvUIIUhlm7BjkXOCh3dzfeb+0Z1WsmpdJyB
         ni0qo4QT/4af/AcwC5uSD0cKkV9tSn7jhIk29vbrYk9CxOyVLEZCLJZukiiDjKO2wBlu
         7B+sep7qrgGCi8VUKp51xymH624FjeBI/hWq0UYiuAdaUztCK6taf5wxGfAUuzqWyWce
         lWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694196; x=1793298996;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hMJO7okefCo16JBnjmJNL1CUuu6f5S3gnSgt1A1bKKw=;
        b=FYfs4iXI7EL+fEW7elrjpLEileraACT+zmFVywBeuEMYq+he/T2vWk5ZQheVBanhYA
         q+ksCZq5zQyKus5sZ8xuW6baXtfYTGqgDXxlcmobz2ymTcGX8fHOz/Lw3bgtcEWdTFuf
         janVZyx4c1lP2o0/FEvqFibIFg+Y/m9fyBY4qUkgFMNtcMIEIk5jtnGIbIpZLQRt2vd9
         op45eiUj/SedmygKlcJDWlvGIdW5Qp95SpaNDJtX20bAaHi5QSML4V8FxkzHcl2iXnfc
         Sh+QkkbHZjAXxXSUHiKuy0XAgVA8N934ZL1zDfm6PBwy8ZFocKmN1OY+B2EUK06O9S9e
         03dA==
X-Forwarded-Encrypted: i=1; AKwUvByZB4a8e5FSmUroaSc8aJLaA6lqIO3/EKMBHCAw4tCTAe7UZgsJiSdhkOR2UwbAzwVAgQ69d8baGw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIFnhli2+7Qzw70PdqV6W8e1P0PwYT4zUk4LIuXz7gxDlM1jMv3
	lFisLNzeDdI+Aoq38LiX93jeUzvfbJ8Eiu57JZMVaxFZdSpXXPnjXrzQl2Ma3knpFHk=
X-Gm-Gg: AYBFou20B8IzRVKTSiC/6t+rZigtfsduGm3u7mABcAC9XactYUlxpWB/Ha02h2RR+Mu
	wBfG3ZiFRKcDmHEqvM5Px9L0EsrTMzvd/FAgHv3TnYRlgoaveXBMCLd7q9o1KEPv8yXdcEjgBkv
	/We8xLZnu9G0Hdok7AgzSsuX6Ka1mUo2P9UK94ZHyDMMLAubgfRX2oKK6eGM5qQK8T7JFfdCboy
	4lJg7dSbpFAAshs6Kt8jJmFW6+1nRO2GV/qPHfRghVwRUH2Gm/V6Hdd+PSmWUrKyFajBuSjwo2Z
	QmvUpBaJd16uYe44Wad4rqVCxJye3N41gIS/tsG5mwJdirEf3iVK2zio9AExYwqD+WQBkvRcvzS
	4qIPflbXp0iBCXvL3XJxFqzLmsJOCtCHTfzLXqD1en+jinDoKYKHXXJQReMLny3SlBh/ghCUqb3
	5ouCGn4B7kEFYg8fXAUelVOpMdhqGZNncLi/e7V3RTPBxmjXAxe6iGCxKfsiaaBqZxXVjLycATU
	U/DSeSo6NBdIA+eMS3cXTA7Hw2X7rg513xDZ6MY54yVf9Y296hMb5DJRv0UIhdC5cdOUWM0
X-Received: by 2002:a05:620a:198a:b0:93f:6375:aa97 with SMTP id af79cd13be357-93f6f8a8819mr50992785a.83.1792694195592;
        Thu, 22 Oct 2026 11:36:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fbaf2ebsm18580685a.21.2026.10.22.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:36:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v4 0/5] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Thu, 22 Oct 2026 18:36:18 +0000
Message-Id: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAKNX2moC/33OQW7DIBAF0KtErEvDAIWkq94jygKGcU3VYAscK
 1XkuxfcTapaXf7R/Kd/Z4VypMJed3eWaY4lDqkG/bRj2Lv0TjyGmpkU0oAQhnvNC00dupFfazc
 VHoyCw4tTgKRY7Y2ZunhbzdP5J5er/yCcGtQ+vCvEfXYJ+3b6HPde79fjb7r99rFMQ/5aB87Qz
 P+2zMAF77QlS8EYYeXbNNwiji4F94zDhbVBs3xgQG8xsjEOdYCjPECwm4x6YCRsMaoyR4t1jCa
 tCP4wy7J8A3D1E1aDAQAA
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792694191; l=7797;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=b/PGE1EHr0+tFSt+l4/WL6aJt3MPRlSgVM4u/FG1+lo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIbko9Fjm4GxuTaTU1MNUfVx7KsRaF+8wS2oO018+hptvfEEeVWoUzK5hrJScCj4n6Xuwun1ymC
 E1HMTbu6VsQE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
v3: https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/

v3->v4:
- 4/5: a v2 security.capability xattr skipped the new checks, it was
  written as is whenever the writer had CAP_SETFCAP over the
  filesystem's namespace.  It now only does that when the filesystem's
  root user is within reach, and goes through the v3 conversion and its
  checks otherwise (Sashiko).

v2->v3:
- The setns() check in 2/5 and the ptrace check in 5/5 only apply to
  namespaces that map the root user of an ancestor within the creator's
  CAP_SETFCAP, or that have no uid_map yet.  Root users stored through
  an idmapped mount are left to whoever sets up the mount, so a root
  task without CAP_SETFCAP can join an ordinary "0 100000" container
  again (Serge, Christian).
- 2/5 adds cred_may_setfcap_userns() for those two checks and
  cred_setfcap_reaches() for the uid_map check; nothing outside
  create_user_ns() calls cap_setfcap_level() directly (Serge).
- Fixed the cap_setfcap_level() kernel-doc, @ns doesn't have to be the
  cred's namespace or below; cap_capable() is compared with != 0
  (Serge).
- Picked up Bradley's Reviewed-by on 1/5 and 3/5, not on 2/5, which
  changed.
- Rebased onto current vfs.all.

v1->v2:
- The state lives on the user namespace now: ns->setfcap_level replaces
  ns->parent_could_setfcap, and cred->setfcap_level is gone (Serge,
  Christian).
- New 2/5: setns() refuses a task whose CAP_SETFCAP doesn't reach as far
  up as the namespace's setfcap_level.  It applies to every user
  namespace, not only to those that map the parent's uid 0, because of
  idmapped mounts (Serge, Christian).
- 5/5 asks a tracer for what setns() asks for, also when the namespace
  doesn't map an ancestor's root user, again because of idmapped mounts.
- Dropped "userns: don't let setns() lend the right to map uid 0", the
  setns() check covers it.  Its nested case moved into 3/5, which checks
  the opener and the writer.
- set_cred_user_ns() isn't touched anymore, so the put-before-use in
  userns_install() is gone (Sashiko).
- Rebased onto current vfs.all.

What it does now:

Every user namespace gets a setfcap_level when it's created, which is
how far up the creator's CAP_SETFCAP counted.  If its tasks can write
file capabilities for the root user of an ancestor, because the
namespace maps that root user or can still map it, setns() only lets in
tasks whose own CAP_SETFCAP reaches that far, and PTRACE_ATTACH asks the
tracer for the same.  The checks on the way to file capabilities then go
by the namespace instead of the cred: a uid_map write that maps the
parent's uid 0 (opener and writer), and setting security.capability.

The visible difference from v1 is the setns() restriction.  A task
without CAP_SETFCAP can't join, or attach to tasks in, a namespace that
maps the root user of an ancestor, such as host uid 0, and was created
by a task that had it.  A task that joins takes on the namespace's
reach.  Containers that don't map host uid 0, unprivileged users and
anything with CAP_SETFCAP aren't affected.

Testing: the v1 flows plus the setns() and ptrace cases, 41 in all, on
vfs.all with and without the series.  For v4 also the v2 xattr route: a
task that unshared without CAP_SETFCAP mounts a tmpfs, writes a v2 xattr
on it, and an overlay mounted from the initial namespace makes a uid
1000 user run the file with CAP_SYS_ADMIN.  That works without the
series and with v3, and gets -EPERM with v4.  Every flow gives what's
expected, and the only ones that changed from v2 are the five idmapped
mount and "0 100000" container cases, which are allowed again.  The
pidfd, namespaces, mount_setattr and ptrace selftests give identical
results with and without.  The TLA+ model, which has no idmapped mounts,
finds no violation with the narrower checks, and still finds the setns()
bypass when the check is taken out.

--- Original email (v1) ---

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
Changes in v4:
- Link to v3: https://patch.msgid.link/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com

Changes in v3:
- Link to v2: https://patch.msgid.link/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com

---
Josef Bacik (5):
      userns: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend CAP_SETFCAP
      userns: check the opener and the writer before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP

 include/linux/capability.h     |   7 ++
 include/linux/user_namespace.h |   7 +-
 kernel/user_namespace.c        |  37 +++++++--
 security/commoncap.c           | 183 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 214 insertions(+), 20 deletions(-)
---
base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

