From: "Williams, Dan J" <dan.j.williams@intel.com>
Date: Wed, 17 Jun 2020 01:15:55 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk>
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>

Hi David,

On Tue, 2020-06-02 at 16:55 +-0100, David Howells wrote:
+AD4- Date: Tue, 02 Jun 2020 16:51:44 +-0100
+AD4- 
+AD4- Hi Linus,
+AD4- 
+AD4- Can you pull this, please?  It adds a general notification queue
+AD4- concept
+AD4- and adds an event source for keys/keyrings, such as linking and
+AD4- unlinking
+AD4- keys and changing their attributes.
+AFs-..+AF0-

This commit:

+AD4-       keys: Make the KEY+AF8-NEED+AF8AKg- perms an enum rather than a mask

...upstream as:

    8c0637e950d6 keys: Make the KEY+AF8-NEED+AF8AKg- perms an enum rather than a mask

...triggers a regression in the libnvdimm unit test that exercises the
encrypted keys used to store nvdimm passphrases. It results in the
below warning.

---

WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key+AF8-task+AF8-permission+-0xd3/0x140
Modules linked in: nd+AF8-blk(OE) nfit+AF8-test(OE) device+AF8-dax(OE) ebtable+AF8-filter(E) ebtables(E) ip6table+AF8-filter(E) ip6+AF8-tables(E) kvm+AF8-intel(E) kvm(E) irqbypass(E) nd+AF8-pmem(OE) dax+AF8-pmem(OE) nd+AF8-btt(OE) dax+AF8-p
ct10dif+AF8-pclmul(E) nd+AF8-e820(OE) nfit(OE) crc32+AF8-pclmul(E) libnvdimm(OE) crc32c+AF8-intel(E) ghash+AF8-clmulni+AF8-intel(E) serio+AF8-raw(E) encrypted+AF8-keys(E) trusted(E) nfit+AF8-test+AF8-iomap(OE) tpm(E) drm(E)
CPU: 15 PID: 6276 Comm: lt-ndctl Tainted: G           OE     5.7.0-rc6+- +ACM-155
Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 0.0.0 02/06/2015
RIP: 0010:key+AF8-task+AF8-permission+-0xd3/0x140
Code: c8 21 d9 39 d9 75 25 48 83 c4 08 4c 89 e6 48 89 ef 5b 5d 41 5c 41 5d e9 1b a7 00 00 bb 01 00 00 00 83 fa 01 0f 84 68 ff ff ff +ADw-0f+AD4- 0b 48 83 c4 08 b8 f3 ff ff ff 5b 5d 41 5c 41 5d c3 83 fa 06

RSP: 0018:ffffaddc42db7c90 EFLAGS: 00010297
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffaddc42db7c7c
RDX: 0000000000000000 RSI: ffff985e1c46e840 RDI: ffff985e3a03de01
RBP: ffff985e3a03de01 R08: 0000000000000000 R09: 5461e7bc000002a0
R10: 0000000000000004 R11: 0000000066666666 R12: ffff985e1c46e840
R13: 0000000000000000 R14: ffffaddc42db7cd8 R15: ffff985e248c6540
FS:  00007f863c18a780(0000) GS:ffff985e3bbc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006d3708 CR3: 0000000125a1e006 CR4: 0000000000160ee0
Call Trace:
 lookup+AF8-user+AF8-key+-0xeb/0x6b0
 ? vsscanf+-0x3df/0x840
 ? key+AF8-validate+-0x50/0x50
 ? key+AF8-default+AF8-cmp+-0x20/0x20
 nvdimm+AF8-get+AF8-user+AF8-key+AF8-payload.part.0+-0x21/0x110 +AFs-libnvdimm+AF0-
 nvdimm+AF8-security+AF8-store+-0x67d/0xb20 +AFs-libnvdimm+AF0-
 security+AF8-store+-0x67/0x1a0 +AFs-libnvdimm+AF0-
 kernfs+AF8-fop+AF8-write+-0xcf/0x1c0
 vfs+AF8-write+-0xde/0x1d0
 ksys+AF8-write+-0x68/0xe0
 do+AF8-syscall+AF8-64+-0x5c/0xa0
 entry+AF8-SYSCALL+AF8-64+AF8-after+AF8-hwframe+-0x49/0xb3
RIP: 0033:0x7f863c624547
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 +ADw-48+AD4- 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffd61d8f5e8 EFLAGS: 00000246 ORIG+AF8-RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffd61d8f640 RCX: 00007f863c624547
RDX: 0000000000000014 RSI: 00007ffd61d8f640 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000014 R09: 00007ffd61d8f4a0
R10: fffffffffffff455 R11: 0000000000000246 R12: 00000000006dbbf0
R13: 00000000006cd710 R14: 00007f863c18a6a8 R15: 00007ffd61d8fae0
irq event stamp: 36976
hardirqs last  enabled at (36975): +AFsAPA-ffffffff9131fa40+AD4AXQ- +AF8AXw-slab+AF8-alloc+-0x70/0x90
hardirqs last disabled at (36976): +AFsAPA-ffffffff910049c7+AD4AXQ- trace+AF8-hardirqs+AF8-off+AF8-thunk+-0x1a/0x1c
softirqs last  enabled at (35474): +AFsAPA-ffffffff91e00357+AD4AXQ- +AF8AXw-do+AF8-softirq+-0x357/0x466
softirqs last disabled at (35467): +AFsAPA-ffffffff910eae96+AD4AXQ- irq+AF8-exit+-0xe6/0xf0
