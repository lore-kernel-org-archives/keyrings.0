From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 21 Aug 2020 17:43:37 +0000
Subject: Re: [PATCH v3] docs: trusted-encrypted.rst: update parameters for command examples
Message-Id: <20200821174337.GC3559@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200818170002.38145-1-colyli@suse.de>
 <20200819210234.GB9942@linux.intel.com>
 <20200819210457.GC9942@linux.intel.com>
 <1a54fdde-6067-1dd1-8459-079023be9a82@suse.de>
In-Reply-To: <1a54fdde-6067-1dd1-8459-079023be9a82@suse.de>
To: Coly Li <colyli@suse.de>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>

On Fri, Aug 21, 2020 at 09:50:16PM +0800, Coly Li wrote:
> On 2020/8/20 05:04, Jarkko Sakkinen wrote:
> > On Thu, Aug 20, 2020 at 12:02:38AM +0300, Jarkko Sakkinen wrote:
> >> On Wed, Aug 19, 2020 at 01:00:02AM +0800, Coly Li wrote:
> >>> The parameters in command examples for tpm2_createprimary and
> >>> tpm2_evictcontrol are outdated, people (like me) are not able to create
> >>> trusted key by these command examples.
> >>>
> >>> This patch updates the parameters of command example tpm2_createprimary
> >>> and tpm2_evictcontrol in trusted-encrypted.rst. With Linux kernel v5.8
> >>> and tpm2-tools-4.1, people can create a trusted key by following the
> >>> examples in this document.
> >>>
> >>> Signed-off-by: Coly Li <colyli@suse.de>
> >>> Cc: Dan Williams <dan.j.williams@intel.com>
> >>> Cc: James Bottomley <jejb@linux.ibm.com>
> >>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >>> Cc: Mimi Zohar <zohar@linux.ibm.com>
> >>> Cc: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> OK, now it is clear. Thank you.
> >>
> >> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > There is one problem though.
> > 
> > You have missed to add linux-doc and linux-integrity maintainers and
> > also their maintainers from the CC list. You need to resend this patch
> > with that information. Use get_maintainers.pl or look from the file
> > called MAINTAINERS.
> 
> Copied. Some of the maintainers are in Cc list already, I add rested in
> v4 patch, and Cc linux-doc and linux-integrity mailing lists.

Please do.

> Thanks.
> 
> Coly Li

BR,
/Jarkko
