From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 03 Jun 2019 20:29:33 +0000
Subject: Re: [PATCH 18/22] docs: security: trusted-encrypted.rst: fix code-block tag
Message-Id: <20190603202933.GB4894@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
In-Reply-To: <9c8e63bba3c3735573ab107ffd65131db10e1d2e.1559171394.git.mchehab+samsung@kernel.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org

On Wed, May 29, 2019 at 08:23:49PM -0300, Mauro Carvalho Chehab wrote:
> The code-block tag is at the wrong place, causing those
> warnings:
> 
>     Documentation/security/keys/trusted-encrypted.rst:112: WARNING: Literal block expected; none found.
>     Documentation/security/keys/trusted-encrypted.rst:121: WARNING: Unexpected indentation.
>     Documentation/security/keys/trusted-encrypted.rst:122: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/security/keys/trusted-encrypted.rst:123: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
