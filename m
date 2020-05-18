From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:27:03 +0000
Subject: [PATCH 16/17] asymmetric_keys: add TPM2 ASN1 definition
Message-Id: <20200518172704.29608-17-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, James Prestwood <prestwoj@gmail.com>

Copied the TPM2 ASN1 definition from trusted-keys

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 crypto/asymmetric_keys/tpm2key.asn1 | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 crypto/asymmetric_keys/tpm2key.asn1

diff --git a/crypto/asymmetric_keys/tpm2key.asn1 b/crypto/asymmetric_keys/tpm2key.asn1
new file mode 100644
index 000000000000..f930fd812db3
--- /dev/null
+++ b/crypto/asymmetric_keys/tpm2key.asn1
@@ -0,0 +1,23 @@
+---
+--- Note: This isn't quite the definition in the standard
+---       However, the Linux asn.1 parser doesn't understand
+---       [2] EXPLICIT SEQUENCE OF OPTIONAL
+---       So there's an extra intermediate TPMPolicySequence
+---       definition to work around this
+
+TPMKey ::= SEQUENCE {
+	type		OBJECT IDENTIFIER ({tpmkey_type}),
+	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
+	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
+	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
+	parent		INTEGER ({tpmkey_parent}),
+	pubkey		OCTET STRING ({tpmkey_pub}),
+	privkey		OCTET STRING ({tpmkey_priv})
+	}
+
+TPMPolicySequence ::= SEQUENCE OF TPMPolicy
+
+TPMPolicy ::= SEQUENCE {
+	commandCode		[0] EXPLICIT INTEGER ({tpmkey_code}),
+	commandPolicy		[1] EXPLICIT OCTET STRING ({tpmkey_policy})
+	}
-- 
2.21.1
