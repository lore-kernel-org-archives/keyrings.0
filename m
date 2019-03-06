From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Date: Wed, 06 Mar 2019 16:47:46 +0000
Subject: Re: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in dmcrypt
Message-Id: <1551890866.5086.125.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
In-Reply-To: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
To: Franck LENORMAND <franck.lenormand@nxp.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc: horia.geanta@nxp.com, silvano.dininno@nxp.com, agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com, dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com, David Gstir <david@sigma-star.at>

Hi Franck,

thanks for working on this!

On Fri, 2019-03-01 at 17:09 +0100, Franck LENORMAND wrote:
> The creation of such structures and its use was not exposed to userspace so
> it was complicated to use and required custom development. We would like to
> ease this using interface which are known and used:
>  - Linux key retention service : Allow to generate or load keys in a
>         keyring which can be used by applications.
>  - dm-crypt : device mapper allowing to encrypt data.
> 
> The capacity to generate or load keys already available in the Linux key
> retention service does not allows to exploit CAAM capabilities hence we
> need to create a new key_type. The new key type "caam_tk" allows to:
>  - Create a black key from random
>  - Create a black key from a red key
>  - Load a black blob to retrieve the black key

On 2018-07-23, Udit Agarwal <udit.agarwal@nxp.com> sent a series which
seems related to this:
[PATCH v2 1/2] security/keys/secure_key: Adds the secure key support
based on CAAM.
[PATCH v2 2/2] encrypted_keys: Adds support for secure key-type as
master key.

Is this series intended to continue that work and cover the same uses-
cases? 

If I remember correctly, the CAAM also supports marking blobs to allow
or disallow exporting the encapsulated key from the hardware. Or is
this unneeded and we could encrypt/decrypt other (less critical) key
material against the tk(cbc(aes)) CAAM key via the keyring mechanisms?

Best regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
