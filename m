From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 01 Jun 2020 17:34:27 +0000
Subject: Re: [RFC PATCH 0/1] security/keys: remove possessor verify after key
Message-Id: <20200601173427.GA26455@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200529081527.GC1376838@linux.intel.com>
In-Reply-To: <20200529081527.GC1376838@linux.intel.com>
To: keyrings@vger.kernel.org

On Fri, May 29, 2020 at 09:00:39AM +0300, Alexey Krasikov wrote:
> $ KEYID=$(keyctl add user john smith @u)
> $ keyctl describe $KEYID
> 5927639: alswrv-----v------------  1000  1000 user: john
> $ keyctl setperm $KEYID 0x3d000000
> $ keyctl describe $KEYID
> 5927639: alsw-v-----v------------  1000  1000 user: john
> $ keyctl print $KEYID
> smith

A keyring default permissions are 0x3f3f0000.
A key default permissions are 0x3f010000.

Because of this:

$ KEYID=$(keyctl add user john smith @u)
$ keyctl setperm $KEYID 0x3d000000
keyctl_setperm: Permission denied

Are you sure that your example is correct?

/Jarkko
