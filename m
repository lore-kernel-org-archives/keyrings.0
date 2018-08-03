From: Denis Kenzior <denkenz@gmail.com>
Date: Fri, 03 Aug 2018 15:12:49 +0000
Subject: Re: [RFCv3 00/13] KEYS: TPM 1.2 asymmetric key type
Message-Id: <e8dbb009-8ff3-11ba-4ee2-f96d73ae0a73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802183121.22909-1-denkenz@gmail.com>
In-Reply-To: <20180802183121.22909-1-denkenz@gmail.com>
To: keyrings@vger.kernel.org

Hi David,

On 08/03/2018 10:07 AM, David Howells wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
> 
>> 	create_tpm_key -s 2048 -w /tmp/privkey.pem /tmp/privkey.tpm
> 
> Where do I find this command?
> 

It is part of the trousers openssl_tpm_engine.
https://git.code.sf.net/p/trousers/openssl_tpm_engine

I do have a small patch on top of that tree (Actually it is originally 
from James Bottomley) that sets the use of the default 20 '0' key by 
default.  I can send this to you privately if you want.

TPM is a bit of a mess in Linux :)

Regards,
-Denis
