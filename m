From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 02 Nov 2017 17:31:41 +0000
Subject: Re: [PATCH 2/4] crypto: dh - don't permit 'p' to be 0
Message-Id: <20171102173141.GB23035@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171101222517.41602-1-ebiggers3@gmail.com>
 <20171101222517.41602-3-ebiggers3@gmail.com>
 <281c8d97-7d44-d157-5221-1487ec03a06f@microchip.com>
In-Reply-To: <281c8d97-7d44-d157-5221-1487ec03a06f@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, Mat Martineau <mathew.j.martineau@linux.intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, Stephan Mueller <smueller@chronox.de>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

On Thu, Nov 02, 2017 at 01:40:51PM +0200, Tudor Ambarus wrote:
> Hi, Eric,
> 
> On 11/02/2017 12:25 AM, Eric Biggers wrote:
> >If 'p' is 0 for the software Diffie-Hellman implementation, then
> >dh_max_size() returns 0.
> 
> dh_set_secret() returns -EINVAL if p_len < 1536, see
> dh_check_params_length(). What am I missing?
> 
> Cheers,
> ta

You pass a buffer containing 0's, not a buffer of length 0.  The buffer is
interpreted as an arbitrary precision integer, so any length buffer filled with
0's has the mathematical value 0.

Eric
