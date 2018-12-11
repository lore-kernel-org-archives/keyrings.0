From: James Morris <jmorris@namei.org>
Date: Tue, 11 Dec 2018 18:30:41 +0000
Subject: Re: [PATCH v2 3/7] efi: Add EFI signature data types
Message-Id: <alpine.LRH.2.21.1812120530300.11653@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com> <20181208202705.18673-4-nayna@linux.ibm.com>
In-Reply-To: <20181208202705.18673-4-nayna@linux.ibm.com>
To: Nayna Jain <nayna@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, jforbes@redhat.com, seth.forshee@canonical.com, kexec@lists.infradead.org, keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, mpe@ellerman.id.au

On Sun, 9 Dec 2018, Nayna Jain wrote:

> From: Dave Howells <dhowells@redhat.com>
> 
> Add the data types that are used for containing hashes, keys and
> certificates for cryptographic verification along with their corresponding
> type GUIDs.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Nayna Jain <nayna@linux.ibm.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>
