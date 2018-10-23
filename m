From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 23 Oct 2018 14:02:35 +0000
Subject: Re: [PATCH v2 3/4] sign-file: add generic built-in engine key support
Message-Id: <1540303355.2787.12.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205215.2815.10.camel@HansenPartnership.com>
In-Reply-To: <1540205215.2815.10.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

On Mon, 2018-10-22 at 14:51 +0100, Mark J Cox wrote:
> Needs revision; OPENSSL_config() is deprecated in OpenSSL 1.1.0+

This doesn't look pleasant: apps/openssl.c now seems to have replaced
this with an open coded equvalent.

The man page says to replace it with OPENSSL_init_crypto() which might
work, or it looks like I might be able to replace it with

CONF_modules_load_file(NULL, NULL, 0);

James
