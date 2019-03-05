From: David Howells <dhowells@redhat.com>
Date: Tue, 05 Mar 2019 07:41:54 +0000
Subject: Re: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
Message-Id: <29870.1551771714@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, linux-kernel@lists.codethink.co.uk

Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
> it as it is a user pointer. This clears the following sparse warning
> for this:
> 
> security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
> security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
> security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: David Howells <dhowells@redhat.com>
