From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 11:24:44 +0000
Subject: Re: [PATCH v13 5/5] security: keys: trusted: Make sealed key properly interoperable
Message-Id: <20200930112444.GC5145@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-6-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200922022809.7105-6-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Mon, Sep 21, 2020 at 07:28:09PM -0700, James Bottomley wrote:
> The current implementation appends a migratable flag to the end of a
> key, meaning the format isn't exactly interoperable because the using
> party needs to know to strip this extra byte.  However, all other
> consumers of TPM sealed blobs expect the unseal to return exactly the
> key.  Since TPM2 keys have a key property flag that corresponds to
> migratable, use that flag instead and make the actual key the only
> sealed quantity.  This is secure because the key properties are bound
> to a hash in the private part, so if they're altered the key won't
> load.
> 
> Backwards compatibility is implemented by detecting whether we're
> loading a new format key or not and correctly setting migratable from
> the last byte of old format keys.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

➜  tpm2-scripts (master) ✗ sudo keyctl add trusted kmk2 "new 32 blobauth=world keyhandle�000000 migratable=1" @u
add_key: Invalid argument
➜  tpm2-scripts (master) ✗ sudo keyctl add trusted kmk2 "new 32 blobauth=world keyhandle�000000 migratable=0" @u
608433517

Showed the -EINVAL example just to point out this:

	case Opt_migratable:
		if (*args[0].from = '0')
			pay->migratable = 0;
		else
			return -EINVAL;
		break;

I think it should just set migratable in both cases even if no-op,
given that it takes the value and also the documentation says that
"migratable=1" is legit:

"migratable=   0|1 indicating permission to reseal to new PCR values,
                default 1 (resealing allowed)"

Obviously not a concern of this patch but this is still IMHO a bug.
Would be nce if you could drop a prepending patch to fix this, when you
rebase the series, with this fixes tag:

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")

BTW, please check my fixes so that I can push them ASAP and you get to
rebase this and we can land it. Now everything is properly tested.

/Jarkko
