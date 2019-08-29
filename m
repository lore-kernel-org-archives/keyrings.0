From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 29 Aug 2019 20:41:27 +0000
Subject: Re: [PATCH 00/13] Test suite tidiness
Message-Id: <20190829204127.GA6592@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190829203542.4410-1-mathstuf@gmail.com>
In-Reply-To: <20190829203542.4410-1-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Thu, Aug 29, 2019 at 16:35:23 -0400, Ben Boeckel wrote:
> A collection of minor patches to the test suite I discovered while
> porting to the Rust bindings I've been working on:
> 
>     https://github.com/mathstuf/rust-keyutils
>     https://github.com/mathstuf/rust-keyutils/pull/34 (for the porting of the test suite)
> 
> Mostly typos, relocating some tests to what seems to be more sensible
> location, fixing some copy/pasta, and adding some missed test cases.
> The patches were developed against master, but have been rebased here
> against `next` to make it easier to add to it. If that is incorrect, I
> can rebase onto `master` and respin.
> 
> Note that I'm sending these for review now, but I'll be on vacation for
> a few weeks. Feel free to leave review comments; I'll act on them once I
> return.

Ah crap, used a dirty directory where I had staged a set of patches
previously. Sorry, will resend.

--Ben
