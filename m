From: David Howells <dhowells@redhat.com>
Date: Fri, 09 Nov 2018 15:05:27 +0000
Subject: Re: [PATCH] KEYS: revert requiring signature "encoding"
Message-Id: <20321.1541775927@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1541772875.3990.29.camel@linux.ibm.com> <1541743166-5036-1-git-send-email-zohar@linux.ibm.com> <27927.1541769383@warthog.procyon.org.uk>
In-Reply-To: <1541772875.3990.29.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Mimi Zohar <zohar@linux.ibm.com> wrote:

> Looking the patch over again, do you prefer the duplicate call or
> defining a local variable and using the ternary conditional operator
> ("?:") like this:
> 
> 	bool rsa = false;
> 
> 	if (!(sig->encoding) && strcmp(pkey->pkey_algo, "rsa") = 0)
>                 rsa = true;
> 
>         ret = software_key_determine_akcipher(rsa ? "pkcs1" : sig->encoding,
>                                               sig->hash_algo,
>                                               pkey, alg_name);

Might be better to do:

	const char *encoding = sig->encoding;

	if (!encoding && strcmp(pkey->pkey_algo, "rsa") = 0)
		encoding = "pkcs1";

	ret = software_key_determine_akcipher(encoding, ...

David
