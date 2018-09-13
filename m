From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 16:08:54 +0000
Subject: [PATCH 0/6] afs: DNS and VL server handling improvements
Message-Id: <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Al,

Here's a set of patches that improves Volume Location server handling in
the AFS filesystem and improves the DNS resolver code to allow server lists
(with addresses, priorities and weights for each server).

The highlights of this patchset are:

 (1) Permit a binary blob to be attached to be attached to a dns_resolver
     type key in lieu of a text one.  The first byte of the payload must be
     0 to cause existing text parsers to error out with EINVAL.  However,
     the "server list" feature must be requested by putting "srv=3D1" into
     the callout info, which is passed to the upcall.

 (2) Clean up the address list handling in AFS.

 (3) Introduce a 'VL server list' concept in AFS with rotation, analogous
     to the fileserver list and rotation.  For the moment VL server
     rotation takes a simple round-robin approach and pays no attention to
     the priority and weight assigned to each server.

The patches will work as-is with the current keyutils package as the
"srv=3D1" option will just be ignored and a text list of addresses will be
used to instantiate the key.  The modified AFS code still handles this.

To make the server list feature work properly, the keyutils package will
need updating to 1.5.12, the proposed commits for which can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/=
?h=3Dnext

that will allow the program run by request-key to be overridden for
"afsdb:" dns_resolver keys by the kafs-client program.  The kafs-client
program changes to make server list resolving work can be found here:

	http://git.infradead.org/users/dhowells/kafs-client.git/shortlog/refs/head=
s/next

along with code to allow static configuration to be used instead.


The kernel patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=
=AFs-dns

David
---
David Howells (6):
      dns: Allow the dns resolver to retrieve a server set
      afs: Do better max capacity handling on address lists
      afs: afs_end_vnode_operation() needs to translate abort codes to erro=
rs
      afs: Differentiate VL servers
      afs: Always build address lists using the helper functions
      afs: Sort address lists so that they are in logical ascending order


 fs/afs/Makefile              |    2=20
 fs/afs/addr_list.c           |  209 ++++++++++++++----------------
 fs/afs/cell.c                |   39 +++---
 fs/afs/dynroot.c             |    2=20
 fs/afs/internal.h            |  114 ++++++++++++++---
 fs/afs/proc.c                |   44 +++---
 fs/afs/rotate.c              |    6 -
 fs/afs/server.c              |   42 ++----
 fs/afs/vl_list.c             |  289 ++++++++++++++++++++++++++++++++++++++=
++++
 fs/afs/vl_rotate.c           |  239 +++++++++++++++++++++++++++++++++++
 fs/afs/vlclient.c            |   32 ++---
 fs/afs/volume.c              |   52 ++------
 net/dns_resolver/dns_key.c   |   61 ++++++++-
 net/dns_resolver/dns_query.c |    5 -
 14 files changed, 866 insertions(+), 270 deletions(-)
 create mode 100644 fs/afs/vl_list.c
 create mode 100644 fs/afs/vl_rotate.c
