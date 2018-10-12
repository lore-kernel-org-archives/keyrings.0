From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 12 Oct 2018 18:11:23 +0000
Subject: Re: [PATCH 1/2] keyutils: Add pkg-config file for keyutils library
Message-Id: <CAPcyv4g8MwdL1mKggsv6ABc7tqMDYi0CGBUHBENdPuxrci23RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936768778.53805.17270502000080117870.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936768778.53805.17270502000080117870.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

On Fri, Oct 12, 2018 at 11:08 AM Dave Jiang <dave.jiang@intel.com> wrote:
>
> This is needed so that other projects can add a dependency on libkeyutils
> via PKG_CHECK_MODULES([KEYUTILS], [keyutils]).  This enabling makes 'make
> install' do the right thing, and of course individual distros will need to
> add enabling to their associated packages (rpm, deb, etc.) so the package
> manager installs do the right thing.

This looks good to me and saves people from needing to duplicate the
same open coded autoconf goop that cifs-utils and nfs-utils have had
to implement.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
