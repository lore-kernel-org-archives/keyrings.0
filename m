From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 10 Jun 2019 06:35:01 +0000
Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Message-Id: <20190610063501.u3q2k2vgytvknxs3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
 <18759853.IUaQuE38eh@tauon.chronox.de>
 <SN6PR02MB5135CE53C3E3FB34CA5E6BA8AF320@SN6PR02MB5135.namprd02.prod.outlook.com>
 <2554415.t45IJDmies@tauon.chronox.de>
 <BN7PR02MB5124A7E685AC0F59AFBEFC8DAF130@BN7PR02MB5124.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB5124A7E685AC0F59AFBEFC8DAF130@BN7PR02MB5124.namprd02.prod.outlook.com>
To: Kalyani Akula <kalyania@xilinx.com>
Cc: Stephan Mueller <smueller@chronox.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sarat Chand Savitala <saratcha@xilinx.com>

On Mon, Jun 10, 2019 at 05:20:58AM +0000, Kalyani Akula wrote:
> Ping!!

We already have existing drivers supporting hardware keys.  Please
check out how they're handling this.  You can grep for paes under
drivers/crypto.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
