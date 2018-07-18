From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Jul 2018 11:17:19 +0000
Subject: Re: [PATCH v5 05/12] keys: add call key_put_sync() to flush key_gc_work when doing a key_put().
Message-Id: <9635.1531912639@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <5959.1531910449@warthog.procyon.org.uk>
 <153186087257.27463.13382652631526471099.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <5959.1531910449@warthog.procyon.org.uk>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, dhowells@redhat.com, keyrings@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> A better way might be to add a global waitqueue and then use that to watch for
> an indication that a key is about to be finally destroyed.  A flag can be set
> on the key to ask for the waitqueue to be poked

Hmmm...  This wouldn't work unless you added yourself to the waitqueue before
decrementing the key usage count:-/

In fact, if someone creates a link to your key, sync'ing the gc isn't
sufficient.

David
