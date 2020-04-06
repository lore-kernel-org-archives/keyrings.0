From: Joe Perches <joe@perches.com>
Date: Mon, 06 Apr 2020 17:46:17 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <fc62bbbe692f695e9231e0007715d80d164f7540.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
	 <20200406023700.1367-1-longman@redhat.com>
	 <319765.1586188840@warthog.procyon.org.uk>
	 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
	 <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
	 <adc76d7c441e8f10697b61ceaff66207fb219886.camel@perches.com>
	 <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
	 <7eb36a794df38c885689085618a8a4ff9df3dd2c.camel@perches.com>
	 <CAHk-=wj=zTfrjXbFp+yhMpjH5jyx=t5fcDVmYN6KpE9Tjxb9YA@mail.gmail.com>
In-Reply-To: <CAHk-=wj=zTfrjXbFp+yhMpjH5jyx=t5fcDVmYN6KpE9Tjxb9YA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2020-04-06 at 10:33 -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 10:22 AM Joe Perches <joe@perches.com> wrote:
> > API function naming symmetry is good.
[]
> See? There is no API symmetry. There is only a small and immaterial
> implementation detail.

The symmetry to an API is the existing 300+
kzfree calls.

Renaming all the kzfree calls would be fine.

Consolidating all the various types of kfree
to just kfree might be even better.

cheers, Joe
