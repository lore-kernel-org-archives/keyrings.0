From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 30 Aug 2020 14:56:55 +0000
Subject: Re: [RESEND PATCH] KEYS: asymmetric: Fix kerneldoc
Message-Id: <20200830145655.GA31461@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200819175212.20583-1-krzk@kernel.org>
In-Reply-To: <20200819175212.20583-1-krzk@kernel.org>
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 07:52:12PM +0200, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     crypto/asymmetric_keys/asymmetric_type.c:160: warning: Function parameter or member 'kid1' not described in 'asymmetric_key_id_same'
>     crypto/asymmetric_keys/asymmetric_type.c:160: warning: Function parameter or member 'kid2' not described in 'asymmetric_key_id_same'
>     crypto/asymmetric_keys/asymmetric_type.c:160: warning: Excess function parameter 'kid_1' description in 'asymmetric_key_id_same'
>     crypto/asymmetric_keys/asymmetric_type.c:160: warning: Excess function parameter 'kid_2' description in 'asymmetric_key_id_same'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  crypto/asymmetric_keys/asymmetric_type.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Hi David, Herbert,

Any comments here?

Best regards,
Krzysztof
