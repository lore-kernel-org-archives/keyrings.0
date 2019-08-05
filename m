From: Alison Schofield <alison.schofield@intel.com>
Date: Mon, 05 Aug 2019 20:31:02 +0000
Subject: Re: [PATCHv2 25/59] keys/mktme: Preparse the MKTME key payload
Message-Id: <20190805203102.GA7592@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
 <20190731150813.26289-26-kirill.shutemov@linux.intel.com>
 <20190805115819.GA31656@rotor>
In-Reply-To: <20190805115819.GA31656@rotor>
To: Ben Boeckel <mathstuf@gmail.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

On Mon, Aug 05, 2019 at 07:58:19AM -0400, Ben Boeckel wrote:
> On Wed, Jul 31, 2019 at 18:07:39 +0300, Kirill A. Shutemov wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > +/* Make sure arguments are correct for the TYPE of key requested */
> > +static int mktme_check_options(u32 *payload, unsigned long token_mask,
> > +			       enum mktme_type type, enum mktme_alg alg)
> > +{
> > +	if (!token_mask)
> > +		return -EINVAL;
> > +
> > +	switch (type) {
> > +	case MKTME_TYPE_CPU:
> > +		if (test_bit(OPT_ALGORITHM, &token_mask))
> > +			*payload |= (1 << alg) << 8;
> > +		else
> > +			return -EINVAL;
> > +
> > +		*payload |= MKTME_KEYID_SET_KEY_RANDOM;
> > +		break;
> > +
> > +	case MKTME_TYPE_NO_ENCRYPT:
		if (test_bit(OPT_ALGORITHM, &token_mask))
			return -EINVAL;
> > +		*payload |= MKTME_KEYID_NO_ENCRYPT;
> > +		break;
> 
> The documentation states that for `type=no-encrypt`, algorithm must not
> be specified at all. Where is that checked?
> 
> --Ben
It's not currently checked, but should be. 
I'll add it as shown above.
Thanks for the review,
Alison
