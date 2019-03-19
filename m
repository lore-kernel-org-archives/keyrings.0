From: James Bottomley <jejb@linux.ibm.com>
Date: Tue, 19 Mar 2019 00:24:40 +0000
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware TPM
Message-Id: <1552955080.2785.26.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155295271345.1945351.6465460744078693578.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Roberto Sassu <roberto.sassu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mimi Zohar <zohar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> Rather than fail initialization of the trusted.ko module, arrange for
> the module to load, but rely on trusted_instantiate() to fail
> trusted-key operations.

What actual problem is this fixing?  To me it would seem like an
enhancement to make the trusted module fail at load time if there's no
TPM rather than waiting until first use to find out it can never work. 
Is there some piece of user code that depends on the successful
insertion of trusted.ko?

James
