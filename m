From: Kalyani Akula <kalyania@xilinx.com>
Date: Thu, 11 Jul 2019 09:25:38 +0000
Subject: RE: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Message-Id: <BN7PR02MB5124F4680E424C25D77D178DAFF30@BN7PR02MB5124.namprd02.prod.outlook.com>
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
In-Reply-To: <20190610063501.u3q2k2vgytvknxs3@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Stephan Mueller <smueller@chronox.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sarat Chand Savitala <saratcha@xilinx.com>

Hi Herbert,

Paes driver is using key expansion algorithm to encrypt and decrypt the plaintext. HW capability of expanding the given plain key is checked based on the provide key length. Here the HW key is the expended version of plain key.

Xilinx AES hardware has a capability to take plain keys/encrypted keys ( these keys are user programmable but for security reasons they are not readable. Only AES accelerator has read access to these keys) stored on chip ( in eFuse/BBRAM etc, ) and used for AES encryption/decryption.
Xilinx software is giving the Customer, the flexibility to choose among the different on-chip AES keys.
So, we chosen a way to add AES_SEL_HW_KEY option.

In Paes driver , The ALG_SET_KEY interface is used to distinguish between HW Vs SW expansion of plain key based on the key_len. 

How about using same interface to distinguish between the User supplied key Vs HW key selection based on key_len parameter.

Thanks
kalyani  	

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Monday, June 10, 2019 12:05 PM
> To: Kalyani Akula <kalyania@xilinx.com>
> Cc: Stephan Mueller <smueller@chronox.de>; keyrings@vger.kernel.org;
> davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sarat Chand Savitala <saratcha@xilinx.com>
> Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for
> ALG_SET_KEY_TYPE
> 
> On Mon, Jun 10, 2019 at 05:20:58AM +0000, Kalyani Akula wrote:
> > Ping!!
> 
> We already have existing drivers supporting hardware keys.  Please check
> out how they're handling this.  You can grep for paes under drivers/crypto.
> 
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
