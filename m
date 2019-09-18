From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Sep 2019 16:18:47 +0000
Subject: Re: Can KEY_DH_OPERATIONS become tristate? (was: Re: Kernel 5.3.0 stuck during boot on Amiga)
Message-Id: <CAMuHMdU_2RWFc=xs3tM38Nt_44k3dp5MMuKAT2MacyuCbO+1Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <278d9706-162d-28a4-4640-31b697924473@physik.fu-berlin.de>
 <c5acb1c0-7a5b-ce42-8b2f-5fd30cbdab6e@physik.fu-berlin.de>
 <6304acd1-7b71-b1fb-f8d8-298cb3025e69@physik.fu-berlin.de>
 <6725b972-05d4-fed4-7094-16401e86b452@gmail.com> <578d8a91-aaee-087f-1742-65e64001b8fa@physik.fu-berlin.de>
 <CAMuHMdUU6ejc168-ksqXrkE+PjCXFJumaRaWjRtj12NjG_TFSg@mail.gmail.com>
 <CAMuHMdWfTrx8VuJoifEEBc1n+3MiiuwKNWcRnUw+TgWJCtOWag@mail.gmail.com>
 <fea74ca3-4b24-780f-af74-a786646b1668@physik.fu-berlin.de>
 <CAMuHMdVeedJZE6mrGdYqRgawUtfu_ww5p-Qg1rLXNmGWiY7Nxg@mail.gmail.com>
 <CAMuHMdVHZ9srJcK+PY=YoP55z1NSjBAtkSr2ROA8i84C75v0zQ@mail.gmail.com> <16476.1568822057@warthog.procyon.org.uk>
In-Reply-To: <16476.1568822057@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi David,

On Wed, Sep 18, 2019 at 5:54 PM David Howells <dhowells@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > CC crypto keys people
> >
> > TL;DR: CONFIG_CRYPTO_DH=y is reported to cause boot delays of several
> > minutes on old and slow machines.
>
> Why is it doing that?  It doesn't do anything unless it is called, so
> something must be calling it.

I don't know.  Enabling initcall_debug shows that dh_init() takes a very long
time.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
