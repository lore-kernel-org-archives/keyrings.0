From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 27 Aug 2020 13:26:34 +0000
Subject: Re: [PATCH] security/keys: use kvfree_sensitive()
Message-Id: <20200827132634.GB4674@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200827072923.14718-1-efremov@linux.com>
In-Reply-To: <20200827072923.14718-1-efremov@linux.com>
To: Denis Efremov <efremov@linux.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:29:23AM +0300, Denis Efremov wrote:
> Use kvfree_sensitive() instead of open-coding it.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
