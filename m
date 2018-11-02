From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 14:09:34 +0000
Subject: Re: [PATCH 1/2] keyutils: Add pkg-config file for keyutils library
Message-Id: <8176.1541167774@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936768778.53805.17270502000080117870.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936768778.53805.17270502000080117870.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> This is needed so that other projects can add a dependency on libkeyutils
> via PKG_CHECK_MODULES([KEYUTILS], [keyutils]).  This enabling makes 'make
> install' do the right thing, and of course individual distros will need to
> add enabling to their associated packages (rpm, deb, etc.) so the package
> manager installs do the right thing.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Just to note that this doesn't apply.  Also, I suspect it needs a build-time
and/or install-time dependency in the spec file.

David
