From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 04 Dec 2018 15:35:50 +0000
Subject: Re: [RFC v2 04/13] x86/mm: Add helper functions for MKTME memory encryption keys
Message-Id: <7896A3D4-22B3-4124-BA0A-ED763128C5D6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com> <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <bd83f72d30ccfc7c1bc7ce9ab81bdf66e78a1d7d.1543903910.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, peterz@infradead.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org



> On Dec 3, 2018, at 11:39 PM, Alison Schofield <alison.schofield@intel.com> wrote:
> 
> Define a global mapping structure to manage the mapping of userspace
> Keys to hardware KeyIDs in MKTME (Multi-Key Total Memory Encryption).
> Implement helper functions that access this mapping structure.
> 

Why is a key “void *”?  Who owns the memory?  Can a real type be used?
