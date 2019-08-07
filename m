From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 07 Aug 2019 02:58:14 +0000
Subject: Re: [PATCH 1/2] KEYS: Replace uid/gid/perm permissions checking with an ACL
Message-Id: <20190807025814.GA1167@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
 <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
 <20190710011559.GA7973@sol.localdomain>
 <20190730034956.GB1966@sol.localdomain>
 <20190731011614.GA687@sol.localdomain>
In-Reply-To: <20190731011614.GA687@sol.localdomain>
To: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:16:14PM -0700, Eric Biggers wrote:
> On Mon, Jul 29, 2019 at 08:49:56PM -0700, Eric Biggers wrote:
> > Hi David,
> > 
> > On Tue, Jul 09, 2019 at 06:16:01PM -0700, Eric Biggers wrote:
> > > On Thu, May 23, 2019 at 04:58:27PM +0100, David Howells wrote:
> > > > Replace the uid/gid/perm permissions checking on a key with an ACL to allow
> > > > the SETATTR and SEARCH permissions to be split.  This will also allow a
> > > > greater range of subjects to represented.
> > > > 
> > > 
> > > This patch broke 'keyctl new_session', and hence broke all the fscrypt tests:
> > > 
> > > $ keyctl new_session
> > > keyctl_session_to_parent: Permission denied
> > > 
> > > Output of 'keyctl show' is
> > > 
> > > $ keyctl show
> > > Session Keyring
> > >  605894913 --alswrv      0     0  keyring: _ses
> > >  189223103 ----s-rv      0     0   \_ user: invocation_id
> > > 
> > > - Eric
> > 
> > This bug is still present in next-20190729.
> > 
> > - Eric
> 
> This fixes it:
> 
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index aa3bfcadbc660..519c94f1cc3c2 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -58,7 +58,7 @@ static struct key_acl session_keyring_acl = {
>  	.possessor_viewable = true,
>  	.nr_ace	= 2,
>  	.aces = {
> -		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~KEY_ACE_JOIN),
> +		KEY_POSSESSOR_ACE(KEY_ACE__PERMS),
>  		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
>  	}
>  };
> 
> 
> The old permissions were KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ, so
> I'm not sure why JOIN permission was removed?
> 
> - Eric

Ping.  This is still broken in linux-next.

- Eric
