From: David Howells <dhowells@redhat.com>
Date: Tue, 06 Jun 2017 09:22:26 +0000
Subject: Re: [PATCH v3] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <24765.1496740946@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606003747.5942-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170606003747.5942-1-mathew.j.martineau@linux.intel.com>
To: keyrings@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > The initial Diffie-Hellman computation made direct use of the MPI
> > library because the crypto module did not support DH at the time. Now
> > that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
> > duplicate code and leverage possible hardware acceleration.
> 
> If I'm going to take this as a fix instead of Eric's patch #3, this needs to
> say what it fixes.

I propose adding the following paragraph, paraphrased from Eric:

	This fixes an issue whereby the result of the Diffie-Hellman
	computation might be shorter than the input prime number - in which
	case we would include additional uninitialized memory in the KDF
	calculation.

David
