From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jun 2020 23:38:29 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
In-Reply-To: <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>

On Tue, Jun 16, 2020 at 6:15 PM Williams, Dan J
<dan.j.williams@intel.com> wrote:
>
> Hi David,
>
> On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> > Date: Tue, 02 Jun 2020 16:51:44 +0100
> >
> > Hi Linus,
> >
> > Can you pull this, please?  It adds a general notification queue
> > concept
> > and adds an event source for keys/keyrings, such as linking and
> > unlinking
> > keys and changing their attributes.
> [..]
>
> This commit:
>
> >       keys: Make the KEY_NEED_* perms an enum rather than a mask
>
> ...upstream as:
>
>     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
>
> ...triggers a regression in the libnvdimm unit test that exercises the
> encrypted keys used to store nvdimm passphrases. It results in the
> below warning.

This regression is still present in tip of tree. David, have you had a
chance to take a look?



>
> ---
>
> WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
> Modules linked in: nd_blk(OE) nfit_test(OE) device_dax(OE) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) kvm_intel(E) kvm(E) irqbypass(E) nd_pmem(OE) dax_pmem(OE) nd_btt(OE) dax_p
> ct10dif_pclmul(E) nd_e820(OE) nfit(OE) crc32_pclmul(E) libnvdimm(OE) crc32c_intel(E) ghash_clmulni_intel(E) serio_raw(E) encrypted_keys(E) trusted(E) nfit_test_iomap(OE) tpm(E) drm(E)
> CPU: 15 PID: 6276 Comm: lt-ndctl Tainted: G           OE     5.7.0-rc6+ #155
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> RIP: 0010:key_task_permission+0xd3/0x140
> Code: c8 21 d9 39 d9 75 25 48 83 c4 08 4c 89 e6 48 89 ef 5b 5d 41 5c 41 5d e9 1b a7 00 00 bb 01 00 00 00 83 fa 01 0f 84 68 ff ff ff <0f> 0b 48 83 c4 08 b8 f3 ff ff ff 5b 5d 41 5c 41 5d c3 83 fa 06
>
> RSP: 0018:ffffaddc42db7c90 EFLAGS: 00010297
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffaddc42db7c7c
> RDX: 0000000000000000 RSI: ffff985e1c46e840 RDI: ffff985e3a03de01
> RBP: ffff985e3a03de01 R08: 0000000000000000 R09: 5461e7bc000002a0
> R10: 0000000000000004 R11: 0000000066666666 R12: ffff985e1c46e840
> R13: 0000000000000000 R14: ffffaddc42db7cd8 R15: ffff985e248c6540
> FS:  00007f863c18a780(0000) GS:ffff985e3bbc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000006d3708 CR3: 0000000125a1e006 CR4: 0000000000160ee0
> Call Trace:
>  lookup_user_key+0xeb/0x6b0
>  ? vsscanf+0x3df/0x840
>  ? key_validate+0x50/0x50
>  ? key_default_cmp+0x20/0x20
>  nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
>  nvdimm_security_store+0x67d/0xb20 [libnvdimm]
>  security_store+0x67/0x1a0 [libnvdimm]
>  kernfs_fop_write+0xcf/0x1c0
>  vfs_write+0xde/0x1d0
>  ksys_write+0x68/0xe0
>  do_syscall_64+0x5c/0xa0
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7f863c624547
> Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007ffd61d8f5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffd61d8f640 RCX: 00007f863c624547
> RDX: 0000000000000014 RSI: 00007ffd61d8f640 RDI: 0000000000000005
> RBP: 0000000000000005 R08: 0000000000000014 R09: 00007ffd61d8f4a0
> R10: fffffffffffff455 R11: 0000000000000246 R12: 00000000006dbbf0
> R13: 00000000006cd710 R14: 00007f863c18a6a8 R15: 00007ffd61d8fae0
> irq event stamp: 36976
> hardirqs last  enabled at (36975): [<ffffffff9131fa40>] __slab_alloc+0x70/0x90
> hardirqs last disabled at (36976): [<ffffffff910049c7>] trace_hardirqs_off_thunk+0x1a/0x1c
> softirqs last  enabled at (35474): [<ffffffff91e00357>] __do_softirq+0x357/0x466
> softirqs last disabled at (35467): [<ffffffff910eae96>] irq_exit+0xe6/0xf0
>
