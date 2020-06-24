From: David Howells <dhowells@redhat.com>
Date: Wed, 24 Jun 2020 00:55:16 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <3015561.1592960116@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
In-Reply-To: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dhowells@redhat.com, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>

Dan Williams <dan.j.williams@intel.com> wrote:

> > This commit:
> >
> > >       keys: Make the KEY_NEED_* perms an enum rather than a mask
> >
> > ...upstream as:
> >
> >     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
> >
> > ...triggers a regression in the libnvdimm unit test that exercises the
> > encrypted keys used to store nvdimm passphrases. It results in the
> > below warning.
> 
> This regression is still present in tip of tree. David, have you had a
> chance to take a look?

nvdimm_lookup_user_key() needs to indicate to lookup_user_key() what it wants
the key for so that the appropriate security checks can take place in SELinux
and Smack.  Note that I have a patch in the works that changes this still
further.

Does setting the third argument of lookup_user_key() to KEY_NEED_SEARCH work
for you?

David
