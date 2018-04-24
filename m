From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 24 Apr 2018 14:46:38 +0000
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-Id: <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180424010321.14739-1-tycho@tycho.ws>
	<20180424045015.GA4281@sol.localdomain>
	<20180424143539.GB3125@cisco>
In-Reply-To: <20180424143539.GB3125@cisco>
To: tycho@tycho.ws, ebiggers3@gmail.com
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, jmorris@namei.org, serge@hallyn.com, Jason@zx2c4.com

Tycho Andersen wrote:
> > > +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> > > +		WARN(1, "big key algorithm changed?");

Please avoid using WARN() WARN_ON() etc.
syzbot would catch it and panic() due to panic_on_warn = 1.
