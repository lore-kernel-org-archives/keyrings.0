From: James Morris <jmorris@namei.org>
Date: Wed, 23 Jan 2019 04:38:11 +0000
Subject: Re: [PATCH 1/3] security: keys: annotate implicit fall through
Message-Id: <alpine.LRH.2.21.1901231537550.3377@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190114201725.13289-1-malat@debian.org>
In-Reply-To: <20190114201725.13289-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: David Howells <dhowells@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019, Mathieu Malaterre wrote:

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit remove the following warning:
> 
>   security/keys/keyring.c:248:10: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

All 3 applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>
