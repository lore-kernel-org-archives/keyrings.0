From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 18 Jun 2020 07:19:55 +0000
Subject: Re: [PATCH v5 1/4] KEYS: trusted: Add generic trusted keys framework
Message-Id: <20200618071955.GE6560@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
 <1591107505-6030-2-git-send-email-sumit.garg@linaro.org>
 <20200615182457.GB5416@linux.intel.com>
 <CAFA6WYNEnXm5FOGHGAg4XB-+GXD=C+YMh+6t976=pStU0WshAA@mail.gmail.com>
 <20200617231429.GD62794@linux.intel.com>
 <CAFA6WYOdtwnewqY0ASnMf7fyw3s_hQx0+oWJRhT3CpkkkxYpDA@mail.gmail.com>
In-Reply-To: <CAFA6WYOdtwnewqY0ASnMf7fyw3s_hQx0+oWJRhT3CpkkkxYpDA@mail.gmail.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Luke Hinds <lhinds@redhat.com>, op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>, James Bottomley <jejb@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, Markus Wamser <Markus.Wamser@mixed-mode.de>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>

On Thu, Jun 18, 2020 at 12:12:41PM +0530, Sumit Garg wrote:
> On Thu, 18 Jun 2020 at 04:44, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 07:02:37PM +0530, Sumit Garg wrote:
> > > + Luke
> > >
> > > Hi Jarkko,
> > >
> > > Prior to addressing your comments below which seems to show your
> > > preference for compile time selection of trust source (TPM or TEE), I
> > > would just like to hear the reasons for this preference especially if
> > > it makes distro vendor's life difficult [1] to make opinionated
> > > selection which could rather be achieved dynamically based on platform
> > > capability.
> > >
> > > [1] https://lkml.org/lkml/2020/6/3/405
> > >
> > > -Sumit
> >
> > Hmm... I do get the distribution kernel point. OK, lets revert to
> > dynamic then. Thanks for the remark.
> >
> > /Jarkko
> 
> Thanks, will revert to dynamic mode in v6.

Sorry about the extra trouble caused by me.

/Jarkko
