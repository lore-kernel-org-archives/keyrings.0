From: David Howells <dhowells@redhat.com>
Date: Wed, 22 Jul 2020 08:01:44 +0000
Subject: Re: [PATCH] KEYS: remove redundant memsets
Message-Id: <695450.1595404904@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200721141516.20335-1-trix@redhat.com>
In-Reply-To: <20200721141516.20335-1-trix@redhat.com>
To: trix@redhat.com
Cc: dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

trix@redhat.com wrote:

> -	if (copy_from_user(&uparams, _params, sizeof(uparams)) != 0)
> -		return -EFAULT;
> -
>  	ret = keyctl_pkey_params_get(uparams.key_id, _info, params);

Erm...  uparams is used on the very next statement after the copy_from_user().

David
