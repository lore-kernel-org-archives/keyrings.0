From: James Morris <jmorris@namei.org>
Date: Wed, 18 Mar 2020 18:56:08 +0000
Subject: Re: [PATCH 02/17] security: Add hooks to rule on setting a watch [ver #5]
Message-Id: <alpine.LRH.2.21.2003190555450.29708@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454381028.2863966.13720387027986442186.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454381028.2863966.13720387027986442186.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, linux-security-module@vger.kernel.orgCasey Schaufler <casey@schaufler-ca.com>Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.orglinux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> Add security hooks that will allow an LSM to rule on whether or not a watch
> may be set.  More than one hook is required as the watches watch different
> types of object.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org
> ---
> 
>  include/linux/lsm_hooks.h |   24 ++++++++++++++++++++++++
>  include/linux/security.h  |   17 +++++++++++++++++
>  security/security.c       |   14 ++++++++++++++
>  3 files changed, 55 insertions(+)
> 


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
