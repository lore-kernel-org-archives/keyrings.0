From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Tue, 04 Dec 2018 09:46:47 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <20181204094647.tjsvwjgp3zq6yqce@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <20181204092550.GT11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181204092550.GT11614@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alison Schofield <alison.schofield@intel.com>, dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Dec 04, 2018 at 09:25:50AM +0000, Peter Zijlstra wrote:
> On Mon, Dec 03, 2018 at 11:39:47PM -0800, Alison Schofield wrote:
> > (Multi-Key Total Memory Encryption)
> 
> I think that MKTME is a horrible name, and doesn't appear to accurately
> describe what it does either. Specifically the 'total' seems out of
> place, it doesn't require all memory to be encrypted.

MKTME implies TME. TME is enabled by BIOS and it encrypts all memory with
CPU-generated key. MKTME allows to use other keys or disable encryption
for a page.

But, yes, name is not good.

-- 
 Kirill A. Shutemov
