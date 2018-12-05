From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 05:32:39 +0000
Subject: Re: [RFC v2 13/13] keys/mktme: Support CPU Hotplug for MKTME keys
Message-Id: <20181205053239.GC18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
 <20181204092841.GU11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181204092841.GU11614@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 10:28:41AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:40:00PM -0800, Alison Schofield wrote:
> > +	for_each_online_cpu(online_cpu)
> > +		if (online_cpu != cpu &&
> > +		    pkgid = topology_physical_package_id(online_cpu)) {
> > +			cpumask_set_cpu(online_cpu, mktme_leadcpus);
> > +			break;
> > +	}
> 
> That's a capital offence right there.
Got it!
