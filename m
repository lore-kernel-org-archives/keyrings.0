From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 10 Dec 2019 13:22:38 +0000
Subject: Re: [PATCH v2 3/8] oid_registry: Add TCG defined OIDS for TPM keys
Message-Id: <1575984158.3459.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936406.31378.53.camel@HansenPartnership.com>
         <677893f3d9a5671b4199190bf4d1d79c4d431578.camel@infradead.org>
In-Reply-To: <677893f3d9a5671b4199190bf4d1d79c4d431578.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org

On Tue, 2019-12-10 at 08:18 +0000, David Woodhouse wrote:
> On Mon, 2019-12-09 at 16:06 -0800, James Bottomley wrote:
> > +       /* TCG defined OIDS for TPM based keys */
> > +       OID_TPMLoadableKey,             /* 2.23.133.10.1.3 */
> > +       OID_TPMImporableKey,            /* 2.23.133.10.1.4 */
> 
> 
> There's a t missing from OID_TPMImpoTableKey. Sorry, missed that last
> time.

Heh, yes, will fix.

James
