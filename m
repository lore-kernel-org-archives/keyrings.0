From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 22 Oct 2018 13:52:38 +0000
Subject: Re: [PATCH v2 3/4] sign-file: add generic built-in engine key support
Message-Id: <1540216358.3012.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205215.2815.10.camel@HansenPartnership.com>
In-Reply-To: <1540205215.2815.10.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

On Mon, 2018-10-22 at 14:51 +0100, Mark J Cox wrote:
> Needs revision; OPENSSL_config() is deprecated in OpenSSL 1.1.0+

It's deprecated but still functional.  I have a todo to find out what
its replacement is.

James
