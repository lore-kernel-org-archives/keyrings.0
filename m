From: David Howells <dhowells@redhat.com>
Date: Wed, 24 Apr 2019 21:54:30 +0000
Subject: Re: [PATCH 10/11] keys: Network namespace domain tag
Message-Id: <1353.1556142870@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155612249070.8564.3179241610171819187.stgit@warthog.procyon.org.uk> <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk>
In-Reply-To: <155612249070.8564.3179241610171819187.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, ebiederm@xmission.com, netdev@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dwalsh@redhat.com, vgoyal@redhat.com

David Howells <dhowells@redhat.com> wrote:

> @@ -385,10 +392,20 @@ static struct net *net_alloc(void)
>  	if (!net)
>  		goto out_free;
>  
> +#ifdef CONFIG_KEYS
> +	net->key_domain = kzalloc(sizeof(struct key_tag), GFP_KERNEL);
> +	if (!net->key_domain)
> +		goto out_free_2;
> +#endif

Initialisation of net->key_domain->usage to 1 is needed here.  I've fixed that
and repushed the patches to the branch.

David
