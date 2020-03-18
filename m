From: James Morris <jmorris@namei.org>
Date: Wed, 18 Mar 2020 18:57:34 +0000
Subject: Re: [PATCH 03/17] security: Add a hook for the point of notification insertion [ver #5]
Message-Id: <alpine.LRH.2.21.2003190557200.29708@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454382138.2863966.4611034029343321389.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454382138.2863966.4611034029343321389.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, linux-security-module@vger.kernel.orgCasey Schaufler <casey@schaufler-ca.com>Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.orglinux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> Add a security hook that allows an LSM to rule on whether a notification
> message is allowed to be inserted into a particular watch queue.
> 
> The hook is given the following information:
> 
>  (1) The credentials of the triggerer (which may be init_cred for a system
>      notification, eg. a hardware error).
> 
>  (2) The credentials of the whoever set the watch.
> 
>  (3) The notification message.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org
> ---
> 
>  include/linux/lsm_hooks.h |   14 ++++++++++++++
>  include/linux/security.h  |   14 ++++++++++++++
>  security/security.c       |    9 +++++++++
>  3 files changed, 37 insertions(+)


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
