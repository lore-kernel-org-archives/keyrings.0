From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 18 Dec 2019 06:31:41 +0000
Subject: [PATCH v3 8/9] security: keys: trusted fix tpm2 authorizations
Message-Id: <20191218063142.23033-9-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20191218063142.23033-1-James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

In TPM 1.2 an authorization was a 20 byte number.  The spec actually
recommended you to hash variable length passwords and use the sha1
hash as the authorization.  Because the spec doesn't require this
hashing, the current authorization for trusted keys is a 40 digit hex
number.  For TPM 2.0 the spec allows the passing in of variable length
passwords and passphrases directly, so we should allow that in trusted
keys for ease of use.  Update the 'blobauth' parameter to take this
into account, so we can now use plain text passwords for the keys.

so before

keyctl add trusted kmk "new 32 blobauth=F572d396fae9206628714fb2ce00f72e94f=
2258f"

after:

keyctl add trusted kmk "new 32 blobauth=3Dhello keyhandle=81000001"

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/keys/trusted-type.h               |  1 +
 security/keys/trusted-keys/trusted_tpm1.c | 24 +++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index fc9c13802c06..c117bf598230 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -34,6 +34,7 @@ struct trusted_key_options {
 	uint16_t keytype;
 	uint32_t keyhandle;
 	unsigned char keyauth[TPM_DIGEST_SIZE];
+	uint32_t blobauth_len;
 	unsigned char blobauth[TPM_DIGEST_SIZE];
 	uint32_t pcrinfo_len;
 	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trus=
ted-keys/trusted_tpm1.c
index 668cbdc675b8..af269f4774de 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -785,12 +785,26 @@ static int getoptions(char *c, struct trusted_key_pay=
load *pay,
 				return -EINVAL;
 			break;
 		case Opt_blobauth:
-			if (strlen(args[0].from) !=3D 2 * SHA1_DIGEST_SIZE)
-				return -EINVAL;
-			res =3D hex2bin(opt->blobauth, args[0].from,
-				      SHA1_DIGEST_SIZE);
-			if (res < 0)
+			/*
+			 * TPM 1.2 authorizations are sha1 hashes
+			 * passed in as hex strings.  TPM 2.0
+			 * authorizations are simple passwords
+			 * (although it can take a hash as well)
+			 */
+			opt->blobauth_len =3D strlen(args[0].from);
+			if (opt->blobauth_len =3D 2 * TPM_DIGEST_SIZE) {
+				res =3D hex2bin(opt->blobauth, args[0].from,
+					      TPM_DIGEST_SIZE);
+				if (res < 0)
+					return -EINVAL;
+				opt->blobauth_len =3D TPM_DIGEST_SIZE;
+			} else if (tpm2 &&
+				   opt->blobauth_len <=3D sizeof(opt->blobauth)) {
+				memcpy(opt->blobauth, args[0].from,
+				       opt->blobauth_len);
+			} else {
 				return -EINVAL;
+			}
 			break;
 		case Opt_migratable:
 			if (*args[0].from =3D '0')
--=20
2.16.4
