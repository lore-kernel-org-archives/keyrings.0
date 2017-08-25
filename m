From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Fri, 25 Aug 2017 06:49:04 +0000
Subject: Re: [PATCH v2] docs: ReSTify table of contents in core.rst
Message-Id: <871so0b0rj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170823204232.1879-1-anowlcalledjosh@gmail.com>
In-Reply-To: <20170823204232.1879-1-anowlcalledjosh@gmail.com>
To: keyrings@vger.kernel.org

On Fri, 25 Aug 2017, Josh Holland <anowlcalledjosh@gmail.com> wrote:
> On 2017-08-24, Jani Nikula wrote:
>> On Wed, 23 Aug 2017, Josh Holland <anowlcalledjosh@gmail.com> wrote:
>> > Sphinx will now generate the table of contents automatically, which
>> > avoids having the ToC getting out of sync with the rest of the document.
>> >
>> > Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
>> > ---
>> >  Documentation/security/keys/core.rst | 12 +-----------
>> >  1 file changed, 1 insertion(+), 11 deletions(-)
>> >
>> > diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
>> > index 312f981fa..1266eeae4 100644
>> > --- a/Documentation/security/keys/core.rst
>> > +++ b/Documentation/security/keys/core.rst
>> > @@ -16,17 +16,7 @@ The key service can be configured on by enabling:
>> >  
>> >  This document has the following sections:
>> >  
>> > -	- Key overview
>> > -	- Key service overview
>> > -	- Key access permissions
>> > -	- SELinux support
>> > -	- New procfs files
>> > -	- Userspace system call interface
>> > -	- Kernel services
>> > -	- Notes on accessing payload contents
>> > -	- Defining a key type
>> > -	- Request-key callback service
>> > -	- Garbage collection
>> > +.. contents:: :local:
>> 
>> Did you actually try this and look at the 'make htmldocs' results?
>> 
>> I know I tried what I suggested:
>> 
>> .. contents::
>>    :local:
>> 
>> http://docutils.sourceforge.net/docs/ref/rst/directives.html#table-of-contents
>
> Yep, I tried with sphinx_rtd_theme and it looks fine.  The documentation
> suggests that the two forms are equivalent:
>
>> If the default title is to be used, the options field list may begin
>> on the same line as the directive marker:
>>
>>   .. contents:: :depth: 2
>
> I went for the single-line version purely because that's what's used in
> Documentation/security/credentials.rst (one of two existing users of
> "contents::"), and I figured I may as well be consistent within the
> security docs.  I have no particular preference either way.

TIL. I'm fine either way. Sorry for the noise.

BR,
Jani.


>
> Thanks,
>
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jani Nikula, Intel Open Source Technology Center
