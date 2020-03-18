From: James Morris <jmorris@namei.org>
Date: Wed, 18 Mar 2020 19:06:10 +0000
Subject: Re: [PATCH 10/17] selinux: Implement the watch_key security hook [ver #5]
Message-Id: <alpine.LRH.2.21.2003190605590.29708@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454388633.2863966.17799427202351674141.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454388633.2863966.17799427202351674141.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.comStephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io, andres@anarazel.de, jlayton@redhat.com, dray@redhat.com, kzak@redhat.com, keyrings@vger.kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, David Howells wrote:

> Implement the watch_key security hook to make sure that a key grants the
> caller View permission in order to set a watch on a key.
> 
> For the moment, the watch_devices security hook is left unimplemented as
> it's not obvious what the object should be since the queue is global and
> didn't previously exist.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
