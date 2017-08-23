From: Josh Holland <anowlcalledjosh@gmail.com>
Date: Wed, 23 Aug 2017 20:34:52 +0000
Subject: Re: [PATCH 1/2] docs: Standardise capitalisation of section headers in core.rst
Message-Id: <20170823203452.fibxglkpfuu3uevm@yes>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170819152106.20432-2-anowlcalledjosh@gmail.com>
In-Reply-To: <20170819152106.20432-2-anowlcalledjosh@gmail.com>
To: keyrings@vger.kernel.org

On 2017-08-21, Jonathan Corbet wrote:
> On Mon, 21 Aug 2017 12:15:26 +0300
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
> 
> > However, if you want to sphinxify things a little, you could make the
> > resulting html a little bit nicer with automatic links, and document
> > maintenance a little bit easier, by replacing the hand written contents
> > with:
> > 
> > .. contents::
> >    :local:
> 
> I think this is what we should do.  I don't think that manually listing
> the section heads buys a whole lot for readers of the docs, and
> experience says they won't be kept in sync with the rest of the
> document.  I'd much rather see a patch taking them out and letting Sphinx
> do the work.

Ok, I'll send a patch in.

> Part 2 looks fine, though, I'll apply that shortly.

Great!

Thanks,

Josh
