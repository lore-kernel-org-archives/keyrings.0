From: James Morris <jmorris@namei.org>
Date: Fri, 28 Sep 2018 16:53:26 +0000
Subject: Re: [PATCH] keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h
Message-Id: <alpine.LRH.2.21.1809290253070.17024@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153809228025.23030.6619415372705612845.stgit@warthog.procyon.org.uk>
In-Reply-To: <153809228025.23030.6619415372705612845.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Fri, 28 Sep 2018, David Howells wrote:

> The keyctl_dh_params struct in uapi/linux/keyctl.h contains the symbol
> "private" which means that the header file will cause compilation failure
> if #included in to a C++ program.  Further, the patch that added the same
> struct to the keyutils package named the symbol "priv", not "private".

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing.


-- 
James Morris
<jmorris@namei.org>
