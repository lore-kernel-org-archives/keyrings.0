From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 12 Dec 2019 21:13:09 +0000
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key" measurements
Message-Id: <1576185189.4579.165.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
         <20191211185116.2740-2-nramas@linux.microsoft.com>
         <1576138743.4579.147.camel@linux.ibm.com>
         <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
In-Reply-To: <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: eric.snowberg@oracle.com, dhowells@redhat.com, mathew.j.martineau@linux.intel.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org

On Thu, 2019-12-12 at 08:57 -0800, Lakshmi Ramasubramanian wrote:
> On 12/12/19 12:19 AM, Mimi Zohar wrote:
> 
> >>> +	ima_process_keys = true;
> >> +
> >> +	INIT_LIST_HEAD(&temp_ima_keys);
> >> +
> >> +	mutex_lock(&ima_keys_mutex);
> >> +
> >> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> >> +		list_move_tail(&entry->list, &temp_ima_keys);
> >> +
> >> +	mutex_unlock(&ima_keys_mutex);
> > 
> > 
> > The v1 comment, which explained the need for using a temporary
> > keyring, is an example of an informative comment.  If you don't
> > object, instead of re-posting this patch, I can insert it.
> 
> Sure Mimi. Thanks for including the comment in the patch.

Looking at this again, something seems off or at least the comment 
doesn't match the code.

       /*
         * To avoid holding the mutex while processing queued keys,
         * transfer the queued keys with the mutex held to a temp list,
         * release the mutex, and then process the queued keys from
         * the temp list.
         *
         * Since ima_process_keys is set to true above, any new key will
         * be processed immediately and not queued.
         */

Setting ima_process_key before taking the lock won't prevent the race.
 I think you want to test ima_process_keys before taking the lock and
again immediately afterward taking the lock, before setting it.  Then
the comment would match the code.

Shouldn't ima_process_keys be defined as static to limit the scope to
this file?

Mimi
