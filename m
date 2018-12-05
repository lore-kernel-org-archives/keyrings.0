From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 17:26:37 +0000
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a system wide basis
Message-Id: <20181205172637.GA443@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
 <20181205054353.GE18596@alison-desk.jf.intel.com>
 <20181205091029.GB4234@hirez.programming.kicks-ass.net>
In-Reply-To: <20181205091029.GB4234@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Wed, Dec 05, 2018 at 10:10:29AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 04, 2018 at 09:43:53PM -0800, Alison Schofield wrote:
> > On Tue, Dec 04, 2018 at 10:21:45AM +0100, Peter Zijlstra wrote:
> > > On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> > 
> > > How is that serialized and kept relevant in the face of hotplug?
> > mktme_leadcpus is updated on hotplug startup and teardowns.
> 
> Not in this patch it is not. That is added in a subsequent patch, which
> means that during bisection hotplug is utterly wrecked if you happen to
> land between these patches, that is bad.
>
The Key Service support is split between 4 main patches (10-13), but
the dependencies go further back in the patchset.

If the bisect need outweighs any benefit from reviewing in pieces,
then these patches can be squashed to a single patch:

keys/mktme: Add the MKTME Key Service type for memory encryption
keys/mktme: Program memory encryption keys on a system wide basis
keys/mktme: Save MKTME data if kernel cmdline parameter allows
keys/mktme: Support CPU Hotplug for MKTME keys

Am I interpreting your point correctly?
Thanks,
Alison
