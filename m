From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 12 Oct 2018 20:53:15 +0000
Subject: Re: [PATCH 2/2] conf: add upcall line for nvdimm in request-key.conf
Message-Id: <CAPcyv4gqzu9+NdDm4_dSHFdOKzE=Xm3iia7Axb8-HDWbtROTCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

On Fri, Oct 12, 2018 at 1:37 PM David Howells <dhowells@redhat.com> wrote:
>
> You should take a look at this patch:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/commit/?h=next&id_2f3c34b0b23e5d2ea4564ac990827c47999992
>
> on the keyutils next branch.  You should add a file into:
>
>         /etc/request-key.d/
>
> with this line:
>
>         +create  logon   nvdimm*         *               /usr/sbin/nvdimm-upcall %k
>
> in it.  Do you actually want to say "nvdimm:*", btw?

Thanks David. I also saw your recent pull request add TPM support.
That's something we're interested in as a follow-on for the nvdimm
keys so we can perhaps minimize a plain text key floating around in
kernel space.

So next time I'll pay closer attention to latest upstream before
shooting off snarky comments.
