From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 07 Dec 2018 11:47:09 +0000
Subject: Re: [RFC v2 12/13] keys/mktme: Save MKTME data if kernel cmdline parameter allows
Message-Id: <20181207114709.kmrbghihyrht2l65@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com>
 <c2668d6d260bff3c88440ad097eb1445ea005860.1543903910.git.alison.schofield@intel.com>
 <1544148839.28511.28.camel@intel.com>
In-Reply-To: <1544148839.28511.28.camel@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "Schofield, Alison" <alison.schofield@intel.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "jmorris@namei.org" <jmorris@namei.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>

On Fri, Dec 07, 2018 at 02:14:03AM +0000, Huang, Kai wrote:
> Alternatively, we can choose to use per-socket keyID, but not to program
> keyID globally across all sockets, so you don't have to save key while
> still supporting CPU hotplug.

Per-socket KeyID approach would make things more complex. For instance
KeyID on its own will not be enough to refer a key. You will need a node
too. It will also require a way to track whether theirs an KeyID on other
node for the key.

It also makes memory management less flexible: runtime migration of the
memory between nodes will be limited and it can hurt memory availablity
for non-encrypted tasks too.

In general, I don't see per-socket KeyID handling very attractive. It
creates more problems than solves.

-- 
 Kirill A. Shutemov
