From: David Howells <dhowells@redhat.com>
Date: Thu, 07 Nov 2019 17:16:09 +0000
Subject: Re: [RFC PATCH 05/14] pipe: Add general notification queue support [ver #2]
Message-Id: <28293.1573146969@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk> <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313376558.29677.12389078014886241663.stgit@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Sigh.  I forgot to build it with the new config options disabled.  I've fixed
that up and pushed it to the git tree.

David
