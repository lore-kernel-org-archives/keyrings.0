From: James Morris <james.l.morris@oracle.com>
Date: Tue, 05 Dec 2017 00:18:10 +0000
Subject: Re: [PATCH] security: keys: remove redundant assignment to key_ref
Message-Id: <alpine.LFD.2.20.1712051116130.21642@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171204181424.15808-1-colin.king@canonical.com>
In-Reply-To: <20171204181424.15808-1-colin.king@canonical.com>
To: linux-security-module@vger.kernel.org

On Mon, 4 Dec 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable key_ref is being assigned a value that is never read;
> key_ref is being re-assigned a few statements later.  Hence this
> assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I think a general cleanup in that function to make all of these follow the 
pattern:

	if (something) {
		key_ref = ERR_PTR(-error);
		goto error;
	}

rather than unconditionally setting the error first, would be better, but 
this is a clear enough fix on its own.

Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

