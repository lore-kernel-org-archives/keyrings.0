From: David Howells <dhowells@redhat.com>
Date: Fri, 05 Oct 2018 15:51:42 +0000
Subject: Re: [PATCH 05/22] KEYS: Provide software public key query function
Message-Id: <22418.1538754702@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LRH.2.21.1810040520570.16168@namei.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <153618449119.7946.11025480207548147086.stgit@warthog.procyon.org.uk>
In-Reply-To: <alpine.LRH.2.21.1810040520570.16168@namei.org>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, denkenz@gmail.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:

> > +	if (strcmp(encoding, "raw") = 0) {
> > +		strcpy(alg_name, pkey->pkey_algo);
> > +		return 0;
> > +	}
> 
> Can encoding here also be NULL to indicate raw? per patch 01:

Ummm...  By the letter of the documentation, yes, though in practice it isn't
(it is defaulted to "raw") in the keyctl interface.  I wonder if it would be
better to require it to say "raw" and never be NULL.

David
