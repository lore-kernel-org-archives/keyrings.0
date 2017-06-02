From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Jun 2017 15:58:22 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <1638.1496419102@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170511003557.3467-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170511003557.3467-1-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> The initial Diffie-Hellman computation made direct use of the MPI
> library because the crypto module did not support DH at the time. Now
> that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
> duplicate code and leverage possible hardware acceleration.

This doesn't apply to linus/master.  I've pushed the keyrings fix patches I
have, including a bunch from Eric Biggers that fix DH stuff, to:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

branch:

	keys-fixes

though I think there may be a couple of bugs in on of Eric's patches where
he's assumed that he can do:

	memzero_explicit(NULL, 0);

I'm not sure whether it's permissible to assume that memset(NULL, 0, 0) is
guaranteed to work correctly.

Note that I haven't included Eric's DH patch that was obsoleted by Stephan's
patch that was obsoleted by this one.

David
