From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 09 Jul 2019 05:56:50 +0000
Subject: Re: [RFC 3/7] tee: add private login method for kernel clients
Message-Id: <CAFA6WYNzs=RErreWaa5BmF-P03Vf9nzQjvY_JpMckw87k9z12w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-4-git-send-email-sumit.garg@linaro.org> <20190708153908.GA28253@jax>
In-Reply-To: <20190708153908.GA28253@jax>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, corbet@lwn.net, dhowells@redhat.com, jejb@linux.ibm.com, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org, serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tee-dev@lists.linaro.org

Thanks Jens for your comments.

On Mon, 8 Jul 2019 at 21:09, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi Sumit,
>
> On Thu, Jun 13, 2019 at 04:00:29PM +0530, Sumit Garg wrote:
> > There are use-cases where user-space shouldn't be allowed to communicate
> > directly with a TEE device which is dedicated to provide a specific
> > service for a kernel client. So add a private login method for kernel
> > clients and disallow user-space to open-session using this login method.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/tee_core.c   | 6 ++++++
> >  include/uapi/linux/tee.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 0f16d9f..4581bd1 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
> >                       goto out;
> >       }
> >
> > +     if (arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL) {
> TEE_IOCTL_LOGIN_REE_KERNEL is defined as 0x80000000 which is in the
> range specified and implementation defined by the GP spec. I wonder if
> we shouldn't filter the entire implementation defined range instead of
> just this value.

Agree. Will rather check for entire implementation defined range:
0x80000000 - 0xFFFFFFFF.

>
> > +             pr_err("login method not allowed for user-space client\n");
> pr_debug(), if it's needed at all.
>

Ok will use pr_debug() instead.

> > +             rc = -EPERM;
> > +             goto out;
> > +     }
> > +
> >       rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
> >       if (rc)
> >               goto out;
> > diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> > index 4b9eb06..f33c69c 100644
> > --- a/include/uapi/linux/tee.h
> > +++ b/include/uapi/linux/tee.h
> > @@ -172,6 +172,8 @@ struct tee_ioctl_buf_data {
> >  #define TEE_IOCTL_LOGIN_APPLICATION          4
> >  #define TEE_IOCTL_LOGIN_USER_APPLICATION     5
> >  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION    6
> > +/* Private login method for REE kernel clients */
> It's worth noting that this is filtered by the TEE framework, compared
> to everything else which is treated opaquely.
>

IIUC, you are referring to login filter in optee_os. Change to prevent
filter for this login method is part of this PR [1].

[1] https://github.com/OP-TEE/optee_os/pull/3082

-Sumit

> > +#define TEE_IOCTL_LOGIN_REE_KERNEL           0x80000000
> >
> >  /**
> >   * struct tee_ioctl_param - parameter
> > --
> > 2.7.4
> >
>
> Thanks,
> Jens
