From: Nick Bowler <nbowler@draconx.ca>
Date: Sat, 21 Sep 2019 01:54:25 +0000
Subject: Re: PROBLEM: nfs? crash in Linux 5.3 (possible regression)
Message-Id: <CADyTPEwUjbV3icj7YD1a5fgzE_t0fpF0Mj9v-fLKywPwKki+Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CADyTPExOnxS+FS6Uqoxu3jNWRy93SQri4Xo1+00aiiVru8XDkg@mail.gmail.com>
 <c573ebd9d835e2bf2d2b2a4dcb682b6d913b0c5e.camel@hammerspace.com>
In-Reply-To: <c573ebd9d835e2bf2d2b2a4dcb682b6d913b0c5e.camel@hammerspace.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 9/20/19, Trond Myklebust <trondmy@hammerspace.com> wrote:
> On Fri, 2019-09-20 at 14:23 -0400, Nick Bowler wrote:
>> Not sure how reproducible this is.  Since I've never seen a crash
>> like this before it may be a regression compared to, say, Linux 4.19
>> but I am not certain because this particular machine is brand new so
>> I don't have experience with older kernels on it...

So it actually seems pretty reliably reproducible, 4 attempts to compile
Linux on Linux 5.3 and all four crash the same way, although there's
definitely some randomness here...

On the other hand, I cannot reproduce if I install Linux 5.2 so it does
seem like a regression in 5.3.  I will see how well bisecting goes...

>> [  796.050025] BUG: kernel NULL pointer dereference, address:
>> 0000000000000014
>> [  796.051280] #PF: supervisor read access in kernel mode
>> [  796.053063] #PF: error_code(0x0000) - not-present page
>> [  796.054636] PGD 0 P4D 0
>> [  796.055688] Oops: 0000 [#1] PREEMPT SMP
>> [  796.056768] CPU: 2 PID: 190 Comm: kworker/2:2 Tainted: G        W
>>       5.3.0 #6
>> [  796.057953] Hardware name: To Be Filled By O.E.M. To Be Filled By
>> O.E.M./B450 Gaming-ITX/ac, BIOS P3.30 05/17/2019
>> [  796.059329] Workqueue: events key_garbage_collector
>> [  796.060623] RIP: 0010:keyring_gc_check_iterator+0x27/0x30
>
> That would be the keyring garbage collector, not NFS.
>
> Cced keyrings@vger.kernel.org
>
>
>> [  796.061845] Code: 44 00 00 48 83 e7 fc b8 01 00 00 00 f6 87 80 00
>> 00 00 21 75 19 48 8b 57 58 48 39 16 7c 05 48 85 d2 7f 0b 48 8b 87 a0
>> 00 00 00 <0f> b6 40 14 c3 0f 1f 40 00 48 83 e7 fc e9 27 eb ff ff 0f
>> 1f
>> 80 00
>> [  796.064638] RSP: 0018:ffffb40fc0757df8 EFLAGS: 00010282
>> [  796.066058] RAX: 0000000000000000 RBX: ffffa14338caed80 RCX:
>> ffffb40fc0757e40
>> [  796.067531] RDX: ffffa1433ae85558 RSI: ffffb40fc0757e40 RDI:
>> ffffa1433ae85500
>> [  796.069014] RBP: ffffb40fc0757e40 R08: 0000000000000000 R09:
>> 000000000000000f
>> [  796.070513] R10: 8080808080808080 R11: 0000000000000001 R12:
>> ffffffffa4cd6180
>> [  796.072025] R13: ffffa14338caee10 R14: ffffa14338caedf0 R15:
>> ffffa1433ffeff00
>> [  796.073567] FS:  0000000000000000(0000) GS:ffffa14340480000(0000)
>> knlGS:0000000000000000
>> [  796.075171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  796.076785] CR2: 0000000000000014 CR3: 0000000747ce6000 CR4:
>> 00000000003406e0
>> [  796.078445] Call Trace:
>> [  796.080091]  assoc_array_subtree_iterate+0x55/0x100
>> [  796.081770]  keyring_gc+0x3f/0x80
>> [  796.083447]  key_garbage_collector+0x330/0x3d0
>> [  796.085155]  process_one_work+0x1cb/0x320
>> [  796.086869]  worker_thread+0x28/0x3c0
>> [  796.088603]  ? process_one_work+0x320/0x320
>> [  796.090335]  kthread+0x106/0x120
>> [  796.092053]  ? kthread_create_on_node+0x40/0x40
>> [  796.093810]  ret_from_fork+0x1f/0x30
>> [  796.095569] Modules linked in: sha1_ssse3 sha1_generic cbc cts
>> rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace ext4 crc16 mbcache
>> jbd2 iwlmvm mac80211 libarc4 amdgpu iwlwifi snd_hda_codec_realtek
>> snd_hda_codec_generic kvm_amd gpu_sched kvm snd_hda_codec_hdmi
>> drm_kms_helper irqbypass k10temp syscopyarea sysfillrect sysimgblt
>> fb_sys_fops video ttm cfg80211 snd_hda_intel snd_hda_codec drm
>> snd_hwdep rfkill snd_hda_core backlight snd_pcm evdev snd_timer snd
>> soundcore efivarfs dm_crypt hid_generic igb hwmon i2c_algo_bit sr_mod
>> cdrom sunrpc dm_mod
>> [  796.104033] CR2: 0000000000000014
>> [  796.106304] ---[ end trace 695aee10f9202347 ]---
>> [  796.108585] RIP: 0010:keyring_gc_check_iterator+0x27/0x30
>> [  796.110894] Code: 44 00 00 48 83 e7 fc b8 01 00 00 00 f6 87 80 00
>> 00 00 21 75 19 48 8b 57 58 48 39 16 7c 05 48 85 d2 7f 0b 48 8b 87 a0
>> 00 00 00 <0f> b6 40 14 c3 0f 1f 40 00 48 83 e7 fc e9 27 eb ff ff 0f
>> 1f
>> 80 00
>> [  796.115773] RSP: 0018:ffffb40fc0757df8 EFLAGS: 00010282
>> [  796.118209] RAX: 0000000000000000 RBX: ffffa14338caed80 RCX:
>> ffffb40fc0757e40
>> [  796.120683] RDX: ffffa1433ae85558 RSI: ffffb40fc0757e40 RDI:
>> ffffa1433ae85500
>> [  796.123176] RBP: ffffb40fc0757e40 R08: 0000000000000000 R09:
>> 000000000000000f
>> [  796.125668] R10: 8080808080808080 R11: 0000000000000001 R12:
>> ffffffffa4cd6180
>> [  796.128104] R13: ffffa14338caee10 R14: ffffa14338caedf0 R15:
>> ffffa1433ffeff00
>> [  796.130493] FS:  0000000000000000(0000) GS:ffffa14340480000(0000)
>> knlGS:0000000000000000
>> [  796.132923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  796.135266] CR2: 0000000000000014 CR3: 0000000747ce6000 CR4:
>> 00000000003406e0
>
