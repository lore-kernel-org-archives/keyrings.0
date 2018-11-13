From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 13 Nov 2018 16:23:43 +0000
Subject: Re: [PATCH v3] keyutils: Add pkg-config file for keyutils library
Message-Id: <a98ffe4d-1a08-6fd2-0e98-67f1485237b0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <154204238794.56932.9923417628758022915.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org



On 11/13/18 8:54 AM, David Howells wrote:
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> +prefix=@prefix@
>> +exec_prefix=@exec_prefix@
> 
> Is there any point to these two lines?  You added a 'PREFIX' variable to the
> Makefile, but it's not used for anything.

Actually I'm not sure. Most .pc config files have them and do not use
them looks like.

> 
> David
> 
