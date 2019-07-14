From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 14 Jul 2019 18:16:49 +0000
Subject: Re: [PATCH, RFC 57/62] x86/mktme: Overview of Multi-Key Total Memory Encryption
Message-Id: <a2d2ac19-1dfe-6f85-df83-d72de4d5fcbf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-58-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-58-kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On 5/8/19 7:44 AM, Kirill A. Shutemov wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Provide an overview of MKTME on Intel Platforms.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  Documentation/x86/mktme/index.rst          |  8 +++
>  Documentation/x86/mktme/mktme_overview.rst | 57 ++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/x86/mktme/index.rst
>  create mode 100644 Documentation/x86/mktme/mktme_overview.rst


> diff --git a/Documentation/x86/mktme/mktme_overview.rst b/Documentation/x86/mktme/mktme_overview.rst
> new file mode 100644
> index 000000000000..59c023965554
> --- /dev/null
> +++ b/Documentation/x86/mktme/mktme_overview.rst
> @@ -0,0 +1,57 @@
> +Overview
> +====...
> +--
> +1. https://software.intel.com/sites/default/files/managed/a5/16/Multi-Key-Total-Memory-Encryption-Spec.pdf
> +2. The MKTME architecture supports up to 16 bits of KeyIDs, so a
> +   maximum of 65535 keys on top of the “TME key” at KeyID-0.  The
> +   first implementation is expected to support 5 bits, making 63

Hi,
How do 5 bits make 63 keys available?

> +   keys available to applications.  However, this is not guaranteed.
> +   The number of available keys could be reduced if, for instance,
> +   additional physical address space is desired over additional
> +   KeyIDs.


thanks.
-- 
~Randy
