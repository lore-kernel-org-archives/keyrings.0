From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 12 Oct 2018 18:14:06 +0000
Subject: Re: [PATCH 2/2] conf: add upcall line for nvdimm in request-key.conf
Message-Id: <CAPcyv4g2zKK76h1z17oqfW=E6K6dZ5kVk9GCZLyqVFAakuh3Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

On Fri, Oct 12, 2018 at 11:08 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add support for nvdimm key management.

Kind of sad that we need to edit this top-level conf file. David,
could you clarify why /etc/request.d can't be used for kernel upcalls?
Otherwise, assuming that's not an acceptable approach:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
