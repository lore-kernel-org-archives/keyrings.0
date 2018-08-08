From: Denis Kenzior <denkenz@gmail.com>
Date: Wed, 08 Aug 2018 15:09:16 +0000
Subject: Re: [RFCv3 07/13] KEYS: trusted: Expose common functionality
Message-Id: <3a78b029-5227-9159-4ed6-ec30cb7624ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802183121.22909-8-denkenz@gmail.com>
In-Reply-To: <20180802183121.22909-8-denkenz@gmail.com>
To: keyrings@vger.kernel.org

Hi James,

On 08/07/2018 03:10 PM, James Morris wrote:
> On Thu, 2 Aug 2018, Denis Kenzior wrote:
> 
>> This patch exposes some common functionality needed to send TPM
>> commands.  The current approach is a complete hack and needs to be
>> addressed properly.  This commit just show-cases what functionality
>> would need to be moved to a shared location or exposed in some other
>> manner.
> 
> Consider adding the linux-integrity list to the cc line for these patches.
> 

Will do.

And thanks for the Reviewed-bys.  Any chance you can also take a look at 
patch 12.  It is adding a tpm_sign primitive similar to other tpm 
primitives implemented in patches 8 & 9.

Regards,
-Denis
