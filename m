From: Ben Boeckel <mathstuf@gmail.com>
Date: Mon, 24 Sep 2018 20:45:18 +0000
Subject: Re: [PATCH] keyctl_dh_compute_kdf: use a void* for opaque data
Message-Id: <20180924204518.GA23168@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180924175506.21077-1-mathstuf@gmail.com>
In-Reply-To: <20180924175506.21077-1-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Mon, Sep 24, 2018 at 13:55:06 -0400, Ben Boeckel wrote:
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  keyutils.c              | 2 +-
>  keyutils.h              | 4 ++--
>  man/keyctl_dh_compute.3 | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

I'll note that these changes seem to need patches applied to the kernel
as well to at least update the documentation with respect to `const` and
`void*`, but it's likely code needs updated as well.

I can submit patches for these as well. I assume I should also send them
here (based on dhowells/keys-asym-keyctl)?

--Ben
