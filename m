Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795194602;
	b=1UFhKNYUR8qARFg0f20GlKt4TN46u6zqicpNE3a98of/1TSHL9pyTaD1JuJ036+Ay2yx
	 YyAqWqD3+RkR8zfKIr27wkY83K2g1DX3+xpA759GNgwkom7WeBtCzyHSaxhLG+sHVO30c
	 Nke+DO7Mce6UKOZhh1WGn6kSIxaZbLdfUlaJk6uQa47xqM70oMbXBKy44dtBTpJMVFbNB
	 t0Obfn5uor+PxgT5tqa4w6CpCNYUS4vSXGPoqgsP9B8pR8m9+KerG1L0KHaM1TqzfieI+
	 O0JeMuyFq0aCrOzvf3DHgxaolFI0rOCKd+2uhsjTsbMbaAW4UJ4D9rrSdcHEHqVYjxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
	b=HM+cagj+zMNYllfu/nLUe/p/f38+NzkY5GZMBOT60v409B+r5KTClm45mHqyTWo7UDg7
	 3LqxwkkHWlNO5uMzuS8wBI5bsDX1E6m65qydfsbNCYokZzw2qvUT5pX+DgaNJRWneQq9h
	 +03YlrgSOMM6ci+9Vo7q2J59zHvp7f+EZTvSBqDobUrn6cO3Hs5qleW6LyWeRSYwNSEXq
	 nTymfele9lBUKXMqhXqdGyGGIcJ7GmEhYsTTSnsSNxqHfdGWr6b2uHGMXGJhkOZbv5/ni
	 OwwErp8i+UuQPXcK4/tYWWje0s8R6gqAYds/l4PflQeQs4EZiml+jpQJtuqWnwUCtFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KzuPKz9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5260A2636
	for <keyrings@vger.kernel.org>; Fri, 20 Nov 2026 17:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC5260A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KzuPKz9w
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ae81ae52ffso7507701fa.2
        for <keyrings@vger.kernel.org>; Fri, 20 Nov 2026 09:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795194599; cv=none;
        d=google.com; s=arc-20260327;
        b=aOxR5K/EBmcNHjPWJhAdECu09FrgMprkGfK9nGucTVmInWVotCbhdfIRKR/oRreYLC
         rBfYIQfXFLFSZeLtODKbZ5DKjWuVO5Ksibiz5aDNA6G0BDWgnTH3bdd6AEffOfaP9OYb
         q3pEkjXcgviBcpMg/Cn5OBgW9rwfv0Igw1R74tptlQLSdfVcRCOApexIRTLAx503uVK0
         sdwrx4V0q687yRwJhxvFzzXaTbF7A8gixEHiWVjIX7NGePg7zi/RJ9JNELq9rlgLcSVl
         EA3kTghYH8oP3oQ9xecWg1zONdfQ9kZCVLLnBpaQKzi2KzfF44eUf6jOY7/XGqWPOfgp
         uZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
        fh=/n3R4mp4cpT9Nst16uP4RIrZJhVgFm+fRDqGCfQDtuA=;
        b=IvGV4tGcrBLPARVVitEHzuDecTSgfWrAtP3d/UI+dRsRJc1yPgpm5kDIXsWqyqCiGb
         707x7j7gz4S2fMmDqmD9ct5+QQTS/AalmLmbqGp2JllKkmsv/+UhRKnh7i86vePyhfSM
         MGmZAOco6EJtxYtRsKiybrubtlfHtHe/qMSzt94Bn5TgCXkXNigmdog1037vQAnfEEcX
         CU0hLiTd8JMkNTvJKPhAhE9YwwDCLM5A5Y51vuJsnZ6fmp4XGuLKaekOcFHXI7YWpnhD
         25qQbuk5LkPXeofVyvXRsX523M1YgkPynHpG0eVYBIV52gQpQMJta+FnmBzBCPqIywvf
         IQzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795194599; x=1795799399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
        b=KzuPKz9wlUIhaJWdwueDeEluQfGhTtFH6fz8FAZF85dKlUnHi8FkaBQALudYSWmLoT
         azKe3eFVYRDOFx+8IjhGNb9qwSrA+uMjFasO0Y78bF+3hajdbSeasLRKTqR9rrRw93Fs
         mgsw5HsHH8a8RLldzj7UExTUzudAO7FPQcBGxVHr544OLOOoquGgLjJUclHerWxaJdLi
         uxmk8NZd0Ky9WVaupdZUPVmFOhf9Zb4PrRXYdyH2vDYOnjm+WhZ7uYiyPgxh2C1qaltX
         V7aCX88km55ADvHdXfnZgPboy0v8Geo0MFUxnSN4Wp1aITRMGG9KONQZYt3Rs95J370H
         rqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194599; x=1795799399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
        b=BekvjOTj1nIW6NitDEhNEvT08gcHOupr38NSmRa6BkWpahPaQW1+4oiKSbu2eeQTW2
         z+FzA2DocpdTXHg1g3cGp+T0dCBaNcCI+yyuq1V0dd0IjnYICIQ5EQv4ycbEHXWik0Sf
         EMAzhUNoJ5q3+cqwZ+lBIIAkUSEHDoieGnxzWOjmzhggxQZ/AT2bVD87S98DKN1WYI1N
         M2r148uBQ1P5sIuTWmkNIRKIibWkQuvKZzT1f5z5DNkINfI+TuV25e+JDevO8JOWxD50
         xdtvo8GLTfuFE72jLpzLZEkIYB7rKiPBSoWBSMfddBofeNeZ0kX2QELOf2V160U2Zyre
         TFeQ==
X-Forwarded-Encrypted: i=1; AL+hErGTJmXmB2jeZblGi+h6eZXFr8+vS9U17/aoB7ZXAevRsNTMrTlx3fof65DPGt3lsePHOQkIct4Qqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8o9QDuwT9xnuURLnhpgqbxyK6BWX/95YqZ+CfE6W1P8sl+ckgN
	I0LQtBeY/Y3hMYjzUybWppGaup9lRsJ5Z+MpD9GoKc1CaoUHiKqUeFFI+CYpL0p/tQzglHWbT1X
	xyf781IPCv5Twt0NaKhW/cnVvqGSAyu+xrw+robMG
X-Gm-Gg: AZFdTZfjBq0ncdpA4jz7iIkBnoG+rqNMEFCw9tn4Fmflk2S/6fyt2h1/10/pU2NHEvb
	Hwewqk5397Lems7XRuQaQLDoUMbB0YY85g7MB+P5LN09QChBMrTN95T2Cjnx54OtJog0R3gmxQG
	eNdH6f9dMWXJMI6JRgzrl8eSxW4qQlKmrIUwhynI9qnNTqZLOpa8Q4HArGKATdDXB/D2R4zOiI9
	XEt7Zb6ePm3eJtnG0eGgHeMd8MfubWt1DcgnFAaE6BfOuhlGdFU+eOr8/UsVAu9yK6epgMVXr/j
	Kzjo/4FyGRPab/HMbIwllQleTj4NuQEKXkvpxKDGWVYt2DzqiK6BfnQy7etYYzEAk1XScqGXR5i
	WMy3lHcDB1MPJDdc4akqu2pxB1DtBvR8ElA==
X-Received: by 2002:a05:6512:1042:b0:5c1:4c4a:f026 with SMTP id
 2adb3069b0e04-5c1bc6f633dmr1312524e87.4.1795194599155; Fri, 20 Nov 2026
 09:09:59 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <CALCETrVqc+1bjH1bhqHee9bsUdk2B6314z7PMexbsnNpMhk14g@mail.gmail.com>
In-Reply-To: <CALCETrVqc+1bjH1bhqHee9bsUdk2B6314z7PMexbsnNpMhk14g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Nov 2026 09:09:47 -0800
X-Gm-Features: Aa3M54qqiWJmEKSjiAInchWSC43ADdXnD64UgkMS8cTjGJqVilvL89j5dcH7YsU
Message-ID: <CALCETrV=zSxb6sgA08DLiK2bQovdMEj9ycG=Cc71mLn2C5Pgeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
To: Andy Lutomirski <luto@kernel.org>
Cc: "Hallgrimur H. Gunnarsson" <halg@google.com>, Christian Brauner <brauner@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Singh KP <kpsingh@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, 
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Nov 19, 2026, at 2:52=E2=80=AFPM, Andy Lutomirski <luto@kernel.org> wr=
ote:
> =EF=BB=BFOn Thu, Nov 19, 2026 at 2:43=E2=80=AFAM Hallgrimur H. Gunnarsson
> <halg@google.com> wrote:
>>
>> When a process creates a new user namespace, it receives a full set of
>> capabilities (CAP_FULL_SET) scoped to that namespace. While namespaced
>> in scope, several of these capabilities (such as CAP_NET_ADMIN and
>> CAP_NET_RAW) expose broad kernel attack surface that many sandboxes and
>> containers never need. However, there is currently no configurable way
>> to withhold such capabilities from user namespaces while still granting
>> them to workloads that require them.
>
>
> One thought (from the rootns thread): the other decent sized attack
> surface here is CAP_MOUNT_ADMIN.  Which doesn't exist as a capability
> bit.
>
> A sort of horrible solution (but maybe not so awful) would be to
> declare that the bits in cap_userns aren't actually capability bits,
> and that you need the bit in cap_userns *and* the bit in cap_effective
> to do sensitive things, and that mounting needs cap_userns to have
> NSCAP_MOUNT_ADMIN *and* cap_effective to have CAP_SYS_ADMIN.
>
> I want to sleep on this.  It might actually solve several problems,
> e.g. controlling creation of ipv4 and ipv6 loopback or tunnel devices
> or whatever.

I slept on it. Here=E2=80=99s a counterproposal.  I=E2=80=99m not saying I =
think this
is better than this patch set, but I think it=E2=80=99s worth weighting the
options.

Define a whole new set of privilege bits.  As a
poorly-painted-bikeshed option, I=E2=80=99ll call them eprivs (for exposure
privileges - it=E2=80=99s a crappy name but at least it=E2=80=99s pronounce=
able).

An epriv is not permission to do something *to* an object; it=E2=80=99s
permission to do something that exposes a meaningful attack surface
within the kernel. So there=E2=80=99s no ns_has_epriv because there is no
object.  These are kind of the opposite of object capabilities.
Additionally, an epriv never grants the ability to do something that
one couldn=E2=80=99t do in an epriv-less world.

For now, all tasks have all eprivs, even not-yet-defined ones, unless
user code or config explicitly changes this.  (Maybe some day secure
boot might remove certain eprivs.)

There should never be a check like ns_capable || has_epriv. It=E2=80=99s al=
so
&&, or perhaps caps are not checked at all.

Example eprivs include:

EPRIV_FSOPEN_VIRT: may fsconfig, fsopen, etc a virtual fs like fuse or
tmpfs or overlayfs.

EPRIV_CLONE_TREE: may clone a mount tree

EPRIV_MOVE_MOUNT: may move mounts around (but only if you also have
CAP_SYS_ADMIN on the correct namespace, of course)

EPRIV_FIREWALL_TC: may configure any firewalling configuration or tc
configuration (this includes iptables, nftables, and ebtables)

EPRIV_NET_RAW: may use raw/packet sockets (like CAP_NET_RAW)

EPRIV_TUNTAP: may create and attach to tun/tap interfaces

EPRIV_IP_LOOPBACK: may set up IPv4 and IPv6 loopback using whatever
new facility we add

EPRIV_NETLINK: may use netlink at all

EPRIV_NET_ADMIN: may use traditional CAP_NET_ADMIN abilities (all
CAP_NET_ADMIN checks will also check EPRIV_NET_ADMIN)

EPRIV_OPEN_FILE_HANDLE: May use open_by_handle_at, etc.

EPRIV_UNSHARE_USERNS: may unshare userns

EPRIV_UNSHARE_NONUSERNS: may unshare any other namespace

EPRIV_MOUNT_CGROUPv1, EPRIV_MOUNT_CGROUPv2: may create a new mount of
these subsystems

EPRIV_PTRACE: there are lots of different variations that might make sense.

EPRIV_MOUNT_PROC_PIDONLY: may mount proc-pidonly

EPRIV_MOUNT_PROC_NOTPIDONLY: may mount proc not-pidonly

EPRIV_MOUNT_SYSFS: may mount sysfs

Example eprivs that are questionable:

EPRIV_DMESG: the kernel log is a specific object, and I think it's
better to control access using something kernel-log-specific.



There is no operation that increases eprivs -- even without
no_new_privs set, a task will never gain an epriv, nor will a child
ever have an epriv that its creator did not have at the time the child
was created.

The evolution rules could be as simple as, on fork/clone, the child
inheriting exactly the parent's eprivs.

Or we could bind eprivs to a userns instead of a task, but that could
be more limiting and awkward than we want.


What do you all think?


FWIW, I had an LLM make an inventory (surely not exhaustive) of
recent-ish CVEs and how they relate to this list.  (The below is the
only part of this email that is LLM-generated, although I added
EPRIV_SYSFS because I didn't realize that nonroot userns could mount
it until I asked an LLM, sigh.)  To me, the list and its breakdown
suggests that there is quite a lot of room for meaningful attack
surface reductions while still leaving large parts of userns
available, and that my epriv proposal captures much of this but the
cap_userns proposal may be too coarse-grained.

(I also asked about eBPF, and my LLM came up with a lot of CVEs, but
there's an existing BPF token mechanism and I therefore did not
propose EPRIV_LOAD_EBPF.)

--- begin LLM output ---

**EPRIV_FSOPEN_VIRT:** CVE-2022-0185*, CVE-2023-0386*, CVE-2023-2640*,
CVE-2023-32629*, CVE-2025-38499*

**EPRIV_CLONE_TREE:** CVE-2025-38499* (only if the check also covers
the relevant internal mount-cloning path; explicit `open_tree()`
restrictions alone are insufficient)

**EPRIV_MOVE_MOUNT:** CVE-2025-37988

**EPRIV_FIREWALL_TC:** CVE-2022-25636, CVE-2022-1015, CVE-2022-1016,
CVE-2022-32250, CVE-2022-34918, CVE-2022-48911*, CVE-2022-2588,
CVE-2023-32233, CVE-2023-35001, CVE-2023-4004, CVE-2023-4015,
CVE-2023-4244, CVE-2023-5197, CVE-2023-6817, CVE-2023-3609,
CVE-2023-4623, CVE-2023-4921, CVE-2024-1086, CVE-2024-0607,
CVE-2024-27397, CVE-2024-26925, CVE-2025-38001, CVE-2026-23111

**EPRIV_NET_RAW:** None identified.

**EPRIV_TUNTAP:** None identified as requiring TUN/TAP. Some
packet-triggered exploits may optionally use it, but that does not
establish it as a necessary blocker.

**EPRIV_IP_LOOPBACK:** None identified.

**EPRIV_NETLINK:** Also those blocked by `EPRIV_FIREWALL_TC`, insofar
as the documented attack paths use netlink. No additional CVEs
identified.

**EPRIV_NET_ADMIN:** Also those blocked by `EPRIV_FIREWALL_TC`,
insofar as the vulnerable operations require `CAP_NET_ADMIN`. No
additional CVEs identified.

**EPRIV_OPEN_FILE_HANDLE:** CVE-2025-38306*

**EPRIV_UNSHARE_USERNS:** Also those blocked by `EPRIV_FSOPEN_VIRT`,
`EPRIV_MOVE_MOUNT`, `EPRIV_FIREWALL_TC`, `EPRIV_OPEN_FILE_HANDLE`,
`EPRIV_MOUNT_CGROUPv1`, and `EPRIV_MOUNT_SYSFS`, plus CVE-2025-38058*.
More generally, blocks the documented unprivileged user-namespace
setup for the entire inventory when no usable user namespace already
exists.

**EPRIV_UNSHARE_NONUSERNS:** Also the namespace-dependent attack paths
blocked by `EPRIV_FIREWALL_TC`, `EPRIV_MOVE_MOUNT`,
`EPRIV_MOUNT_CGROUPv1`, `EPRIV_MOUNT_SYSFS`, and many of those blocked
by `EPRIV_FSOPEN_VIRT`. Coverage depends on whether the necessary
non-user namespaces already exist.

**EPRIV_MOUNT_CGROUPv1:** CVE-2022-0492*

**EPRIV_MOUNT_CGROUPv2:** None identified.

**EPRIV_PTRACE:** None identified.

**EPRIV_LOAD_EBPF:** None identified.

**EPRIV_MOUNT_PROC_PIDONLY:** None identified.

**EPRIV_MOUNT_PROC_NOTPIDONLY:** None identified.

**EPRIV_MOUNT_SYSFS:** CVE-2025-22089*

CVEs not cleanly blocked by an operation-specific bit
Excluding the two EPRIV_UNSHARE_* gates:

- CVE-2025-38058: No explicit unmount privilege. The vulnerable race
involves umount(2) and path lookup.

- CVE-2022-0492: The cgroup-v1 mount bit covers the documented
new-mount attack path, but not necessarily configuration of
release_agent on an existing writable hierarchy.

- CVE-2025-38499: The correct gate depends on which filesystem-context
or internal cloning operation reaches clone_private_mnt(). I would not
count EPRIV_CLONE_TREE as a definitive blocker without checking the
exact call paths.
