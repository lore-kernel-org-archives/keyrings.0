From: David Howells <dhowells@redhat.com>
Date: Wed, 06 Feb 2019 22:26:53 +0000
Subject: Re: [PATCH] security: keys: add NULL checking for key->type->instantiate
Message-Id: <31395.1549492013@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
In-Reply-To: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: dhowells@redhat.com, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Geliang Tang <geliangtang@gmail.com> wrote:

> key->type->instantiate can be NULL, add NULL checking to prevent
> NULL pointer dereference in __key_instantiate_and_link().

Do you have an oops report or test case for this?

David
