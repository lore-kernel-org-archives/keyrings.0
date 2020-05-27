From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 27 May 2020 19:58:21 +0000
Subject: Re: [RESEND] security/keys: remove possessor verify after key permission check
Message-Id: <1590609501.4731.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200505091958.GD16980@willie-the-truck>
In-Reply-To: <20200505091958.GD16980@willie-the-truck>
To: keyrings@vger.kernel.org

On Wed, 2020-05-27 at 22:47 +0300, Jarkko Sakkinen wrote:
[...]
> > ping
> 
> Please send a new version with a full example of the scenario that
> you are referring. This thread became too messy to follow with the
> HTML emails included (that do no reach vger).

Yes, please ... I'm missing most of the emails because of the vger and
html problem.  I think the request is to remove the possessor check in
keyctl_read, but just done blindly that would completely destroy our
namespaced security system for keys, so it doesn't sound like a good
idea at all.  What's the actual problem this is trying to solve?  It's
annoying that root has to join the session keyring to read a key, but
the reason for it is well justified and the fact that even root can't
reach some session keyrings is a feature not a bug.

James
