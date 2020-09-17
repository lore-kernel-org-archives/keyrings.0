From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 17 Sep 2020 15:17:52 +0000
Subject: Re: [PATCH v11 4/5] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <20200917151752.GA7389@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200912172643.9063-5-James.Bottomley@HansenPartnership.com>
 <202009131413.8dt8QEc8%lkp@intel.com>
 <1600016571.7833.9.camel@HansenPartnership.com>
 <20200915091140.GC3612@linux.intel.com>
 <CAKwvOdnDJKPJ__sVKX2HmLUWyNPo=b0ccLvyBLyWoFfC0EFkiA@mail.gmail.com>
 <20200916162707.GF21026@linux.intel.com>
 <CAKwvOdnM66H2CNwsscgvALsb=gdiV9UDLQuqrKzdbmCr5S1McA@mail.gmail.com>
In-Reply-To: <CAKwvOdnM66H2CNwsscgvALsb=gdiV9UDLQuqrKzdbmCr5S1McA@mail.gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org, kbuild-all@lists.01.org, clang-built-linux <clang-built-linux@googlegroups.com>, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Wed, Sep 16, 2020 at 11:04:33AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 16, 2020 at 9:27 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > The compiler that you use in your example is unfortunately not
> > preincluded to my Ubuntu installation...
> 
> $ sudo apt install gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf
> -- 
> Thanks,
> ~Nick Desaulniers

Thanks, installed for the future. A bit more convenient than compile
your own chain :-)

/Jarkko
