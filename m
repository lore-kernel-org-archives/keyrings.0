From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 11 May 2020 21:41:27 +0000
Subject: Re: [PATCH v2] security/keys: rewrite big_key crypto to use Zinc
Message-Id: <CAHmME9oXiTmVuOYmG=K3ijWK+zP2yB9a2CFjbLx_5fkDiH30Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHmME9rvp4JrER0RPp=VgYwYL87jntwW8vWNANzubH3Ah_8Oow@mail.gmail.com>
 <20200502001942.626523-1-Jason@zx2c4.com> <20200510211738.GA52708@sol.localdomain>
In-Reply-To: <20200510211738.GA52708@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com

On Sun, May 10, 2020 at 3:17 PM Eric Biggers <ebiggers@kernel.org> wrote:
> The commit message should say "lib/crypto", not Zinc.  Nothing in the source
> tree actually says Zinc, so it will confuse people who haven't read all the
> previous discussions.

Old commit message from a few years ago. Will adjust.

>
> >               /* read file to kernel and decrypt */
> > -             ret = kernel_read(file, buf->virt, enclen, &pos);
> > +             ret = kernel_read(file, buf, enclen, &pos);
> >               if (ret >= 0 && ret != enclen) {
> >                       ret = -EIO;
> >                       goto err_fput;
> > +             } else if (ret < 0) {
> > +                     goto err_fput;
> >               }
>
> It would make sense to write this as the following, to make it consistent with
> how the return value of kernel_write() is checked in big_key_preparse():
>
>                 ret = kernel_read(file, buf, enclen, &pos);
>                 if (ret != enclen) {
>                         if (ret >= 0)
>                                 ret = -ENOMEM;
>                         goto err_fput;
>                 }

Will do, and will send a v3 with your reviewed-by.

Jason
