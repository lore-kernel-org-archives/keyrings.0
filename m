Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95F2D7380;
	Sat, 30 May 2026 00:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102181; cv=none; b=fzhumanY26DXr+5IUTNxPE6YT15ILUqgG13EMdtVHbqywFRP3bFBa2DK71FjeYhj5dBiowsVlAJw+8PWQ0BRv133okSg1sI8ZzZ8pbpBlQpqz7ls6pXBDjf42yBDadc0aJtkyuSz0zp+Aq/O5JvFx+scx2LYJsjxeHlM8QAYtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102181; c=relaxed/simple;
	bh=35KOIQbjEoSeh+1qGzA3Ip30rURFMu/I+G+2pGv7BTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koOEosEEbg6tVz2drDqGCq2IxA6zauVGmGE9afMcyYBIf44YLiZldpzgKDQNTYGAydr0CF7XB/TZY/KZVHgwlU3eFyBxZRBRXr1+vRkZnYeWM94XnBxSqf07UHRPuwnZcKrnGI3aGlnNVmqHyDMnRe38nU0HqIEejTXiKLgv5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR+tr/fQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR+tr/fQ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E1A8F1F00893;
	Sat, 30 May 2026 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102180;
	bh=lT4mfvZMRgUMeqUuX+o0Wy/QrmIbIfiVQ04RemgOQ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CR+tr/fQ1STZPvL/bibRKFMiDNHiN+hxzy1rXTJ2lxm/2l8qZ5FJ99+4Zwn6W+ZZn
	 9HgOQsATff9tO3j2WxMw/fG/wCflNXEWuuzGiGFDI5Yo/1tFMfwh6eixgtCYWNMEIs
	 j1579nk9jmsFYrh8+NngUbBAEr0Ymcs3g6dPBLv1AVmcNNXF6AwmEIjRDETd01+fXq
	 fWjPgYJr8XS5NV1M+shIjj1g2yYOilRHYsJMiCu5ytzBZpgfQXlax4yev9kyrvIol/
	 Vpr7Qr+3Pw5RHh5yI1XYXCRzz8pKFpPehbua56nbnwj+6rSJFiZdQcdZhwYRYFWnUi
	 dtlPUAAWJks2Q==
Date: Sat, 30 May 2026 03:49:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Liu Mingyu <Edwardliu0214@outlook.com>
Cc: David Howells <dhowells@redhat.com>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] keys: Enforce keep guard when moving keys
Message-ID: <aho0IDYyV4B81KZq@kernel.org>
References: <ME0P300MB0618CDE63E5F370D2790CDE9AA162@ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ME0P300MB0618CDE63E5F370D2790CDE9AA162@ME0P300MB0618.AUSP300.PROD.OUTLOOK.COM>

On Fri, May 29, 2026 at 04:54:52AM +0000, Liu Mingyu wrote:
> KEYCTL_MOVE removes the source link as part of moving a key
> between keyrings. key_unlink() rejects removal of a
> KEY_FLAG_KEEP-protected key from a KEY_FLAG_KEEP-protected keyring,
> but key_move() did not enforce the same rule.

Got it.

> 
> Reject such moves with -EPERM when both the source keyring and key
> are protected. Leave same-keyring moves as a no-op so callers can
> continue to use KEYCTL_MOVE idempotently. Document the errno and add
> KUnit coverage for the normal move, protected rejection and no-op paths.
> 
> Fixes: ed0ac5c7ec37 ("keys: Add a keyctl to move a key between keyrings")
> Signed-off-by: Mingyu Liu <edwardliu0214@outlook.com>

It'd be better to split kunit into separate patch as otherwise this is
not too fluid to backport.


> ---
>  Documentation/security/keys/core.rst |   1 +
>  security/keys/Kconfig                |  13 +++
>  security/keys/Makefile               |   1 +
>  security/keys/keyctl.c               |   2 +
>  security/keys/keyring.c              |   7 +-
>  security/keys/keyring_test.c         | 121 +++++++++++++++++++++++++++
>  6 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 security/keys/keyring_test.c
> 
> diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
> index 326b8a973828..6096ce6c63da 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -600,6 +600,7 @@ The keyctl syscall functions are:
>       A process must have link permission on the key for this function to be
>       successful and write permission on both keyrings.  Any errors that can
>       occur from KEYCTL_LINK also apply on the destination keyring here.
> +     If the key and source keyring are protected, EPERM will be returned.
>  
>  
>    *  Unlink a key or keyring from another keyring::
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 84f39e50ca36..acffb5f7385c 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -129,4 +129,17 @@ config KEY_NOTIFICATIONS
>  	  This makes use of pipes to handle the notification buffer and
>  	  provides KEYCTL_WATCH_KEY to enable/disable watches.
>  
> +config KEYS_KUNIT_TEST
> +	tristate "KUnit tests for keyrings" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Build KUnit tests for keyring operations.
> +	  These tests exercise keyring link and move behavior, including
> +	  protection of KEY_FLAG_KEEP entries.
> +	  They are intended for KUnit runs on developer kernels and are not
> +	  needed for normal systems.
> +
> +	  If you are unsure how to answer this question, answer N.
> +
>  endif # KEYS
> diff --git a/security/keys/Makefile b/security/keys/Makefile
> index 5f40807f05b3..fa583a4ea945 100644
> --- a/security/keys/Makefile
> +++ b/security/keys/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_SYSCTL) += sysctl.o
>  obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
>  obj-$(CONFIG_KEY_DH_OPERATIONS) += dh.o
>  obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
> +obj-$(CONFIG_KEYS_KUNIT_TEST) += keyring_test.o
>  
>  #
>  # Key types
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index ef855d69c97a..b37bf1505ec5 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -590,6 +590,8 @@ long keyctl_keyring_unlink(key_serial_t id, key_serial_t ringid)
>   * the caller Write permission.  There must also be a link in the from keyring
>   * to the key.  If both keyrings are the same, nothing is done.
>   *
> + * If the key and source keyring are protected, -EPERM will be returned.
> + *
>   * If successful, 0 will be returned.
>   */
>  long keyctl_keyring_move(key_serial_t id, key_serial_t from_ringid,
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5a9887d6b7be..60c184bd9a8d 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1582,7 +1582,8 @@ EXPORT_SYMBOL(key_unlink);
>   *
>   * Returns 0 if successful, -ENOTDIR if either keyring isn't a keyring,
>   * -EKEYREVOKED if either keyring has been revoked, -ENFILE if the second
> - * keyring is full, -EDQUOT if there is insufficient key data quota remaining
> + * keyring is full, -EPERM if this would remove a protected key from a
> + * protected keyring, -EDQUOT if there is insufficient key data quota remaining
>   * to add another link or -ENOMEM if there's insufficient memory.  If
>   * KEYCTL_MOVE_EXCL is set, then -EEXIST will be returned if there's already a
>   * matching key in @to_keyring.
> @@ -1608,6 +1609,10 @@ int key_move(struct key *key,
>  	key_check(from_keyring);
>  	key_check(to_keyring);
>  
> +	if (test_bit(KEY_FLAG_KEEP, &from_keyring->flags) &&
> +	    test_bit(KEY_FLAG_KEEP, &key->flags))
> +		return -EPERM;
> +
>  	ret = __key_move_lock(from_keyring, to_keyring, &key->index_key);
>  	if (ret < 0)
>  		goto out;
> diff --git a/security/keys/keyring_test.c b/security/keys/keyring_test.c
> new file mode 100644
> index 000000000000..0055b50224e9
> --- /dev/null
> +++ b/security/keys/keyring_test.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * KUnit tests for keyring operations.
> + */
> +
> +#include <keys/user-type.h>
> +#include <kunit/test.h>
> +#include <linux/cred.h>
> +#include <linux/err.h>
> +#include <linux/key.h>
> +#include <linux/key-type.h>
> +#include <linux/keyctl.h>
> +#include <linux/module.h>
> +#include <linux/uidgid.h>
> +
> +static void keyring_test_key_put(void *data)
> +{
> +	key_put(data);
> +}
> +
> +static struct key *test_keyring_alloc(struct kunit *test, const char *desc,
> +				      unsigned long flags)
> +{
> +	struct key *keyring;
> +
> +	keyring = keyring_alloc(desc, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				current_cred(), KEY_POS_ALL | KEY_USR_ALL,
> +				KEY_ALLOC_NOT_IN_QUOTA | flags, NULL, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, keyring);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
> +							keyring_test_key_put,
> +							keyring), 0);
> +
> +	return keyring;
> +}
> +
> +static struct key *test_user_key_alloc(struct kunit *test, const char *desc,
> +				       struct key *keyring,
> +				       unsigned long flags)
> +{
> +	static const char payload[] = "payload";
> +	struct key *key;
> +	int ret;
> +
> +	key = key_alloc(&key_type_user, desc, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +			current_cred(), KEY_POS_ALL | KEY_USR_ALL,
> +			KEY_ALLOC_NOT_IN_QUOTA | flags, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, key);
> +	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
> +							keyring_test_key_put,
> +							key), 0);
> +
> +	ret = key_instantiate_and_link(key, payload, sizeof(payload),
> +				       keyring, NULL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	return key;
> +}
> +
> +static void keyring_move_user_key(struct kunit *test)
> +{
> +	struct key *from, *to, *key;
> +	int ret;
> +
> +	from = test_keyring_alloc(test, "move-from", 0);
> +	to = test_keyring_alloc(test, "move-to", 0);
> +	key = test_user_key_alloc(test, "move-key", from, 0);
> +
> +	ret = key_move(key, from, to, 0);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret = key_move(key, to, from, 0);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static void keyring_move_keep_key_fails(struct kunit *test)
> +{
> +	struct key *from, *to, *key;
> +	int ret;
> +
> +	from = test_keyring_alloc(test, "keep-from", KEY_ALLOC_SET_KEEP);
> +	to = test_keyring_alloc(test, "keep-to", 0);
> +	key = test_user_key_alloc(test, "keep-key", from, 0);
> +
> +	KUNIT_ASSERT_TRUE(test, test_bit(KEY_FLAG_KEEP, &from->flags));
> +	KUNIT_ASSERT_TRUE(test, test_bit(KEY_FLAG_KEEP, &key->flags));
> +
> +	ret = key_move(key, from, to, 0);
> +	KUNIT_EXPECT_EQ(test, ret, -EPERM);
> +
> +	ret = key_move(key, to, from, 0);
> +	KUNIT_EXPECT_EQ(test, ret, -ENOENT);
> +}
> +
> +static void keyring_move_keep_same_keyring(struct kunit *test)
> +{
> +	struct key *keyring, *key;
> +	int ret;
> +
> +	keyring = test_keyring_alloc(test, "keep-same", KEY_ALLOC_SET_KEEP);
> +	key = test_user_key_alloc(test, "keep-same-key", keyring, 0);
> +
> +	ret = key_move(key, keyring, keyring, 0);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static struct kunit_case keyring_test_cases[] = {
> +	KUNIT_CASE(keyring_move_user_key),
> +	KUNIT_CASE(keyring_move_keep_key_fails),
> +	KUNIT_CASE(keyring_move_keep_same_keyring),
> +	{}
> +};
> +
> +static struct kunit_suite keyring_test_suite = {
> +	.name = "keyring",
> +	.test_cases = keyring_test_cases,
> +};
> +
> +kunit_test_suite(keyring_test_suite);
> +
> +MODULE_LICENSE("GPL");
> 
> base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
> -- 
> 2.51.2.windows.1
> 

BR, Jarkko
