From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Sat, 02 Sep 2017 04:39:58 +0000
Subject: [PATCH v2 0/6] keyctl.2 updates
Message-Id: <20170902043958.GA27412@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mat Martineau <mathew.j.martineau-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephan Mueller <smueller-T9tCv8IpfcWELgA04lAiVw@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

While trying to add support for the new keyctl features (ability to
provide KDF and ability to restrict addition to the keyring) decoding
to strace, I've noticed that these are not documented, so here is
my initial attempt to document these things. Unfortunately, keys/crypto
infrastructure is quite foreign to me, so these patches definitely need
some improvement.

For the one part is definitely omitted yet is the documentation for the
"asymmetric" key type, which should be a part of keyrings.7, I think.

Thanks for all the feedback regarding the original version, I've tried to
incorporate it in this version of the patchset.

Changes since v1:
 * Added additional information about causes of EAGAIN, ENOENT, and
   ETIMEDOUT for the KEYCTL_DH_COMPUTE operation.
 * Information about internal limit on hashname moved to the description
   of yet another cause of EINVAL for the KEYCTL_DH_COMPUTE.
 * The description of possible restriction specification for asymmetric
   key type has been corrected.
 * Added information about causes of ENOENT and EOPNOTSUPP for the
   KEYCTL_RESTRICT_KEYRING operation.
 * Added wildcard mention of the ENOMEM error code.

Eugene Syromyatnikov (6):
  keyctl.2: change "is" to "was" in error descriptions
  keyctl.2: update kernel documentation path reference
  keyrings.7: add pointers to kernel's documentation
  keyctl.2: document the ability to provide KDF parameters in
    KEYCTL_DH_COMPUTE
  keyctl.2: document KEYCTL_RESTRICT_KEYRING operation
  keyctl.2: mention ENOMEM in ERRORS

 man2/keyctl.2   | 289 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 man7/keyrings.7 |   5 +
 2 files changed, 282 insertions(+), 12 deletions(-)

-- 
2.1.4

