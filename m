From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 06 Jun 2017 00:16:13 +0000
Subject: Re: [PATCH v2] KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API
Message-Id: <alpine.OSX.2.21.1706051707010.7532@mjmartin-mac01.sea.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1638.1496419102@warthog.procyon.org.uk>
In-Reply-To: <1638.1496419102@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org


Hi Eric -

On Sun, 4 Jun 2017, Eric Biggers wrote:

> Hi Mat,
>
> On Wed, May 10, 2017 at 05:35:57PM -0700, Mat Martineau wrote:
>> The initial Diffie-Hellman computation made direct use of the MPI
>> library because the crypto module did not support DH at the time. Now
>> that KPP is implemented, KEYCTL_DH_COMPUTE should use it to get rid of
>> duplicate code and leverage possible hardware acceleration.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> Have you verified that this doesn't change the API at all --- order of bytes
> within the numbers, whether they are padded with zeroes, any other corner cases
> etc.?  There can't be breaking changes to the API after this is released in
> mainline, and this is already in v4.12-rc4.

The available unit tests in keyutils (next branch) and ELL still pass.

Stephan pointed out a difference regarding handling of leading zeros in 
KDF, which is what I addressed in v2 of the patch. There's a gap in the 
unit tests where results with leading zeros are not covered well, and I'm 
working on that. DH results are definitely handled the same with this 
patch, but I have yet to confirm KDF output - I don't have a known-good 
test vector for KDF when the shared secret has leading zeros.

--
Mat Martineau
Intel OTC
