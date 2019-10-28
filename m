From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 28 Oct 2019 17:08:38 +0000
Subject: Re: [PATCH v2 3/4] KEYS: Added BUILTIN_TRUSTED_KEYS enum to measure keys added to builtin_trusted_ke
Message-Id: <1572282518.4532.260.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
         <20191023233950.22072-4-nramas@linux.microsoft.com>
         <1572186810.4532.206.camel@linux.ibm.com>
         <8494baa1-c4db-f08b-26c9-2e56279075d0@linux.microsoft.com>
In-Reply-To: <8494baa1-c4db-f08b-26c9-2e56279075d0@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Mon, 2019-10-28 at 08:12 -0700, Lakshmi Ramasubramanian wrote:
> On 10/27/19 7:33 AM, Mimi Zohar wrote:
> 
> > .builtin_trusted_keys is a trusted keyring, which is created by the
> > kernel.  It cannot be deleted or replaced by userspace, so it should
> > be possible to correlate a keyring name with a keyring number on
> > policy load.
> 
> Yes - at policy load we can map a keyring name to a keyring number.
> 
> But at runtime we still need to know if the keyring parameter passed to 
> the IMA hook function is configured to be measured.
> 
> void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> 				   unsigned long flags, bool create);
> {
>     => Get the keyring number for the given "keyring".

There is no "getting" involved here.  Pass "keyring" to
process_buffer_measurement and on to ima_get_action().

>     => Check if the keyring number is in the configured IMA policy.

ima_get_action() should do a simple compare of the valued stored in
the IMA policy with the value returned by key_serial().

Mimi

>     => If yes, measure the key.
>     => Else, do nothing.
> }

> Did I misunderstand what you had stated?
