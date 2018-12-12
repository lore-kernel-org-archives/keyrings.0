From: James Morris <jmorris@namei.org>
Date: Wed, 12 Dec 2018 23:42:27 +0000
Subject: Re: [PATCH 0/5] security: remove needless usage of module header
Message-Id: <alpine.LRH.2.21.1812131041490.7600@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1544387793-32309-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-integrity@vger.kernel.org

On Sun, 9 Dec 2018, Paul Gortmaker wrote:

> Paul Gortmaker (5):
>   security: audit and remove any unnecessary uses of module.h
>   keys: remove needless modular infrastructure from ecryptfs_format
>   security: fs: make inode explicitly non-modular
>   security: integrity: make evm_main explicitly non-modular
>   security: integrity: make ima_main explicitly non-modular

All applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-general

-- 
James Morris
<jmorris@namei.org>
