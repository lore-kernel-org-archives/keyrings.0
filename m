From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 10 Jan 2018 09:42:53 +0000
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/request_key04: new test for request_key() permission check bug
Message-Id: <87vagajbhe.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hello Eric,

Eric Biggers writes:

> From: Eric Biggers <ebiggers@google.com>
>
> Add a test for a bug that allowed the request_key() system call to be
> used to add a key to a keyring using only Search permission.  This bug
> was assigned CVE-2017-17807.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>
> No changes since v1, just added a patch preceding this one.
>
>  include/lapi/keyctl.h                              |  4 +
>  runtest/cve                                        |  1 +
>  runtest/syscalls                                   |  1 +
>  .../kernel/syscalls/request_key/request_key04.c    | 87 ++++++++++++++++++++++
>  4 files changed, 93 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/request_key/request_key04.c

Only issue is that you are missing .gitignore entry. Otherwise LGTM.

-- 
Thank you,
Richard.
