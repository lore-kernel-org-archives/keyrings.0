From: James Morris <jmorris@namei.org>
Date: Tue, 28 May 2019 21:01:47 +0000
Subject: Re: [PATCH 7/7] keys: Grant Link permission to possessers of request_key auth keys
Message-Id: <alpine.LRH.2.21.1905290701390.31297@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856413201.10428.13385006340817641517.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856413201.10428.13385006340817641517.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> Grant Link permission to the possessers of request_key authentication keys,
> thereby allowing a daemon that is servicing upcalls to arrange things such
> that only the necessary auth key is passed to the actual service program
> and not all the daemon's pending auth keys.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
