From: Kairui Song <kasong@redhat.com>
Date: Mon, 14 Jan 2019 03:28:10 +0000
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for signature verify
Message-Id: <CACPcB9caE8Go+MuayBe_Pzz+iHSRi0rr1-Yo1Qtbks=h5+fN1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190109164824.19708-1-kasong@redhat.com> <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com> <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com, Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com, linux-integrity <linux-integrity@vger.kernel.org>, kexec@lists.infradead.org

Hi, Mimi, Dave

I checked the previous patches:
https://www.spinics.net/lists/keyrings/msg03518.html
https://www.spinics.net/lists/keyrings/msg03517.html
https://www.spinics.net/lists/keyrings/msg03516.html

That the latest patched I could found that placed the platform keyring in certs/
However it didn't cc kexec list, and so I think Dave didn't receive them.

I could compose a patch to use the previous design, how do you think?


On Sun, Jan 13, 2019 at 9:40 AM Dave Young <dyoung@redhat.com> wrote:
>
> Hi,
>
> On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > [snip]
> >
> > > Personally I would like to see platform key separated from integrity.
> > > But for the kexec_file part I think it is good at least it works with
> > > this fix.
> > >
> > > Acked-by: Dave Young <dyoung@redhat.com>
> >
> > The original "platform" keyring patches that Nayna posted multiple
> > times were in the certs directory, but nobody commented/responded.  So
> > she reworked the patches, moving them to the integrity directory and
> > posted them (cc'ing the kexec mailing list).  It's a bit late to be
> > asking to move it, isn't it?
>
> Hmm, apologize for being late,  I did not get chance to have a look the
> old series.  Since we have the needs now, it should be still fine
>
> Maybe Kairui can check Nayna's old series, see if he can do something
> again?
>
> >
> > Mimi
> >
>
> Thanks
> Dave



--
Best Regards,
Kairui Song
