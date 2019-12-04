From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 04 Dec 2019 22:43:59 +0000
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
Message-Id: <2c613462-825e-a3d1-9bf2-2314f0c1a4da@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
 <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
 <1575403616.5241.76.camel@linux.ibm.com>
 <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
 <1575458192.5241.99.camel@linux.ibm.com>
In-Reply-To: <1575458192.5241.99.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/4/19 3:16 AM, Mimi Zohar wrote:

Hi Mimi,

> 
> The integrity subsystem, and other concepts upstreamed to support it,
> are being used by different people/companies in different ways.  I
> know some of the ways, but not all, as how it is being used.  For
> example, Mat Martineau gave an LSS2019-NA talk titled "Using and
> Implementing Keyring Restrictions for Userspace".  I don't know if he
> would be interested in measuring keys on these restricted userspace
> keyrings, but before we limit how a new feature works, we should at
> least look to see if that limitation is really necessary.
> 
> Mimi

I have updated the patch per your suggestion - if uid is specified in 
the policy for key measurement, then it is checked against the current 
user's credential.

Please review the updated patch set (v10).

thanks,
  -lakshmi
