Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36338481FA3
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792236389; cv=none; b=Si0ra5DGfx73Z5zIa9IWO3IN3ViiOi9JzlQXxjp2dhFix4ljsV9HpK5d3nDS0VMGiMYmbVLHNCZA0LTedKRT6fdCo0DrDdoDzFX5zMTPiVBkiy/ZT6+ktWu29dg5WuOM2akOc1C4YKBr7O9jV9R987OC55HEdLucMIa0qoWhB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792236389; c=relaxed/simple;
	bh=gsribd0HQ70V34cHYt527v1HP/hbNVLeP8tYt+TmdxU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qd3w32f/CQikWV9gPJ8K50hON8Tb/QXjbL/sevmsX8csK4sBKuCuygSVcB0w+nl2s+Af/U/xRYudVox+zR/S+0Iwf8jJ1pzoUzXcvL3zLsGPIrVarEzI3xOSRhFchoVLkJ4/q1wOlq2Bn8cC8iPGTC4M7GIPFaiEeLdnnYP7uT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4d2f0f77124so1062725b6e.3
        for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 04:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792236385; x=1792841185;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vk5FIeZx+LnftjORcYrMxzyaqeVw+XPzBJbPmLQupXo=;
        b=hbMoTlnnfSN+jAxR0CppZ2UtddanqLFbzQPUOE4E6aRvSsWt4x8uLTeU8yiXi8j+QZ
         iQEMKWMAadptG6O7u07GIuUikasNdLaIhKq4HRwhRe2yjXjxKntBKCViENNovusJn43g
         sepsNT/avOP/sQpL/LS96LlhfDy4JzE+k6Pj3oHQUTetq1jgO6wyW+AETKr6U8/r1dQT
         jiWHF8bDgnuNIf8QB5Z6BNecPFyVSzdl3Fi6u7Dz19xnilAuFueBdqf8ZS64HIDXwDcT
         pZfnAnFX885mscGSCRpfYQgrucx49dWjMPkerepx83U8nVaHLCp8iYA+RI2yesGaOWl7
         89RQ==
X-Forwarded-Encrypted: i=1; AKwUvBxai9o+jF70ojVwfuYfyOvP4heyVyyEKct7odEThVmD1w3HM7LHbVeripjPtVIm6s/+ITz1NL1XQg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLe5LVy0oZk8KR4rmmUFwm8PZG7921I67j2KVbt+tSa0ttMqSAv
	1EGY955wckuZqNwD/27XQBCgD9w4aw2jUqkJO1L1Ucjij65YgNuDTz+zWM7j99COU4i0DdyGpyb
	W5nosKcqu1SyHhkLqD0/BQTeZxweesvnizB9vK9gMtnxC4DqibRY0g/Un4xU=
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1645:b0:4f4:cea0:23 with SMTP id
 5614622812f47-53ccaf25555mr1825896b6e.14.1792236384987; Sat, 17 Oct 2026
 04:26:24 -0700 (PDT)
Date: Sat, 17 Oct 2026 04:26:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad35b60.7952420f.283480.0360.GAE@google.com>
Subject: [syzbot] [keyrings?] [lsm?] BUG: workqueue lockup in key_garbage_collector
From: syzbot <syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    7a19f0cc94ad Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16320f01580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D26d6221a572842a=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc15de43f1e7fffbb7=
b9b
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/296cd4b77dbf/disk-=
7a19f0cc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e57669ed895f/vmlinux-=
7a19f0cc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c679c1ad76d4/Ima=
ge-7a19f0cc.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com

BUG: workqueue lockup - pool cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 stuck f=
or 30s!
Showing busy workqueues and worker pools:
workqueue events: flags=3D0x100
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D13 refcnt=3D14
    in-flight: 10:key_garbage_collector for 51s ,1030:request_firmware_work=
_func for 87s
    pending: nsim_dev_hwstats_traffic_work, 2*psi_avgs_work, vmstat_shepher=
d, 4*ovs_dp_masks_rebalance, 2*psi_avgs_work, delayed_vfree_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D12 refcnt=3D13
    in-flight: 4831:nsim_fib_event_work for 56s ,26:nsim_fib_event_work for=
 56s
    pending: 4*nsim_dev_hwstats_traffic_work, 2*psi_avgs_work, 2*ovs_dp_mas=
ks_rebalance, free_ipc, delayed_vfree_work
workqueue events_unbound: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D5 refcnt=3D6
    pending: toggle_allocation_gate, 2*nsim_dev_trap_report_work, flush_mem=
cg_stats_dwork, nsim_dev_trap_report_work
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D24 refcnt=3D25
    in-flight: 524:cfg80211_wiphy_work for 56s ,134:cfg80211_wiphy_work for=
 56s ,12:cfg80211_wiphy_work for 41s ,13:cfg80211_wiphy_work for 57s ,40:cf=
g80211_wiphy_work for 48s ,1395:cfg80211_wiphy_work for 48s ,41:cfg80211_wi=
phy_work for 56s ,1171:cfg80211_wiphy_work for 57s cfg80211_wiphy_work
    pending: 5*cfg80211_wiphy_work, 2*nsim_dev_trap_report_work, 3*cfg80211=
_wiphy_work, crng_reseed, cfg80211_wiphy_work, 3*macvlan_process_broadcast
workqueue events_power_efficient: flags=3D0x82
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D6 refcnt=3D7
    pending: neigh_periodic_work, wg_ratelimiter_gc_entries, neigh_managed_=
work, fb_flashcursor, neigh_managed_work, gc_worker
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: neigh_periodic_work, do_cache_clean
workqueue events_dfl_long: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D5 refcnt=3D6
    pending: 5*defense_work_handler
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: defense_work_handler
workqueue mm_percpu_wq: flags=3D0x108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D3
    pending: vmstat_update
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D2
    pending: vmstat_update
workqueue writeback: flags=3D0x4a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D4 MAYDAY
    pending: wb_workfn
workqueue iou_exit: flags=3D0x2
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: io_ring_exit_work
workqueue mld: flags=3D0x40108
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D3 MAYDA=
Y
    pending: mld_dad_work
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D70 MAYD=
AY
    in-flight: 4816:mld_ifc_work for 7s
    inactive: 3*mld_ifc_work, mld_dad_work, 11*mld_ifc_work, mld_dad_work, =
6*mld_ifc_work, mld_dad_work, 8*mld_ifc_work, mld_dad_work, 10*mld_ifc_work=
, mld_dad_work, mld_ifc_work, 2*mld_dad_work, 2*mld_ifc_work, mld_dad_work,=
 mld_ifc_work, mld_dad_work, 13*mld_ifc_work, 2*mld_dad_work
workqueue ipv6_addrconf: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D419 MAYDAY
    pending: mayday_cursor_func, addrconf_dad_work
    inactive: 413*addrconf_dad_work
workqueue bat_events: flags=3D0x6000a
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D45 MAYDAY
    in-flight: 2856(RESCUER):batadv_tt_purge for 8s
    pending: mayday_cursor_func
    inactive: 2*batadv_tt_purge, 4*batadv_mcast_mla_update, batadv_purge_or=
ig, 3*batadv_iv_send_outstanding_bat_ogm_packet, batadv_purge_orig, 2*batad=
v_iv_send_outstanding_bat_ogm_packet, 2*batadv_purge_orig, batadv_iv_send_o=
utstanding_bat_ogm_packet, batadv_purge_orig, batadv_iv_send_outstanding_ba=
t_ogm_packet, batadv_mcast_mla_update, 8*batadv_iv_send_outstanding_bat_ogm=
_packet, batadv_dat_purge, batadv_bla_periodic_work, batadv_dat_purge, bata=
dv_bla_periodic_work, batadv_dat_purge, batadv_bla_periodic_work, batadv_da=
t_purge, batadv_bla_periodic_work, batadv_dat_purge, batadv_bla_periodic_wo=
rk, 2*batadv_tt_purge
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D4 refcnt=3D7 MAYDA=
Y
    in-flight: 4824:wg_packet_tx_worker for 57s wg_packet_tx_worker
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_tx_worker, wg_packet_decrypt_worker, wg_packet_encry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D6 MAYDA=
Y
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_decrypt_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D3
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_tx_worker, wg_packet_decrypt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_encrypt_worker, wg_packet_tx_worker, wg_packet_decry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker, wg_packet_decry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D4 MAYDA=
Y
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D2 refcnt=3D3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D4 MAYDA=
Y
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D4 MAYDA=
Y
    pending: wg_packet_encrypt_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
workqueue wg-kex-wg0: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D4
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker, wg_packet_=
tx_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D6 MAYDA=
Y
    in-flight: 4832:wg_packet_tx_worker for 56s wg_packet_tx_worker
    pending: wg_packet_encrypt_worker
workqueue wg-crypt-wg1: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_tx_worker, wg_packet_encrypt_worker, wg_packet_decry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D2 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_encrypt_worker, wg_packet_decrypt_worker
workqueue wg-kex-wg2: flags=3D0x6
  pwq 8: cpus=3D0-1 flags=3D0x6 nice=3D0 active=3D1 refcnt=3D2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=3D0x128
  pwq 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 active=3D3 refcnt=3D5 MAYDA=
Y
    pending: wg_packet_decrypt_worker, wg_packet_tx_worker, wg_packet_encry=
pt_worker
  pwq 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 active=3D1 refcnt=3D4 MAYDA=
Y
    pending: wg_packet_encrypt_worker
pool 2: cpus=3D0 node=3D0 flags=3D0x2 nice=3D0 hung=3D30s workers=3D6 manag=
er: 4872 idle: 4314 9 4802
pool 6: cpus=3D1 node=3D0 flags=3D0x2 nice=3D0 hung=3D7s workers=3D9 manage=
r: 4925 idle: 24 4817 866
pool 8: cpus=3D0-1 flags=3D0x6 nice=3D0 hung=3D8s workers=3D9 manager: 1461
Showing backtraces of busy workers in stalled worker pools:
pool 2:
task:kworker/0:1     state:R  running task     stack:0     pid:10    tgid:1=
0    ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: events key_garbage_collector
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x135c/0x2b00 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0x13c/0x20c kernel/sched/core.c:7376
 schedule_timeout+0xc0/0x28c kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common+0x220/0x394 kernel/sched/completion.c:132
 wait_for_completion+0x18/0x24 kernel/sched/completion.c:153
 synchronize_rcu_normal+0x28c/0x350 kernel/rcu/tree.c:3355
 synchronize_rcu+0x1f4/0x258 kernel/rcu/tree.c:3413
 key_garbage_collector+0x728/0x894 security/keys/gc.c:297
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854
pool 2:
task:kworker/0:2     state:R  running task     stack:0     pid:1030  tgid:1=
030  ppid:2      task_flags:0x4208060 flags:0x00000010
Workqueue: events request_firmware_work_func
Call trace:
 __switch_to+0x2b4/0x6e4 arch/arm64/kernel/process.c:775 (T)
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x135c/0x2b00 kernel/sched/core.c:7284
 preempt_schedule_common+0xd4/0x190 kernel/sched/core.c:7463
 preempt_schedule+0x60/0x78 kernel/sched/core.c:7487
 __local_bh_enable_ip+0x16c/0x234 kernel/softirq.c:480
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:237 [inline]
 _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:245
 spin_unlock_bh include/linux/spinlock.h:407 [inline]
 restore_regulatory_settings+0x6f0/0x1650 net/wireless/reg.c:3555
 regdb_fw_cb+0x14c/0x1a8 net/wireless/reg.c:1026
 request_firmware_work_func+0xe8/0x24c drivers/base/firmware_loader/main.c:=
1164
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3479
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3560
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:854


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
