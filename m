From: David Howells <dhowells@redhat.com>
Date: Sat, 22 Sep 2018 00:01:23 +0000
Subject: Re: [PATCH v8 04/12] keys: export lookup_user_key to external users
Message-Id: <19731.1537574483@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153549646033.4089.17866270311512341456.stgit@djiang5-desk3.ch.intel.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153549646033.4089.17866270311512341456.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dave Jiang <dave.jiang@intel.com> wrote:

> Export lookup_user_key() symbol in order to allow nvdimm passphrase
> update to retrieve user injected keys.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: David Howells <dhowells@redhat.com>
