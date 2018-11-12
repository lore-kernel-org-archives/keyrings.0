From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 12 Nov 2018 17:05:10 +0000
Subject: Re: [PATCH v2] keyutils: Add pkg-config file for keyutils library
Message-Id: <c0e79dc9-575a-94ca-bd94-b46091666d44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <154145467410.14757.17777844184467107867.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <154145467410.14757.17777844184467107867.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org


On 11/12/2018 5:49 AM, David Howells wrote:
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> This is needed so that other projects can add a dependency on libkeyutils
>> via PKG_CHECK_MODULES([KEYUTILS], [keyutils]).  This enabling makes 'make
>> install' do the right thing, and of course individual distros will need to
>> add enabling to their associated packages (rpm, deb, etc.) so the package
>> manager installs do the right thing.
> Shouldn't the keyutils.pc file be in keyutils-libs-devel, not keyutils-libs?

I'll fix and resend.

>
> David
