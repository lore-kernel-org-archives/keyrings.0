From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 17 Jun 2020 01:46:24 +0000
Subject: Re: [PATCH] keys: Do not check the retval of commit_creds in join_session_keyring
Message-Id: <20200617014613.GA7215@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <044b34c4388405e995e38fb57fc120361bf962db.1568124150.git.suse-tux@gmx.de>
In-Reply-To: <044b34c4388405e995e38fb57fc120361bf962db.1568124150.git.suse-tux@gmx.de>
To: keyrings@vger.kernel.org

On Fri, Jun 12, 2020 at 01:25:33PM +0200, Marcus Huewe wrote:
> Do not check the return value of the commit_creds call in
> join_session_keyring in order to make the code more concise.
> Since commit_creds always returns 0, the if-statement is not needed
> and the session keyring's serial can be directly assigned to the
> "ret" variable.
> 
> Signed-off-by: Marcus Huewe <suse-tux@gmx.de>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

David, can you pick this up to your tree (give that a generic
keyring change)?

/Jarkko
