From: Dave Hansen <dave.hansen@intel.com>
Date: Mon, 10 Sep 2018 18:57:49 +0000
Subject: Re: [RFC 09/12] mm: Restrict memory encryption to anonymous VMA's
Message-Id: <84154fd2-7c27-0fd2-f339-15e144a5df49@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1536356108.git.alison.schofield@intel.com>
 <f69e3d4f96504185054d951c7c85075ebf63e47a.1536356108.git.alison.schofield@intel.com>
 <ae0288d5205a5c431e9a6bf0c9e68beded45e84b.camel@intel.com>
In-Reply-To: <ae0288d5205a5c431e9a6bf0c9e68beded45e84b.camel@intel.com>
To: "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Schofield, Alison" <alison.schofield@intel.com>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "Shutemov, Kirill" <kirill.shutemov@intel.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "jmorris@namei.org" <jmorris@namei.org>, "Huang, Kai" <kai.huang@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

On 09/10/2018 11:21 AM, Sakkinen, Jarkko wrote:
>> +/*
>> + * Encrypted mprotect is only supported on anonymous mappings.
>> + * All VMA's in the requested range must be anonymous. If this
>> + * test fails on any single VMA, the entire mprotect request fails.
>> + */
> kdoc

kdoc what?  You want this comment in kdoc format?  Why?
