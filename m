From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 15 May 2020 02:22:31 +0000
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Message-Id: <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
In-Reply-To: <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
> I'm compiling now kernel with all series included.
> 
> Kind of checking if I could just take the whole series. Let see.
> 
> In all cases I want the style errors in 3/8 to be fixes with a helper
> but maybe better to hold before sending anything. Possibly that is all
> needed I'll just carve that patch myself.
> 
> Please don't do anything for the moment.

This is what I tried first (with the full series applied):

#!/bin/sh

die()
{
	keyctl clear @u
	./tpm2-flush --all-transient
	exit $1
}

KEYHANDLE=$(./tpm2-root-key || die 1)
KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE hash=sha256" @u || die 1)

echo "$KEYID ($KEYHANDLE)"

keyctl pipe $KEYID > blob.hex || die 1
keyctl clear @u || die 1

echo "Import key from blob"

keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u || die 1

die 0

Result:

sudo ./keyctl-smoke.sh
566201053 (0x80000000)
keyctl_read_alloc: Permission denied

Any ideas what I might have done wrong? Have not tried auth value yet
but afaik the above should fully test import and export.

Uses tpm2-scripts:

https://github.com/jsakkine-intel/tpm2-scripts

I'll probably move these to git.infradead.org because I don't like
really like at all Github and my kernel tree is there anyway.

/Jarkko
