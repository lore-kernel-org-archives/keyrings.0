From: David Howells <dhowells@redhat.com>
Date: Mon, 02 Mar 2020 08:28:52 +0000
Subject: Re: kernel BUG at lib/assoc_array.c:LINE!
Message-Id: <538780.1583137732@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200218211259.GA19673@linux.intel.com> <000000000000f4bf93059db8b081@google.com>
In-Reply-To: <20200218211259.GA19673@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: dhowells@redhat.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> The arguments for request_key_and_link() are fairly constrained:
> 
> type == &key_type_dns_resolver
> description == "afsdb:<cell name>"
> domain_tag == net->key_domain
> callout_info == "srv=1"
> callout_len == 5
> aux == NULL
> dest_keyring == NULL
> flags == KEY_ALLOC_IN_QUOTA
> 
> (manually resolved)
> 
> The only obvious moving part I see is the key type implementatio i.e.
> net/dns_resolver/dns_key.c.

It shouldn't matter what the payload of the key is going to be, but it might
matter what the cell name is.  Looking in the log, I see this:

mount(&(0x7f0000000000)=ANY=[@ANYBLOB="25dc545df1e34ab2e26e2f5034c85b3a"], &(0x7f0000000140)='./file0\x00', &(0x7f0000000180)='afs\x00', 0x0, 0x0)

The:

	@ANYBLOB="25dc545df1e34ab2e26e2f5034c85b3a"

is the source, i.e.:

	%\xdcT]\xf1\xe3J\xb2\xe2n/P4\xc8[':

This is in the form "[%#][<cellname>:]<volumename>", which comports with the
log:

[  621.627412][ T6728] kAFS: unable to lookup cell '?T]??J??n/P4?['

This is a bit odd, since the version allegedly being tested includes a patch
to prohibit AFS cell names that contain unprintable chars.  It should error
out in afs_alloc_cell(), way before it tries to do a DNS lookup.

David
