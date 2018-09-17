From: "Huang, Kai" <kai.huang@intel.com>
Date: Mon, 17 Sep 2018 10:48:33 +0000
Subject: RE: [RFC 11/12] keys/mktme: Add a new key service type for memory encryption keys
Message-Id: <105F7BF4D0229846AF094488D65A098935432E09@PGSMSX112.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1536356108.git.alison.schofield@intel.com>
 <1a14a6feb02f968c5e6b98360f6f16106b633b58.1536356108.git.alison.schofield@intel.com>
 <105F7BF4D0229846AF094488D65A098935424C2D@PGSMSX112.gar.corp.intel.com>
 <20180915000639.GA28666@alison-desk.jf.intel.com>
In-Reply-To: <20180915000639.GA28666@alison-desk.jf.intel.com>
To: "Schofield, Alison" <alison.schofield@intel.com>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Nakajima, Jun" <jun.nakajima@intel.com>, "Shutemov,
 Kirill" <kirill.shutemov@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, "jmorris@namei.org" <jmorris@namei.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>

> -----Original Message-----
> From: Schofield, Alison
> Sent: Saturday, September 15, 2018 12:07 PM
> To: Huang, Kai <kai.huang@intel.com>
> Cc: dhowells@redhat.com; tglx@linutronix.de; Nakajima, Jun
> <jun.nakajima@intel.com>; Shutemov, Kirill <kirill.shutemov@intel.com>;
> Hansen, Dave <dave.hansen@intel.com>; Sakkinen, Jarkko
> <jarkko.sakkinen@intel.com>; jmorris@namei.org; keyrings@vger.kernel.org;
> linux-security-module@vger.kernel.org; mingo@redhat.com; hpa@zytor.com;
> x86@kernel.org; linux-mm@kvack.org
> Subject: Re: [RFC 11/12] keys/mktme: Add a new key service type for memory
> encryption keys
> 
> On Sun, Sep 09, 2018 at 08:29:29PM -0700, Huang, Kai wrote:
> > > + */
> > > +static int mktme_build_cpumask(void) {
> > > +	int online_cpu, mktme_cpu;
> > > +	int online_pkgid, mktme_pkgid = -1;
> > > +
> > > +	if (!zalloc_cpumask_var(&mktme_cpumask, GFP_KERNEL))
> > > +		return -ENOMEM;
> > > +
> > > +	for_each_online_cpu(online_cpu) {
> > > +		online_pkgid = topology_physical_package_id(online_cpu);
> > > +
> > > +		for_each_cpu(mktme_cpu, mktme_cpumask) {
> > > +			mktme_pkgid > > > topology_physical_package_id(mktme_cpu);
> > > +			if (mktme_pkgid = online_pkgid)
> > > +				break;
> > > +		}
> > > +		if (mktme_pkgid != online_pkgid)
> > > +			cpumask_set_cpu(online_cpu, mktme_cpumask);
> > > +	}
> >
> > Could we use 'for_each_online_node', 'cpumask_first/next', etc to simplify the
> logic?
> 
> Kai,
> 
> I tried to simplify it and came up with code that looked like this:
> 
> 	int lead_cpu, node;
> 	for_each_online_node(node) {
> 		lead_cpu = cpumask_first(cpumask_of_node(node));
> 		if (lead_cpu < nr_cpu_ids)
> 			cpumask_set_cpu(lead_cpu, mktme_cpumask_NEW);
> 	}
> When I test it on an SNC (Sub Numa Cluster) system it gives me too many CPU's.
> I get a CPU per Node (just like i asked for;) instead of per Socket.
> It has 2 sockets and 4 NUMA nodes.
> 
> I kind of remember this when I originally coded it, hence the bottoms up
> approach using topology_physical_package_id()
> 
> Any ideas?

Hmm.. I forgot the SNC case, sorry :(

So in case of SNC, is PCONFIG per-package, or per-node? I am not quite sure about this.

If PCONFIG is per-package, I don't have better idea than your original one. :)

Thanks,
-Kai
> 
> Alison
> 
