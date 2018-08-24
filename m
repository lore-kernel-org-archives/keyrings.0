From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 24 Aug 2018 07:52:27 +0000
Subject: Re: [PATCH 08/23] TPMLIB: Break TPM bits out of security/keys/trusted.c
Message-Id: <20180824075227.GG3584@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486706322.13066.3105842100625841410.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486706322.13066.3105842100625841410.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:43PM +0100, David Howells wrote:
> Break the TPM bits out of security/keys/trusted.c into their own call wrapper
> library.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

I think the very first steps that we should take would be to make TPM
subsystem to use struct tpm_buf internally for everything and convert
tpm_send() to take tpm_buf instead of a raw buffer.

For TPM 2.0 the subsystem already uses tpm_buf. I remember Tomas Winkler
working on to do the same for TPM 1.x.

After that it would make sense to convert TPM 1.x to use struct tpm_buf to
construct commands.

After all of this is done it is possible to evaluate these changes.

BTW right now there is call wrapper interface provided by the TPM
subsystem for TPM 2.0 trusted keys. Not sure if this has been the
right design choice. TPM 1.x and TPM 2.0 trusted keys implementations
live in different subsystems ATM, which at least somewhat wrong.

/Jarkko
