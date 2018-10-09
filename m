From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 09 Oct 2018 22:11:39 +0000
Subject: undefined behavior (-Wvarargs) in security/keys/trusted.c#TSS_authhmac()
Message-Id: <CAKwvOdkqtfAyDdxkac=NtfSiskiGyOhN1PPzkxBYpR_JEBTRbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, zohar@linux.vnet.ibm.com, dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Eric Biggers <ebiggers@google.com>

Hello,
I noticed that compiling with
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
and Clang produced the warning:

  CC      security/keys/trusted.o
security/keys/trusted.c:146:17: warning: passing an object that
undergoes default
      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
        va_start(argp, h3);
                       ^
security/keys/trusted.c:126:37: note: parameter of type 'unsigned
char' is declared here
unsigned char *h2, unsigned char h3, ...)
                               ^

Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
standards explicitly call this out as undefined behavior:

The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with ... or with a
type that is not compatible with the type that results after
application of the default argument promotions, the behavior is
undefined.

So if I understand my C promotion/conversion rules correctly, unsigned
char would be promoted to int?

We had a few ideas for possible fixes in:
https://github.com/ClangBuiltLinux/linux/issues/41

Do the maintainers have feedback on these suggestions or a more appropriate fix?

Note: https://www.gnu.org/software/libc/manual/html_node/Calling-Variadics.html
and `man 3 va_start` mention more about promotions, but just for
va_arg, not va_start. But the standard seems explicit about parmN
which is passed to va_start.

https://www.eskimo.com/~scs/cclass/int/sx11c.html is also an
interesting read on the subject, which states: `Finally, for vaguely
related reasons, the last fixed argument (the one whose name is passed
as the second argument to the va_start() macro) should not be of type
char, short int, or float, either.`
-- 
Thanks,
~Nick Desaulniers
