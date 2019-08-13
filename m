From: Ben Boeckel <mathstuf@gmail.com>
Date: Tue, 13 Aug 2019 13:07:02 +0000
Subject: Re: [PATCHv2 57/59] x86/mktme: Document the MKTME Key Service API
Message-Id: <20190813130702.GC9079@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
 <20190731150813.26289-58-kirill.shutemov@linux.intel.com>
 <20190805115837.GB31656@rotor>
 <20190805204453.GB7592@alison-desk.jf.intel.com>
In-Reply-To: <20190805204453.GB7592@alison-desk.jf.intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

On Mon, Aug 05, 2019 at 13:44:53 -0700, Alison Schofield wrote:
> Yes. Fixed up as follows:
> 
> 	Add a "no-encrypt' type key::
> 
>         char \*options_NOENCRYPT = "type=no-encrypt";
> 
>         key = add_key("mktme", "name", options_NOENCRYPT,
>                       strlen(options_NOENCRYPT), KEY_SPEC_THREAD_KEYRING);

Thanks. Looks good to me.

Reviewed-by: Ben Boeckel <mathstuf@gmail.com>

--Ben
