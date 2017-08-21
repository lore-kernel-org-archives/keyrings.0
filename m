From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 21 Aug 2017 12:58:16 +0000
Subject: Re: [PATCH 1/2] docs: Standardise capitalisation of section headers in core.rst
Message-Id: <20170821065816.32c37ef8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170819152106.20432-2-anowlcalledjosh@gmail.com>
In-Reply-To: <20170819152106.20432-2-anowlcalledjosh@gmail.com>
To: keyrings@vger.kernel.org

On Mon, 21 Aug 2017 12:15:26 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> However, if you want to sphinxify things a little, you could make the
> resulting html a little bit nicer with automatic links, and document
> maintenance a little bit easier, by replacing the hand written contents
> with:
> 
> .. contents::
>    :local:

I think this is what we should do.  I don't think that manually listing
the section heads buys a whole lot for readers of the docs, and
experience says they won't be kept in sync with the rest of the
document.  I'd much rather see a patch taking them out and letting Sphinx
do the work.

Part 2 looks fine, though, I'll apply that shortly.

Thanks,

jon
