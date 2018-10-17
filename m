From: Mark J Cox <mjc@redhat.com>
Date: Wed, 17 Oct 2018 14:23:57 +0000
Subject: Re: [PATCH v2] support other engines for module signing
Message-Id: <alpine.LFD.2.21.1810171519570.4574@hatman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.LFD.2.21.1810171514270.4574@hatman>
In-Reply-To: <alpine.LFD.2.21.1810171514270.4574@hatman>
To: keyrings@vger.kernel.org

> But it's still not great. What engine are you actually trying to use
> here? Can't you make it Just Work without the user having to get
> involved in knowing the details of the crypto library you happen to be
> using today? Recognise its storage file format if it has one (like the
> TPM engine has distinctive PEM tags), or use STORE, or recognise its
> URI format if it has one (like RFC7512 for PKCS#11, or Nikos's draft
> for tpmkey: at least for TPMv1.2).

There are many OpenSSL engines available besides PKCS-11, for example a 
number of hardware signing modules provide OpenSSL engine modules.  This 
patch allows a user to use them to sign kernel modules using sign-file.c.

For example, if you are using a Thales HSM they provide an OpenSSL engine 
called "Chil" and therefore to sign kernel modules using such a module you 
simply now have to do:

sign-file -e chil -d sha256 nameofthekey certfile.pem kernelmodule.ko

The user will know that they want to sign using their Thales HSM protected 
key, and therefore this interface is obvious (in the same way they'd use 
openssl with the -engine option to do any other random functions).

Mark
