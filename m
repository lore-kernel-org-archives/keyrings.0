From: James Morris <jmorris@namei.org>
Date: Thu, 10 May 2018 18:09:13 +0000
Subject: Re: [PATCH 17/18] security: encrypted-keys: Remove pr_fmt duplicate logging prefixes
Message-Id: <alpine.LRH.2.21.1805110409080.1003@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1525964381.git.joe@perches.com> <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
In-Reply-To: <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
To: Joe Perches <joe@perches.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 10 May 2018, Joe Perches wrote:

> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 63 ++++++++++++++------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

