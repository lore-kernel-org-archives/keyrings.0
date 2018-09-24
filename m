From: Ben Boeckel <mathstuf@gmail.com>
Date: Mon, 24 Sep 2018 13:01:55 +0000
Subject: [PATCH 0/4] keyctl_dh_compute_kdf touchups
Message-Id: <20180924130159.5299-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

As requested. Feel free to squash if that is preferred.

--Ben

Ben Boeckel (4):
  keyctl: fix error path message names
  man/keyctl_dh_compute: mention /proc/crypto for hashnames
  man/keyctl_dh_compute: clarify keyctl_dh_compute_kdf
  keyctl_dh_compute_kdf: const-ify input parameters

 keyctl.c                |  4 ++--
 keyutils.c              |  5 +++--
 keyutils.h              |  4 ++--
 man/keyctl_dh_compute.3 | 20 ++++++++++++++------
 4 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.17.1
