From: David Howells <dhowells@redhat.com>
Date: Fri, 30 Aug 2019 14:13:03 +0000
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042 from LTP
Message-Id: <4384.1567174383@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190830085646.14740-1-hdanton@sina.com>
In-Reply-To: <20190830085646.14740-1-hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, Sachin Sant <sachinp@linux.vnet.ibm.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Hillf Danton <hdanton@sina.com> wrote:

> -	struct request_key_auth *rka = dereference_key_rcu(key);
> +	struct request_key_auth *rka;
> +
> +	rcu_read_lock();
> +	rka = dereference_key_rcu(key);

This shouldn't help as the caller, proc_keys_show(), is holding the RCU read
lock across the call.  The end of the function reads:

		if (key->type->describe)
			key->type->describe(key, m);
		seq_putc(m, '\n');

		rcu_read_unlock();
		return 0;
	}

and the documentation says "This method will be called with the RCU read lock
held".

I suspect the actual bugfix is this bit:

> +	if (!rka)
> +		goto out;

David
