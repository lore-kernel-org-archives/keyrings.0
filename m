From: David Howells <dhowells@redhat.com>
Date: Fri, 21 Sep 2018 23:05:19 +0000
Subject: Re: [PATCH v8 04/12] keys: export lookup_user_key to external users
Message-Id: <16512.1537571119@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAPcyv4jO9-OrBvDNxN6hB4X6bPKnerqkdh812_LjScwe44mX2A@mail.gmail.com>
 <153549632073.4089.3609134467249378610.stgit@djiang5-desk3.ch.intel.com>
 <153549646033.4089.17866270311512341456.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <CAPcyv4jO9-OrBvDNxN6hB4X6bPKnerqkdh812_LjScwe44mX2A@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Schofield, Alison  <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm" <linux-nvdimm@lists.01.org>, ebiggers3@gmail.com, dhowells@redhat.com, keyrings@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> wrote:

> This looks like a core api for affecting keyctl api internals, should
> it be EXPORT_SYMBOL_GPL?

No, it should be EXPORT_SYMBOL().  Let me look through the other patches.

David
