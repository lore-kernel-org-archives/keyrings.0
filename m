From: David Howells <dhowells@redhat.com>
Date: Thu, 30 Jul 2020 17:19:36 +0000
Subject: Re: [PATCH] watch_queue: Limit the number of watches a user can hold
Message-Id: <521562.1596129576@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <439876.1596106009@warthog.procyon.org.uk> <159562904644.2287160.13294507067766261970.stgit@warthog.procyon.org.uk>
In-Reply-To: <439876.1596106009@warthog.procyon.org.uk>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Could you consider taking this patch as a bugfix since the problem exists
> already in upstream code?

Alternatively, I can include it in a set with the mount notifications.

David
