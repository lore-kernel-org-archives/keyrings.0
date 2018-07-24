From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 24 Jul 2018 13:34:50 +0000
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
Message-Id: <1532439290.3277.52.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
         <1532302451.6206.22.camel@linux.ibm.com>
         <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
To: Udit Agarwal <udit.agarwal@nxp.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>, "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com" <serge@hallyn.com>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sahil Malhotra <sahil.malhotra@nxp.com>, Ruchika Gupta <ruchika.gupta@nxp.com>, Horia Geanta <horia.geanta@nxp.com>, Aymen Sghaier <aymen.sghaier@nxp.com>

On Tue, 2018-07-24 at 12:31 +0000, Udit Agarwal wrote:
> Yes the secure keys and CAAM are correlated. Secure keys depends on
> NXP CAAM crypto HW accelerator.  Secure key is a random data of
> length X (passed using keyctl command) & derived using CAAM. Blob of
> this data is also created using CAAM. Only blob is visible to user
> space.

The term "secure keys" is really generic.  What makes the "secure
keys" secure?  We introduced "trusted keys", because TPM 1.2 didn't
support symmetric keys.  We shouldn't just duplicate "trusted keys"
for different HW, but improve upon it (eg. symmetric keys never leave
the device).

The new key type should define generic methods, which are implemented
for NXP CAAM rypto HW accelerator as an example.

Mimi

