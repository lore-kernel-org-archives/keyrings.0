From: Dave Hansen <dave.hansen@intel.com>
Date: Thu, 06 Dec 2018 15:11:21 +0000
Subject: Re: [RFC v2 10/13] keys/mktme: Add the MKTME Key Service type for memory encryption
Message-Id: <986544e1-ffd1-1cd2-f0d3-4b1a4e8e8f3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <42d44fb5ddbbf7241a2494fc688e274ade641965.1543903910.git.alison.schofield@intel.com>
 <a19a48ae1d6434a1764b02c2376a99130ce15174.camel@intel.com>
In-Reply-To: <a19a48ae1d6434a1764b02c2376a99130ce15174.camel@intel.com>
To: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Schofield, Alison" <alison.schofield@intel.com>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "jmorris@namei.org" <jmorris@namei.org>, "Huang, Kai" <kai.huang@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Nakajima, Jun" <jun.nakajima@intel.com>

On 12/6/18 12:51 AM, Sakkinen, Jarkko wrote:
> On Mon, 2018-12-03 at 23:39 -0800, Alison Schofield wrote:
>> MKTME (Multi-Key Total Memory Encryption) is a technology that allows
>> transparent memory encryption in upcoming Intel platforms. MKTME will
>> support mulitple encryption domains, each having their own key. The main
>> use case for the feature is virtual machine isolation. The API needs the
>> flexibility to work for a wide range of uses.
> Some, maybe brutal, honesty (apologies)...
> 
> Have never really got the grip why either SME or TME would make
> isolation any better. If you can break into hypervisor, you'll
> have these tools availabe:

For systems using MKTME, the hypervisor is within the "trust boundary".
 From what I've read, it is a bit _more_ trusted than with AMD's scheme.

But, yes, if you can mount a successful arbitrary code execution attack
against the MKTME hypervisor, you can defeat MKTME's protections.  If
the kernel creates non-encrypted mappings of memory that's being
encrypted with MKTME, an arbitrary read primitive could also be a very
valuable in defeating MKTME's protections.  That's why Andy is proposing
doing something like eXclusive-Page-Frame-Ownership (google XPFO).
