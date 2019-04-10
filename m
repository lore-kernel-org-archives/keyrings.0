From: James Morris <jmorris@namei.org>
Date: Wed, 10 Apr 2019 17:31:01 +0000
Subject: Re: [PATCH] keys: safe concurrent user->{session,uid}_keyring access
Message-Id: <alpine.LRH.2.21.1904110330420.25754@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190327155508.144730-1-jannh@google.com>
In-Reply-To: <20190327155508.144730-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Wed, 27 Mar 2019, Jann Horn wrote:

> The current code can perform concurrent updates and reads on
> user->session_keyring and user->uid_keyring. Add a comment to
> struct user_struct to document the nontrivial locking semantics, and use
> READ_ONCE() for unlocked readers and smp_store_release() for writers to
> prevent memory ordering issues.
> 
> Fixes: 69664cf16af4 ("keys: don't generate user and user session keyrings unless they're accessed")
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>
