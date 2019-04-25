From: David Howells <dhowells@redhat.com>
Date: Thu, 25 Apr 2019 11:02:42 +0000
Subject: Re: [PATCH 05/11] keys: Add a 'recurse' flag for keyring searches
Message-Id: <20948.1556190162@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com> <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk> <155612245200.8564.4960129218705025182.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAOq732KsRiXtGD9Wj-iGB77pqJbprCiuDKy_Ypi=dLfvn_9QNQ@mail.gmail.com>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: dhowells@redhat.com, ebiederm@xmission.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dwalsh@redhat.com, vgoyal@redhat.com

Andrew Zaborowski <andrew.zaborowski@intel.com> wrote:

> >  extern key_ref_t keyring_search(key_ref_t keyring,
> >                                 struct key_type *type,
> > -                               const char *description);
> > +                               const char *description,
> > +                               bool no_recurse);
> 
> No functional difference but it's "recurse" everywhere else.

Fixed, thanks.

David
