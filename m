From: Kalyani Akula <kalyania@xilinx.com>
Date: Mon, 10 Jun 2019 05:20:58 +0000
Subject: RE: [RFC PATCH 4/5] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Message-Id: <BN7PR02MB5124A7E685AC0F59AFBEFC8DAF130@BN7PR02MB5124.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
 <18759853.IUaQuE38eh@tauon.chronox.de>
 <SN6PR02MB5135CE53C3E3FB34CA5E6BA8AF320@SN6PR02MB5135.namprd02.prod.outlook.com>
 <2554415.t45IJDmies@tauon.chronox.de>
In-Reply-To: <2554415.t45IJDmies@tauon.chronox.de>
To: Stephan Mueller <smueller@chronox.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sarat Chand Savitala <saratcha@xilinx.com>

Ping!!

> -----Original Message-----
> From: Stephan Mueller <smueller@chronox.de>
> Sent: Friday, May 24, 2019 12:50 PM
> To: Kalyani Akula <kalyania@xilinx.com>; keyrings@vger.kernel.org
> Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Sarat Chand Savitala
> <saratcha@xilinx.com>
> Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for
> ALG_SET_KEY_TYPE
> 
> Am Mittwoch, 8. Mai 2019, 11:31:08 CEST schrieb Kalyani Akula:
> 
> Hi Kalyani,
> 
> > Hi Stephan,
> >
> > Keyrings is in-kernel key-management and retention facility. User can
> > use it to manage keys used for applications.
> >
> > Xilinx cryptographic hardware has a mechanism to store keys in its
> > internal hardware and do not have mechanism to read it back due to security
> reasons.
> > It stores key internally in different forms like simple key, key
> > encrypted with unique hardware DNA, key encrypted with hardware family
> > key, key stored in eFUSEs/BBRAM etc.
> > Based on security level expected, user can select one of the key for
> > AES operation. Since AES hardware internally has access to these keys,
> > user do not require to provide key to hardware, but need to tell which
> > internal hardware key user application like to use for AES operation.
> >
> > Basic need is to pass information to AES hardware about which internal
> > hardware key to be used for AES operation.
> >
> > I agree that from general use case perspective we are not selecting
> > key type but selecting internal hardware keys provided by user. How
> > about providing option to select custom hardware keys provided by
> > hardware (AES_SEL_HW_KEY)?
> 
> I am not intimately familiary with the keyring facility. Thus, let us ask the experts
> at the keyring mailing list :-)
> 
> >
> > Thanks
> > kalyani
> >
> > > -----Original Message-----
> > > From: Stephan Mueller <smueller@chronox.de>
> > > Sent: Thursday, April 25, 2019 12:01 AM
> > > To: Kalyani Akula <kalyania@xilinx.com>
> > > Cc: herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> > > crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC PATCH 4/5] crypto: Adds user space interface for
> > > ALG_SET_KEY_TYPE
> > >
> > > Am Montag, 22. April 2019, 11:17:55 CEST schrieb Kalyani Akula:
> > >
> > > Hi Kalyani,
> > >
> > > > > Besides, seem to be more a key handling issue. Wouldn't it make
> > > > > sense to rather have such issue solved with key rings than in
> > > > > the kernel crypto API?
> > > >
> > > > [kalyani] Can you please elaborate on this further ?
> > >
> > > The kernel has a keyring support in security/keys which has a user
> > > space interface with keyutils. That interface is commonly used for
> > > any sort of key manipulation.
> > >
> > > Ciao
> > > Stephan
> 
> 
> 
> Ciao
> Stephan
> 
