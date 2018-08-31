From: Alison Schofield <alison.schofield@intel.com>
Date: Fri, 31 Aug 2018 16:55:12 +0000
Subject: Re: [RFC] KEYS: inject an MKTME specific safety check in the keyctl revoke path
Message-Id: <20180831165512.GA5224@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180814020538.GA18424@alison-desk.jf.intel.com>
	<20180831110543.GB9346@linux.intel.com>
In-Reply-To: <20180831110543.GB9346@linux.intel.com>
To: linux-security-module@vger.kernel.org

On Fri, Aug 31, 2018 at 02:05:43PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 13, 2018 at 07:05:38PM -0700, Alison Schofield wrote:
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
> 
> What is the new syscall? Can you point to a description?

I can give you this, and tell you that it will be included in the 'next'
RFC for the MKTME API's. 

System Call: encrypt_mprotect()
MKTME encryption is requested by calling encrypt_mprotect() which
is an extension of the existing mprotect() system call. The caller
passes a handle to a previously allocated and programmed encryption
key. That handle was created with the MKTME Key Service.
> 
> > 
> > The KEY_FLAG_KEEP bit offers good control. The mktme service uses that
> > bit to prevent userspace keys from disappearing without the service
> > being notified.
> > 
> > Problem is that we need a safe and synchronous way to revoke keys. The
> > way .revoke methods function now, the key service type is called late
> > in the revoke process. The mktme key service has no means to reject the
> > request. So, even if the mktme service sanity checks the request in its
> > .revoke method, it's too late to do anything about it.
> 
> I have trouble understanding the problem. I'm just seeing what you need
> but I don't know why you need it...

I replied to your comments inline below.

Then, I had a conversation with DaveH suggesting that we more actively
manage the KEY_FLAG_KEEP flag so that it always reflects the in use
status of the keys, as opposed to trying to figure it out at revoke
time. 
> 
> > 
> > This proposal inserts an MKTME specific check earlier into the existing
> > keyctl <revoke> path. If it is safe to revoke the key, mktme key service
> > will turn off KEY_FLAG_KEEP and let the revoke continue (and succeed).
> > Otherwise, not safe, KEY_FLAG_KEEP stays on, and the revoke continues
> > (and fails).
> > 
> > I considered proposing a new keyctl <option> just for this mktme 'safe
> > revoke' request. I wonder if that might be the preferred method for
> > inserting this type specific behavior?
> > 
> > Hoping that from this description and the diff you can understand the
> > issue and suggest alternative solutions if needed. Thanks for looking!
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
> > @@ -316,4 +316,10 @@ static inline void key_check(const struct key *key)
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
> > +	 * sanity check before allowing a revoke. If the sanity check
> > +	 * passes, the mktme key service will clear KEY_FLAG_KEEP bit
> > +	 * and the revoke will proceed.
> > +	 */
> 
> I think this should be moved to the kdoc of the function.
> 
> > +	if (strcmp(key->type->name, "mktme") = 0)  {
> > +		if (mktme_safe_revoke(key)) {
> > +			ret = -EINVAL;
> > +			goto error;
> > +		}
> > +	}
> 
> What about -EBUSY instead? There is something wrong here because you
> ignore the return value of mktme_safe_revoke() and substitute your own
> return value. Should be:
> 
> ret = mktme_safe_revoke(key);
> if (ret)
> 	goto error;
> 
> I think this should renamed simply as mktme_revoke_key() and document in
> the function long description what measures it need to take to revoke a
> key.

Considering your comments, I see the whole error handling situation is
unneeded. I can make mktme_safe_revoke a void funtion. It's job is to
turn off KEY_FLAG_KEEP if possible. It could just be something like:

	if (strcmp(key->type->name, "mktme") = 0) 
                mktme_safe_revoke(key);

and let the flow continue as is. 
> 
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
> > + * The important error case here is outstanding memory mappings using
> > + * the corresponding hardware keyid.
> > + */
> 
> Please use kdoc.
> 
> > +int mktme_safe_revoke(struct key *key)
> > +{
> > +	int keyid, vma_count;
> > +	int ret = -1;
> 
> So you choose to use a magic number instead of relaying to the standard
> errnos?
Yes, I did. Undoing the whole error return thing, but got you msg for
future reference.
> 
> > +
> > +	mktme_map_lock();
> > +	keyid = mktme_map_keyid_from_serial(key->serial);
> > +	if (keyid <= 0)
> > +		goto out;
> > +
> > +	vma_count = vma_read_encrypt_ref(keyid);
> > +	if (vma_count > 0) {
> > +		pr_debug("mktme not freeing keyid[%d] encrypt_count[%d]\n",
> > +			 keyid, vma_count);
> 
> Wasn't it busy using it? Maybe the log message could be more exact.
It's a debug message. I don't think I have any more exacting info.
Will look at.
> 
> > +		goto out;
> > +	}
> > +	mktme_clear_programmed_key(keyid);
> > +	/* Clearing KEY_FLAG_KEEP flag allows the revoke to proceed */
> 
> Is this comment necessary?
No. It's probably repeated what the func header will say. 

> 
> > +	clear_bit(KEY_FLAG_KEEP, &key->flags);
> > +	ret = 0;
> > +out:
> > +	mktme_map_unlock();
> > +	return ret;
> > +}
> > +
> > +
> > @@ -315,6 +348,7 @@ int mktme_instantiate(struct key *key, struct key_preparsed_payload *prep)
> >  
> >  	mktme_map_lock();
> >  	ret = mktme_program_key(key->serial, kprog);
> > +	set_bit(KEY_FLAG_KEEP, &key->flags);
> >  	mktme_map_unlock();
> >  out:
> >  	kzfree(datablob);
> > -- 
> > 2.14.1
> > 
> 
> What about just waiting by adding callback to the MMU notifier when the
> count is zero and using a wait queue?
That sounds interesting but I'm not sure we'd want to wait as opposed to
fail and tell userspace to stop using their keys before revoking.

> 
> /Jarkko
