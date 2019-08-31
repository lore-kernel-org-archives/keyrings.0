From: Yihao Wu <wuyihao@linux.alibaba.com>
Date: Sat, 31 Aug 2019 08:20:04 +0000
Subject: [PATCH 0/2] Detect and overwrite existing signature
Message-Id: <fbc3db40-9633-9c20-1ef6-ec8cbb514e01@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Currently, sign-file directly signs on a kernel module without checking
if there's already one signature. This patch set makes sign-file aware
of the existing signature. And it allows the user to cope with it. 

Yihao Wu (2):
  sign-file: introduce check_module_sig
  sign-file: detect existing signature and handle it

 scripts/sign-file.c | 118 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 10 deletions(-)

--
2.21.0
