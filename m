From: David Howells <dhowells@redhat.com>
Date: Thu, 27 Jun 2019 22:07:04 +0000
Subject: Re: [PATCH 8/9] keys: Network namespace domain tag [ver #4]
Message-Id: <30674.1561673224@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAF=yD-Kgdwt5=0iboxhvZz4zvNewSGow74U15mQQvO1u8VUGcw@mail.gmail.com> <156096279115.28733.8761881995303698232.stgit@warthog.procyon.org.uk> <156096287188.28733.15342608110117616221.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAF=yD-Kgdwt5=0iboxhvZz4zvNewSGow74U15mQQvO1u8VUGcw@mail.gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, keyrings@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Network Development <netdev@vger.kernel.org>, linux-afs@lists.infradead.org, dwalsh@redhat.com, vgoyal@redhat.com, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> > +#ifdef CONFIG_KEYS
> > +out_free_2:
> > +       kmem_cache_free(net_cachep, net);
> 
> needs
>             net = NULL;
> 
> to signal failure
> 
> > +#endif

I've folded that into the patch and retagged, remerged and repushed.

David
