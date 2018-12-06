From: Dave Hansen <dave.hansen@intel.com>
Date: Thu, 06 Dec 2018 14:59:10 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <a0a1e0d2-ef32-8378-5363-b730afc99c03@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
 <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
 <063026c66b599ba4ff0b30a5ecc7d2c716e4da5b.camel@intel.com>
 <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
In-Reply-To: <20181206112255.4bbumbrf5nnz4t2z@kshutemo-mobl1>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "jmorris@namei.org" <jmorris@namei.org>, "Huang, Kai" <kai.huang@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Schofield, Alison" <alison.schofield@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

On 12/6/18 3:22 AM, Kirill A. Shutemov wrote:
>> When you say "disable encryption to a page" does the encryption get
>> actually disabled or does the CPU just decrypt it transparently i.e.
>> what happens physically?
> Yes, it gets disabled. Physically. It overrides TME encryption.

I know MKTME itself has a runtime overhead and we expect it to have a
performance impact in the low single digits.  Does TME have that
overhead?  Presumably MKTME plus no-encryption is not expected to have
the overhead.

We should probably mention that in the changelogs too.
