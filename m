From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 05:36:15 +0000
Subject: Re: [RFC v2 13/13] keys/mktme: Support CPU Hotplug for MKTME keys
Message-Id: <20181205053615.GD18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c14d24b09ee2ae37ea4106726ce8fe2aea31f6c7.1543903910.git.alison.schofield@intel.com>
 <20181204093116.GV11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181204093116.GV11614@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 10:31:16AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:40:00PM -0800, Alison Schofield wrote:
> >  static int mktme_program_system(struct mktme_key_program *key_program,
> > -				cpumask_var_t mktme_cpumask)
> > +				cpumask_var_t mktme_cpumask, int hotplug)
> >  {
> >  	struct mktme_hw_program_info info = {
> >  		.key_program = key_program,
> >  		.status = MKTME_PROG_SUCCESS,
> >  	};
> > -	get_online_cpus();
> > -	on_each_cpu_mask(mktme_cpumask, mktme_program_package, &info, 1);
> > -	put_online_cpus();
> > +
> > +	if (!hotplug) {
> > +		get_online_cpus();
> > +		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
> > +				 &info, 1);
> > +		put_online_cpus();
> > +	} else {
> > +		on_each_cpu_mask(mktme_cpumask, mktme_program_package,
> > +				 &info, 1);
> > +	}
> >  
> >  	return info.status;
> >  }
> 
> That is pretty horrible; and I think easily avoided.
Agree it's ugly. Not sure we share the same reasoning. I realize that
the hotplug case is on the current cpu and so that whole
one_each_cpu_mask() call is not needed. mktme_program_package() can just
be called on the current cpu.

The ugliness that haunts me is that I wanted to reuse this code path,
and so I passed that 'hotplug' parameter along as a differentiator
between hotplug & 'typical' key programming. 
I'll rework this.
