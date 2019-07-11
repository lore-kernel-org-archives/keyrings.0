From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 11 Jul 2019 11:10:11 +0000
Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Message-Id: <20190711111011.x3qzukon2zqnsgac@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
 <18759853.IUaQuE38eh@tauon.chronox.de>
 <SN6PR02MB5135CE53C3E3FB34CA5E6BA8AF320@SN6PR02MB5135.namprd02.prod.outlook.com>
 <2554415.t45IJDmies@tauon.chronox.de>
 <BN7PR02MB5124A7E685AC0F59AFBEFC8DAF130@BN7PR02MB5124.namprd02.prod.outlook.com>
 <20190610063501.u3q2k2vgytvknxs3@gondor.apana.org.au>
 <BN7PR02MB5124F4680E424C25D77D178DAFF30@BN7PR02MB5124.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB5124F4680E424C25D77D178DAFF30@BN7PR02MB5124.namprd02.prod.outlook.com>
To: Kalyani Akula <kalyania@xilinx.com>
Cc: Stephan Mueller <smueller@chronox.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sarat Chand Savitala <saratcha@xilinx.com>

On Thu, Jul 11, 2019 at 09:25:38AM +0000, Kalyani Akula wrote:
>
> How about using same interface to distinguish between the User supplied key Vs HW key selection based on key_len parameter.

As long as you use the paes name instead of aes you can do whatever
you want with the key encoding.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
