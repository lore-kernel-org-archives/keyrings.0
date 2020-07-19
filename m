From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Jul 2020 18:10:04 +0000
Subject: Re: [RFC PATCH 0/5] keys: Security changes, ACLs and Container keyring
Message-Id: <87tuy3nzpf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
In-Reply-To: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Thu, 16 Jul 2020 21:34:37 +0100")
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, jlayton@redhat.com, christian@brauner.io, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>

David Howells <dhowells@redhat.com> writes:

> Here are some patches to provide some security changes and some container
> support:

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

There remain unfixed security issues in the new mount api.   Those need
to get fixed before it is even worth anyones time reviewing new code.

Those issues came up in the review.  I successfully demonstrated how to
address the security issues in the new mount api before the code was
merged.  Yet the code was merged with the security issues present,
and I have not seem those issues addressed.

So far I have had to rewrite two filesystems because of bugs in the
mount API.

Enough is enough.  Let's get the what has already been merged sorted
out before we had more.

Eric
