From: James Bottomley <James.Bottomley@Hansenpartnership.com>
Date: Tue, 23 Oct 2018 11:42:46 +0000
Subject: Re: [PATCH v2 4/4] sign-file: add explicit engine specification
Message-Id: <7b0180b6-cf05-4cb1-897a-8df78f6cf609@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205281.2815.12.camel@HansenPartnership.com>
In-Reply-To: <1540205281.2815.12.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

On October 23, 2018 12:37:52 PM GMT, David Woodhouse <dwmw2@infradead.org> wrote:
>On Tue, 2018-10-23 at 12:10 +0100, James Bottomley wrote:
>> On Mon, 2018-10-22 at 12:38 +0100, David Woodhouse wrote:
>> > On Mon, 2018-10-22 at 11:48 +0100, James Bottomley wrote:
>> > > This commit adds an optional -e <engine> argument to sign
>> > > file.  Now that we have the explicit engine addition, the
>original
>> > > pkcs11 token implementation can also be merged into this code
>> > > (using UI methods for getting the key instead of the engine
>control
>> > > command).  To keep the code functioning the same way (no need to
>> > > specify the pkcs11 engine if the key file begins pkcs11:) an
>> > > explicit check will set the engine to pkcs11 if a pkcs11 key
>> > > specifier is detected.
>> > > 
>> > > Signed-off-by: James Bottomley
><James.Bottomley@HansenPartnership.c
>> > > om>
>> > 
>> > Acked-if-you-tested-it-with-PKCS#11-by: David Woodhouse
><dwmw@amazon.
>> > co.uk>
>> 
>> It was a right royal pain, but I have tested it with softhsm+p11lib
>> engine and it all (amazingly) seems to work with correct pkcs11 URLs
>> ... just don't ask me to do it again.
>
>That shouldn't have been a pain.
>
>The SoftHSM part should been just installing the package then running
>the two commands from OpenConnect's tests/Makefile.am that I pointed
>you at — 'softhsm2-util --init-token' then 'softhsm2-util --import'.
>
>Then you just install the PKCS#11 engine package, then you should be
>able to use sign-tool (or indeed anything else in the distro) with the
>RFC7512 URI for the cert you imported, instead of a PEM filename.
>
>If it wasn't as simple as that, please file bugs with your distro. It's
>OpenSUSE, right? I don't pay much attention to SUSE but I didn't think
>their crypto bits were as out of date and badly maintained as
>Debian/Ubuntu — I kind of expected stuff to work properly.

The pain points were opensuse doesn't package softhsm.  Provisioning softhsm according to the man page gives a slot not found error and it's unclear how to pass the pkcs11 module to the engine.  Once I had the source code, I figured it out, but it definitely wasn't easy.

James


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
