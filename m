From: James Morris <jmorris@namei.org>
Date: Sat, 25 May 2019 03:57:02 +0000
Subject: Re: [PATCH 2/7] keys: sparse: Fix incorrect RCU accesses
Message-Id: <alpine.LRH.2.21.1905251356520.32154@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856409697.10428.15024260088836364169.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856409697.10428.15024260088836364169.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 22 May 2019, David Howells wrote:

> Fix a pair of accesses that should be using RCU protection.
> 
> rcu_dereference_protected() is needed to access task_struct::real_parent.
> 
> current_cred() should be used to access current->cred.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
