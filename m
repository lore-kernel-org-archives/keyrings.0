From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 04 Dec 2019 11:16:32 +0000
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
Message-Id: <1575458192.5241.99.camel@linux.ibm.com>
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
In-Reply-To: <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, eric.snowberg@oracle.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.orgMat Martineau <mathew.j.martineau@linux.intel.com>

[Cc'ing Mat Martineau]

On Tue, 2019-12-03 at 15:37 -0800, Lakshmi Ramasubramanian wrote:
> On 12/3/2019 12:06 PM, Mimi Zohar wrote:
> 
> > Suppose both root and uid 1000 define a keyring named "foo".  The
> > current "keyrings=foo" will measure all keys added to either keyring
> > named "foo".  There needs to be a way to limit measuring keys to a
> > particular keyring named "foo".
> > 
> > Mimi
> 
> Thanks for clarifying.
> 
> Suppose two different non-root users create keyring with the same name 
> "foo" and, say, both are measured, how would we know which keyring 
> measurement belongs to which user?
> 
> Wouldn't it be sufficient to include only keyrings created by "root" 
> (UID value 0) in the key measurement? This will include all the builtin 
> trusted keyrings (such as .builtin_trusted_keys, 
> .secondary_trusted_keys, .ima, .evm, etc.).
> 
> What would be the use case for including keyrings created by non-root 
> users in key measurement?
> 
> Also, since the UID for non-root users can be any integer value (greater 
> than 0), can an an administrator craft a generic IMA policy that would 
> be applicable to all clients in an enterprise?

The integrity subsystem, and other concepts upstreamed to support it,
are being used by different people/companies in different ways.  I
know some of the ways, but not all, as how it is being used.  For
example, Mat Martineau gave an LSS2019-NA talk titled "Using and
Implementing Keyring Restrictions for Userspace".  I don't know if he
would be interested in measuring keys on these restricted userspace
keyrings, but before we limit how a new feature works, we should at
least look to see if that limitation is really necessary.

Mimi
