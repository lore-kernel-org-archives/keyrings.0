From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 24 Aug 2018 06:30:15 +0000
Subject: Re: [PATCH 03/23] TPM: Provide a platform driver for the user emulator driver
Message-Id: <20180824063015.GE3584@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486702979.13066.16900998092976336647.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486702979.13066.16900998092976336647.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:09PM +0100, David Howells wrote:
> Provide a platform driver for the user emulator driver.  This seems to be
> necessary to stop tpm_chip_find_get() from blowing up because it assumes
> unconditionally that any device will have a driver attached:
> 
> 		if (try_module_get(pos->dev->driver->owner)) {
> 
> However, this doesn't then work right because if I remove the TPM device and
> re-add it, the tpm ID isn't recycled (ie, /dev/tpm0 becomes unavailable and
> the new TPM is /dev/tpm1).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Again, a duplicate.

/Jarkko
