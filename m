From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 09 Jul 2019 20:42:25 +0000
Subject: Re: [PATCH 2/2] KEYS: Provide KEYCTL_GRANT_PERMISSION
Message-Id: <20190709204225.GM641@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862712317.24863.13455329541359881229.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862712317.24863.13455329541359881229.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 04:58:43PM +0100, David Howells wrote:
> Provide a keyctl() operation to grant/remove permissions.  The grant
> operation, wrapped by libkeyutils, looks like:
> 
> 	int ret = keyctl_grant_permission(key_serial_t key,
> 					  enum key_ace_subject_type type,
> 					  unsigned int subject,
> 					  unsigned int perm);
> 
> Where key is the key to be modified, type and subject represent the subject
> to which permission is to be granted (or removed) and perm is the set of
> permissions to be granted.  0 is returned on success.  SET_SECURITY
> permission is required for this.
> 
> The subject type currently must be KEY_ACE_SUBJ_STANDARD for the moment
> (other subject types will come along later).
> 
> For subject type KEY_ACE_SUBJ_STANDARD, the following subject values are
> available:
> 
> 	KEY_ACE_POSSESSOR	The possessor of the key
> 	KEY_ACE_OWNER		The owner of the key
> 	KEY_ACE_GROUP		The key's group
> 	KEY_ACE_EVERYONE	Everyone
> 
> perm lists the permissions to be granted:
> 
> 	KEY_ACE_VIEW		Can view the key metadata
> 	KEY_ACE_READ		Can read the key content
> 	KEY_ACE_WRITE		Can update/modify the key content
> 	KEY_ACE_SEARCH		Can find the key by searching/requesting
> 	KEY_ACE_LINK		Can make a link to the key
> 	KEY_ACE_SET_SECURITY	Can set security
> 	KEY_ACE_INVAL		Can invalidate
> 	KEY_ACE_REVOKE		Can revoke
> 	KEY_ACE_JOIN		Can join this keyring
> 	KEY_ACE_CLEAR		Can clear this keyring
> 
> If an ACE already exists for the subject, then the permissions mask will be
> overwritten; if perm is 0, it will be deleted.
> 
> Currently, the internal ACL is limited to a maximum of 16 entries.
> 
> For example:
> 
> 	int ret = keyctl_grant_permission(key,
> 					  KEY_ACE_SUBJ_STANDARD,
> 					  KEY_ACE_OWNER,
> 					  KEY_ACE_VIEW | KEY_ACE_READ);
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Where is the documentation and tests for this?  I want to add syzkaller
definitions for this, but there is no documentation (a commit message doesn't
count).  I checked the 'next' branch of keyutils as well.

How is anyone supposed to use this if there is no documentation?

- Eric
