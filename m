From: David Howells <dhowells@redhat.com>
Date: Wed, 20 Feb 2019 18:07:22 +0000
Subject: Re: [RFC PATCH v3 00/18] fscrypt: key management improvements
Message-Id: <14023.1550686042@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190220065249.32099-1-ebiggers@kernel.org>
In-Reply-To: <20190220065249.32099-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, dhowells@redhat.com, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>, Paul Crowley <paulcrowley@google.com>

I have a couple of patches that add ACLs to keyrings, that you can find at =
the
top of the branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dkeys-acl

I have other patches that allow tags to be used as subjects in the ACL, wit=
h a
container supplying a tag, e.g.:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/comm=
it/?h=3Dcontainer&id=E0fdc5613a32b9475b025f58e7a2267329b3f3a4

Might something similar be of use to you here, perhaps specifying a tag
referring to the blockdev of interest rather than the container?

David
