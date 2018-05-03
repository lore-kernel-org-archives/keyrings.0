From: James Morris <jmorris@namei.org>
Date: Thu, 03 May 2018 17:11:31 +0000
Subject: Re: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
Message-Id: <alpine.LRH.2.21.1805040311050.12843@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
To: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Keyrings <keyrings@vger.kernel.org>, Linux Integrity <linux-integrity@vger.kernel.org>, Linux Security <linux-security-module@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, George Wilson <gcwilson@us.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>

On Wed, 2 May 2018, Mehmet Kayaalp wrote:

> These patches add support for modifying the reserved space for extra
> certificates in a compressed bzImage in x86. This allows separating the
> system keyring certificate from the kernel build process. After the kernel
> image is distributed, the insert-sys-cert script can be used to insert the
> certificate for x86.

Can you provide more explanation of how this is useful and who would use 
it?

-- 
James Morris
<jmorris@namei.org>

