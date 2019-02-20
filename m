From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 20 Feb 2019 18:36:20 +0000
Subject: Re: [RFC PATCH v3 00/18] fscrypt: key management improvements
Message-Id: <20190220183619.GA177939@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190220065249.32099-1-ebiggers@kernel.org>
 <14023.1550686042@warthog.procyon.org.uk>
In-Reply-To: <14023.1550686042@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>, Paul Crowley <paulcrowley@google.com>

Hi David,

On Wed, Feb 20, 2019 at 06:07:22PM +0000, David Howells wrote:
> I have a couple of patches that add ACLs to keyrings, that you can find a=
t the
> top of the branch here:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dkeys-acl
>=20
> I have other patches that allow tags to be used as subjects in the ACL, w=
ith a
> container supplying a tag, e.g.:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/co=
mmit/?h=3Dcontainer&id=E0fdc5613a32b9475b025f58e7a2267329b3f3a4
>=20
> Might something similar be of use to you here, perhaps specifying a tag
> referring to the blockdev of interest rather than the container?
>=20
> David

I don't think so.  The main point of adding keys directly to the filesystem=
 is
that it's generally inappropriate to apply OS-level access control or
process-based visibility restrictions to fscrypt keys given that:

- The unlocked/locked status of files is already filesystem-level.
- The purpose of encryption is orthogonal to OS-level access control.

The ioctl based interface also makes it *much* easier to implement all the
semantics needed for removing fscrypt keys.

I don't see how key ACLs would be appropriate here, except that key ACLs wo=
uld
allow userspace to opt-in to fixing the denial of service vulnerability whe=
re
keyctl_invalidate() only requires Search permission.  But for fscrypt that's
addressed by my proposal too, and is just one of many problems it addresses.

- Eric
