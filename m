From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Sep 2017 16:09:02 +0000
Subject: Re: [PATCH] KEYS: prevent KEYCTL_READ on negative key
Message-Id: <30124.1505837342@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170918183723.114253-1-ebiggers3@gmail.com>
In-Reply-To: <20170918183723.114253-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> +	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
> +		ret = -ENOKEY;
> +		goto error2;
> +	}

It might be better to do this check in key_validate().  Also, it should
perhaps take the error from key->reject_error.

David
