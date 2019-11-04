From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 04 Nov 2019 20:55:06 +0000
Subject: Re: [Patch v3 6/7] doc: keys: Document usage of TEE based Trusted Keys
Message-Id: <20191104205453.GA29713@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1572530323-14802-1-git-send-email-sumit.garg@linaro.org>
 <1572530323-14802-7-git-send-email-sumit.garg@linaro.org>
 <20191031214745.GG10507@linux.intel.com>
 <CAFA6WYMkE928v-v76gGtWmsS0PwRp-OHUtkS0+Ts4V6x0AKBqQ@mail.gmail.com>
 <20191101201957.GA8369@linux.intel.com>
 <CAFA6WYNwSSaZv5OM=q+LCyn0mEdpg7K+W_v2_NBHhtktg1BFXw@mail.gmail.com>
In-Reply-To: <CAFA6WYNwSSaZv5OM=q+LCyn0mEdpg7K+W_v2_NBHhtktg1BFXw@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Janne Karhunen <janne.karhunen@gmail.com>, Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Stuart Yoder <stuart.yoder@arm.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Mon, Nov 04, 2019 at 12:28:47PM +0530, Sumit Garg wrote:
> On Sat, 2 Nov 2019 at 01:50, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Nov 01, 2019 at 03:04:18PM +0530, Sumit Garg wrote:
> >
> > > Isn't this statement contradicting with your earlier statement
> > > regarding the right order would be to complete TEE patches review
> > > first and then come up with documentation here [2]?
> > >
> > > [1] https://lore.kernel.org/linux-integrity/1568025601.4614.253.camel@linux.ibm.com/
> > > [2] https://lore.kernel.org/linux-integrity/20190909163643.qxmzpcggi567hmhv@linux.intel.com/
> >
> > With the intersecting issues, namely key generation and conflicting
> > keyctl parameters, that was not a well considered statement.
> 
> Okay, let me work on documentation first, but I think resending whole
> patch-set just for documentation review and rework would be an
> overkill. Would minor revisions of this patch only like v3.1, v3.2
> etc. work for you? And later I could send next version of this
> patch-set once we agree on documentation.

Yeah, we could iterate through the documentation patch and once
we are happy with it you can bundle it to your main patch set.

/Jarkko
