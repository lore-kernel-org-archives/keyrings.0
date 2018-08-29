From: Alison Schofield <alison.schofield@intel.com>
Date: Wed, 29 Aug 2018 00:33:52 +0000
Subject: Re: [RFC] KEYS: inject an MKTME specific safety check in the keyctl revoke path
Message-Id: <20180829003352.GA18344@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180814020538.GA18424@alison-desk.jf.intel.com>
	<1534474145.2908.4.camel@intel.com>
In-Reply-To: <1534474145.2908.4.camel@intel.com>
To: linux-security-module@vger.kernel.org

On Thu, Aug 16, 2018 at 07:49:11PM -0700, Huang, Kai wrote:
> On Mon, 2018-08-13 at 19:05 -0700, Alison Schofield wrote:
> > This RFC is asking for feedback on a problem I'm running into using
> > the Kernel Key Service for MKTME (MultiKey Total Memory Encryption).
> > 
> > I previously posted an RFC with the proposal to create a new key type
> > "mktme" to support MKTME (Multi-Key Total Memory Encryption).
> > https://www.spinics.net/lists/keyrings/msg03702.html
> > 
> > The MKTME key service maps userspace keys to hardware keyids. Those
> > keys are used in a new system call that encrypts memory. The keys
> > need to be tightly controlled. One example is that userspace keys
> > should not be revoked while the hardware keyid slot is still in use.
> > 
> > The KEY_FLAG_KEEP bit offers good control. The mktme service uses
> > that
> > bit to prevent userspace keys from disappearing without the service
> > being notified.
> > 
> > Problem is that we need a safe and synchronous way to revoke keys.
> > The
> > way .revoke methods function now, the key service type is called late
> > in the revoke process. The mktme key service has no means to reject
> > the
> > request. So, even if the mktme service sanity checks the request in
> > its
> > .revoke method, it's too late to do anything about it.
> > 
> > This proposal inserts an MKTME specific check earlier into the
> > existing
> > keyctl <revoke> path. If it is safe to revoke the key, mktme key
> > service
> > will turn off KEY_FLAG_KEEP and let the revoke continue (and
> > succeed).
> > Otherwise, not safe, KEY_FLAG_KEEP stays on, and the revoke continues
> > (and fails).
> > 
> > I considered proposing a new keyctl <option> just for this mktme
> > 'safe
> > revoke' request. I wonder if that might be the preferred method for
> > inserting this type specific behavior?
> > 
> > Hoping that from this description and the diff you can understand the
> > issue and suggest alternative solutions if needed. Thanks for
> > looking!
> 
> I am not expert, but maybe we can also consider making key_revoke()
> return error code, rather than void?
> 
> Thanks,
> -Kai

Kai,

In this proposal, the mktme key service would no longer have a
.revoke function defined in its key_type. There would be nothing
left to do after the key has been revoked since all the work was
done in preparation. So, I think a return value from key_revoke 
is not needed.

But, for your needs (KVM 'userspace') the "keyctl REVOKE" command does
have a return value, so KVM will know if a revoke succeeds|fails.

Alison

> 
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  security/keys/internal.h   |  6 ++++++
> >  security/keys/keyctl.c     | 14 ++++++++++++++
> >  security/keys/mktme_keys.c | 34 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 54 insertions(+)
> > 
> > diff --git a/security/keys/internal.h b/security/keys/internal.h
> > index 9f8208dc0e55..1b6425d0d1ab 100644
> > --- a/security/keys/internal.h
> > +++ b/security/keys/internal.h
> > @@ -316,4 +316,10 @@ static inline void key_check(const struct key
> > *key)
> >  
> >  #endif
> >  
> > +#ifdef CONFIG_MKTME_KEYS
> > +extern int mktme_safe_revoke(struct key *key);
> > +#else
> > +static inline int mktme_safe_revoke(struct key *key) { return 0; }
> > +#endif /* CONFIG_MKTME_KEYS */
> > +
> >  #endif /* _INTERNAL_H */
> > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > index 1ffe60bb2845..7b5f98af1d54 100644
> > --- a/security/keys/keyctl.c
> > +++ b/security/keys/keyctl.c
> > @@ -387,6 +387,20 @@ long keyctl_revoke_key(key_serial_t id)
> >  
> >  	key = key_ref_to_ptr(key_ref);
> >  	ret = 0;
> > +
> > +	/*
> > +	 * MKTME (Multi-Key Total Memory Encryption) Keys require a
> > +	 * sanity check before allowing a revoke. If the sanity
> > check
> > +	 * passes, the mktme key service will clear KEY_FLAG_KEEP
> > bit
> > +	 * and the revoke will proceed.
> > +	 */
> > +	if (strcmp(key->type->name, "mktme") = 0)  {
> > +		if (mktme_safe_revoke(key)) {
> > +			ret = -EINVAL;
> > +			goto error;
> > +		}
> > +	}
> > +
> >  	if (test_bit(KEY_FLAG_KEEP, &key->flags))
> >  		ret = -EPERM;
> >  	else
> > diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
> > index b937bbe6bcdb..887b483d7b38 100644
> > --- a/security/keys/mktme_keys.c
> > +++ b/security/keys/mktme_keys.c
> > @@ -67,6 +67,39 @@ static int mktme_clear_programmed_key(int keyid)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * mktme_safe_revoke() is called during the revoke process to
> > + * determine if it is safe to revoke a key. If this check passes,
> > + * the revoke proceeds, otherwise an error is returned to userspace.
> > + * The important error case here is outstanding memory mappings
> > using
> > + * the corresponding hardware keyid.
> > + */
> > +int mktme_safe_revoke(struct key *key)
> > +{
> > +	int keyid, vma_count;
> > +	int ret = -1;
> > +
> > +	mktme_map_lock();
> > +	keyid = mktme_map_keyid_from_serial(key->serial);
> > +	if (keyid <= 0)
> > +		goto out;
> > +
> > +	vma_count = vma_read_encrypt_ref(keyid);
> > +	if (vma_count > 0) {
> > +		pr_debug("mktme not freeing keyid[%d]
> > encrypt_count[%d]\n",
> > +			 keyid, vma_count);
> > +		goto out;
> > +	}
> > +	mktme_clear_programmed_key(keyid);
> > +	/* Clearing KEY_FLAG_KEEP flag allows the revoke to proceed
> > */
> > +	clear_bit(KEY_FLAG_KEEP, &key->flags);
> > +	ret = 0;
> > +out:
> > +	mktme_map_unlock();
> > +	return ret;
> > +}
> > +
> > +
> > @@ -315,6 +348,7 @@ int mktme_instantiate(struct key *key, struct
> > key_preparsed_payload *prep)
> >  
> >  	mktme_map_lock();
> >  	ret = mktme_program_key(key->serial, kprog);
> > +	set_bit(KEY_FLAG_KEEP, &key->flags);
> >  	mktme_map_unlock();
> >  out:
> >  	kzfree(datablob);
