From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 27 Oct 2019 14:47:24 +0000
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on key create or update
Message-Id: <1572187644.4532.211.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-2-nramas@linux.microsoft.com>
         <1572032428.4532.72.camel@linux.ibm.com>
         <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
In-Reply-To: <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Fri, 2019-10-25 at 15:28 -0700, Lakshmi Ramasubramanian wrote:
> On 10/25/2019 12:40 PM, Mimi Zohar wrote:
> 
> >> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> >> +				   unsigned long flags, bool create)
> >> +{
> >> +	const struct public_key *pk;
> >> +
> >> +	if (key->type != &key_type_asymmetric)
> >> +		return;
> >> +
> >> +	if (!ima_initialized)
> >> +		return;
> > 
> > There's no reason to define a new variable to determine if IMA is
> > initialized.  Use ima_policy_flag.  
> 
> Please correct me if I am wrong -
> 
> ima_policy_flag will be set to 0 if IMA is not yet initialized
> OR
> IMA is initialized, but ima_policy_flag could be still set to 0 (say, 
> due to the configured policy).
> 
> In the latter case the measurement request should be a NOP immediately.

I'm not sure.  The builtin keys most likely will be loaded prior to a
custom IMA policy containing "keyring" rules are defined.

Mimi
