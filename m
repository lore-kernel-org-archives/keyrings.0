From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 05 Dec 2018 18:11:18 +0000
Subject: Re: [RFC v2 01/13] x86/mktme: Document the MKTME APIs
Message-Id: <4ED70A75-9A88-41B4-B595-87FB748772F9@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1543903910.git.alison.schofield@intel.com> <c2276bbbb19f3a28bd37c3dd6b1021e2d9a10916.1543903910.git.alison.schofield@intel.com>
In-Reply-To: <c2276bbbb19f3a28bd37c3dd6b1021e2d9a10916.1543903910.git.alison.schofield@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dhowells@redhat.com, tglx@linutronix.de, jmorris@namei.org, mingo@redhat.com, hpa@zytor.com, bp@alien8.de, luto@kernel.org, peterz@infradead.org, kirill.shutemov@linux.intel.com, dave.hansen@intel.com, kai.huang@intel.com, jun.nakajima@intel.com, dan.j.williams@intel.com, jarkko.sakkinen@intel.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org



> On Dec 3, 2018, at 11:39 PM, Alison Schofield <alison.schofield@intel.com> wrote:

I realize you’re writing code to expose hardware behavior, but I’m not sure this
really makes sense in this context.

> .
> +
> +Usage
> +-----
> +    When using the Kernel Key Service to request an *mktme* key,
> +    specify the *payload* as follows:
> +
> +    type=
> +        *user*    User will supply the encryption key data. Use this
> +                type to directly program a hardware encryption key.
> +

I think that “user” probably sense as a “key service” key, but I don’t think it is at all useful for non-persistent memory.  Even if we take for granted that MKTME for anonymous memory is useful at all, “cpu” seems to be better in all respects.


Perhaps support for “user” should be tabled until there’s a design for how to use this for pmem?  I imagine it would look quite a bit like dm-crypt.  Advanced pmem filesystems could plausibly use different keys for different files, I suppose.

If “user” is dropped, I think a lot of the complexity goes away. Hotplug becomes automatic, right?

> +        *cpu*    User requests a CPU generated encryption key.

Okay, maybe, but it’s still unclear to me exactly what the intended benefit is, though.

> +                The CPU generates and assigns an ephemeral key.
> +
> +        *clear* User requests that a hardware encryption key be
> +                cleared. This will clear the encryption key from
> +                the hardware. On execution this hardware key gets
> +                TME behavior.
> +

Why is this a key type?  Shouldn’t the API to select a key just have an option to ask for no key to be used?

> +        *no-encrypt*
> +                 User requests that hardware does not encrypt
> +                 memory when this key is in use.

Same as above.  If there’s a performance benefit, then there could be a way to ask for cleartext memory.  Similarly, some pmem users may want a way to keep their pmem unencrypted.

—Andy
