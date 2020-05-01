From: James Prestwood <prestwoj@gmail.com>
Date: Fri, 01 May 2020 17:17:06 +0000
Subject: Re: old "add integrity and security to TPM2 transactions" patches
Message-Id: <CAPv5Ue72DaLDNu5QhHPgxSk3r3mSXN5PZMKXA1LUo88nmKymCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Hi,

I don't have the original email to reply to, but can be found in the archives:

https://lore.kernel.org/linux-crypto/20190910162132.GA11338@linux.intel.com/

I am trying to get these patches working on my hardware TPM. They work
fine with an emulated TPM but not on the TPM I have. I have a Dell XPS
9550, which came stock with a 1.2 TPM. I did a firmware upgrade
provided by Dell to get TPM 2.0.

The kernel TPM initialization/start up works fine, and seems to create
the null primary key successfully. The problem starts when trying to
load the null key context (tpm2_load_context) in
tpm2_start_auth_session(). This command fails to transmit with -EIO. I
can't really get any more info other than this since there is no debug
info to get from a TPM.

I am trying to determine if its the above patches, or my TPM behaving
badly. Is there some preparation I need to do on the TPM to get this
working? I have cleared it a few times to start fresh but nothing
seems to change.

I am not very familiar with the various tss tools to interact with the
TPM, but I was able to create a primary key (tsscreateprimarykey) as
well as get capabilities, so the TPM is at least accepting those, just
not a load context apparently.

Thanks,
James

Thanks,
James
