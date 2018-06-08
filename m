From: Alison Schofield <alison.schofield@intel.com>
Date: Fri, 08 Jun 2018 18:06:33 +0000
Subject: Re: RESEND [RFC] KEYS: add a new type "mktme" to kernel key services
Message-Id: <20180608180633.GA25718@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180525234328.GA2981@alison-desk.jf.intel.com>
	<19964.1528475584@warthog.procyon.org.uk>
In-Reply-To: <19964.1528475584@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Thanks for the feedback David. See comments inline...
alisons

On Fri, Jun 08, 2018 at 05:33:04PM +0100, David Howells wrote:
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > +EXPORT_SYMBOL(key_lookup);
> 
> *Twitch*.
> 
> There's no protection on this whatsoever.
got it.

> 
> > +struct mktme_mapping {
> > +	struct mutex		lock;	/* protect mktme_map & hw state */
> > +	struct data {
> > +		key_serial_t	serial;
> 
> Why key_serial_t rather than struct key *?
> 
> Unless you pin it, there's no guarantee that serial will refer to the same
> key - or even the same type of key - next time you look for it.
> 
> The kernel should not be using key IDs outside of code keyrings code, except
> for logging purposes.

Perhaps I'm munging userspace vs kernel usage rules here.

Userspace gets a key_serial_t when they add_key(). Later, they use
key_serial_t in another system call to request an encrypted mapping.
That system call does validity checking on key_serial_t, gets the
corresponding keyid slot from the above struct, and performs the
encrypted mapping.

I see how I can save struct key* and use it here. I'm just not
clear why key* is safer that key_serial_t. Either piece I save,
key* or key_serial_t needs to be repeatedly validated.
(key* would avoid need for key_lookup() ;))

Concerned I'm missing a bigger point here?

> 
> > +static int mktme_recover_key(void)
> > +{
> > +	int i = mktme_max_keyids;
> > +	struct key *key;
> > +
> > +	do {
> > +		if (!mktme_map->id[i].serial)
> > +			continue;
> > +
> > +		key = key_lookup(mktme_map->id[i].serial);
> > +		if (IS_ERR(key))
> > +			goto recover;
> 
> This gets a ref on the key from key_lookup() and then simply drops it.  Did
> you also want to check the key type?

Sure.
This is an attempt at playing defense againt changes in keys that
this key service is not directly told about.

> 
> > +
> > +		if (key_validate(key) < 0) {
> > +			/*
> > +			 * Here the key ptr is good, but the
> > +			 * key may * be marked for removal.
> > +			 * Leave this here to watch for.
> > +			 */
> > +			pr_info("%s key validate fails\n", __func__);
> > +			goto recover;
> > +		}
> > +	} while (i--);
> > +
> > +	return 0;
> > +recover:
> > +	mktme_unregister_key(i);
> > +	return i;
> > +}
> 
> What do you name your keys?  Can they be named for the slot they're in?

The service doesn't name keys. Userspace may use keyctl 'name'
field or add_key() 'description' field. BTW - we never tell userspace
what hardware slot they are mapped to.

Maybe not the type of naming usage you were thinking of?

> 
> > +/* Parse the options from the datablob and fill in struct mktme_key_program.
> > + * After parsing, call mktme_check_options() for sanity checking.
> > + *
> > + * Success returns 0, otherwise -EINVAL.
> > + */
> > +static int mktme_get_options(char *datablob, struct mktme_key_program *kprog)
> > +{
> > +	enum mktme_alg alg = MKTME_ALG__LAST;
> > +	substring_t args[MAX_OPT_ARGS];
> > +	unsigned long token_mask = 0;
> > +	int len, ret, token;
> > +	char *p = datablob;
> > +
> > +	while ((p = strsep(&datablob, " \t"))) {
> > +		if (*p = '\0' || *p = ' ' || *p = '\t')
> > +			continue;
> > +		token = match_token(p, mktme_tokens, args);
> > +		if (test_and_set_bit(token, &token_mask))
> > +			return -EINVAL;
> > +
> > +		len = strlen(args[0].from) / 2;
> > +		if (len > MKTME_MAX_OPTION_SIZE)
> > +			return -EINVAL;
> > +
> > +		switch (token) {
> > +		case opt_userkey:
> > +			ret = hex2bin(kprog->key_field_1, args[0].from, len);
> > +			if (ret < 0)
> > +				return -EINVAL;
> > +			kprog->keyid_ctrl |= MKTME_KEYID_SET_KEY_DIRECT;
> > +			break;
> 
> You should perhaps use request_key() or lookup_user_key() here maybe?

This is the encryption key that the user passes as an option to add_key.
Each of these options are a (maybe) required piece of their key setup.

> 
> > +
> > +		case opt_tweak:
> > +			ret = hex2bin(kprog->key_field_2, args[0].from, len);
> > +			if (ret < 0)
> > +				return -EINVAL;
> > +			break;
> > +
> > +		case opt_entropy:
> > +			ret = hex2bin(kprog->key_field_1, args[0].from, len);
> > +			if (ret < 0)
> > +				return -EINVAL;
> > +			break;
> > +
> > +		case opt_algorithm:
> > +			alg = match_string(mktme_alg_name, MKTME_ALG__LAST,
> > +					   args[0].from);
> > +			switch (alg) {
> > +			case MKTME_ALG_AES_XTS_128:
> > +				kprog->keyid_ctrl |= MKTME_AES_XTS_128;
> > +				break;
> > +
> > +			case MKTME_ALG_NO_ENCRYPT:
> > +				kprog->keyid_ctrl |= MKTME_KEYID_NO_ENCRYPT;
> > +				break;
> > +
> > +			default:
> > +				return -EINVAL;
> > +			}
> > +			break;
> > +
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	dump_kprog(kprog);
> > +	return mktme_check_options(kprog, token_mask);
> > +}
> > +
> > +/* Key Service Command: Creates a software key and programs hardware */
> > +
> > +int mktme_instantiate(struct key *key, struct key_preparsed_payload *prep)
> 
> Please use preparsing if you can.  You shouldn't be returning ENOMEM from
> ->instantiate() if at all possible.

Got it, will pursue.

> 
> > +{
> > +	struct mktme_key_program *kprog = NULL;
> > +	size_t datalen = prep->datalen;
> > +	char *datablob;
> > +	int ret = 0;
> > +
> > +	if (datalen <= 0 || datalen > 1024 || !prep->data)
> > +		return -EINVAL;
> > +
> > +	datablob = kmemdup(prep->data, datalen + 1, GFP_KERNEL);
> > +	if (!datablob)
> > +		return -ENOMEM;
> > +
> > +	datablob[datalen] = '\0';
> > +	kprog = kzalloc(sizeof(*kprog), GFP_KERNEL);
> > +	if (!kprog) {
> > +		kzfree(datablob);
> > +		return -ENOMEM;
> > +	}
> > +	ret = mktme_get_options(datablob, kprog);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	mutex_lock(&mktme_map->lock);
> > +	ret = mktme_register_key(key->serial, kprog);
> > +	mutex_unlock(&mktme_map->lock);
> > +out:
> > +	kzfree(datablob);
> > +	kzfree(kprog);
> > +	dump_keys();
> > +	return ret;
> > +}
> > +
> > +/* Key Service Command: Clears the keys software and hardware */
> > +
> > +void mktme_revoke(struct key *key)
> > +{
> > +	int keyid;
> > +
> > +	keyid = mktme_get_keyid(key->serial);
> > +	if (keyid < 0)
> > +		return;
> > +
> > +	mutex_lock(&mktme_map->lock);
> > +	mktme_unregister_key(keyid);
> > +	mutex_unlock(&mktme_map->lock);
> > +	dump_keys();
> > +}
> > +
> > +struct key_type key_type_mktme = {
> > +	.name = "mktme",
> > +	.instantiate = mktme_instantiate,
> > +	.revoke = mktme_revoke,
> > +	.describe = user_describe,
> > +};
> > +
> > +/*
> > + * Get the maximum keyids reported from BIOS.
> > + * Allocate the mktme_map structure and register mktme key type.
> > + */
> > +static int __init init_mktme(void)
> > +{
> > +	int ret;
> > +
> > +	/* TODO: get real max hardware keyids */
> > +	/* mktme_max_keyids = nr_keyids; */
> > +
> > +	mktme_max_keyids = 100;
> > +	mktme_mapped_keyids = 0;
> > +	mktme_map = kzalloc((sizeof(mktme_map->id[0]) * mktme_max_keyids)
> > +			    + (sizeof(mktme_map->lock)), GFP_KERNEL);
> > +	if (!mktme_map)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&mktme_map->lock);
> > +	ret = register_key_type(&key_type_mktme);
> > +	if (ret < 0)
> > +		kfree(mktme_map);
> > +
> > +	return ret;
> > +}
> > +
> > +static void __exit cleanup_mktme(void)
> > +{
> > +	unregister_key_type(&key_type_mktme);
> > +	kfree(mktme_map);
> > +}
> > +
> > +late_initcall(init_mktme);
