From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 13 Oct 2020 02:51:55 +0000
Subject: [PATCH v4 2/3] KEYS: trusted: Fix migratable=1 failing
Message-Id: <20201013025156.111305-3-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20201013025156.111305-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20201013025156.111305-1-jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, stable@vger.kernel.org, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Safford <safford@watson.ibm.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Consider the following transcript:

$ keyctl add trusted kmk "new 32 blobauth=3Dhelloworld keyhandle=80000000 m=
igratable=3D1" @u
add_key: Invalid argument

The documentation has the following description:

  migratable=3D   0|1 indicating permission to reseal to new PCR values,
                default 1 (resealing allowed)

The consequence is that "migratable=3D1" should succeed. Fix this by
allowing this condition to pass instead of return -EINVAL.

[*] Documentation/security/keys/trusted-encrypted.rst

Cc: stable@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trus=
ted-keys/trusted_tpm1.c
index c7b1701cdac5..7a937c3c5283 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -801,7 +801,7 @@ static int getoptions(char *c, struct trusted_key_paylo=
ad *pay,
 		case Opt_migratable:
 			if (*args[0].from =3D '0')
 				pay->migratable =3D 0;
-			else
+			else if (*args[0].from !=3D '1')
 				return -EINVAL;
 			break;
 		case Opt_pcrlock:
--=20
2.25.1
