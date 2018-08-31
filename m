From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 31 Aug 2018 08:40:57 +0000
Subject: Re: [RFC] KEYS: add a new type "mktme" to kernel key services
Message-Id: <20180831084057.GA9346@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180525233135.GA2774@alison-desk.jf.intel.com>
In-Reply-To: <20180525233135.GA2774@alison-desk.jf.intel.com>
To: linux-security-module@vger.kernel.org

On Fri, May 25, 2018 at 04:31:35PM -0700, Alison Schofield wrote:
> Hi David & Key Community,
> 
> I'm requesting your comments on placing the MK-TME API in the Kernel
> Key Service API set. I'm hoping to get a thumbs-up on the general
> direction before going further down this path. Key Services seems to
> offer a tremendous amount of functionality. I'd like to hear if you
> think so too, address any concerns, or hear other suggestions for its
> placement. Here are the details...
> 
> MK-TME (Multi-Key Total Memory Encryption) is a technology that allows
> transparent memory encryption in upcoming Intel platforms. Whereas TME
> allows encryption of the entire system memory using a single key, MK-TME
> allows mulitple encryption domains, each having their own key. The main
> use case for the feature is virtual machine isolation. The API, however,
> needs the flexibility to work for a wide range of uses.
> 
> Kirill Shutemov has a patchset for the core kernel support that has
> been making its way upstream. Find that here:
> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git mktme/wip
> 
> After considering alternatives (new API, crypto API) this POC adds
> "mktme" as a new key service to the existing kernel key services.
> 
> The mktme key service will manage the adding and removing of software
> keys. It will map software keys to hardware keyid slots and program the
> hardware keyid slots with the user requested encryption options.
> 
> The mktme key service will not store any encryption keys in the kernel.
> We program the hardware and basically throw away the key. We only retain
> a mapping of which software key is assigned to which hardware keyid. It
> is not even possible to read back any of the programming info (encryption
> algorithm, key, tweak, entropy) once programmed.
> 
> The mktme key service is half of the API level solution. It will be paired
> with a new API that uses these keys to protect the memory. You will see
> reference to that mktme_mprotect() system call in the example documentation
> included in the patch. It doesn't exist yet.
> 
> The first file in the patch is Documentation with sample usages.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Kirill Shutemov <kirill.shutemov@intel.com>

Please Cc me too.

> ---
>  Documentation/security/keys/mktme.rst |  69 ++++++
>  include/keys/mktme-type.h             |  32 +++
>  security/keys/Kconfig                 |  11 +
>  security/keys/Makefile                |   1 +
>  security/keys/key.c                   |   1 +
>  security/keys/mktme.c                 | 413 ++++++++++++++++++++++++++++++++++

Should it rather be intel_mktme.c? And intel_mktme-type.h.

>  6 files changed, 527 insertions(+)
>  create mode 100644 Documentation/security/keys/mktme.rst
>  create mode 100644 include/keys/mktme-type.h
>  create mode 100644 security/keys/mktme.c
> 
> diff --git a/Documentation/security/keys/mktme.rst b/Documentation/security/keys/mktme.rst
> new file mode 100644
> index 0000000..bb9557e
> --- /dev/null
> +++ b/Documentation/security/keys/mktme.rst
> @@ -0,0 +1,69 @@
> +=====================
> +Keys for Multi-Key Total Memory Encryption
> +=====================
> +
> +Keys for Multi-Key Total Memory Encryption (MKTME) are a new key type
> +added to the existing kernel key ring service.
> +
> +Allocating MKTME Keys via command line or system call::
> +
> +    keyctl add mktme name "[options]" ring
> +
> +    key_serial_t add_key(const char *type, const char *description,
> +                         const void *payload, size_t plen,
> +                         key_serial_t keyring);
> +
> +
> +Revoking MKTME Keys via command line or system call::
> +
> +   keyctl revoke <key>
> +
> +   long keyctl(KEYCTL_REVOKE, key_serial_t key);
> +
> +
> +Options Field Definition::
> +
> +    userkey=      user provided encryption key. This key defaults to
> +                  a CPU generated (ephemeral) key if a userkey is not
> +                  defined here.
> +
> +    algorithm=    encryption algorithm to be used. Defaults to system
> +                  default TME algorithm. Select 'no_encrypt' for no
> +                  encryption.
> +
> +    tweak=        user provided tweak. This tweak will be added to the
> +                  user provided key.

A tautology: tweak is a tweak. What is "a tweak"?

> +
> +    entropy=      user provided entropy. This entropy will be used to
> +                  generated the CPU generated key.
> +
> +Algorithm Dependencies::
> +
> +    There will be algorithm dependencies that dictate which 'options'
> +    actually make sense. For example, aes_xts_128 will require a
> +    tweak key when a userkey is specified. Here we will document
> +    these dependencies based on algorithms supported. At initial
> +    release of the feature we will only support 2 algorithm choices:
> +    aex_xts_128 and no_encrypt.
> +
> +
> +Sample usage MK-TME Key Service API with mktme_mprotect() API::
> +
> +  Add a key::
> +        key = add_key(mktme, name, "userkey" tweakD", strlen(argv[3]),
> +                      KEY_SPEC_USER_KEYRING);
> +  Map memory::
> +        ptr = mmap(NULL, size, prot, MAP_ANONYMOUS, -1, 0);
> +
> +  Protect memory::
> +        ret = syscall(sys_mktme_mprotect, ptr, size, prot, key);
> +
> +  Use protected memory::
> +        ................
> +
> +  Free memory::
> +        ret = munmap(ptr, size);
> +
> +  Revoke key::                 /* User may keep and resuse the key */
> +        ret = keyctl(KEYCTL_REVOKE, key);
> +
> diff --git a/include/keys/mktme-type.h b/include/keys/mktme-type.h
> new file mode 100644
> index 0000000..4542606
> --- /dev/null
> +++ b/include/keys/mktme-type.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Key service for Multi-KEY Total Memory Encryption
> + */
> +
> +#ifndef _KEYS_MKTME_TYPE_H
> +#define _KEYS_MKTME_TYPE_H
> +
> +#include <linux/key.h>
> +
> +/*
> + * User can optionally provide encryption algorithm, encryption
> + * key, and tweak key.
> + */
> +
> +#define MKTME_MAX_OPTION_SIZE		64
> +
> +enum mktme_alg {
> +	MKTME_ALG_AES_XTS_128,
> +	MKTME_ALG_NO_ENCRYPT,		/* do not encrypt */
> +	MKTME_ALG__LAST,
> +};
> +
> +const char *const mktme_alg_name[MKTME_ALG__LAST] = {
> +	[MKTME_ALG_AES_XTS_128]	= "aes_xts_128",
> +	[MKTME_ALG_NO_ENCRYPT]	= "no_encrypt",
> +};
> +
> +extern struct key_type key_type_mktme;
> +
> +#endif /* _KEYS_MKTME_TYPE_H */
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 6462e66..3e5e619 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -101,3 +101,14 @@ config KEY_DH_OPERATIONS
>  	 in the kernel.
>  
>  	 If you are unsure as to whether this is required, answer N.
> +
> +config MKTME_KEYS
> +	bool "MKTME KEYS"
> +	depends on KEYS
> +	help
> +	  This option provides support for Multi-Key Total Memory
> +	  Encryption (MKTME). MKTME allows userspace to manage the
> +	  use of hardware programmed memory encryption keys for
> +	  encrypting any page of memory.
> +
> +	  If you are unsure as to whether this is required, answer N.
> diff --git a/security/keys/Makefile b/security/keys/Makefile
> index ef1581b..fa74bfc 100644
> --- a/security/keys/Makefile
> +++ b/security/keys/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_KEY_DH_OPERATIONS) += dh.o
>  obj-$(CONFIG_BIG_KEYS) += big_key.o
>  obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
>  obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
> +obj-$(CONFIG_MKTME_KEYS) += mktme.o
> diff --git a/security/keys/key.c b/security/keys/key.c
> index d97c939..5aa367b 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -679,6 +679,7 @@ struct key *key_lookup(key_serial_t id)
>  	spin_unlock(&key_serial_lock);
>  	return key;
>  }
> +EXPORT_SYMBOL(key_lookup);
>  
>  /*
>   * Find and lock the specified key type against removal.
> diff --git a/security/keys/mktme.c b/security/keys/mktme.c
> new file mode 100644
> index 0000000..977a528
> --- /dev/null
> +++ b/security/keys/mktme.c
> @@ -0,0 +1,413 @@
> +// SPDX-License-Identifier: GPL-3.0
> +
> +/* See Documentation/security/keys/mktme.rst */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/key.h>
> +#include <linux/key-type.h>
> +#include <linux/init.h>
> +#include <linux/parser.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <asm/intel_pconfig.h>
> +#include <keys/mktme-type.h>
> +#include <keys/user-type.h>
> +
> +/**
> + * struct mktme_mapping - global mapping of MKTME software keys
> + *                        to hardware keyids.
> + *
> + * @lock:   One lock used while (un)registering to protect the software
> + *	    map structure and the hardware state.

What is "one lock"?
What is "the software map structure"?
What is "the hardware state"?

If the description didn't exist at all I would be gained as much
knowledge as I gained now.

> + *
> + * @serial: Serial number associated with the software key. Userspace
> + *	    will use the serial number when invoking mktme_mprotect().

So.. user space directly invokes mktme_mprotect, which would mean a
change to the VDSO to achieve that?

"@serial: a Linux keyring serial number associated with the key"

or along the lines... Now the description is just confusing.

> + *
> + * @count:  Count is managed by mktme_mprotect(). Count is the number
> + *          of mappings outstanding with this serial/keyid pair.
> + *
> + * The MKTME Key Service API manages the adding and removing of software
> + * keys. It maps software keys to hardware keyid slots and programs the
> + * hardware keyid slots with the user requested encryption options.
> + *
> + * API mktme_mprotect() references this structure when requests are
> + * made to protect memory with one of these mapped keys.
> + */

Almos follows kdoc except no newlines between variable descriptions.

> +
> +struct mktme_mapping {
> +	struct mutex		lock;	/* protect mktme_map & hw state */
> +	struct data {
> +		key_serial_t	serial;
> +		unsigned int	count;
> +	} id[];
> +};

I'm totally against aligning struct fields albeit I think it makes sense
for enums. Tends to be one big causer of merge conflicts when you
backport to stable kernels.

> +
> +struct mktme_mapping *mktme_map;
> +unsigned int mktme_max_keyids;		/* max hardware keyids   */
> +unsigned int mktme_mapped_keyids;	/* number of keys mapped */

Should be static.

Since there is a single global array of mappings it would be cleaner to
have a named struct to describe a mapping and then just array of thos
e.g.

struct mktme_mapping {
	key_serial_t serial;
	unsigned int count;
};

static LIST_HEAD(mktme_mapping_list);
static struct mutex mktme_mapping_lock;:

> +
> +#define MKTME_DEBUG 0
> +#if MKTME_DEBUG

Ugh, you should rather use pr_debug() rather than this ugly
construction.

> +static inline void dump_keys(void)
> +{
> +	int i = mktme_max_keyids + 1;
> +
> +	while (i--)
> +		pr_info(" [%d:%d:%d]\n", i, mktme_map->id[i].serial,
> +			mktme_map->id[i].count);
> +}
> +
> +static inline void dump_kprog(struct mktme_key_program *kprog)
> +{
> +	print_hex_dump(KERN_INFO, "key_field_1: ", DUMP_PREFIX_NONE, 8, 1,
> +		       kprog->key_field_1, MKTME_MAX_OPTION_SIZE / 2, 1);
> +	print_hex_dump(KERN_INFO, "key_field_2: ", DUMP_PREFIX_NONE, 8, 1,
> +		       kprog->key_field_2, MKTME_MAX_OPTION_SIZE / 2, 1);
> +	pr_info("key_ctl [%x]\n", kprog->keyid_ctrl);
> +}
> +#else
> +static inline void dump_keys(void)
> +{
> +}
> +
> +static inline void dump_kprog(struct mktme_key_program *kprog)
> +{
> +}
> +#endif
> +
> +/*
> + * If a valid serial# is passed in, return the assigned keyid
> + * or EINVAL for invalid serial.
> + * If 0 is passed in, return an available keyid, or EINVAL if
> + * no more keyids are available.
> + */
> +
> +int mktme_get_keyid(key_serial_t serial)
> +{
> +	int i = mktme_max_keyids;
> +
> +	for (i = mktme_max_keyids; i > 0; i--)
> +		if (mktme_map->id[i].serial = serial)
> +			return i;
> +	return -EINVAL;
> +}
> +
> +static int mktme_unregister_key(int keyid)
> +{
> +	struct mktme_key_program *kprog = NULL;
> +	int ret;
> +
> +	kprog = kzalloc(sizeof(*kprog), GFP_KERNEL);
> +	if (!kprog)
> +		return -ENOMEM;
> +
> +	kprog->keyid = keyid;
> +	kprog->keyid_ctrl = MKTME_KEYID_CLEAR_KEY;
> +
> +	/* TODO ret = mktme_key_program(kprog); */
> +	ret = MKTME_PROG_SUCCESS;

No TODO's allowed.

> +
> +	if (ret = MKTME_PROG_SUCCESS) {
> +		mktme_map->id[kprog->keyid].serial = 0;
> +		mktme_map->id[kprog->keyid].count = 0;
> +		mktme_mapped_keyids--;
> +	}
> +	/* TODO pr the descriptive HW errors before passing up */
> +
> +	return ret;
> +}
> +
> +/*
> + * Check that for each keyid that is currently programmed, there is a
> + * valid userspace key associated. If the userspace key no longer exists,
> + * unregister it (clear it from both software and hardware)
> + *
> + * So far - it seems we can get here if a 'keyctl invalidate' is done.
> + * If we can find a way to block unwanted key control options, this defense
> + * could be removed.
> + *
> + * Call with mktme_map->lock held.
> + *
> + * Returns the keyid recovered, or 0 if no key is recovered.
> + */
> +

This should be in kdoc format and no newline-character in-between.

> +static int mktme_recover_key(void)
> +{
> +	int i = mktme_max_keyids;
> +	struct key *key;
> +
> +	do {
> +		if (!mktme_map->id[i].serial)
> +			continue;
> +
> +		key = key_lookup(mktme_map->id[i].serial);
> +		if (IS_ERR(key))
> +			goto recover;
> +
> +		if (key_validate(key) < 0) {
> +			/*
> +			 * Here the key ptr is good, but the
> +			 * key may * be marked for removal.
> +			 * Leave this here to watch for.
> +			 */
> +			pr_info("%s key validate fails\n", __func__);
> +			goto recover;
> +		}
> +	} while (i--);
> +
> +	return 0;
> +recover:
> +	mktme_unregister_key(i);
> +	return i;
> +}
> +
> +/* Add the key to software map and progam key into the hardware. */
> +
> +static int mktme_register_key(key_serial_t serial,
> +			      struct mktme_key_program *kprog)
> +{
> +	int keyid, ret;
> +
> +	/*
> +	 * If it appears that we are out of keyid's, try to
> +	 * recover an abandoned keyid. Note that Keyid 0 is
> +	 * reserved for system level TME.
> +	 */
> +
> +	if (mktme_mapped_keyids < mktme_max_keyids)
> +		keyid = mktme_get_keyid(0);
> +	else
> +		keyid = mktme_recover_key();
> +
> +	if (keyid = 0)
> +		return -EDQUOT;
> +
> +	kprog->keyid = keyid;
> +	dump_kprog(kprog);
> +
> +	/* TODO ret = mktme_key_program(kprog); */
> +	ret = MKTME_PROG_SUCCESS;
> +	if (ret = MKTME_PROG_SUCCESS) {
> +		mktme_map->id[keyid].serial = serial;
> +		mktme_map->id[keyid].count = 0;
> +		mktme_mapped_keyids++;
> +	}
> +	/* TODO pr the descriptive HW errors before passing up */
> +
> +	return ret;
> +}
> +
> +enum {
> +	opt_err = -1,
> +	opt_userkey,
> +	opt_tweak,
> +	opt_entropy,
> +	opt_algorithm,
> +};

Enums should be named and should be in all capitals e.g.

enum mktme_opt_ids {
	OPT_ERR = -1,
	/* ... */
};

> +
> +static const match_table_t mktme_tokens = {
> +	{opt_userkey, "userkey=%s"},
> +	{opt_tweak, "tweak=%s"},
> +	{opt_entropy, "entropy=%s"},
> +	{opt_algorithm, "algorithm=%s"},
> +	{opt_err, NULL}
> +};
> +
> +/*
> + * Sanity check the user specified options against each algorithms
> + * requirements.
> + *
> + * Success returns 0, otherwise -EINVAL.
> + */
> +
> +static int mktme_check_options(struct mktme_key_program *kprog,
> +			       unsigned long token_mask)
> +{
> +	/* no userkey specified, use cpu generated key */
> +	if (!test_bit(opt_userkey, &token_mask))
> +		kprog->keyid_ctrl |= MKTME_KEYID_SET_KEY_RANDOM;

What is the *non-obvious* fact that the comment provides that is not
*obvious* from the code? Maybe you should consider removing the comment?

English sentences start with a capital letter and end with a period.

> +	/* no algorithm specified, use aes_xts_128 */
> +	if (!test_bit(opt_algorithm, &token_mask))
> +		kprog->keyid_ctrl |= MKTME_AES_XTS_128;
> +
> +	/* userkey specified, no entropy allowed */
> +	if ((test_bit(opt_userkey, &token_mask)) &&
> +	    (test_bit(opt_entropy, &token_mask))) {
> +		pr_err("mktme: entropy not an option with userkey\n");
> +		return -EINVAL;
> +	}
> +	/* userkey specified with aes_xts_128, requires tweak */
> +	if ((test_bit(opt_userkey, &token_mask)) &&
> +	    (kprog->keyid_ctrl & MKTME_AES_XTS_128)) {
> +		if (!(test_bit(opt_tweak, &token_mask))) {
> +			pr_err("mktme: algorithm requires a tweak key\n");
> +			return -EINVAL;
> +		}
> +	}
> +	dump_kprog(kprog);
> +	return 0;
> +}

Same for other comments except tweak is a completely non-obvious
concept.

> +
> +/* Parse the options from the datablob and fill in struct mktme_key_program.
> + * After parsing, call mktme_check_options() for sanity checking.
> + *
> + * Success returns 0, otherwise -EINVAL.
> + */

kdoc

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> +static int mktme_get_options(char *datablob, struct mktme_key_program *kprog)
> +{
> +	enum mktme_alg alg = MKTME_ALG__LAST;
> +	substring_t args[MAX_OPT_ARGS];
> +	unsigned long token_mask = 0;
> +	int len, ret, token;
> +	char *p = datablob;
> +
> +	while ((p = strsep(&datablob, " \t"))) {
> +		if (*p = '\0' || *p = ' ' || *p = '\t')
> +			continue;
> +		token = match_token(p, mktme_tokens, args);
> +		if (test_and_set_bit(token, &token_mask))
> +			return -EINVAL;
> +
> +		len = strlen(args[0].from) / 2;
> +		if (len > MKTME_MAX_OPTION_SIZE)
> +			return -EINVAL;
> +
> +		switch (token) {
> +		case opt_userkey:
> +			ret = hex2bin(kprog->key_field_1, args[0].from, len);
> +			if (ret < 0)
> +				return -EINVAL;
> +			kprog->keyid_ctrl |= MKTME_KEYID_SET_KEY_DIRECT;
> +			break;
> +
> +		case opt_tweak:
> +			ret = hex2bin(kprog->key_field_2, args[0].from, len);
> +			if (ret < 0)
> +				return -EINVAL;
> +			break;
> +
> +		case opt_entropy:
> +			ret = hex2bin(kprog->key_field_1, args[0].from, len);
> +			if (ret < 0)
> +				return -EINVAL;
> +			break;
> +
> +		case opt_algorithm:
> +			alg = match_string(mktme_alg_name, MKTME_ALG__LAST,
> +					   args[0].from);
> +			switch (alg) {
> +			case MKTME_ALG_AES_XTS_128:
> +				kprog->keyid_ctrl |= MKTME_AES_XTS_128;
> +				break;
> +
> +			case MKTME_ALG_NO_ENCRYPT:
> +				kprog->keyid_ctrl |= MKTME_KEYID_NO_ENCRYPT;
> +				break;
> +
> +			default:
> +				return -EINVAL;
> +			}
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	dump_kprog(kprog);
> +	return mktme_check_options(kprog, token_mask);
> +}
> +
> +/* Key Service Command: Creates a software key and programs hardware */
> +
> +int mktme_instantiate(struct key *key, struct key_preparsed_payload *prep)
> +{
> +	struct mktme_key_program *kprog = NULL;
> +	size_t datalen = prep->datalen;
> +	char *datablob;
> +	int ret = 0;
> +
> +	if (datalen <= 0 || datalen > 1024 || !prep->data)
> +		return -EINVAL;
> +
> +	datablob = kmemdup(prep->data, datalen + 1, GFP_KERNEL);
> +	if (!datablob)
> +		return -ENOMEM;
> +
> +	datablob[datalen] = '\0';
> +	kprog = kzalloc(sizeof(*kprog), GFP_KERNEL);
> +	if (!kprog) {
> +		kzfree(datablob);
> +		return -ENOMEM;
> +	}
> +	ret = mktme_get_options(datablob, kprog);
> +	if (ret < 0)
> +		goto out;
> +
> +	mutex_lock(&mktme_map->lock);
> +	ret = mktme_register_key(key->serial, kprog);
> +	mutex_unlock(&mktme_map->lock);
> +out:
> +	kzfree(datablob);
> +	kzfree(kprog);
> +	dump_keys();
> +	return ret;
> +}
> +
> +/* Key Service Command: Clears the keys software and hardware */
> +
> +void mktme_revoke(struct key *key)
> +{
> +	int keyid;
> +
> +	keyid = mktme_get_keyid(key->serial);
> +	if (keyid < 0)
> +		return;
> +
> +	mutex_lock(&mktme_map->lock);
> +	mktme_unregister_key(keyid);
> +	mutex_unlock(&mktme_map->lock);
> +	dump_keys();
> +}
> +
> +struct key_type key_type_mktme = {
> +	.name = "mktme",
> +	.instantiate = mktme_instantiate,
> +	.revoke = mktme_revoke,
> +	.describe = user_describe,
> +};
> +
> +/*
> + * Get the maximum keyids reported from BIOS.
> + * Allocate the mktme_map structure and register mktme key type.
> + */
> +static int __init init_mktme(void)
> +{
> +	int ret;
> +
> +	/* TODO: get real max hardware keyids */
> +	/* mktme_max_keyids = nr_keyids; */
> +
> +	mktme_max_keyids = 100;
> +	mktme_mapped_keyids = 0;
> +	mktme_map = kzalloc((sizeof(mktme_map->id[0]) * mktme_max_keyids)
> +			    + (sizeof(mktme_map->lock)), GFP_KERNEL);
> +	if (!mktme_map)
> +		return -ENOMEM;
> +
> +	mutex_init(&mktme_map->lock);
> +	ret = register_key_type(&key_type_mktme);
> +	if (ret < 0)
> +		kfree(mktme_map);
> +
> +	return ret;
> +}
> +
> +static void __exit cleanup_mktme(void)
> +{
> +	unregister_key_type(&key_type_mktme);
> +	kfree(mktme_map);
> +}
> +
> +late_initcall(init_mktme);
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe keyrings" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Even for RFC you should aim something that could be wrong but you think
it is in the right direction. Get rid of all TODO's for the next
version.

/Jarkko
