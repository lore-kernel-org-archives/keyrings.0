From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 10 Jul 2019 01:15:59 +0000
Subject: Re: [PATCH 1/2] KEYS: Replace uid/gid/perm permissions checking with an ACL
Message-Id: <20190710011559.GA7973@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 04:58:27PM +0100, David Howells wrote:
> Replace the uid/gid/perm permissions checking on a key with an ACL to allow
> the SETATTR and SEARCH permissions to be split.  This will also allow a
> greater range of subjects to represented.
> 

This patch broke 'keyctl new_session', and hence broke all the fscrypt tests:

$ keyctl new_session
keyctl_session_to_parent: Permission denied

Output of 'keyctl show' is

$ keyctl show
Session Keyring
 605894913 --alswrv      0     0  keyring: _ses
 189223103 ----s-rv      0     0   \_ user: invocation_id

- Eric
