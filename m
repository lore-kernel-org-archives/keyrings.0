From: "Jiang, Dave" <dave.jiang@intel.com>
Date: Tue, 13 Nov 2018 15:17:23 +0000
Subject: Re: [PATCH v3] keyutils: Add pkg-config file for keyutils library
Message-Id: <7030DE8C-B54A-4588-899E-78E2AF807830@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org



> On Nov 13, 2018, at 7:51 AM, David Howells <dhowells@redhat.com> wrote:
> 
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> This is needed so that other projects can add a dependency on libkeyutils
>> via PKG_CHECK_MODULES([KEYUTILS], [keyutils]).  This enabling makes 'make
>> install' do the right thing, and of course individual distros will need to
>> add enabling to their associated packages (rpm, deb, etc.) so the package
>> manager installs do the right thing.
> 
> Also, everything else in /usr/lib/pkgconfig/ is libxxx.pc.  Should I just
> change this to match?

Sure. That should be fine. 
> 
> David
