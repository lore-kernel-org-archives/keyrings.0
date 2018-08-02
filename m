From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Aug 2018 16:14:41 +0000
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
Message-Id: <8060.1533226481@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
In-Reply-To: <20180723111432.26830-1-udit.agarwal@nxp.com>
To: Udit Agarwal <udit.agarwal@nxp.com>
Cc: dhowells@redhat.com, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com, ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com

Udit Agarwal <udit.agarwal@nxp.com> wrote:

> +=====
> +Secure Key
> +=====
> +
> +Secure key is the new type added to kernel key ring service.
> +Secure key is a symmetric type key of minimum length 32 bytes
> +and with maximum possible length to be 128 bytes. It is produced
> +in kernel using the CAAM crypto engine. Userspace can only see
> +the blob for the corresponding key. All the blobs are displayed
> +or loaded in hex ascii.

To echo Mimi, this sounds suspiciously like it should have a generic
interface, not one that's specifically tied to one piece of hardware -
particularly if it's named with generic "secure".

Can you convert this into a "symmetric" type and make the backend pluggable?

> +	keyctl add secure <name> "new <keylen>" <ring>
> +	keyctl load secure <name> "load <hex_blob>" <ring>
> +	keyctl print <key_id>

There isn't a "keyctl load" that I recall.  Did you mean "keyctl add"?

I wonder if it makes sense to actually add "create" and "load" interfaces for
asymmetric and symmetric key types to aid in key management, e.g.:

	keyctl create symmetric.caam foo_munging_key len8 @s
	keyctl load symmetric.caam foo_munging_key id=xxx @s
	keyctl create asymmetric.tpm foo_signing_key "rsa len@96" @s
	keyctl load asymmetric.tpm foo_signing_key id=xxx @s

Note the subtype extension added to the type.  This is something I've been
meaning to add to add_key() and request_key().  It means that we don't have to
try and divine the nature of the key from the payload, but can leave the
payload as just the data if data is needed.

This might look something like:

	key = keyctl_create(const char *type, const char *desc,
			    const char *data, key_serial_t keyring);
	key = keyctl_load(const char *type, const char *desc,
			  const char *id, key_serial_t keyring);

There would probably need to be a way to query the ID of a created key also,
so that you can then pass that ID back to the loader.

	keyctl_get_id(key_serial_t key, char *buf, size_t buf_size);

David
