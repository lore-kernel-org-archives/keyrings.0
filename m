From: Ben Boeckel <mathstuf@gmail.com>
Date: Wed, 19 Jun 2019 13:30:33 +0000
Subject: Re: keyctl_capabilities and buflen
Message-Id: <20190619133033.GA11027@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190605130247.GA21275@rotor.kitware.com>
In-Reply-To: <20190605130247.GA21275@rotor.kitware.com>
To: keyrings@vger.kernel.org

On Wed, Jun 05, 2019 at 09:02:47 -0400, Ben Boeckel wrote:
> I'm looking at the implementation of `keyctl_capabilities` in the `next`
> branch and it's not clear if `buflen` is the size of the memory pointed
> to by `buffer` in array size or in byte size by its documentation. It
> seems to be the size in bytes by the code (the &3) could probably
> warrant a comment to make it clearer that it is related to
> sizeof(unsigned int) here). This seems very odd to me, or is it just a
> common kernel pattern I haven't seen before?

I see that this is now `unsigned char*` instead of `unsigned int` on
`next` now and in the kernel by the newest patch submission.

Thanks,

--Ben
