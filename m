From: Ben Boeckel <mathstuf@gmail.com>
Date: Wed, 05 Jun 2019 13:02:47 +0000
Subject: keyctl_capabilities and buflen
Message-Id: <20190605130247.GA21275@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi,

I'm looking at the implementation of `keyctl_capabilities` in the `next`
branch and it's not clear if `buflen` is the size of the memory pointed
to by `buffer` in array size or in byte size by its documentation. It
seems to be the size in bytes by the code (the &3) could probably
warrant a comment to make it clearer that it is related to
sizeof(unsigned int) here). This seems very odd to me, or is it just a
common kernel pattern I haven't seen before?

Thanks,

--Ben
