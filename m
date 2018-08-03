From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 03 Aug 2018 15:23:35 +0000
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
Message-Id: <1533309815.4337.437.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1533307535.4337.415.camel@linux.ibm.com>
         <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
         <1533297482.4337.373.camel@linux.ibm.com>
         <1533306238.4140.1.camel@HansenPartnership.com>
         <25968.1533308142@warthog.procyon.org.uk>
In-Reply-To: <25968.1533308142@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Udit Agarwal <udit.agarwal@nxp.com>, zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com, ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com

On Fri, 2018-08-03 at 15:55 +0100, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > "trusted" keys are currently being used to decrypt other keys (eg.
> > encrypted, ecryptfs, ...).
> 
> Can it decrypt both symmetric and asymmetric keys?

Yes, the "trusted" key is returned to the caller and is used to
decrypt a datablob.

For an example, refer to encrypted_key_decrypt().  The call
to request_master_key() returns either the "trusted" or "user" type
key, which is used to decrypt the "enccrypted" key type.

Mimi

