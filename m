From: David Howells <dhowells@redhat.com>
Date: Mon, 24 Sep 2018 13:17:50 +0000
Subject: Re: Questions about keyctl_dh_compute_kdf
Message-Id: <11341.1537795070@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180924112838.GB20321@rotor>
In-Reply-To: <20180924112838.GB20321@rotor>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> > >   - Should `hashname` be a `const char*`? Does the kernel have any
> > >     reason to write here?
> > >   - Should `otherinfo` be a `const unsigned char*`? Maybe `const void*`?
> > >     If the caller specifies the format, why is it non-const?
> > 
> > You are correct, both should be const. The data type of char is
> > appropriate and should not be turned into a void. If you have a specific
> > data type for the otherinfo data, I think it would be appropriate for the
> > developer to simply type-cast it. In general, I would like to avoid a void
> > unless there is no other way.
> 
> Avoiding `void*` is sensible.

IMO, "(const) void *" should be used for arbitrary or opaque data rather than
"(const) char *" or "(const) unsigned char *" so that you don't need to
typecast the pointer.

> But `const char*` makes me think of C-strings. Maybe `const uint8_t*` to
> indicate that it is arbitrary data?

Don't switch for "(const) char *" to "const uint8_t *" please.  If someone's
already using "char *" their compiler may start complaining as "char" may be
implicitly a signed number and you would be switching to explicitly unsigned.

> Though looking at other APIs, there's mostly `void*` AFAICS (not an excuse,
> just an observation).

Yep.

David
