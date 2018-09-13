From: David Howells <dhowells@redhat.com>
Date: Thu, 13 Sep 2018 21:50:56 +0000
Subject: Re: [PATCH 4/6] afs: Differentiate VL servers
Message-Id: <14307.1536875456@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153685496637.16086.17825712088461188576.stgit@warthog.procyon.org.uk> <153685493441.16086.3483582787020297039.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685496637.16086.17825712088461188576.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +		ret = -EPROTONOSUPPORT;
> +		if (protocol != IPPROTO_UDP)
> +			goto error;

This needs to be:

		ret = -EPROTONOSUPPORT;
		if (protocol != IPPROTO_UDP && protocol != 0)
			goto error;

so that if the protocol is unspecified by the DNS upcall program, we choose
UDP.

David
