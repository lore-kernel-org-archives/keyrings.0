From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 13 May 2020 16:50:12 +0000
Subject: Re: [RESEND] security/keys: remove possessor verify after key permission check
Message-Id: <20200513165012.GB25598@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20200505091958.GD16980@willie-the-truck>
In-Reply-To: <20200505091958.GD16980@willie-the-truck>
To: keyrings@vger.kernel.org

On Thu, May 07, 2020 at 11:39:48AM +0300, Алексей Красиков wrote:
>     
>    You've removed all the attributes except the reading.
>    Nothing can be done with the key if it can't be found.
>    Try this:
>     
>    $ KEYID=$(keyctl add user john smith @u)
>    $ keyctl describe $KEYID
>    $ keyctl setperm $KEYID 0x3d000000
>    $ keyctl describe $KEYID
>    $ keyctl print $KEYID
>     
>    /Alexey

Hi please re-respond with plain text.

HTML mails do not go to vger.kernel.org. Also please try to avoid
top posting (i.e. quote and respond inline).


/Jarkko
