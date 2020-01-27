From: Vasily Averin <vvs@virtuozzo.com>
Date: Mon, 27 Jan 2020 19:27:47 +0000
Subject: Re: [PATCH 1/1] proc_keys_next should increase position index
Message-Id: <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
 <1451508.1580125174@warthog.procyon.org.uk>
In-Reply-To: <1451508.1580125174@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

On 1/27/20 2:39 PM, David Howells wrote:
> I don't see the effect you're talking about with /proc/keys.  I see the
> following:
> 
> 	[root@andromeda ~]# dd if=/proc/keys bs@ skip=1
> 	dd: /proc/keys: cannot skip to specified offset
> 
> and then it follows up with the normal content with no obvious duplicates (the
> lines are numbered ascendingly in the first column).
> 
> I think I may be being confused by what you mean by "the last line".

on unpatched kernel

$ uname -a
Linux vvsx1 5.3.0-26-generic #28~18.04.1-Ubuntu SMP Wed Dec 18 16:40:14 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

$ dd if=/proc/keys bs=1  # VvS: full usual output
0f6bfdf5 I--Q---     2 perm 3f010000  1000  1000 user      4af2f79ab8848d0a: 740
1fb91b32 I--Q---     3 perm 1f3f0000  1000 65534 keyring   _uid.1000: 2
27589480 I--Q---     1 perm 0b0b0000     0     0 user      invocation_id: 16
2f33ab67 I--Q---   152 perm 3f030000     0     0 keyring   _ses: 2
33f1d8fa I--Q---     4 perm 3f030000  1000  1000 keyring   _ses: 1
3d427fda I--Q---     2 perm 3f010000  1000  1000 user      69ec44aec7678e5a: 740
3ead4096 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1
521+0 records in
521+0 records out
521 bytes copied, 0,00123769 s, 421 kB/s

$ dd if=/proc/keys bsP0 skip=1  # read after lseek in middle of last line
dd: /proc/keys: cannot skip to specified offset
g   _uid_ses.1000: 1        <<<< end of last line
3ead4096 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1   <<<< and whole last lien again
0+1 records in
0+1 records out
97 bytes copied, 0,000135035 s, 718 kB/s

$ dd if=/proc/keys bs00 skip=1   # read after lseek beyond end of file
dd: /proc/keys: cannot skip to specified offset
3ead4096 I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1   <<<< generates last line
0+1 records in
0+1 records out
76 bytes copied, 0,000119981 s, 633 kB/s

On patched kernel:
[test@localhost ~]$ uname -a
Linux localhost.localdomain 5.5.0-rc6-00151-gd8d014f #8 SMP Fri Jan 24 13:25:06 MSK 2020 x86_64 x86_64 x86_64 GNU/Linux

[test@localhost ~]$ dd if=/proc/keys bs=1
06e8bec5 I--Q---     4 perm 1f3f0000  1000 65534 keyring   _uid.1000: empty
1b7ee8ed I--Q---    11 perm 3f030000  1000  1000 keyring   _ses: 1
2c1a365d I--Q---     1 perm 1f3f0000  1000 65534 keyring   _uid_ses.1000: 1
3f5823b4 I--Q---     6 perm 3f030000  1000  1000 keyring   _ses: 1
286+0 records in
286+0 records out
286 bytes copied, 0,000414581 s, 690 kB/s

[test@localhost ~]$ dd if=/proc/keys bs'0 skip=1  # VvS: read after lseek in middle of last line
dd: /proc/keys: cannot skip to specified offset
yring   _ses: 1   <<<< only end of last line was generated, as expected
0+1 records in
0+1 records out
16 bytes copied, 7,7199e-05 s, 207 kB/s

[test@localhost ~]$ dd if=/proc/keys bs00 skip=1   # VvS: read after lseek beond end of file
dd: /proc/keys: cannot skip to specified offset
0+0 records in   <<<< nothing was generated, as expected
0+0 records out
0 bytes copied, 8,8036e-05 s, 0,0 kB/s
