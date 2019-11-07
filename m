From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 07 Nov 2019 18:15:28 +0000
Subject: Re: [RFC PATCH 08/14] pipe: Allow buffers to be marked read-whole-or-error for notifications [ver #2
Message-Id: <CALCETrWszYm9=-WEgSbhmGc3DYCvY6q3W4Lezm6YtKnGtRs_5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
 <157313379331.29677.5209561321495531328.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313379331.29677.5209561321495531328.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Nov 7, 2019 at 5:39 AM David Howells <dhowells@redhat.com> wrote:
>
> Allow a buffer to be marked such that read() must return the entire buffer
> in one go or return ENOBUFS.  Multiple buffers can be amalgamated into a
> single read, but a short read will occur if the next "whole" buffer won't
> fit.
>
> This is useful for watch queue notifications to make sure we don't split a
> notification across multiple reads, especially given that we need to
> fabricate an overrun record under some circumstances - and that isn't in
> the buffers.

Hmm.  I'm not totally in love with introducing a new error code like
this for read(), especially if it could affect the kind of pipe that
is bound to a file in a filesystem.  But maybe it's not a problem.
