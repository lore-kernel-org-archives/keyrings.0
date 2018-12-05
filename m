From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 05 Dec 2018 05:44:45 +0000
Subject: Re: [RFC v2 11/13] keys/mktme: Program memory encryption keys on a system wide basis
Message-Id: <20181205054444.GF18596@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <72dd5f38c1fdbc4c532f8caf2d2010f1ddfa8439.1543903910.git.alison.schofield@intel.com>
 <20181204092145.GR11614@hirez.programming.kicks-ass.net>
 <20181204095009.ehgyxvv4lcd7ztd7@black.fi.intel.com>
In-Reply-To: <20181204095009.ehgyxvv4lcd7ztd7@black.fi.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 12:50:09PM +0300, Kirill A. Shutemov wrote:
> On Tue, Dec 04, 2018 at 09:21:45AM +0000, Peter Zijlstra wrote:
> > On Mon, Dec 03, 2018 at 11:39:58PM -0800, Alison Schofield wrote:
> > 
> > > +struct mktme_hw_program_info {
> > > +	struct mktme_key_program *key_program;
> > > +	unsigned long status;
> > > +};
> > > +
> > > +/* Program a KeyID on a single package. */
> > > +static void mktme_program_package(void *hw_program_info)
> > > +{
> > > +	struct mktme_hw_program_info *info = hw_program_info;
> > > +	int ret;
> > > +
> > > +	ret = mktme_key_program(info->key_program);
> > > +	if (ret != MKTME_PROG_SUCCESS)
> > > +		WRITE_ONCE(info->status, ret);
> > 
> > What's the purpose of that WRITE_ONCE()?
> 
> [I suggested the code to Alison.]
> 
> Yes, you're right. Simple assignment will do.
Will do. Thanks!

> 
> -- 
>  Kirill A. Shutemov
