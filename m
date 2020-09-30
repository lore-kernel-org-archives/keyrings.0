From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Wed, 30 Sep 2020 20:15:06 +0000
Subject: [PATCH 0/2] Preloaded revocation keys
Message-Id: <20200930201508.35113-1-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, dwmw2@infradead.org
Cc: masahiroy@kernel.org, michal.lkml@markovi.net, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, jarkko.sakkinen@linux.intel.com, eric.snowberg@oracle.com

The Secure Boot Forbidden Signature Database, dbx, contains a list of
now revoked signatures and keys previously approved to boot with UEFI
Secure Boot enabled.  Currently EFI_CERT_X509_SHA256_GUID and
EFI_CERT_SHA256_GUID can be preloaded (at build time) into the system
blacklist keyring.

Add the ability to also preload EFI_CERT_X509_GUID dbx entries.

This series can be applied on its own; however to use preloaded
revocation certificates, [1] should be applied first.

[1] https://www.spinics.net/lists/keyrings/msg08422.html


Eric Snowberg (2):
  certs: Move load_system_certificate_list to a common function
  certs: Add ability to preload revocation certs

 certs/Kconfig                   |  8 +++++
 certs/Makefile                  | 20 ++++++++++--
 certs/blacklist.c               | 17 ++++++++++
 certs/common.c                  | 56 +++++++++++++++++++++++++++++++++
 certs/common.h                  |  9 ++++++
 certs/revocation_certificates.S | 21 +++++++++++++
 certs/system_keyring.c          | 49 ++---------------------------
 scripts/Makefile                |  1 +
 8 files changed, 132 insertions(+), 49 deletions(-)
 create mode 100644 certs/common.c
 create mode 100644 certs/common.h
 create mode 100644 certs/revocation_certificates.S


base-commit: 02de58b24d2e1b2cf947d57205bd2221d897193c
-- 
2.18.1
