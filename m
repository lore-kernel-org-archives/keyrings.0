From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 07 Dec 2018 04:23:54 +0000
Subject: Re: [RFC v2 00/13] Multi-Key Total Memory Encryption API (MKTME)
Message-Id: <7ac80308-1831-fe42-9c53-05f913cba403@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <CALCETrUqqQiHR_LJoKB2JE6hCZ-e7LiFprEhmo-qoegDZJ9uYQ@mail.gmail.com>
 <c610138f-32dd-a24c-dc52-4e0006a21409@intel.com>
 <CALCETrU34U3berTaEQbvNt0rfCdsjwj+xDb8x7bgAMFHEo=eUw@mail.gmail.com>
 <1544147742.28511.18.camel@intel.com>
In-Reply-To: <1544147742.28511.18.camel@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>, "luto@kernel.org" <luto@kernel.org>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "jmorris@namei.org" <jmorris@namei.org>, "peterz@infradead.org" <peterz@infradead.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Schofield, Alison" <alison.schofield@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

On 12/6/18 5:55 PM, Huang, Kai wrote:
> I think one usage of user-specified key is for NVDIMM, since CPU key
> will be gone after machine reboot, therefore if NVDIMM is encrypted
> by CPU key we are not able to retrieve it once shutdown/reboot, etc.

I think we all agree that the NVDIMM uses are really useful.

But, these patches don't implement that.  So, if NVDIMMs are the only
reasonable use case, we shouldn't merge these patches until we add
NVDIMM support.
