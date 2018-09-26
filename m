From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Sep 2018 21:28:12 +0000
Subject: Re: [PATCH v10 00/12] Adding security support for nvdimm
Message-Id: <CAPcyv4hfsV6eiUOVXg7HwGr7GpMpv=9Tjg1wMVY_UNDtMat_mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153799466529.71621.10728628542331983376.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153799466529.71621.10728628542331983376.stgit@djiang5-desk3.ch.intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>, Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org

On Wed, Sep 26, 2018 at 1:47 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> The following series implements security support for nvdimm. Mostly adding
> new security DSM support from the Intel NVDIMM DSM spec v1.7, but also
> adding generic support libnvdimm for other vendors. The most important
> security features are unlocking locked nvdimms, and updating/setting security
> passphrase to nvdimms.
>
> v10:

Looks good to me, I'll get this soaking in -next. David please pipe up
if there are any concerns left unaddressed, but I think Dave covered
them all.
