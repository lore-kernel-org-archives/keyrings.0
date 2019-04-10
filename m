From: James Morris <jmorris@namei.org>
Date: Wed, 10 Apr 2019 17:29:07 +0000
Subject: Re: [PATCH] security: don't use RCU accessors for cred->session_keyring
Message-Id: <alpine.LRH.2.21.1904110328490.25754@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190327153938.82007-1-jannh@google.com>
In-Reply-To: <20190327153938.82007-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Wed, 27 Mar 2019, Jann Horn wrote:

> sparse complains that a bunch of places in kernel/cred.c access
> cred->session_keyring without the RCU helpers required by the __rcu
> annotation.
> 
> cred->session_keyring is written in the following places:
> 
>  - prepare_kernel_cred() [in a new cred struct]
>  - keyctl_session_to_parent() [in a new cred struct]
>  - prepare_creds [in a new cred struct, via memcpy]
>  - install_session_keyring_to_cred()
>   - from install_session_keyring() on new creds
>   - from join_session_keyring() on new creds [twice]
>   - from umh_keys_init()
>    - from call_usermodehelper_exec_async() on new creds
> 
> All of these writes are before the creds are committed; therefore,
> cred->session_keyring doesn't need RCU protection.
> 
> Remove the __rcu annotation and fix up all existing users that use __rcu.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>
