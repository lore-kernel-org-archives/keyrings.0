From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 18 Jun 2020 00:43:48 +0000
Subject: Re: [PATCH 0/5] kmod/umh: a few fixes
Message-Id: <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com, slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org, josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, bridge@lists.linux-foundation.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 15:49:18 +0000 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> Tiezhu Yang had sent out a patch set with a slew of kmod selftest
> fixes, and one patch which modified kmod to return 254 when a module
> was not found. This opened up pandora's box about why that was being
> used for and low and behold its because when UMH_WAIT_PROC is used
> we call a kernel_wait4() call but have never unwrapped the error code.
> The commit log for that fix details the rationale for the approach
> taken. I'd appreciate some review on that, in particular nfs folks
> as it seems a case was never really hit before.
> 
> This goes boot tested, selftested with kmod, and 0-day gives its
> build blessings.

Any thoughts on which kernel version(s) need some/all of these fixes?

>  drivers/block/drbd/drbd_nl.c         | 20 +++++------
>  fs/nfsd/nfs4recover.c                |  2 +-
>  include/linux/sched/task.h           | 13 ++++++++
>  kernel/kmod.c                        |  5 ++-
>  kernel/umh.c                         |  4 +--
>  lib/test_kmod.c                      |  2 +-
>  net/bridge/br_stp_if.c               | 10 ++----
>  security/keys/request_key.c          |  2 +-
>  tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----

I'm not really sure who takes kmod changes - I'll grab these unless
someone shouts at me.
