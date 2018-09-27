From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 18:39:51 +0000
Subject: Re: [PATCH 5/5] dns_key: add a function to verify the key description
Message-Id: <20180927183951.GC6356@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131450.23458-6-mathstuf@gmail.com>
In-Reply-To: <20180927131450.23458-6-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Thu, Sep 27, 2018 at 18:15:19 +0100, David Howells wrote:
> You can actually vet the description in ->preparse().  ->vet_description() is
> redundant if all key types implement ->preparse().

Would it be better to do so in ->preparse() then? Currently the only
place it is verified (that I can find) is in the userspace
key.dns_resovler.

--Ben
