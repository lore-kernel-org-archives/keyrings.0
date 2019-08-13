From: Ben Boeckel <mathstuf@gmail.com>
Date: Tue, 13 Aug 2019 13:06:33 +0000
Subject: Re: [PATCHv2 25/59] keys/mktme: Preparse the MKTME key payload
Message-Id: <20190813130633.GB9079@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
 <20190731150813.26289-26-kirill.shutemov@linux.intel.com>
 <20190805115819.GA31656@rotor>
 <20190805203102.GA7592@alison-desk.jf.intel.com>
In-Reply-To: <20190805203102.GA7592@alison-desk.jf.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

On Mon, Aug 05, 2019 at 13:31:02 -0700, Alison Schofield wrote:
> It's not currently checked, but should be. 
> I'll add it as shown above.
> Thanks for the review,

Thanks. Seeing how this works elsewhere now, feel free to add my review
with the proposed check to the new patch.

Reviewed-by: Ben Boeckel <mathstuf@gmail.com>

--Ben
