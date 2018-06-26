From: Stephan Mueller <smueller@chronox.de>
Date: Tue, 26 Jun 2018 15:13:44 +0000
Subject: Re: [RFC PATCH] crypto: DH - add public key verification test
Message-Id: <2507292.VHlOeOYlAP@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <3594538.6iHA3aaNKK@positron.chronox.de>
In-Reply-To: <3594538.6iHA3aaNKK@positron.chronox.de>
To: keyrings@vger.kernel.org

Am Dienstag, 26. Juni 2018, 12:17:42 CEST schrieb Stephan M=FCller:

Hi,

> +		MPI val =3D mpi_alloc(0);

I just saw that I did not check for val after allocation. That will be fixe=
d=20
in another installment of the patch.

Ciao
Stephan


