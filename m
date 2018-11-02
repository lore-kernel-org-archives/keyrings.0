From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 14:10:18 +0000
Subject: Re: [PATCH 2/2] conf: add upcall line for nvdimm in request-key.conf
Message-Id: <8218.1541167818@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> Add support for nvdimm key management.

I'm not going to apply this as you said you could make your change to the
nvdimm package.  You will need to have a dependency there on keyutils-1.5.12.

David
