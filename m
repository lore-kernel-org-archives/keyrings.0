From: David Howells <dhowells@redhat.com>
Date: Tue, 11 Sep 2018 22:56:55 +0000
Subject: Re: [RFC 04/12] x86/mm: Add helper functions to manage memory encryption keys
Message-Id: <30751.1536706615@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <28a55df5da1ecfea28bac588d3ac429cf1419b42.1536356108.git.alison.schofield@intel.com> <cover.1536356108.git.alison.schofield@intel.com>
In-Reply-To: <28a55df5da1ecfea28bac588d3ac429cf1419b42.1536356108.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, Kai Huang <kai.huang@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, Kirill Shutemov <kirill.shutemov@intel.com>, Dave Hansen <dave.hansen@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@intel.com>, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-mm@kvack.org

Alison Schofield <alison.schofield@intel.com> wrote:

> +void mktme_map_set_keyid(int keyid, unsigned int serial)
> +{
> +	mktme_map->serial[keyid] = serial;
> +	mktme_map->mapped_keyids++;
> +}

It appears that 'serial' should be key_serial_t.

Note that you *aren't* allowed to cache key serial numbers inside the kernel.
You must cache the struct key * instead and hold a reference to the key.  This
will prevent the key from being destroyed whilst it is in use.

David
