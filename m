From: Denis Kenzior <denkenz@gmail.com>
Date: Mon, 20 Aug 2018 21:52:24 +0000
Subject: [PATCH 0/2] keys-asym-keyctl: Trivial fixes
Message-Id: <20180820215226.20661-1-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Here are a couple of trivial fixes against the keys-asym-keyctl tree.
These can probably be squashed into the relevant commits.

Denis Kenzior (2):
  asym_tpm: Fix tpm_flushspecific return value
  public_key: Don't erroneously call akcipher_verify

 crypto/asymmetric_keys/asym_tpm.c   | 2 +-
 crypto/asymmetric_keys/public_key.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.16.1
