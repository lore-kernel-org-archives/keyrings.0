From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Thu, 02 Nov 2017 11:40:51 +0000
Subject: Re: [PATCH 2/4] crypto: dh - don't permit 'p' to be 0
Message-Id: <281c8d97-7d44-d157-5221-1487ec03a06f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171101222517.41602-1-ebiggers3@gmail.com>
 <20171101222517.41602-3-ebiggers3@gmail.com>
In-Reply-To: <20171101222517.41602-3-ebiggers3@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: keyrings@vger.kernel.org, Mat Martineau <mathew.j.martineau@linux.intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, Stephan Mueller <smueller@chronox.de>, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

Hi, Eric,

On 11/02/2017 12:25 AM, Eric Biggers wrote:
> If 'p' is 0 for the software Diffie-Hellman implementation, then
> dh_max_size() returns 0.

dh_set_secret() returns -EINVAL if p_len < 1536, see
dh_check_params_length(). What am I missing?

Cheers,
ta
