From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 29 May 2019 12:47:58 +0000
Subject: Re: [PATCH, RFC 05/62] mm/page_alloc: Handle allocation for encrypted memory
Message-Id: <20190529124758.ojyakxdx2zf6nmtt@box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-6-kirill.shutemov@linux.intel.com>
 <20190529072124.GC3656@rapoport-lnx>
In-Reply-To: <20190529072124.GC3656@rapoport-lnx>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:21:25AM +0300, Mike Rapoport wrote:
> Shouldn't it be EXPORT_SYMBOL?

We don't have callers outside core-mm at the moment.

I'll add kerneldoc in the next submission.

-- 
 Kirill A. Shutemov
