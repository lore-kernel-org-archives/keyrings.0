From: David Howells <dhowells@redhat.com>
Date: Tue, 06 Jun 2017 08:24:07 +0000
Subject: Re: [PATCH v3] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <23188.1496737447@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170606003747.5942-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170606003747.5942-1-mathew.j.martineau@linux.intel.com>
To: keyrings@vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> The initial Diffie-Hellman computation made direct use of the MPI
> library because the crypto module did not support DH at the time. Now
> that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
> duplicate code and leverage possible hardware acceleration.

If I'm going to take this as a fix instead of Eric's patch #3, this needs to
say what it fixes.

David
