From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 05:43:53 +0000
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a system wide basis
Message-Id: <20181205054353.GE18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181204092145.GR11614@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 10:21:45AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> 
> > +static int mktme_build_leadcpus_mask(void)
> > +{
> > +	int online_cpu, mktme_cpu;
> > +	int online_pkgid, mktme_pkgid = -1;
> > +
> > +	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	for_each_online_cpu(online_cpu) {
> > +		online_pkgid = topology_physical_package_id(online_cpu);
> > +
> > +		for_each_cpu(mktme_cpu, mktme_leadcpus) {
> > +			mktme_pkgid = topology_physical_package_id(mktme_cpu);
> > +			if (mktme_pkgid = online_pkgid)
> > +				break;
> > +		}
> > +		if (mktme_pkgid != online_pkgid)
> > +			cpumask_set_cpu(online_cpu, mktme_leadcpus);
> 
> Do you really need LOCK prefixed bit set here?
No. Changed to __cpumask_set_cpu(). Will check for other instances
where I can skip LOCK prefix.

> How is that serialized and kept relevant in the face of hotplug?
mktme_leadcpus is updated on hotplug startup and teardowns.

> Also, do you really need O(n^2) to find the first occurence of a value
> in an array?
How about this O(n)?
	
	unsigned long *pkg_map;
	int cpu, pkgid;

	if (!zalloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
		return -ENOMEM;

	pkg_map = bitmap_zalloc(topology_max_packages(), GFP_KERNEL);
	if (!pkg_map) {
		free_cpumask_var(mktme_leadcpus);
		return -ENOMEM;
	}
	for_each_online_cpu(cpu) {
		pkgid = topology_physical_package_id(cpu);
		if (!test_and_set_bit(pkgid, pkg_map))
			__cpumask_set_cpu(cpu, mktme_leadcpus);
	}
