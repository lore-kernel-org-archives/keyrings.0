From: James Morris <jmorris@namei.org>
Date: Wed, 18 Mar 2020 19:04:07 +0000
Subject: Re: [PATCH 06/17] watch_queue: Add a key/keyring notification facility [ver #5]
Message-Id: <alpine.LRH.2.21.2003190558240.29708@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454384808.2863966.9318850402218181933.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454384808.2863966.9318850402218181933.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com, sds@tycho.nsa.gov, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> +++ b/Documentation/security/keys/core.rst
> @@ -833,6 +833,7 @@ The keyctl syscall functions are:
>       A process must have search permission on the key for this function to be
>       successful.
>  
> +
>    *  Compute a Diffie-Hellman shared secret or public key::
>  
>  	long keyctl(KEYCTL_DH_COMPUTE, struct keyctl_dh_params *params,

Extraneous newline.


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
