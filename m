Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110992;
	b=KgXGykV08wFH/cWv6YGM1b3PtrMhIktljBdoiNU8N51I7/8bc8HHnsvOnt2YzOnY89ka
	 NCDCaI85A8Dkqn4QhhBIR2EwF5zob7KB5t9h/p1nnvzpLsKct9SMZSai3XDJwntKRXprg
	 uGg4K4hdntuIWCsyPetaC3nPGQA1sbAbAMKRUk3qsfHT9xV6J9Ja37T8u8yTaTw/UsyqV
	 GcDXsOaG4eeGo3BexyMSGZJq9ZXovKslQMRZ52BuuigCWdLxmDqFXLp93X7tQj6xNI4dD
	 45pzRBiUozufmLHhQJJI2GqnQ2N6tJDIG+LiuBQBW0qxSwafqWPSE6TIaftPMCvaqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=KpeK065/6sR2oZFaaD2SM2r0ejAo3wqL+1zwizTdrsI=;
	b=hLYL1uwOd6CxTWOPC1sBZge2+P31+VeKCXSU63JegD3dYT8GE1V8kehK7lFEpfkafQHW
	 q4P17E7zJ1qXG4sLHsrVa5/wIgcx98fNrt02c45Si7/TnKpop6/kPJS/f/wxE/gvK18zW
	 eLa6sUSbOi49nQO8wJwjrGL+yVmC64My0mOA+47AA/w/R2csTlGluwehbbueP5LsiDiie
	 56ialatMtixHaDX6hp2KdU5JY0bB2VPXCL/eCo8B/YB65TL3q4jYU7+0PrcJB9b6+LCKG
	 38p/ZPUCdcE2rMgnrnyUnsQzAAJbfX83cJauroO07fXh0qvAjltyJ5SFKFQ4M7Wr9+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WoaQl03X;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BE606A325
	for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 14:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754BE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=WoaQl03X
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-78fb1fb9508so767250137.1
        for <keyrings@vger.kernel.org>; Tue, 27 Oct 2026 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793110990; x=1793715790; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KpeK065/6sR2oZFaaD2SM2r0ejAo3wqL+1zwizTdrsI=;
        b=WoaQl03XqLcFbEJ/ZEAo+vj3EIRw1BE8CF3TRKHxP51KBMs+QKBM0n1ABXkwUH7oNw
         Ghmjr/jGXxNJMBuIcbRu+Hwv/ATGoJS5fcNtR+9X0H41N70fWjX4c8Xb9+RKmmuLxr0F
         aWKL4x+MBWP2Qmv59fg4jxDLUpIeGODs20jUk2unBbenakNbE3ULxEFq0UuteR7W6zaH
         CM6gE8t50GTXk2nBnFKM4vWmRvuri4UsiLGFCfom6MdLDBhTdn2K4hk6XIccWnWUB8mB
         7h6e3ucGBrjJZk/LyTfNNQ0aS9pM0dYVHBP9eD3z6mWW2hO1cQJW9q4jPT8YKH3uABE+
         wEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110990; x=1793715790;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpeK065/6sR2oZFaaD2SM2r0ejAo3wqL+1zwizTdrsI=;
        b=G+lam8kKmmqUHbBm/Su8zboTbzUZIpz5n3+m9Z2wiwRPl+IKzr9F6nP8uu1VYSfP1S
         pg/1xompBQFWblzBfKQyKxPkTY3ezOrXSHQl49LPuPXKg8aagIT2v2pgt4tgb9BDR1w1
         BkBXh2oeVC6JsrCsbXaTtmnKdfuvHmAwHFEBUgRjcZCCFgVCzS+cVe2ocvGg2CHDeDyJ
         +C5fVGf3CxHsbTKVgNeCKhvloyGfMfmetrckYWHi4+lRVM7tYVlBOZWYwXij+D7Xvhjb
         3V+xXYuotJhC1D/9VK3Y49p8NHUC2gtmm4SWdBs88m9mg20D4Tf7HjEwhcQ8oFVANBSK
         k2rg==
X-Forwarded-Encrypted: i=1; AKwUvBwO8jxBS3BkROKOnU0jgtGDiYG7WKpitpjICWXjjNvJIixqpAnmhXnzYB5vtXgq/LL0OTlCEhdC9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+p9QKTLWm5C9w0/oMju0vCroESD6Lf/E50K62jom3Nq4Gu7DI
	/pSjM7Ty6whWmGMlTiXUTGPmoPVMVA7nnBbuW8N+g+vkj3k2yJ95pOkXEWRCiJcrll4=
X-Gm-Gg: AYBFou1DPovz6+pIByXDRCknP71yqpnZtxuWehAidFOenAHtLs9Dqb8xvQzBIv89qzl
	hHXXYqrvBFFvKHFiFz2oE/mjXrl0dlI+SwTQ+f+o+5JQnJ2p6nQ/1Np54Q7Wi8PNLLnHR6RbmPi
	ps/gHOQA3I/MWxWdTJ9ScvnPIIWsJLL454L4940Fdm0dVQEoUyVkOwiz5fsq5YqmP52Eg2yEdp0
	yCK6aa7TvA5UYgK5muVuq9oZrx1e4XTJzghktRs+6X2UoM/iCExRgJZG86IdbSWPl+AicnP8PJB
	ZKINHN1GmAaSXOvG7iCZ4G5muVuQgMZE3erlBqqUcsrtkfAJnc6jKjaB2/SD69SWy2zt9Wx2gIi
	hB5H69xCuad1HHJ95YA0i/sEKdqZsHME1EZ4bAfY/R1j3ZUJRnxeqRqiJGM7/Stxwb5pweStpvS
	jAAgZlLQ2hFiBbTWsP230wVn7ySDT3gnb97qpsbT44TibDElEavysQ4zW1NRiJ/qpZyn3+/kJkT
	/XMCPVKO6eaTXiGWOsJvcl948nC17uN8I6RfRIvqJ2Kb0bdHXPCXebb/GhueTAWWAf6PFkG
X-Received: by 2002:a05:6102:3f91:b0:7ce:78f9:ae13 with SMTP id ada2fe7eead31-7cea147d70fmr919786137.10.1793110990163;
        Tue, 27 Oct 2026 07:23:10 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259fbcbfsm2667893241.10.2026.10.27.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:23:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 0/6] capabilities: close the ways around the CAP_SETFCAP
 rule for uid 0
Date: Tue, 27 Oct 2026 14:22:48 +0000
Message-Id: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIALmz4GoC/4XQS07EMAwG4KuMsiZM3klZcQ/EIg+HBjFt1XSqQ
 aPenaRsiohgY8mW/emX7yjDnCCjp9MdzbCmnMahNObhhHxvhzfAKZQeMcIUJURhJ3CGJXo74Wu
 5HTIOilMjLaceOCp30wwx3Xbz5fW7z1f3Dn6pUN1wNgN2sx18X0cf09mJ8z78SdfdPuVlnD/3g
 Cut5l9ZVooJjkKDhqAU0ex5GW/JT3YI9tGPF1QDrezAUNFiWGWsF4F2zNCgmww/MIy2GF6YTvs
 SRoDgQJuMODKsxYjCGGMtibEUE5uMPDK8xcjCEFU2GHfQyXYadWSaL1aFYTJS4rS3omv/Rv/L6
 MK4aKzUKmomu1/Mtm1fPmE2MJ8CAAA=
X-Change-ID: 20261006-b4-setfcap-userns-d63185a31ce3
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Bradley Morgan <brads@mainlining.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793110987; l=11081;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=W1HfnfaaVuBoj+aGv37wuET8vdQ6BztO9MZfPCYWO6A=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJAkBI/xA/nppdmPjhYFXIax7GHe0NFHdLI05TP80ooHHN9YDrtLV3YWGQD3r8RY37s2GCxdheh
 2pgGKPXw9kA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
v2: https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
v3: https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/
v4: https://lore.kernel.org/all/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com/
v5: https://lore.kernel.org/all/20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com/
v6: https://lore.kernel.org/all/20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com/
v7: https://lore.kernel.org/all/20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com/

v7->v8:
- 6/6 only, 1-5 are unchanged.  A case whose setup failed in a child
  waited for the harness timeout, because the parent kept its own copy
  of the pipe end it read from.  The cases where a privileged task maps
  for one that gave up CAP_SETFCAP now share one helper that talks to
  it over a socket pair, and the others close the ends they don't use,
  so a failed step ends the case with a setup error at once (Sashiko).

v6->v7:
- 6/6 only, 1-5 are unchanged.  Every case now reaches the step it is
  named for, and a setup step that fails is an error rather than a
  refusal.  Cases that stopped at setns() are setns() cases now: a task
  that joins has CAP_SETFCAP wherever the creator had it, so nothing
  after setns() checks it.  In the v3 rootid, nesting after dropping
  CAP_SETFCAP and reverse idmapped mount cases a privileged task maps a
  namespace created without CAP_SETFCAP, so the xattr gets written.
  pidfd_getfd() is a ptrace case of its own.  The session keyring case
  joins a keyring of its own first, so it works under su, and skips
  without keyrings (Sashiko).

v5->v6:
- New 6/6: a kselftest with every case the series has been through,
  48 of them.  Without the series 22 fail, with v5 the 4 below fail.
- 3/5: a task inside the namespace that is being mapped also has to
  hold CAP_SETFCAP there to open or write a uid_map that maps an
  ancestor's root user.  Before, a task that gave up CAP_SETFCAP could
  write "0 0 1" and get it back from execve() (Sashiko).
- 4/5: a v2 xattr on a filesystem whose namespace has no uid 0 is
  refused with -EINVAL instead of stored unconverted, where it was
  honoured nowhere.  Falling through to the conversion would not do:
  for a writer outside that namespace it names the writer's root user
  instead (Sashiko).

v4->v5:
- 3/5: the uid_map check only looked for an extent at the parent's uid
  0.  The root user of an ancestor can sit at any uid in the parent, so
  a task without CAP_SETFCAP could map "0 1000 1" under a "1000 0 1"
  and get host uid 0 as its uid 0 unchecked.  It now finds every
  ancestor root user the map contains.  4/5 already refused the file
  capabilities after such a map, so this is the map rule itself
  (Sashiko).  Dropped Bradley's Reviewed-by on 3/5, which changed.

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

Testing: 6/6 runs every case on its own, 48 in all, as root in private
mount namespaces.  On vfs.all without the series 22 of them fail: the
ways around the rule, and the two v2 xattrs without a root user that are
now refused; with the series all pass, including the idmapped mount
ones.  The pidfd, namespaces, mount_setattr and ptrace selftests give
identical results with and without.  The TLA+ model, which has no
idmapped mounts, no v2 xattrs and maps only uid 0 of the parent, finds
no violation with the narrower setns() and ptrace checks, and still
finds the setns() bypass when the check is taken out.

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
Changes in v8:
- Link to v7: https://patch.msgid.link/20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com

Changes in v7:
- Link to v6: https://patch.msgid.link/20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com

Changes in v6:
- Link to v5: https://patch.msgid.link/20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com

Changes in v5:
- Link to v4: https://patch.msgid.link/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com

Changes in v4:
- Link to v3: https://patch.msgid.link/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com

Changes in v3:
- Link to v2: https://patch.msgid.link/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com

Changes in v2:
- Link to v1: https://patch.msgid.link/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com

---
Josef Bacik (6):
      userns: record how far up CAP_SETFCAP reaches
      userns: don't let setns() lend CAP_SETFCAP
      userns: check the opener and the writer before mapping uid 0
      capabilities: limit fscaps to where CAP_SETFCAP reaches
      capabilities: don't let ptrace borrow CAP_SETFCAP
      selftests/namespaces: test the CAP_SETFCAP rule for user namespaces

 include/linux/capability.h                        |    6 +
 include/linux/user_namespace.h                    |    7 +-
 kernel/user_namespace.c                           |   95 +-
 security/commoncap.c                              |  184 ++-
 tools/testing/selftests/namespaces/Makefile       |    3 +-
 tools/testing/selftests/namespaces/config         |    3 +
 tools/testing/selftests/namespaces/setfcap_test.c | 1368 +++++++++++++++++++++
 7 files changed, 1632 insertions(+), 34 deletions(-)
---
base-commit: 2c3ba1f1cb416b81d617b92a24a4bcaa48d574e3
change-id: 20261006-b4-setfcap-userns-d63185a31ce3

