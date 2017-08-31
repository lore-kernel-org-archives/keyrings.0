From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Thu, 31 Aug 2017 15:58:16 +0000
Subject: [RFC PATCH 0/5] keyctl.2 updates
Message-Id: <20170831155816.GA606@asgard.redhat.com>
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

Eugene Syromyatnikov (5):
  keyctl.2: change "is" to "was" in error descriptions
  keyctl.2: update kernel documentation path reference
  keyrings.7: add pointers to kernel's documentation
  keyctl.2: document the ability to provide KDF parameters in
    KEYCTL_DH_COMPUTE
  keyctl.2: document KEYCTL_RESTRICT_KEYRING operation

 man2/keyctl.2   | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 man7/keyrings.7 |   5 ++
 2 files changed, 209 insertions(+), 12 deletions(-)

-- 
2.1.4

