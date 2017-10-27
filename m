From: James Morris <james.l.morris@oracle.com>
Date: Fri, 27 Oct 2017 07:55:39 +0000
Subject: Re: [PATCH] KEYS: trusted: fix writing past end of buffer in trusted_read()
Message-Id: <alpine.LFD.2.20.1710270954210.2635@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026205744.105566-1-ebiggers3@gmail.com>
In-Reply-To: <20171026205744.105566-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

On Thu, 26 Oct 2017, Eric Biggers wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> When calling keyctl_read() on a key of type "trusted", if the
> user-supplied buffer was too small, the kernel ignored the buffer length
> and just wrote past the end of the buffer, potentially corrupting
> userspace memory.  Fix it by instead returning the size required, as per
> the documentation for keyctl_read().
> 
> We also don't even fill the buffer at all in this case, as this is
> slightly easier to implement than doing a short read, and either
> behavior appears to be permitted.  It also makes it match the behavior
> of the "encrypted" key type.
> 
> Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: <stable@vger.kernel.org> # v2.6.38+
> Signed-off-by: Eric Biggers <ebiggers@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>



-- 
James Morris
<james.l.morris@oracle.com>

