From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 09 Nov 2018 14:14:35 +0000
Subject: Re: [PATCH] KEYS: revert requiring signature "encoding"
Message-Id: <1541772875.3990.29.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1541743166-5036-1-git-send-email-zohar@linux.ibm.com>
         <27927.1541769383@warthog.procyon.org.uk>
In-Reply-To: <27927.1541769383@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

On Fri, 2018-11-09 at 13:16 +0000, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > Attempting to verify IMA signatures fail causing the system to hang.
> 
> Can you say why?

On systems with IMA-appraisal enabled with a policy requiring file 
signatures, the "good" signature values are stored on the filesystem
as extended attributes (security.ima).  Signature verification failure
would normally be limited to just a particular file (eg. executable),
but during boot signature verification failure could result in a
system hang.

Removing existing signature formats breaks existing systems.  This
patch adds support for RSA signatures without an explicit "pkcs1" sig-
>encoding.

> 
> > Fixes: commit 82f94f24475c ("KEYS: Provide software public key query
> >        function [ver #2]")
> 
> Btw, no word "commit" after Fixes:.

Ok.

Looking the patch over again, do you prefer the duplicate call or
defining a local variable and using the ternary conditional operator
("?:") like this:

	bool rsa = false;

	if (!(sig->encoding) && strcmp(pkey->pkey_algo, "rsa") = 0)
                rsa = true;

        ret = software_key_determine_akcipher(rsa ? "pkcs1" : sig->encoding,
                                              sig->hash_algo,
                                              pkey, alg_name);

Mimi
