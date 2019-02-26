From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 26 Feb 2019 09:11:18 +0000
Subject: Re: [PATCH] security: keys: add NULL checking for key->type->instantiate
Message-Id: <20190226091118.GB3197@OptiPlex>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
 <31395.1549492013@warthog.procyon.org.uk>
In-Reply-To: <31395.1549492013@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:26:53PM +0000, David Howells wrote:
> Geliang Tang <geliangtang@gmail.com> wrote:
> 
> > key->type->instantiate can be NULL, add NULL checking to prevent
> > NULL pointer dereference in __key_instantiate_and_link().
> 
> Do you have an oops report or test case for this?
> 
> David

Here is the test module code. Insmod it, we can get the oops.

#include <linux/init.h>
#include <linux/module.h>
#include <linux/key.h>
#include <linux/key-type.h>
#include <linux/cred.h>
#include <linux/seq_file.h>

static int test_instantiate(struct key *key, struct key_preparsed_payload *prep)
{
	return 0;
}

static void test_describe(const struct key *key, struct seq_file *m)
{
	seq_puts(m, key->description);
}

struct key_type test_key_type = {
        .name           = "test",
	//.instantiate	= test_instantiate,
        .describe       = test_describe,
};

static int __init test_init(void)
{
	const struct cred *cred = current_cred();
	struct key *key;
	int ret;

	register_key_type(&test_key_type);

	key = key_alloc(&test_key_type, "test",
			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
			KEY_POS_SEARCH, KEY_ALLOC_NOT_IN_QUOTA, NULL);
	if (IS_ERR(key))
		return -1;

	pr_info("keyring allocated successfully.\n");

	ret = key_instantiate_and_link(key,
				       NULL,
				       sizeof(int),
				       current->cred->user->session_keyring,
				       NULL);
	if (ret < 0) {
		key_revoke(key);
		key_put(key);
		return ret;
	}

	return 0;
}

static void __exit test_exit(void)
{
	unregister_key_type(&test_key_type);
}

module_init(test_init);
module_exit(test_exit);

MODULE_LICENSE("GPL");
