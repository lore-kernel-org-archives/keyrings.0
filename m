From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Jul 2018 10:40:49 +0000
Subject: Re: [PATCH v5 05/12] keys: add call key_put_sync() to flush key_gc_work when doing a key_put().
Message-Id: <5959.1531910449@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153186087257.27463.13382652631526471099.stgit@djiang5-desk3.ch.intel.com>
 <153186061802.27463.14539931103401173743.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153186087257.27463.13382652631526471099.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> +static void __key_put(struct key *key, bool sync)
> +{
> +	if (key) {
> +		key_check(key);
> +
> +		if (refcount_dec_and_test(&key->usage)) {
> +			schedule_work(&key_gc_work);
> +			if (sync)
> +				flush_work(&key_gc_work);
> +		}
> +	}
> +}

I'm not sure this is a good way to go about it.  This assumes that the gc will
do an entire pass before returning to the dispatcher, but that won't
necessarily always be the case.  Further, it might take two passes to get rid
of a key that has expired, been revoked or been invalidated: the first pass
removes the links and then a second pass might be needed to remove the key,
depending on the serial number of the key relative to the serial numbers of
the keyrings linking to it.  RCU synchronisation is then performed before the
key can actually be cleaned up.

A better way might be to add a global waitqueue and then use that to watch for
an indication that a key is about to be finally destroyed.  A flag can be set
on the key to ask for the waitqueue to be poked

David.
