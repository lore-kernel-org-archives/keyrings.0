From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Sep 2019 15:54:17 +0000
Subject: Re: Can KEY_DH_OPERATIONS become tristate? (was: Re: Kernel 5.3.0 stuck during boot on Amiga)
Message-Id: <16476.1568822057@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAMuHMdVHZ9srJcK+PY=YoP55z1NSjBAtkSr2ROA8i84C75v0zQ@mail.gmail.com> <278d9706-162d-28a4-4640-31b697924473@physik.fu-berlin.de> <c5acb1c0-7a5b-ce42-8b2f-5fd30cbdab6e@physik.fu-berlin.de> <6304acd1-7b71-b1fb-f8d8-298cb3025e69@physik.fu-berlin.de> <6725b972-05d4-fed4-7094-16401e86b452@gmail.com> <578d8a91-aaee-087f-1742-65e64001b8fa@physik.fu-berlin.de> <CAMuHMdUU6ejc168-ksqXrkE+PjCXFJumaRaWjRtj12NjG_TFSg@mail.gmail.com> <CAMuHMdWfTrx8VuJoifEEBc1n+3MiiuwKNWcRnUw+TgWJCtOWag@mail.gmail.com> <fea74ca3-4b24-780f-af74-a786646b1668@physik.fu-berlin.de> <CAMuHMdVeedJZE6mrGdYqRgawUtfu_ww5p-Qg1rLXNmGWiY7Nxg@mail.gmail.com>
In-Reply-To: <CAMuHMdVHZ9srJcK+PY=YoP55z1NSjBAtkSr2ROA8i84C75v0zQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> CC crypto keys people
> 
> TL;DR: CONFIG_CRYPTO_DH=y is reported to cause boot delays of several
> minutes on old and slow machines.

Why is it doing that?  It doesn't do anything unless it is called, so
something must be calling it.

> Can KEY_DH_OPERATIONS be made tristate?

Um.  It's non-trivial since it's implementing a keyctl() function for
userspace to call and there's currently no ops table to jump through.

David
