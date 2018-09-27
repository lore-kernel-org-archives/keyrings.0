From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 13:14:45 +0000
Subject: [PATCH 0/5] keys: const-ification and other fixes
Message-Id: <20180927131450.23458-1-mathstuf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

The main patch is #4, but these are all things I found while using the
code and documentation to make Rust wrappers for `libkeyutils` with
stronger typing.

If it is preferred that these be split up, let me know.

--Ben

Ben Boeckel (5):
  docs: fix prototype for `request_key`
  docs: clarify `keyctl ... trusted` commands
  rxrpc: mention that client key payloads are not arbitrary
  keyctl.h: update pointer types
  dns_key: add a function to verify the key description

 Documentation/security/keys/core.rst          |  2 +-
 .../security/keys/trusted-encrypted.rst       | 20 ++++-----
 include/uapi/linux/keyctl.h                   |  4 +-
 net/dns_resolver/dns_key.c                    | 44 +++++++++++++++----
 net/rxrpc/key.c                               |  4 +-
 5 files changed, 50 insertions(+), 24 deletions(-)

-- 
2.17.1
