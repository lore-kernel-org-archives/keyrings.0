From: James Morris <jmorris@namei.org>
Date: Wed, 18 Mar 2020 19:07:11 +0000
Subject: Re: [PATCH 12/17] watch_queue: Add security hooks to rule on setting mount and sb watches [ver #5]
Message-Id: <alpine.LRH.2.21.2003190606591.29708@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454390389.2863966.16459187265972715098.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454390389.2863966.16459187265972715098.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, linux-security-module@vger.kernel.orgCasey Schaufler <casey@schaufler-ca.com>Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.orglinux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> Add security hooks that will allow an LSM to rule on whether or not a watch
> may be set on a mount or on a superblock.  More than one hook is required
> as the watches watch different types of object.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: Stephen Smalley <sds@tycho.nsa.gov>
> cc: linux-security-module@vger.kernel.org


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
