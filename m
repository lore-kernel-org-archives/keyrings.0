From: David Howells <dhowells@redhat.com>
Date: Fri, 18 Oct 2019 16:46:27 +0000
Subject: Re: WARNING: refcount bug in find_key_to_update
Message-Id: <32000.1571417187@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191017092428.7336-1-hdanton@sina.com>
In-Reply-To: <20191017092428.7336-1-hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com

Hillf Danton <hdanton@sina.com> wrote:

> -			  (1 << KEY_FLAG_REVOKED))) {
> +			  (1 << KEY_FLAG_REVOKED)) || !key_tryget(key)) {
>  		kleave(" = NULL [x]");
>  		return NULL;
>  	}
> -	__key_get(key);

That should be ineffective and ought not to fix the bug.

David
