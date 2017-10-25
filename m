From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Wed, 25 Oct 2017 20:17:44 +0000
Subject: Re: [PATCH v2] tpm: use struct tpm_chip for tpm_chip_find_get()
Message-Id: <20171025201744.GB2815@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
 <CANc+2y46q85+G1=9cXKW0R8FpGBqCuzkLnJzvSYFQ1S=ztKGew@mail.gmail.com>
 <20171025193452.d4qa4dhacfgqejk7@linux.intel.com>
 <20171025194633.GB998@obsidianresearch.com>
 <20171025200746.svsraubdotjyzt2i@linux.intel.com>
In-Reply-To: <20171025200746.svsraubdotjyzt2i-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Sakkinen <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Herbert Xu <herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org>, "open list:INTEGRITY MEASUREMENT ARCHITECTURE (IMA)" <linux-ima-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, PrasannaKumar Muralidharan <prasannatsmkumar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "moderated list:TPM DEVICE DRIVER" <tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Dmitry Kasatkin <dmitry.kasatkin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Morris <james.l.morris-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Matt Mackall <mpm-VDJrAJ4Gl5ZBDgjK7y7TUQ@public.gmane.org>, "open list:INTEGRITY MEASUREMENT ARCHITECTURE (IMA)" <linux-ima-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, David Safford <safford-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, linux-integrity-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mimi Zohar <zohar-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "open list:KEYS-TRUSTED" <keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Serge E. Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>

On Wed, Oct 25, 2017 at 10:07:46PM +0200, Jarkko Sakkinen wrote:

> The id has a nice feature that it is unique for one boot cycle you can
> even try to get a chip that has been deleted. It has the most stable
> properties in the long run.

It isn't unique, we can re-use ids them via idr_alloc(). We should
never use index inside the kernel.

> Address is a reusable identifier in one boot cycle.

It is invalid to pass in a chip for which the caller does not hold a
kref, so address is the safest argument.

Jason
