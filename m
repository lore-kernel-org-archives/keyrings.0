From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Mar 2020 09:27:21 +0000
Subject: Re: kernel BUG at lib/assoc_array.c:LINE!
Message-Id: <686378.1583141241@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <538780.1583137732@warthog.procyon.org.uk> <20200218211259.GA19673@linux.intel.com> <000000000000f4bf93059db8b081@google.com>
In-Reply-To: <538780.1583137732@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com

David Howells <dhowells@redhat.com> wrote:

> [  621.627412][ T6728] kAFS: unable to lookup cell '?T]??J??n/P4?['
> 
> This is a bit odd, since the version allegedly being tested includes a patch
> to prohibit AFS cell names that contain unprintable chars.  It should error
> out in afs_alloc_cell(), way before it tries to do a DNS lookup.

Ah, no, that's okay.  This error message is printed in afs_parse_source() on
the way out after afs_lookup_cell() fails (presumably due to afs_alloc_cell()
failing).

It seems unlikely that the dead process is actually anything to do with the
mount that more or less immediately preceded it in the log.  It mount should
have failed without creating a cell record - which then precludes affecting
afs_manage_cell().  However, a previously created cell with a valid name can
feasibly be driving afs_manage_cell() and causing the problem.

David
