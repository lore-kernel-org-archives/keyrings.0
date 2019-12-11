From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 11 Dec 2019 00:03:18 +0000
Subject: Re: [PATCH v10 1/6] IMA: Check IMA policy flag
Message-Id: <1576022598.4579.50.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-2-nramas@linux.microsoft.com>
         <1576017749.4579.40.camel@linux.ibm.com>
         <6385347a-bc40-7717-f9ad-8ed7dd7fee51@linux.microsoft.com>
In-Reply-To: <6385347a-bc40-7717-f9ad-8ed7dd7fee51@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Tue, 2019-12-10 at 15:29 -0800, Lakshmi Ramasubramanian wrote:
> On 12/10/19 2:42 PM, Mimi Zohar wrote:
> 
> > Patch descriptions aren't suppose to be written as pseudo code.  Start
> > with the current status and problem description.
> > 
> > For example, "process_buffer_measurement() may be called prior to IMA being initialized, which would result in a kernel panic.  This patch ..."
> > 
> > Mimi
> 
> I'll update the patch description in this one and in the other patches 
> per your comments.
> 
> Are you done reviewing all the patches in this set?
> 
> Other than the one code change per your comment on "[PATCH v10 5/6]" 
> there are no other code changes I need to make?
> Just wanted to confirm.
> 
> 	[PATCH v10 5/6] IMA: Add support to limit measuring keys
> => With the additional "uid" support this isn't necessarily true any
> more.

Yes, other than the code change needed for this and the patch
descriptions, it looks good.  Am continuing with reviewing the other
patch set - queueing "key" measurements.

Mimi
