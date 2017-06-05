From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 05 Jun 2017 03:41:32 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <20170605034132.GB6277@zzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1638.1496419102@warthog.procyon.org.uk>
In-Reply-To: <1638.1496419102@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org

Hi Mat,

On Wed, May 10, 2017 at 05:35:57PM -0700, Mat Martineau wrote:
> The initial Diffie-Hellman computation made direct use of the MPI
> library because the crypto module did not support DH at the time. Now
> that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
> duplicate code and leverage possible hardware acceleration.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Have you verified that this doesn't change the API at all --- order of bytes
within the numbers, whether they are padded with zeroes, any other corner cases
etc.?  There can't be breaking changes to the API after this is released in
mainline, and this is already in v4.12-rc4.

Also, Stephan, what is the purpose of the "__spare" field in keyctl_kdf_params?
How is it ever supposed to be used for anything if the kernel doesn't even
validate that it contains 0's?  Some flag hacked into the 'otherinfolen'
field...?

Eric
