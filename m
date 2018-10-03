From: James Morris <jmorris@namei.org>
Date: Wed, 03 Oct 2018 19:03:56 +0000
Subject: Re: [PATCH 03/22] KEYS: Provide missing asymmetric key subops for new key type ops
Message-Id: <alpine.LRH.2.21.1810040503001.16168@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618447788.7946.12036865757091293640.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618447788.7946.12036865757091293640.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018, David Howells wrote:

> +int asymmetric_key_eds_op(struct kernel_pkey_params *params,
> +			  const void *in, void *out)
> +{
> +	const struct asymmetric_key_subtype *subtype;
> +	struct key *key = params->key;
> +	int ret;
> +
> +	pr_devel("=>%s()\n", __func__);

Are you planning on leaving these pr_devel()s in?

-- 
James Morris
<jmorris@namei.org>
