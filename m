From: David Howells <dhowells@redhat.com>
Date: Fri, 05 Jul 2019 21:30:39 +0000
Subject: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
Message-Id: <28477.1562362239@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, jmorris@namei.org, keyrings@vger.kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Here's my fourth block of keyrings changes for the next merge window.  They
change the permissions model used by keys and keyrings to be based on an
internal ACL by the following means:

 (1) Replace the permissions mask internally with an ACL that contains a
     list of ACEs, each with a specific subject with a permissions mask.
     Potted default ACLs are available for new keys and keyrings.

     ACE subjects can be macroised to indicate the UID and GID specified on
     the key (which remain).  Future commits will be able to add additional
     subject types, such as specific UIDs or domain tags/namespaces.

     Also split a number of permissions to give finer control.  Examples
     include splitting the revocation permit from the change-attributes
     permit, thereby allowing someone to be granted permission to revoke a
     key without allowing them to change the owner; also the ability to
     join a keyring is split from the ability to link to it, thereby
     stopping a process accessing a keyring by joining it and thus
     acquiring use of possessor permits.

 (2) Provide a keyctl to allow the granting or denial of one or more
     permits to a specific subject.  Direct access to the ACL is not
     granted, and the ACL cannot be viewed.

David
---
The following changes since commit a58946c158a040068e7c94dc1d58bbd273258068:

  keys: Pass the network namespace into request_key mechanism (2019-06-27 23:02:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-acl-20190703

for you to fetch changes up to 7a1ade847596dadc94b37e49f8c03f167fd71748:

  keys: Provide KEYCTL_GRANT_PERMISSION (2019-07-03 13:05:22 +0100)

----------------------------------------------------------------
Keyrings ACL

----------------------------------------------------------------
David Howells (2):
      keys: Replace uid/gid/perm permissions checking with an ACL
      keys: Provide KEYCTL_GRANT_PERMISSION

 Documentation/security/keys/core.rst               | 128 ++++++--
 Documentation/security/keys/request-key.rst        |   9 +-
 certs/blacklist.c                                  |   7 +-
 certs/system_keyring.c                             |  12 +-
 drivers/md/dm-crypt.c                              |   2 +-
 drivers/nvdimm/security.c                          |   2 +-
 fs/afs/security.c                                  |   2 +-
 fs/cifs/cifs_spnego.c                              |  25 +-
 fs/cifs/cifsacl.c                                  |  28 +-
 fs/cifs/connect.c                                  |   4 +-
 fs/crypto/keyinfo.c                                |   2 +-
 fs/ecryptfs/ecryptfs_kernel.h                      |   2 +-
 fs/ecryptfs/keystore.c                             |   2 +-
 fs/fscache/object-list.c                           |   2 +-
 fs/nfs/nfs4idmap.c                                 |  30 +-
 fs/ubifs/auth.c                                    |   2 +-
 include/linux/key.h                                | 121 +++----
 include/uapi/linux/keyctl.h                        |  65 ++++
 lib/digsig.c                                       |   2 +-
 net/ceph/ceph_common.c                             |   2 +-
 net/dns_resolver/dns_key.c                         |  12 +-
 net/dns_resolver/dns_query.c                       |  15 +-
 net/rxrpc/key.c                                    |  19 +-
 net/wireless/reg.c                                 |   6 +-
 security/integrity/digsig.c                        |  31 +-
 security/integrity/digsig_asymmetric.c             |   2 +-
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/ima/ima_mok.c                   |  13 +-
 security/integrity/integrity.h                     |   6 +-
 .../integrity/platform_certs/platform_keyring.c    |  14 +-
 security/keys/compat.c                             |   2 +
 security/keys/encrypted-keys/encrypted.c           |   2 +-
 security/keys/encrypted-keys/masterkey_trusted.c   |   2 +-
 security/keys/gc.c                                 |   2 +-
 security/keys/internal.h                           |  16 +-
 security/keys/key.c                                |  29 +-
 security/keys/keyctl.c                             | 104 ++++--
 security/keys/keyring.c                            |  27 +-
 security/keys/permission.c                         | 361 +++++++++++++++++++--
 security/keys/persistent.c                         |  27 +-
 security/keys/proc.c                               |  22 +-
 security/keys/process_keys.c                       |  86 +++--
 security/keys/request_key.c                        |  34 +-
 security/keys/request_key_auth.c                   |  15 +-
 security/selinux/hooks.c                           |  16 +-
 security/smack/smack_lsm.c                         |   3 +-
 46 files changed, 992 insertions(+), 325 deletions(-)
