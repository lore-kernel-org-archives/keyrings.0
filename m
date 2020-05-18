From: David Howells <dhowells@redhat.com>
Date: Mon, 18 May 2020 14:09:21 +0000
Subject: Re: [PATCH 1/1] Documentation: security: core.rst: add missing argument
Message-Id: <870601.1589810961@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net> <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
In-Reply-To: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
To: Ben Boeckel <me@benboeckel.net>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>, jarkko.sakkinen@linux.intel.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Ben Boeckel <me@benboeckel.net> wrote:

>  	long keyctl(KEYCTL_PKEY_QUERY,
>  		    key_serial_t key_id, unsigned long reserved,
> +		    const char* params,
>  		    struct keyctl_pkey_query *info);

"const char *params".  I fixed that and applied it.

David
