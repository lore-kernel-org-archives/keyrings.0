From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 06 Jan 2020 21:58:18 +0000
Subject: Re: [PATCH v4 5/9] security: keys: trusted: Make sealed key properly interoperable
Message-Id: <482ad14deb25b1323c0079fb120fdf0ffd0724b3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-6-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20191230173802.8731-6-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
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

I'll stop review here as I'm now quite confident that in high-level
this going to right direction.

For remaining patches:

- Be more explict with the tools. That will also give a framework to
  easily test the patches.
- Same remarks for the code formatting as I gave to earlier.

/Jarkko
