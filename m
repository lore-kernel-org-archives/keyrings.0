From: Ben Boeckel <me@benboeckel.net>
Date: Sat, 16 May 2020 00:39:16 +0000
Subject: [PATCH 0/1] Document keyctl(KEYCTL_PKEY_QUERY) arguments correctly
Message-Id: <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

This is the way the code parses the arguments and libkeyutils calls the
syscall.

Note on the email split: I'm still in the process of migrating emails
for various usages hence the email From mismatch here (I've migrated my
list subscription, but not my general contribution email).

Ben Boeckel (1):
  Documentation: security: core.rst: add missing argument

 Documentation/security/keys/core.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 12bf0b632ed090358cbf03e323e5342212d0b2e4
-- 
2.25.4
