From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 31 Oct 2019 15:37:33 +0000
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key create or update
Message-Id: <1572536253.5028.50.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
         <20191031011910.2574-2-nramas@linux.microsoft.com>
         <1572523831.5028.43.camel@linux.ibm.com>
         <b83bd7ef-ce7f-e750-e30b-30d5a6469a28@linux.microsoft.com>
         <20191031152730.GQ1554@sasha-vm>
In-Reply-To: <20191031152730.GQ1554@sasha-vm>
To: Sasha Levin <sashal@kernel.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: dhowells@redhat.com, matthewgarrett@google.com, jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, prsriva@linux.microsoft.com

On Thu, 2019-10-31 at 11:27 -0400, Sasha Levin wrote:
> On Thu, Oct 31, 2019 at 08:08:48AM -0700, Lakshmi Ramasubramanian wrote:
> >On 10/31/19 5:10 AM, Mimi Zohar wrote:
> >
> >>On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
> >>>Asymmetric keys used for verifying file signatures or certificates
> >>>are currently not included in the IMA measurement list.
> >>>
> >>>This patch defines a new IMA hook namely ima_post_key_create_or_update()
> >>>to measure asymmetric keys.
> >>
> >>It's not enough for the kernel to be able to compile the kernel after
> >>applying all the patches in a patch set.  After applying each patch,
> >>the kernel should build properly, otherwise it is not bi-sect safe.
> >>  Refer to "3) Separate your changes" of
> >>"Documentation/process/submitting-patches.rst.
> >
> >I started with kernel version 5.3 for this patch set.
> >I applied Nayna's process_buffer_measurement() patch and then built my 
> >changes on top of that.
> >This patch has no other dependency as far as I know.
> >
> >Are you seeing a build break after applying this patch alone?
> >
> >(PATCH v3 1/9) KEYS: Defined an IMA hook to measure keys on key create 
> >or update
> 
> I couldn't even apply this patch: Nayna's series (v10) doesn't apply on
> top of 5.3 to begin with, and while it does apply on mainline, this
> first patch wouldn't apply on top.

Lakshmi, development is always on top of mainline.  In this case,
 please use 5.4.0-rc3 and apply Nayna's v10 patch set.

Mimi
