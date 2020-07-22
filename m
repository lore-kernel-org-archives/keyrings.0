From: Joe Perches <joe@perches.com>
Date: Wed, 22 Jul 2020 20:20:00 +0000
Subject: Re: [PATCH v2] KEYS: remove redundant memset
Message-Id: <b60f9b3e07b86d0f8631f6990f61b5172c43841f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200722134610.31947-1-trix@redhat.com>
         <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
         <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
In-Reply-To: <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
To: Tom Rix <trix@redhat.com>, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 13:10 -0700, Tom Rix wrote:
> On 7/22/20 1:02 PM, Joe Perches wrote:
> > On Wed, 2020-07-22 at 06:46 -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Reviewing use of memset in keyctrl_pkey.c
> > > 
> > > keyctl_pkey_params_get prologue code to set params up
> > > 
> > > 	memset(params, 0, sizeof(*params));
> > > 	params->encoding = "raw";
> > > 
> > > keyctl_pkey_query has the same prologue
> > > and calls keyctl_pkey_params_get.
> > > 
> > > So remove the prologue.
> > > 
> > > Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> > At best, this is a micro optimization.
> Yes
> > How is this appropriate for a Fixes: line?
> Removing unneeded code is not a fix?

IMO: there's no "bug" here.

It's not a logic defect causing some unintended outcome.
It doesn't need backporting to stable branches.

Documentation/process/submitting-patches.rst-If your patch fixes a bug in a specific commit, e.g. you found an issue using
Documentation/process/submitting-patches.rst:``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
Documentation/process/submitting-patches.rst-the SHA-1 ID, and the one line summary.
