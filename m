From: James Morris <jmorris@namei.org>
Date: Thu, 30 May 2019 19:43:26 +0000
Subject: Re: [PATCH 18/22] docs: security: trusted-encrypted.rst: fix code-block tag
Message-Id: <alpine.LRH.2.21.1905310543170.26428@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
In-Reply-To: <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org

On Wed, 29 May 2019, Mauro Carvalho Chehab wrote:

> The code-block tag is at the wrong place, causing those
> warnings:
> 
>     Documentation/security/keys/trusted-encrypted.rst:112: WARNING: Literal block expected; none found.
>     Documentation/security/keys/trusted-encrypted.rst:121: WARNING: Unexpected indentation.
>     Documentation/security/keys/trusted-encrypted.rst:122: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/security/keys/trusted-encrypted.rst:123: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>
