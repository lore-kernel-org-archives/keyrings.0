From: David Howells <dhowells@redhat.com>
Date: Fri, 28 Sep 2018 09:28:10 +0000
Subject: Re: [PATCH v10 06/12] nfit/libnvdimm: add set passphrase support for Intel nvdimms
Message-Id: <28715.1538126890@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <26387.1538124354@warthog.procyon.org.uk>
 <153799483810.71621.11639561453544624699.stgit@djiang5-desk3.ch.intel.com>
 <153799466529.71621.10728628542331983376.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <26387.1538124354@warthog.procyon.org.uk>
Cc: alison.schofield@intel.com, keescook@chromium.org, linux-nvdimm@lists.01.org, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> 	if (sscanf(buf, "%" __stringify(SEC_CMD_SIZE) "s %u %u", ...) = 3)

Actually, that would need to be "SEC_CMD_SIZE - 1" - which might get
stringified as-is.

David
