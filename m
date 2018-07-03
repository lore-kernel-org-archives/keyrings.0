From: James Morris <jmorris@namei.org>
Date: Tue, 03 Jul 2018 18:00:09 +0000
Subject: Re: [PATCH 04/11] nfit/libnvdimm: add unlock of nvdimm support for Intel DIMMs
Message-Id: <alpine.LRH.2.21.1807040358010.32123@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153057423804.38125.15912575101400055843.stgit@djiang5-desk3.ch.intel.com>
 <153057476931.38125.15448927598576316449.stgit@djiang5-desk3.ch.intel.com>
 <AT5PR8401MB1169BD7B3DE8CDA8BA5AE658AB420@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4ipAULUgtV6rvx7hQBLtjr7VSE25KvBiHxHRe7TT0HvKA@mail.gmail.com>
In-Reply-To: <CAPcyv4ipAULUgtV6rvx7hQBLtjr7VSE25KvBiHxHRe7TT0HvKA@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, "keescook@chromium.org" <keescook@chromium.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>

On Mon, 2 Jul 2018, Dan Williams wrote:

> If an attacker can run arbitrary code in the kernel they can get the
> key from the ring directly, or turn on ACPI debug. A platform could
> arrange for the DIMMs to be unlocked pre-OS to minimize passphrase
> exposure, 

So, either from within UEFI secure boot, or via the bootloader?

-- 
James Morris
<jmorris@namei.org>

