From: CrazyT <crazyt2019+lml@gmail.com>
Date: Thu, 27 Jun 2019 16:59:13 +0000
Subject: Problem with the kernels trusted module on "inactive" TPM
Message-Id: <CACnrVGfhkpsSWbCai4+5WEOhRukEr7JWDUnFdM-5D+FUyov+nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi,


some people (including me) have problems with the "trusted" kernel module.
As a result to this also the ecryptfs-module won't load.
(https://bugs.archlinux.org/task/62678)
If you use an "inactive" TPM module, the "trusted" module won't load anymore.
The command modprobe just responds with "Bad address".
The strace-command shows that init_module fails with EFAULT.
I believe the reason for this is that the trusted-module handles
inactive modules the same as active modules.
This results in an error.

For example:
https://github.com/torvalds/linux/commit/0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400#diff-c01228e6d386afb29df6aac17d9dd7abR1251

My guess is that init_digests(); returns EFAULT in that case.
The " if (!chip)" check above probably needs to check if the chip is "inactive".

"inactive" = still visible to the system, but not functional.
It seems to be the default bios-setting for TPM on thinkpad.
(btw.: i have no clue why anybody would need something like that)

Sadly i have no idea how you would check for an inactive chip,else i
would have send a patch instead.
But I hope the info i wrote is enough to get it fixed by somebody.


Greetings,

CrazyT
