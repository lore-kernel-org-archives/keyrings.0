From: David Howells <dhowells@redhat.com>
Date: Tue, 03 Sep 2019 16:37:10 +0000
Subject: Re: [PATCH 04/11] General notification queue with user mmap()'able ring buffer [ver #7]
Message-Id: <27533.1567528630@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190903085706.7700-1-hdanton@sina.com> <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
In-Reply-To: <20190903085706.7700-1-hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> wrote:

> > +	for (i = 0; i < wf->nr_filters; i++) {
> > +		wt = &wf->filters[i];
> > +		if (n->type = wt->type &&
> > +		    (wt->subtype_filter[n->subtype >> 5] &
> > +		     (1U << (n->subtype & 31))) &&
> 
> Replace the pure numbers with something easier to understand.

How about the following:

static bool filter_watch_notification(const struct watch_filter *wf,
				      const struct watch_notification *n)
{
	const struct watch_type_filter *wt;
	unsigned int st_bits = sizeof(wt->subtype_filter[0]) * 8;
	unsigned int st_index = n->subtype / st_bits;
	unsigned int st_bit = 1U << (n->subtype % st_bits);
	int i;

	if (!test_bit(n->type, wf->type_filter))
		return false;

	for (i = 0; i < wf->nr_filters; i++) {
		wt = &wf->filters[i];
		if (n->type = wt->type &&
		    (wt->subtype_filter[st_index] & st_bit) &&
		    (n->info & wt->info_mask) = wt->info_filter)
			return true;
	}

	return false; /* If there is a filter, the default is to reject. */
}

David
