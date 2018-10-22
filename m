From: Mark J Cox <mjc@redhat.com>
Date: Mon, 22 Oct 2018 14:08:37 +0000
Subject: Re: [PATCH v2 3/4] sign-file: add generic built-in engine key support
Message-Id: <alpine.LFD.2.21.1810221504010.6485@hatman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205215.2815.10.camel@HansenPartnership.com>
In-Reply-To: <1540205215.2815.10.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

> On Mon, 2018-10-22 at 14:51 +0100, Mark J Cox wrote:
>> Needs revision; OPENSSL_config() is deprecated in OpenSSL 1.1.0+
>
> It's deprecated but still functional.  I have a todo to find out what
> its replacement is.

CONF_modules_load().  The patch really ought to be updated and not drop 
deprecation warnings as many OS now include OpenSSL 1.1.0+

Mark
