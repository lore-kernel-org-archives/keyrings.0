From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Thu, 09 Jan 2020 16:47:49 +0000
Subject: Re: [PATCH v8 0/3] IMA: Deferred measurement of keys
Message-Id: <259affae-d579-d7b8-7fff-ff6ef440ac29@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20200109024359.3410-1-nramas@linux.microsoft.com>
 <1578546442.5147.37.camel@linux.ibm.com>
In-Reply-To: <1578546442.5147.37.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, James.Bottomley@HansenPartnership.com, linux-integrity@vger.kernel.org
Cc: dhowells@redhat.com, arnd@arndb.de, matthewgarrett@google.com, sashal@kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On 1/8/20 9:07 PM, Mimi Zohar wrote:

> On Wed, 2020-01-08 at 18:43 -0800, Lakshmi Ramasubramanian wrote:
>=20
>> Changelog:
>>
>>    v8
>>
>>    =3D> Rebased the changes to linux-next
>>    =3D> Need to apply the following patch first
>>    https://lore.kernel.org/linux-integrity/20200108160508.5938-1-nramas@=
linux.microsoft.com/
>=20
> Unless you made some other changes, the previous version of this patch
> set is already in next-integrity-testing. =C2=A0There's no reason to re-
> post these patches again, and definitely not against linux-next.
>=20
> Mimi
>=20

The change was to integrate the changes from the patch for the CONFIG issue:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/c=
ommit/?h=3Dnext-integrity-testing&idPa2506e069fc71f4be1bbcc2c5534bf58ed94ab

The following commit needs to be updated to use the new config=20
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS instead of=20
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/c=
ommit/?h=3Dnext-integrity-testing&id=E164a1695a5705c24c897b0bc7e9b97abb0830=
c8

Please let me know if I can clone next-integrity-testing and make the=20
above update. I'll post the updated patch today.

thanks,
  -lakshmi
