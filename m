From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 27 Feb 2020 20:26:44 +0000
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <1582835204.18538.21.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
         <1582834760.18538.15.camel@HansenPartnership.com>
In-Reply-To: <1582834760.18538.15.camel@HansenPartnership.com>
To: James Prestwood <prestwoj@gmail.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Thu, 2020-02-27 at 12:19 -0800, James Bottomley wrote:
> On Thu, 2020-02-27 at 09:19 -0800, James Prestwood wrote:
[...]
> > I think this was all a result of bad packaging on Fedora's part,
> > but still, the experience didn't sit well with me and I felt it
> > would be worth while to add support for this in keyctl.
> 
> Well there's a list you can report problems to and get help:
> 
> openssl-tpm2-engine@groups.io
> 
> I've got to confess I develop on openSUSE and debian, so Fedora
> doesn't get much testing.

I should add that even though I don't test on fedora, the opensuse
build service does in my TPM build environment:

https://build.opensuse.org/package/show/home:jejb1:TPM/openssl_tpm2_engine

It says the builds for Fedora 26, 29 and Rawhide all succeeded.  The
build service does both building and testing with the swtpm, so the
engine on fedora gets a pretty extensive workout.

James
