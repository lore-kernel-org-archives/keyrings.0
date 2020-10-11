From: rishi gupta <gupt21@gmail.com>
Date: Sun, 11 Oct 2020 17:56:54 +0000
Subject: Does selinux rule needed for .ima keyring access - integrity: Request for unknown key 'id:87deb3bf' 
Message-Id: <CALUj-gs2-kCX00Pf42kb+fYo0UE6DD6he3z=-Lz8M52-AFFi_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity <linux-integrity@vger.kernel.org>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Hi IMA experts,

Do we need to write any rule for selinux to allow access to key in
.ima keyring for all processes or I am thinking in wrong direction.

"integrity: Request for unknown key 'id:87deb3bf' err -13" is the
error with selinux enabled (kernel is 4.14). Without selinux enabled,
IMA appraisal works fine.
Audit logs:
[10012.824868] type00 audit(315974764.149:5729): pidu11 uid01
auidB94967295 sesB94967295
subj=system_u:system_r:testd_cm_t:s0-s15:c0.c1023 op="appraise_data"
cause="invalid-signature" comm="sh" name="/sbin/testdaemon"
dev="ubifs" ino446 res=0

Output of few commands just in case it is useful:

# keyctl show -x %:.builtin_trusted_keys
Keyring
0x26edf4c7 ---lswrv      0     0  keyring: .builtin_trusted_keys
0x3e65ef00 ---lswrv      0     0   \_ asymmetric: IMA-CA: IMA/EVM
certificate signing key: 20c98dcf771b2a945c0ffd245011118299f90bdf

# keyctl show -x %:.ima
Keyring
0x0e961ca8 ---lswrv      0     0  keyring: .ima
0x2e3011f8 ---lswrv      0     0   \_ asymmetric: ima: signing key:
edc4697e8b77ef2713e491616726090c87deb3bf

/ # cat /proc/keys
02fdee99 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
035ab7c0 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0439d238 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
04964e3e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
04da590e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
054ef37d I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
055154e2 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
06511dd4 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0761426a I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0793080e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
07f495f8 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
082f71d6 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
096dee7c I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
09904799 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0b87b742 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0c1b072c I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
0d02c3ff I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
0db26b5a I--Q---     8 perm 3f030000     0     0 keyring   _ses: 1
0dc6c62e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
0e961ca8 I------     1 perm 1f0f0000     0     0 keyring   .ima: 1
0ff12212 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1156ac2d I--Q---    13 perm 3f030000     0     0 keyring   _ses: 1
1252fe6f I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
1285aef6 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1322fc5e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
13866397 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
14173f44 I--Q---     2 perm 1f3f0000     0 65534 keyring   _uid.0: empty
14931524 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
155502e8 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
1604215d I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
16b40b6b I--Q---     4 perm 3f030000     0     0 keyring   _ses: 1
17db30d9 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
18ea41e0 I--Q---     5 perm 3f030000     0     0 keyring   _ses: 1
19b92253 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
19eeed3f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1b89b979 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
1c0a573f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1cd763d5 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1d3caf71 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1d6a3880 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
1ddffca9 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
1df0c622 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
201c5a37 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2045b3bb I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
20993304 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
2154e4a6 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
22f2253f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
25e97a49 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2665b7b4 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
26edf4c7 I------     1 perm 1f0b0000     0     0 keyring
.builtin_trusted_keys: 1
2798bd15 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
29931371 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2a3853b1 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2cc594f1 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2dc04d98 I--Q---     2 perm 3f030000     0     0 keyring   _ses: 1
2e0e4f06 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2e3011f8 I------     1 perm 1f030000     0     0 asymmetri ima:
signing key: edc4697e8b77ef2713e491616726090c87deb3bf: X509.rsa
87deb3bf []
2e769ee9 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2ebb4809 I--Q---     1 perm 1f3f0000     0 65534 keyring   _uid_ses.0: 1
2fdc0299 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
307f8910 I--Q---     1 perm 3f030000     0     0 keyring   _ses: 1
3384a46f I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
357dd4d1 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
3be9a95e I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
3c3162f6 I--Q---     3 perm 3f030000     0     0 keyring   _ses: 1
3d47a3ab I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
3e65ef00 I------     1 perm 1f030000     0     0 asymmetri IMA-CA:
IMA/EVM certificate signing key:
20c98dcf771b2a945c0ffd245011118299f90bdf: X509.rsa 99f90bdf []
3f625ed4 I--Q---     5 perm 3f030000     0     0 keyring   _ses: 1

Regards.,
Rishi
