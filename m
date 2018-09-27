From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 18:37:00 +0000
Subject: Re: [PATCH 4/5] keyctl.h: update pointer types
Message-Id: <20180927183700.GA6356@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131450.23458-5-mathstuf@gmail.com>
In-Reply-To: <20180927131450.23458-5-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Thu, Sep 27, 2018 at 18:08:03 +0100, David Howells wrote:
> Ben Boeckel <mathstuf@gmail.com> wrote:
> > These should be `const` since the kernel should not touch them. In
> > addition `otherinfo` is defined to be opaque, so make it a `void *`.
> 
> You're changing the UAPI - and this no longer matches what's in keyutils.h in
> userspace.

Please see patch #5/7 of the keyutils patches on this thread for that change.

> The UAPI change might potentially cause userspace to fail to compile if
> someone was assigning the char * pointer from the struct to another char *
> pointer.

Is this in a released kernel? Isn't the KDF code being added in another
pull request of yours[1]?

--Ben

[1]https://lwn.net/Articles/764227/
