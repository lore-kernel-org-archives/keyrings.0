From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Thu, 06 Dec 2018 11:22:55 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
 <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
 <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
In-Reply-To: <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
To: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "jmorris@namei.org" <jmorris@namei.org>, "Huang, Kai" <kai.huang@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

On Wed, Dec 05, 2018 at 08:32:52PM +0000, Sakkinen, Jarkko wrote:
> On Tue, 2018-12-04 at 12:46 +0300, Kirill A. Shutemov wrote:
> > On Tue, Dec 04, 2018 at 09:25:50AM +0000, Peter Zijlstra wrote:
> > > On Mon, Dec 03, 2018 at 11:39:47PM -0800, Alison Schofield wrote:
> > > > (Multi-Key Total Memory Encryption)
> > > 
> > > I think that MKTME is a horrible name, and doesn't appear to accurately
> > > describe what it does either. Specifically the 'total' seems out of
> > > place, it doesn't require all memory to be encrypted.
> > 
> > MKTME implies TME. TME is enabled by BIOS and it encrypts all memory with
> > CPU-generated key. MKTME allows to use other keys or disable encryption
> > for a page.
> 
> When you say "disable encryption to a page" does the encryption get
> actually disabled or does the CPU just decrypt it transparently i.e.
> what happens physically?

Yes, it gets disabled. Physically. It overrides TME encryption.

-- 
 Kirill A. Shutemov
