From: David Howells <dhowells@redhat.com>
Date: Mon, 03 Jul 2017 08:19:03 +0000
Subject: Re: [PATCH v2] KEYS: Add documentation for asymmetric keyring restrictions
Message-Id: <6232.1499069943@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:

> +	root-id=`keyctl add keyring root-certs "" @s`

You can't have a variable with a '-' in it in shell.  You have to change the
'-' to an '_'.

David
