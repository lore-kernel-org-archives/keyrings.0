From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 12 Dec 2019 16:58:05 +0000
Subject: Re: [PATCH v11 0/6] KEYS: Measure keys when they are created or updated
Message-Id: <1f34f41a-f43d-0397-aed0-e43aab87ac42@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191211164707.4698-1-nramas@linux.microsoft.com>
 <1576160916.4579.151.camel@linux.ibm.com>
In-Reply-To: <1576160916.4579.151.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 12/12/19 6:28 AM, Mimi Zohar wrote:

> Hi Lakshmi,
> 
> On Wed, 2019-12-11 at 08:47 -0800, Lakshmi Ramasubramanian wrote:
>> Keys created or updated in the system are currently not measured.
>> Therefore an attestation service, for instance, would not be able to
>> attest whether or not the trusted keys keyring(s), for instance, contain
>> only known good (trusted) keys.
>>
>> IMA measures system files, command line arguments passed to kexec,
>> boot aggregate, etc. It can be used to measure keys as well.
>> But there is no mechanism available in the kernel for IMA to
>> know when a key is created or updated.
>>
>> This change aims to address measuring keys created or updated
>> in the system.
> 
> Thank you!  This patch set is now queued in the next-integrity-testing
> branch of https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
> integrity.git/.
> 
> Mimi
> 

Thanks Mimi.

  -lakshmi
