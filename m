From: James Morris <jmorris@namei.org>
Date: Tue, 05 Mar 2019 03:28:07 +0000
Subject: Re: [PATCH] keys: fix missing __user in KEYCTL_PKEY_QUERY
Message-Id: <alpine.LRH.2.21.1903051427590.20560@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20190301113026.17721-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, serge@hallyn.com, linux-kernel@lists.codethink.co.uk

On Fri, 1 Mar 2019, Ben Dooks wrote:

> The arg5 of KEYCTL_PKEY_QUERY should have a __user pointer tag on
> it as it is a user pointer. This clears the following sparse warning
> for this:
> 
> security/keys/keyctl.c:1755:43: warning: incorrect type in argument 3 (different address spaces)
> security/keys/keyctl.c:1755:43:    expected struct keyctl_pkey_query [noderef] <asn:1>*<noident>
> security/keys/keyctl.c:1755:43:    got struct keyctl_pkey_query *<noident>
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>
