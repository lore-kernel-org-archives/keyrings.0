From: David Howells <dhowells@redhat.com>
Date: Mon, 16 Mar 2020 11:50:51 +0000
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding key semaphore
Message-Id: <1797278.1584359451@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-2-longman@redhat.com> <20200313152102.1707-1-longman@redhat.com>
In-Reply-To: <20200313152102.1707-2-longman@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>

Waiman Long <longman@redhat.com> wrote:

>  include/linux/key-type.h                  |  2 +-
>  security/keys/big_key.c                   | 11 ++---
>  security/keys/encrypted-keys/encrypted.c  |  7 ++-
>  security/keys/keyctl.c                    | 57 +++++++++++++++++++----
>  security/keys/keyring.c                   |  6 +--
>  security/keys/request_key_auth.c          |  7 ++-
>  security/keys/trusted-keys/trusted_tpm1.c | 14 +-----
>  security/keys/user_defined.c              |  5 +-
> ...
> -	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
> +	long (*read)(const struct key *key, char *buffer, size_t buflen);

Note that there are read functions outside of security/keys/ that also need
fixing - dns_resolver_read() and rxrpc_read().

David
